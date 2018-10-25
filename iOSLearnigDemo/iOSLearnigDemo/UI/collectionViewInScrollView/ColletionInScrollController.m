//
//  ColletionInScrollController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/21.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "ColletionInScrollController.h"
#import "ScrollTestCollectionViewCell.h"

@interface ColletionInScrollController () <UIScrollViewDelegate ,UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UICollectionView *colletionView;
@property (nonatomic, strong) UICollectionView *colletionView2;
@property (nonatomic, strong) UICollectionView *colletionView3;

@property (nonatomic, strong) NSArray *dataSource1;
@property (nonatomic, strong) NSArray *dataSource2;
@property (nonatomic, strong) NSArray *dataSource3;

@property (nonatomic, strong) NSMutableArray *collectionViews;
@property (nonatomic, strong) NSArray *everycollectionPages;
@property (nonatomic, assign) CGFloat beforeOffset;
@end

@implementation ColletionInScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource1= @[@(1),@(2)];
    self.dataSource2= @[@(1),@(2),@(3)];
    self.dataSource3= @[@(1),@(2),@(3),@(4)];
    self.everycollectionPages = @[@(self.dataSource1.count),@(self.dataSource2.count),@(self.dataSource3.count)];
    self.collectionViews = [NSMutableArray arrayWithCapacity:3];
    [self _addScrollView];

    
    [self _addCollectionView];
    [self _addCollectionView2];
    [self _addCollectionView3];
    
//
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.colletionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.colletionView2 addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.colletionView3 addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
//    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    swipeGesture.delegate = self;
//    [self.view addGestureRecognizer:swipeGesture];
}

- (void)_addScrollView{
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.nn_width, 300)];
    scollView.showsHorizontalScrollIndicator = NO;
//    scollView.delegate = self;
    scollView.pagingEnabled = YES;
    scollView.scrollEnabled = YES;
    scollView.contentSize = CGSizeMake(self.view.nn_width * 3, 0);
    self.scrollView = scollView;
//    self.scrollView.delegate = self;
    
    [self.view addSubview:scollView];
    
}
- (void)_addCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.nn_width, 300);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.bounces = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _colletionView = collectionView;
    [self.scrollView addSubview:collectionView];

    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScrollTestCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellId"];
//    collectionView.scrollEnabled = NO;
    [self.collectionViews addObject:self.colletionView];
    collectionView.delaysContentTouches = NO;
}

- (void)_addCollectionView2{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.nn_width, 300);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.colletionView.frame), 0, self.colletionView.nn_width, self.colletionView.nn_height)  collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];  //手动设置背景色
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _colletionView2 = collectionView;
    [self.scrollView addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScrollTestCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    [self.collectionViews addObject:self.colletionView2];
//    collectionView.scrollEnabled = NO;
    collectionView.delaysContentTouches = NO;
}

- (void)_addCollectionView3{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(self.view.nn_width, 300);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.colletionView2.frame), 0, self.colletionView.nn_width, self.colletionView.nn_height)  collectionViewLayout:flowLayout];
    collectionView.backgroundColor = [UIColor whiteColor];  //手动设置背景色
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.pagingEnabled = YES;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.bounces = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _colletionView3 = collectionView;
    [self.scrollView addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ScrollTestCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellId"];
    [self.collectionViews addObject:self.colletionView3];
//    collectionView.scrollEnabled = NO;
    collectionView.delaysContentTouches = NO;
    
}
/// 处理子视图假设不能滚动，挺操蛋的
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    return;
//    if ([keyPath isEqualToString:@"contentOffset"]){
//        CGPoint offSet = [(UIScrollView *)object contentOffset];
//        CGFloat offSetX = offSet.x;
//        __block NSUInteger scrollViewIndex = 0;
//        [self.collectionViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if ([obj isEqual:object]){
//                scrollViewIndex = idx;
//                *stop = YES;
//            }
//        }];
//        // 是父视图
//        if ([object isEqual:self.scrollView]){
//            if(offSetX == 0){
//
//            }
//        }
//        // 子视图
//        UIScrollView *curScroll = (UIScrollView *)object;
//        if (scrollViewIndex == 0){
//            if (offSetX == self.scrollView.nn_width * ([self.everycollectionPages[0] integerValue] - 1)){
//                curScroll.scrollEnabled = NO;
//                self.scrollView.scrollEnabled = YES;
//            }
//        } else if (scrollViewIndex == self.collectionViews.count - 1){
//
//        } else {
//            if (offSetX == self.scrollView.nn_width * (scrollViewIndex - 1) || offSetX == ){
//                self.scrollView.scrollEnabled = YES;
//                curScroll.scrollEnabled = NO;
//            }
//        }
//    }
//    return;
    //
    
