//
//  VSBeautyGroupSelector.m
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import "VSBeautyGroupSelector.h"
#import "VSGroupSelectorBaseCollectionView.h"

@interface VSBeautyGroupCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) CALayer *borderLayer;
@end
@implementation VSBeautyGroupCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self _addSubViews];
    }
    return self;
}
- (void)_addSubViews
{
//    CALayer *layer = [[CALayer alloc] init];
//    layer.borderWidth = 1.f;
//    layer.masksToBounds = YES;
//
//    [self.contentView.layer addSublayer:layer];
//    self.borderLayer = layer;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.layer.borderWidth = 1.f;
    [self.contentView addSubview:titleLabel];
    _label = titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.contentView.bounds;
    _label.layer.cornerRadius = self.bounds.size.width / 2.f;
    
//    _borderLayer.frame = self.contentView.bounds;
//    _borderLayer.cornerRadius = self.bounds.size.width / 2.f;
}

@end
@interface VSBeautyGroupSelector() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) VSGroupSelectorBaseCollectionView *collectionView;
@end

@implementation VSBeautyGroupSelector

- (instancetype)initWithSize:(CGSize)size{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    if (self = [super initWithFrame:frame]){
        [self _initProps];
        [self _addSubViews];
    }
    return self;
}

- (void)_initProps{
    _levelCount = 5;
    _currentLevel = 0;
    _normalBgColor = [UIColor colorWithWhite:1.f alpha:.2f];
    _selectedBgColor = [UIColor redColor];
    _normalTextColor = [UIColor whiteColor];
    _selectedTextColor = _normalTextColor;
    
    _borderColor = [UIColor whiteColor];
    _horizontalMargin = 20;
    _leftMagin = 15;
    _normalFont = [UIFont systemFontOfSize:16.f];
}

- (void)_addSubViews{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = self.horizontalMargin;
    
    VSGroupSelectorBaseCollectionView *collectionView = [[VSGroupSelectorBaseCollectionView alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height - 50) / 2, self.frame.size.width, 50) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    collectionView.contentInset = UIEdgeInsetsMake(0, self.leftMagin, 0, 0);
    [collectionView registerClass:[VSBeautyGroupCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView = collectionView;
    [self addSubview:collectionView];
}

- (void)setLeftMagin:(CGFloat)leftMagin{
    _leftMagin = leftMagin;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, leftMagin, 0, 0);
}

- (void)setLevelCount:(NSUInteger)levelCount{
    _levelCount = levelCount;
    [self.collectionView reloadData];
}

- (void)setCurrentLevel:(NSUInteger)currentLevel{
    [self _setupCellItemAtIndex:_currentLevel selected:NO];
    [self _setupCellItemAtIndex:currentLevel selected:YES];
    _currentLevel = currentLevel;
}
#pragma mark - collection delegate/datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.levelCount + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat width = (self.frame.size.width - self.leftMagin * 2 - self.horizontalMargin * self.levelCount) / (self.levelCount + 1);
    return CGSizeMake(width, width);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VSBeautyGroupCollectionViewCell *cell = (VSBeautyGroupCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.item];
    [self _setupCell:cell selected:NO];
    
    if(indexPath.row == self.currentLevel){ //默认第一组
        [self _setupCell:cell selected:YES];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 1.选择某个item
    [self _setupCell:(VSBeautyGroupCollectionViewCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentLevel inSection:0]] selected:YES];
    [self _setupCell:(VSBeautyGroupCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath] selected:YES];
    self.currentLevel = indexPath.item;
    
    // 2.回调代理
    if(self.delegate && [self.delegate respondsToSelector:@selector(vsBeautyGroupSelector:selectLevel:)]){
        [self.delegate vsBeautyGroupSelector:self selectLevel:self.currentLevel];
    }
}
#pragma mark - private
- (void)_setupCell:(VSBeautyGroupCollectionViewCell *)cell selected:(BOOL)selected{
    if (!selected){
        cell.label.backgroundColor = self.normalBgColor;
        
        cell.label.layer.borderColor = self.borderColor.CGColor;
        cell.label.textColor = _normalTextColor;
        cell.label.font = _normalFont;
    }else{
        cell.label.backgroundColor = self.selectedBgColor;
        cell.label.layer.borderColor = self.borderColor.CGColor;
        cell.label.textColor = _selectedTextColor;
        cell.label.font = _selectedFont;
    }
}

- (void)_setupCellItemAtIndex:(NSInteger)index selected:(BOOL)selected{
    [self _setupCell:(VSBeautyGroupCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]] selected:selected];
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *hitTargetView = [super hitTest:point withEvent:event];
//
//    if ([hitTargetView isKindOfClass:UIControl.class]) {
//        return hitTargetView;
//    } else if (hitTargetView != self) {
//        return self.superview;
//    }
//
//    return nil;
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    point = [self convertPoint:point toView:self.superview];
    BOOL inside = [self pointInside:point withEvent:event];
    if (inside){
//        if ([self.collectionView pointInside:point withEvent:event]){
//            return self.collectionView;
//        }
        return self;
    }
    return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
