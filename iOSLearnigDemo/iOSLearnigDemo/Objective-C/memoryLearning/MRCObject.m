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
@property (nonatomic,strong) NSData *data;
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

- (NSData *)data{
    return [[_data retain] autorelease]; // 正确的应该这么写
}

- (void)setData:(NSData *)data{ //正确的应该这么写
    if(_data != data){ // 要加这个判断，如果data和_data指向同一个对象的话，release方法执行之后就对象就释放掉了
        [_data release];
        _data = [data retain];
    }
}

#pragma mark -- MRC
// 1.谁持有或者谁创建，谁负责释放
// 2.alloc init new copy retain 会修改引用计数+1
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
@end