//    if ([keyPath isEqualToString:@"contentOffset"]){
//
//        CGPoint offSet = [(UIScrollView *)object contentOffset];
//        NSLog(@"%ld,bounds origin x :%lf,offsetX: %lf",[self objectCellIndex:object],[(UIScrollView *)object bounds].origin.x,offSet.x);
//        return;
//        CGFloat offSetX = offSet.x;
//        if ([object isEqual:self.colletionView]){
//            if (offSetX == self.colletionView.nn_width * (self.dataSource1.count - 1) + 1){
//                self.colletionView.scrollEnabled = NO;
//                self.scrollView.scrollEnabled = YES;
////                self.colletionView2.scrollEnabled = YES;
//            }
//            if (offSetX == 0){
//                self.colletionView.scrollEnabled = NO;
//                self.scrollView.scrollEnabled = YES;
//                //                self.colletionView2.scrollEnabled = YES;
//            }
//        }
//        if ([object isEqual:self.colletionView2]){
//            if (offSetX == self.colletionView.nn_width * (self.dataSource2.count - 1) + 1){
//                self.scrollView.scrollEnabled = YES;
//                self.colletionView2.scrollEnabled = NO;
////                self.colletionView.scrollEnabled = YES;
//            }
//            if (offSetX == 0){
//                self.scrollView.scrollEnabled = YES;
//                self.colletionView2.scrollEnabled = NO;
//            }
//        }
//        if ([object isEqual:self.scrollView]){
//            if (offSetX == 5){
//                self.scrollView.scrollEnabled = NO;
//                self.colletionView.scrollEnabled = YES;
//            } else if (offSetX == self.scrollView.nn_width + 5){
//                self.scrollView.scrollEnabled = NO;
//                self.colletionView2.scrollEnabled = YES;
//            }
//        }
//    }
}

- (void)dealloc{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.colletionView2 removeObserver:self forKeyPath:@"contentOffset"];
    [self.colletionView removeObserver:self forKeyPath:@"contentOffset"];
    [self.colletionView3 removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark -
#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if ([collectionView isEqual:self.colletionView]){
        return self.dataSource1.count;
    } if ([collectionView isEqual:self.colletionView2]){
        return self.dataSource2.count;
    }
    return self.dataSource3.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ScrollTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    if ([collectionView isEqual:self.colletionView]){
        cell.backgroundColor = [UIColor redColor];
    } else if ([collectionView isEqual:self.colletionView2]){
        cell.backgroundColor = [UIColor yellowColor];
    } else if ([collectionView isEqual:self.colletionView3]){
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.itemLabel.text = [NSString stringWithFormat:@"item %ld",(long)indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    self.scrollView.scrollEnabled = NO;
    return YES;
}

- (void)handleSwipe:(UIGestureRecognizer*)gestureRecognizer
{
    
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    self.scrollView.scrollEnabled = NO;
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (!decelerate)
//    {
//        self.scrollView.scrollEnabled = YES;
//    }
//}
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    self.scrollView.scrollEnabled = YES;
//}
- (NSInteger)objectCellIndex:(UIScrollView *)scrollView{
    for (int i = 0 ; i < self.collectionViews.count; i++) {
        if ([scrollView isEqual:self.collectionViews[i]]){
            return i;
        }
    }
    return -1;
}
#pragma mark - test 分页是否支持子视图2倍屏宽【不支持】
- (void)_testPageSupport2ScreenWidth{
    UIView *subView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.nn_width, self.scrollView.nn_height)];
    subView1.backgroundColor = [UIColor redColor];
    
    UIView *subView2 = [[UIView alloc] initWithFrame:CGRectMake(self.scrollView.nn_width, 0, self.scrollView.nn_width , self.scrollView.nn_height)];
    subView2.backgroundColor = [UIColor greenColor];
    [self.scrollView addSubview:subView1];
    [self.scrollView addSubview:subView2];
}
@end
