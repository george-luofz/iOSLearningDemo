//
//  CustomFlowLayout.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "CustomFlowLayout.h"

#define layoutColumnCount 3
#define layoutColumnMagin  10
#define layoutRowMagin 10

@interface CustomFlowLayout()
@property NSMutableArray *layoutArrs;
@end
@implementation CustomFlowLayout

- (NSMutableArray *)layoutArrs{
    if (!_layoutArrs) {
        _layoutArrs = [NSMutableArray array];
    }
    return _layoutArrs;
}

- (void)prepareLayout{
    
    // 清楚之前所有的布局属性
    [self.layoutArrs removeAllObjects];
    
    // 开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++) {
        
        // 创建位置
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        // 获取indexPath位置上cell对应的布局属性
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.layoutArrs addObject:attrs];
    }
}

- (CGSize)collectionViewContentSize{
    return CGSizeMake(0,self.collectionView.nn_height * 2);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.layoutArrs;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return self.layoutArrs
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    // 主要是计算frame
    CGFloat itemH = [self _heightOfIndexPath:indexPath];
    CGFloat itemW = (self.collectionView.nn_width - layoutColumnMagin * (layoutColumnCount - 1)) / layoutColumnCount;
//    NSInteger destColumn = 0;
//    for (int i = 0 ; i < layoutColumnCount; i++) {
//
//    }
    CGFloat itemX = indexPath.row * (itemW + layoutColumnMagin);
    CGFloat itemY = 10;
    CGRect frame = CGRectMake(itemX, itemY, itemW, itemH);
    att.frame = frame;
    return att;
}

- (CGFloat)_heightOfIndexPath:(NSIndexPath *)indexPath{
    return 50 + indexPath.row * 10;
}
@end
