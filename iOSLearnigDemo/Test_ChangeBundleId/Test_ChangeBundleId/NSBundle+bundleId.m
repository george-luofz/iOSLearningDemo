//
//  NSBundle+bundleId.m
//  Test_ChangeBundleId
//
//  Created by 罗富中 on 2020/7/16.
//  Copyright © 2020 George_luofz. All rights reserved.
//

#import "NSBundle+bundleId.h"
#import <objc/runtime.h>

static NSString *kChangedBundleIdentifier = @"com.sina.yizhibo";
static NSString *kBundleIdentifierInInfoDict = @"CFBundleIdentifier";

@implementation NSBundle (bundleId)

- (NSString *)bundleIdentifier {
    return kChangedBundleIdentifier;
}

- (NSDictionary<NSString *,id> *)localizedInfoDictionary {
    NSDictionary *oriDict = [self _wbt_invokeOriginalSelector:_cmd];
    if ([oriDict isKindOfClass:[NSDictionary class]] && oriDict.allKeys.count) {
        NSMutableDictionary *tempDict = [oriDict mutableCopy];
        [tempDict setObject:kChangedBundleIdentifier forKey:kBundleIdentifierInInfoDict];
        return [tempDict copy];
    }
    return oriDict;
}

- (NSDictionary<NSString *,id> *)infoDictionary {
    NSDictionary *oriDict = [self _wbt_invokeOriginalSelector:_cmd];
    if ([oriDict isKindOfClass:[NSDictionary class]] && oriDict.allKeys.count) {
        NSMutableDictionary *tempDict = [oriDict mutableCopy];
        [tempDict setObject:kChangedBundleIdentifier forKey:kBundleIdentifierInInfoDict];
        return [tempDict copy];
    }
    return oriDict;
}

- (id)_wbt_invokeOriginalSelector:(SEL)selector {
    // Get the class method list
    uint count;
    Method *list = class_copyMethodList([self class], &count);

    id returnValue = nil;
    // Find and call original method .
    for ( int i = count - 1 ; i >= 0; i--) {
        Method method = list[i];
        SEL name = method_getName(method);
        IMP imp = method_getImplementation(method);
        
        if (name == selector) {
            returnValue = ((id (*)(id, SEL))imp)(self, name);
            break;
        }
    }
    free(list);
    return returnValue;
}
@end
