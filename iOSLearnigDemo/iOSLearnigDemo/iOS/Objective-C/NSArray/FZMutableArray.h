//
//  FZMutableArray.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/24.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZMutableArray : NSMutableArray
{
    @public
    unsigned long long _used;
    unsigned long long _doHardRetain:1;
    unsigned long long _doWeakAccess:1;
    unsigned long long _size:62;
    unsigned long long _hasObjects:1;
    unsigned long long _hasStrongReferences:1;
    unsigned long long _offset:62;
    unsigned long long _mutations;
    __unsafe_unretained id *_list;
}
@end

NS_ASSUME_NONNULL_END
