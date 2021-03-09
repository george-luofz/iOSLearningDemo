//
//  main.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/14.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <malloc/malloc.h>

struct Student_IMPL {
    Class isa;
    int _no;
    int _age;
};

struct MJ_object_class {
    Class isa;
};

@interface Student : NSObject {
@public
    int _no;
    int _age;
}

@end

@implementation Student

@end

int main(int argc, char * argv[]) {
    
    // 获取类实际分配内存大小：
    NSObject *obj = [[NSObject alloc] init];
    NSLog(@"%ld",malloc_size((__bridge void *)obj));
    
    Student *stu = [Student new];
    stu->_no = 10;
    stu->_age = 5;
    
    // Student对象本质
    struct Student_IMPL *stuImpl = (__bridge struct Student_IMPL*)stu;
    NSLog(@"stu:age:%d",stuImpl->_age);
    NSLog(@"stu: %ld",malloc_size((__bridge void *)obj));
    
    
    /* isa地址值
     ISA_MASK: 0x007ffffffffffff8
     
     class 对象：0x0000000102eb6648
     isa: 0x0000000102eb6648 (类对象并没有isa_mask)
     
     元类对象：0x00000001053fb648
     类 isa: 0x00000001053fb620
     isa & ISA_MASK : 0x00000001053fb620 (相等了)
     */
    Student *s1 = [Student new];
    Class sClass = [Student class];
    Class metaClass = [sClass class];
    
    struct MJ_object_class *meta_class_st = (__bridge struct MJ_object_class *)sClass;
    NSLog(@"hhh");
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
