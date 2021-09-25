//
//  JSONViewerDataSource.h
//  iOSLearnigDemo
//
//  Created by luofuzhong on 2021/9/25.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONNodeLayoutModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSONViewerDataSource : NSObject
@property (nonatomic, strong) NSArray<JSONNodeLayoutModel *> *dataSources;

@end

NS_ASSUME_NONNULL_END
