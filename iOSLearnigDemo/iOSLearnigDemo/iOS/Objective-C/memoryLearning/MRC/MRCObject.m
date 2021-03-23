//
//  MRCObject.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MRCObject.h"
#import "MRCTestObject.h"
#import "MRCSubTestObject.h"

@interface MRCObject()
@property (nonatomic, strong) NSData    *data;
@property (nonatomic, retain) NSObject  *property;
@end

@implementation MRCObject
@synthesize data = _data;

- (void)test{
    // 1. alloc init之后引用计数为1
    MRCTestObject *obj = [[MRCTestObject alloc] init];
    NSInteger count = [obj retainCount];
    NSLog(@"count:%ld",count);
    [obj release];
    
    // 2.self未持有对象，无需负责释放
    id obj2 = [self getAObjNotRetain];
    NSLog(@"obj:%@",obj2);
    
    // 3.dealloc方法
    MRCSubTestObject *testObj = [[MRCSubTestObject alloc] init];
    NSData *data = [NSData data];
    testObj.data = data;
    [data release];
    [testObj release];
    
}

- (void)test_autoreleasepool{
    // 4.autoreleasepool
    [self _test_autoreleasepool];
}

#pragma mark -- MRC
// 1.谁持有或者谁创建，谁负责释放
// 2.alloc init new copy retain 会修改引用计数+1， 返回的是
// 3.release引用计数-1

- (id) getAObjNotRetain {
    // self 并不持有obj，也就是并没有property属性；
    // 可以用autoreleasepool来解决
    id obj = [[NSObject alloc] init];
    [obj autorelease];
    return obj;
}


// 4.dealloc 方法不要直接调用setter；super dealloc不需要显示调用
// dealloc方法探究，dealloc方法中尽量使用实例变量
// 理由：
// 1.实例变量效率更高
// 2.若子类重写了父类的属性，则有可能会引发崩溃；【亲测无效，没有发生崩溃】

- (void)dealloc{
    _data = nil;
    // 调用这个，会调用setter方法；所以效率没有直接使用实例变量效率高
    // 若子类重写了父类的该属性，子类先释放，_data = nil,父类再释放时，会调用一个已释放对象
    self.data = nil;
    
    // 2.赋值时不使用临时变量，可以这样
    [_property release];
    _property = nil;
    [super dealloc];
}

// 5. init方法也不要直接调用setter，尽量使用实例变量
- (instancetype)init{
    if(self = [super init]){
        _data = [NSData data];
    }
    return self;
}
// ARC测试就不能在这个类里了

void objc_storeStrong(id *object,id value){
    id oldValue = *object;
    value = [value retain];
    *object = value;
    [oldValue release];
}


#pragma mark -- autoreleasepool
- (void)_test_autoreleasepool{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
//    MRCTestObject * __strong array = [[[MRCTestObject alloc] init] autorelease];
    NSNumber * __strong array = [[NSNumber alloc] init];
    NSInteger count1 = _objc_rootRetainCount(array); //？？？此处引用计数为1为何，应该为2啊
//    [pool addObject:array]; //加入autoreleasepool，不用该方法，而是对对象调用autorelease方法
    NSInteger count2 = _objc_rootRetainCount(array);
//    [array release]; //不能释放，因为下方pool release时，还会对array调用release方法，而这时对象已经释放掉了，野指针崩溃
    NSInteger count3 = _objc_rootRetainCount(array);
//    [pool drain];//不能直接调用，会崩溃
    [pool release]; //调用drain或者release都会崩溃
    NSInteger count4 = _objc_rootRetainCount(array);
    NSLog(@"count1:%ld,count2:%ld,count3:%ld,count4:%ld",count1,count2,count3,count4);
    
    // 总结：
    // 1. 不需要手动addObject
    // 2. pool drain与pool release作用一样
    // 3. pool释放时机：
    // 3.1 MRC下 pool release或者drain时候，
    // 3.1.1 block中异常时，不会释放
    // 3.1.2 可以在autoreleasepool中retain以延长生命周期
    
    // 3.2 ARC下 当出了块之后就释放；runloop事件结束之后释放
    
    // 4. main.m中autoreleasepool可以删掉吗？可以
    // return 方法不会返回，这个autoreleasepool也就不会出了代码块；mainrunloop会自己创建autoreleasepool，所以无需创建
}

#pragma mark -- setter/getter
// MRC下setter/getter应该这样写
- (NSData *)data{
    return [[_data retain] autorelease]; // 正确的应该这么写
}

- (void)setData:(NSData *)data{ //正确的应该这么写
    if(_data != data){ // 要加这个判断，如果data和_data指向同一个对象的话，release方法执行之后就对象就释放掉了
        [_data release];
        _data = [data retain];
    }
}

- (void)test_setter{
    // 为属性赋值两种方式不同
    // 1.使用临时变量，变量释放一次，对象引用计数为1，dealloc时，引用计数为0，正常
    NSObject * a = [[NSObject alloc] init]; // 对象的引用计数为1
    self.property = a; // 对象的引用计数为2
    NSInteger count3 = _objc_rootRetainCount(self.property);
    [a release];
    NSInteger count4 = _objc_rootRetainCount(a);
    NSLog(@"%s,count:%ld count:%ld",__func__,count3,count4);
    
    // 2.不使用临时变量，需要使用autorelease，autoreleasepool释放一次，dealloc释放一次还是OK的
    self.property = [[[NSObject alloc] init] autorelease];
    
}

// 4. 函数返回值问题
// MRC下
// 4.1 retained return value，需要对象手动释放
// 4.2 unretained return value, 不需要手动释放
// ARC下
// 4.3 retained return value，编译器会加入release
// 4.4 unretained return value，不一定会加入autoreleasepool

// 5.—__weak实现
// 6.ARC优化
// 如果有autorelease又有
// 7. ARC下dealloc中有必要置为nil吗

// 8.如何实现一个leak工具
@end
