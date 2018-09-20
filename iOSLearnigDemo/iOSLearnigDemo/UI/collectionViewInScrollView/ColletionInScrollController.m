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
@property (nonatomic, strong) UICollectionView *colletionView2;


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
//    flowLayout.itemSize = CGSizeMake(100, 100);
//    flowLayout.minimumInteritemSpacing = 10;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.bounds collectionViewLayout:flowLayout];
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

- (void)_test{
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = <##>;
//    label.frame = CGRectMake(<##>,<##>,<##>,<##>);
//    label.text = <##>;
//    label.font = [UIFont systemFontOfSize:<##><##>];
//    label.textColor = <##>;
//    label.textAlignment = <##>;
//    label.numberOfLines = 0;

    
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(<##>, <##>, <##>, <##>) style:UITableViewStylePlain];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//
//    tableView.tableHeaderView = <##>;
//    tableView.tableFooterView = [UIView new];
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//
//    [tableView registerClass:[<##> class] forCellReuseIdentifier:<##>];
    
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(<##>, <##>, <##>, <##>);
//    btn.backgroundColor = [UIColor clearColor];
//    [btn setTitle:<##> forState:UIControlStateNormal];
//    [btn setImage:<##> forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(<##>:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    flowLayout.itemSize = CGSizeMake(<##>, <##>);
//    flowLayout.minimumInteritemSpacing = <##>;
//
//    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.scrollView.bounds collectionViewLayout:flowLayout];
//    collectionView.dataSource = self;
//    collectionView.delegate = self;
//    collectionView.bounces = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    collectionView.showsVerticalScrollIndicator = NO;
//
//    [collectionView registerClass:[<##> class] forCellWithReuseIdentifier:<##>];
    
    
//#pragma mark -
//#pragma mark - tableView
//    -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//    {
//        return 1;
//    }
//
//    -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//    {
//        return <#expression#>
//    }
//
//    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//        <#classCell#> * cell = [tableView dequeueReusableCellWithIdentifier:<#(nonnull NSString *)#>];
//
//        return cell;
//    }
//
//    -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//
//    }
//
//    -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//    {
//        return <#expression#>
//    }
//}

//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = <##>;
//    imageView.userInteractionEnabled = YES;
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.image = <##>;
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(<##>)];
//    [<##> addGestureRecognizer:tap];
    
//[UIScreen mainScreen].bounds.size.width
//[UIScreen mainScreen].bounds.size.height

    
}



@end
