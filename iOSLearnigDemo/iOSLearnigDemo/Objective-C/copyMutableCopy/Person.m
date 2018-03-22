//
//  Person.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/21.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "Person.h"
@interface Person()<NSCopying,NSMutableCopying>
@end
@implementation Person

- (id)copyWithZone:(NSZone *)zone{
    Person *person = [Person allocWithZone:zone];
    person.name = self.name;
    person.year = self.year;
    return person;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    Person *person = [Person allocWithZone:zone];
    person.name = self.name;
    person.year = self.year;
    return person;
}
@end
