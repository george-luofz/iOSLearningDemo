//
//  ColletionInScrollController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/21.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ColletionInScrollController.h"

@interface ColletionInScrollController () <UIScrollViewDelegate ,UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UICollectionView *colletionView;
@property (nonatomic) UICollectionView *colletionView2;
@end

@implementation ColletionInScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _addScrollView];
    [self _addCollectionView];
    [self _addCollectionView2];
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.colletionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.colletionView2 addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)_addScrollView{
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.nn_width, 300)];
//    scollView.showsVerticalScrollIndicator = NO;
    scollView.showsHorizontalScrollIndicator = NO;
    scollView.delegate = self;
    scollView.pagingEnabled = YES;
    scollView.scrollEnabled = NO;
    scollView.contentSize = CGSizeMake(self.view.nn_width * 2, 0);
    self.scrollView = scollView;
    [self.view addSubview:scollView];
}
- (void)_addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.bounds collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];  //手动设置背景色
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _colletionView = collectionView;
    [self.scrollView addSubview:collectionView];
}

- (void)_addCollectionView2{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.colletionView.frame), 0, self.colletionView.nn_width, self.colletionView.nn_height)  collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];  //手动设置背景色
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
    _colletionView2 = collectionView;
    [self.scrollView addSubview:collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CGSizeMake(self.colletionView.nn_width, self.colletionView.nn_height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:self.colletionView]){
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        if (cell == nil){
            cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.colletionView.nn_width, self.colletionView.nn_height)];
        }
        cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random()%255 / 255.0 green:arc4random()%255 / 255.0 blue:arc4random()%255 / 255.0 alpha:1.f];
        return cell;
    }
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    if (cell == nil){
        cell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, self.colletionView.nn_width, self.colletionView.nn_height)];
    }
    UIColor *color = nil;
    if (indexPath.item %2 ==0){
        color = [UIColor redColor];
    }else{
        color = [UIColor greenColor];
    }
    cell.contentView.backgroundColor = color;
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]){
        CGPoint offSet = [(UIScrollView *)object contentOffset];
        CGFloat offSetX = offSet.x;
        CGFloat width = self.colletionView.nn_width * 2;
        if ([object isEqual:self.colletionView]){
            if (offSetX == self.colletionView.nn_width * 2 + 20){
                self.colletionView.scrollEnabled = NO;
                self.scrollView.scrollEnabled = YES;
//                self.colletionView2.scrollEnabled = YES;
            }
        }
        if ([object isEqual:self.colletionView2]){
            if (offSetX == self.colletionView.nn_width + 20){
                self.scrollView.scrollEnabled = YES;
                self.colletionView2.scrollEnabled = NO;
//                self.colletionView.scrollEnabled = YES;
            }
            if (offSetX == 0){
                self.scrollView.scrollEnabled = YES;
                self.colletionView2.scrollEnabled = NO;
            }
        }
        if ([object isEqual:self.scrollView]){
            if (offSetX == 0){
                self.scrollView.scrollEnabled = NO;
//                self.colletionView2.scrollEnabled = NO;
                self.colletionView.scrollEnabled = YES;
            } else if (offSetX == self.scrollView.nn_width){
                self.scrollView.scrollEnabled = NO;
                //                self.colletionView2.scrollEnabled = NO;
                self.colletionView2.scrollEnabled = YES;
            }
        }
    }
}

- (void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.colletionView2 removeObserver:self forKeyPath:@"contentOffset"];
    [self.colletionView removeObserver:self forKeyPath:@"contentOffset"];
}
@end
