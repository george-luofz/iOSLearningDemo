//
//  JSONNodeLayoutModel.h
//  iOSLearnigDemo
//
//  Created by luofuzhong on 2021/9/25.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONNodeLayoutModel : NSObject
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *value;

@property (nonatomic, assign) NSInteger rootDepth;
@property (nonatomic, assign) NSInteger depth;

@property (nonatomic, assign) BOOL isRootNode;
@property (nonatomic, assign) BOOL isLastNode;

@property (nonatomic, strong) NSArray<JSONNodeLayoutModel *> *subNodes;
@end

NS_ASSUME_NONNULL_END
