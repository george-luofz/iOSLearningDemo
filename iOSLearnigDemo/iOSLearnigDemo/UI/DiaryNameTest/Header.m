//
//  Header.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/28.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "Header.h"
#import "HeaderCollectionViewCell.h"
#import "CustomFlowLayout.h"

@interface Header()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic) UICollectionView *collectionView;
@end
@implementation Header

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self _addSubViews];
    }
    return self;
}

- (void)_addSubViews{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumInteritemSpacing = 20;
    
    CustomFlowLayout *layouts = [[CustomFlowLayout alloc] init];
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layouts];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[HeaderCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HeaderCollectionViewCell class])];
    
    [self addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.dataSource.count + 1;
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HeaderCollectionViewCell class]) forIndexPath:indexPath];
    
    return cell;
}
@end
