//
//  KVOTestController.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/6.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "KVOTestController.h"
#import "MJPerson.h"
#import <objc/runtime.h>

@interface KVOTestController ()

@end

@implementation KVOTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MJPerson *person = [MJPerson new];
    person.age = 10;
    person.name = @"富中";
    
    // 替换isa
//    NSLog(@"person before class :%@",object_getClass(person));
    [person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:nil];
//    [person willChangeValueForKey:@"age"];
//    [person didChangeValueForKey:@"age"];
//    NSLog(@"person after class :%@",object_getClass(person));
    
    person.age = 10;
    
    // 替换imp
    Method method = class_getInstanceMethod(object_getClass(person), @selector(setAge:));
    IMP imp = method_getImplementation(method);
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    id newValue = change[NSKeyValueChangeNewKey];
    NSLog(@"%s",_cmd);
}


// kvo本质：
// 1. isa 替换，实现一个新类NSKVONotifying_MJPerson，继承于原类，将isa指向新类，如何属性：automaticallyNotifiesObserversOfAge为NO，则不实现
// 2. imp 替换，替换新类中set方法imp -> _NSSetLongLongValueAndNotify
// 3. 内部调用willChangeValueForKey -> [super set] -> didChangeValueForKey -> 该方法内部NSKeyValueDidChange类 -> NSKeyValueNotifyObserver -> 调用observer keyPath方法，核心是didChangeValueForKey方法
@end
