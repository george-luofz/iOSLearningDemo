//
//  VSGroupSelectorHeader.m
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//
#import "VSGroupSelectorHeader.h"
#import "VSGroupSelector.h"

@interface VSGroupHeaderCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UILabel *titleLabel;
@end
@implementation VSGroupHeaderCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self addTabTitleLabel];
    }
    return self;
}
- (void)addTabTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [UIColor darkTextColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLabel.frame = self.contentView.bounds;
}
@end

@interface VSGroupSelectorHeader() <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView   *underLine;

@end
@implementation VSGroupSelectorHeader

- (instancetype)initWithSize:(CGSize)size{
    if (self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)]){
        _titles = @[@"滤镜",@"美颜",@"大眼瘦脸"];
        [self _setupCommonProps];
    }
    return self;
}

- (void)setTitles:(NSArray<NSString *> *)titles{
    _titles = titles;
    [self.collectionView reloadData];
    if (self.collectionView.contentSize.width > self.frame.size.width){
        self.collectionView.scrollEnabled = YES;
    }
}

- (void)scollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{
    if (fromIndex == toIndex) return;
    
    // underline
    // item
    [self _scrollUnderLineFromIndex:fromIndex toIndex:toIndex progress:progress];
    [self _scrollCellItemFromIndex:fromIndex toIndex:toIndex progress:progress];
    self.currentSelectIndex = toIndex;
}

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex{
    [self clickFromIndex:_currentSelectIndex toIndex:currentSelectIndex animated:NO];
    _currentSelectIndex = currentSelectIndex;
}

- (void)setupSubViews{
    [self _addSubViews];
}

- (void)_addSubViews{
    // collectionView
    // underLine
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.scrollEnabled = NO;
    collectionView.contentInset = UIEdgeInsetsMake(0, 20, 0, 0);
    [collectionView registerClass:[VSGroupHeaderCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView = collectionView;
    [self addSubview:collectionView];
    
    UIView *underLine = [[UIView alloc] initWithFrame:[self _underLineFrameAtIndex:self.currentSelectIndex]];
    _underLine = underLine;
    _underLine.backgroundColor = self.underLineColor;
    [_collectionView addSubview:underLine];
}

- (void)_setupCommonProps{
    _normalFont = [UIFont systemFontOfSize:16.f];
    _selectedFont = _normalFont;
    _normalColor = [UIColor colorWithWhite:1.0f alpha:.5];
    _selectedColor = [UIColor redColor];
    _tagTopMagin = 14.f;
    _tagHorizontalMargin = 62.f;
    
    _useConstantUnderLineWidth = NO;
    _underLineWidth = 20.f;
    _underLineHeight = 3.f;
    _underLineColor = _selectedColor;
    
    _currentSelectIndex = 0;
    _selectedScale = 0;
}

#pragma mark - 滚动到某组
- (void)_scrollUnderLineFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{
    CGRect fromIndexCellFrame = [self _cellFrameAtIndex:fromIndex];
    CGRect toIndexCellFrame = [self _cellFrameAtIndex:toIndex];
    CGFloat currentOriginX = fromIndexCellFrame.origin.x + (toIndexCellFrame.origin.x - fromIndexCellFrame.origin.x) * progress;
    CGFloat currentWidth = fromIndexCellFrame.size.width + (toIndexCellFrame.size.width - fromIndexCellFrame.size.width) * progress;
    CGRect currentUnderLineFrame = CGRectMake(currentOriginX, _underLine.frame.origin.y, currentWidth, _underLine.frame.size.height);
    _underLine.frame = currentUnderLineFrame;
}

- (void)_scrollCellItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{
    [self _scrollCellItemToIndex:toIndex animated:YES];
    [self _scrollCellItemColorFromIndex:fromIndex toIndex:toIndex progress:progress];
    [self _scrollCellItemScaleFromIndex:fromIndex toIndex:toIndex progress:progress];
    // 其他操作
}

- (void)_scrollCellItemToIndex:(NSInteger)toIndex animated:(BOOL)animated{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}

- (void)_scrollCellItemColorFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{
    if(_selectedColor == nil) return;
    
    VSGroupHeaderCollectionViewCell *currentSelectCell = (VSGroupHeaderCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    VSGroupHeaderCollectionViewCell *currentNormalCell = (VSGroupHeaderCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    
    CGFloat fromR,fromG,fromB,fromA;
    CGFloat toR,toG,toB,toA;
    [_selectedColor getRed:&fromR green:&fromG blue:&fromB alpha:&fromA];
    [_normalColor getRed:&toR green:&toG blue:&toB alpha:&toA];
    
    CGFloat currentNormalR,currentNomalG,currentNomalB,currentNomalA;
    currentNormalR = fromR + (toR - fromR) * progress;
    currentNomalG = fromG + (toG - fromG) * progress;
    currentNomalB = fromB + (toB - fromB) * progress;
    currentNomalA = fromA + (toA - fromA) * progress;
    
    CGFloat currentSelectR,currentSelectG,currentSelectB,currentSelectA;
    currentSelectR = toR - (toR - fromR) * progress;
    currentSelectG = toG - (toG - fromG) * progress;
    currentSelectB = toB - (toB - fromB) * progress;
    currentSelectA = toA - (toA - fromA) * progress;
    
    UIColor *currentNormalColor = [UIColor colorWithRed:currentNormalR green:currentNomalG blue:currentNomalB alpha:currentNomalA];
    UIColor *currentSelectColor = [UIColor colorWithRed:currentSelectR green:currentSelectG blue:currentSelectB alpha:currentSelectA];
    
    currentNormalCell.titleLabel.textColor = currentSelectColor;
    currentSelectCell.titleLabel.textColor = currentNormalColor;
}

- (void)_scrollCellItemScaleFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(CGFloat)progress{
    if(_selectedScale == 0) return;
    
    CGFloat scale = _selectedScale;
    CGFloat currentSelectScale = scale - (scale - 1) * progress;
    CGFloat currentNormalScale = 1 + (scale - 1) * progress;
    
    [self _scaleCellItem:fromIndex scale:currentSelectScale];
    [self _scaleCellItem:toIndex scale:currentNormalScale];
}

- (void)_scaleCellItem:(NSInteger)index scale:(CGFloat)scale{
    if (self.selectedScale == 0) return;
    VSGroupHeaderCollectionViewCell *currentSelectCell = (VSGroupHeaderCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    currentSelectCell.transform = CGAffineTransformMakeScale(scale, scale);
}

#pragma mark - 点击切换到某组
- (void)clickFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated{
    if (fromIndex == toIndex) return;
    [self _clickUnderLineFromIndex:fromIndex toIndex:toIndex animated:animated];
    [self _clickCellItemFromIndex:fromIndex toIndex:toIndex animated:animated];
}

- (void)_clickUnderLineFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated{
    CGRect frame = [self _underLineFrameAtIndex:toIndex];
    if (animated){
        [UIView animateWithDuration:.25f animations:^{
            self.underLine.frame = frame;
        }];
    }else{
        _underLine.frame = frame;
    }
}

- (void)_clickCellItemFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex animated:(BOOL)animated{
    [self _scrollCellItemToIndex:toIndex animated:animated];
    VSGroupHeaderCollectionViewCell *currentSelectCell = (VSGroupHeaderCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:toIndex inSection:0]];
    currentSelectCell.titleLabel.textColor = _selectedColor;
    VSGroupHeaderCollectionViewCell *beforeSelectCell = (VSGroupHeaderCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:fromIndex inSection:0]];
    beforeSelectCell.titleLabel.textColor = _normalColor;
    [self _scaleCellItem:toIndex scale:self.selectedScale];
    [self _scaleCellItem:fromIndex scale:1];
    
}
#pragma mark - collection delegate/datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat width = [self _stringWidthAtIndex:indexPath.row font:_normalFont constraintedToSize:CGSizeMake(300, 100)];
    return CGSizeMake(width, self.frame.size.height - 2 * _tagTopMagin); //减去topMagin
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return _tagHorizontalMargin;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VSGroupHeaderCollectionViewCell *cell = (VSGroupHeaderCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titleLabel.backgroundColor = [UIColor orangeColor];
    cell.titleLabel.text = [_titles objectAtIndex:indexPath.row];
    cell.titleLabel.textColor = _normalColor;
    cell.titleLabel.font = _normalFont;
    
    if(indexPath.row == 0){ //默认第一组
        cell.titleLabel.textColor = _selectedColor;
        [self _scaleCellItem:indexPath.item scale:self.selectedScale];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 1.选择某个item
    [self clickFromIndex:self.currentSelectIndex toIndex:indexPath.item animated:YES];
    self.currentSelectIndex = indexPath.item;
    // 2.回调代理
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickAtIndex:titleStr:)]){
        [self.delegate clickAtIndex:indexPath.item titleStr:self.titles[indexPath.item]];
    }
}

#pragma mark -- 数值处理

- (CGRect)_cellFrameAtIndex:(NSInteger)index{
    UICollectionViewLayoutAttributes *att = [_collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
    return att.frame;
}

- (CGFloat)_underLineWidthAtIndex:(NSInteger)index{
    return [self _cellFrameAtIndex:index].size.width;
}

- (CGFloat)_stringWidthAtIndex:(NSInteger)index font:(UIFont *)font constraintedToSize:(CGSize)size{
    NSString *string = [_titles objectAtIndex:index];
    CGSize textSize = CGSizeZero;
    
    CGRect frame = [string boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName:font } context:nil];
    textSize = CGSizeMake(frame.size.width, frame.size.height + 1);
    return frame.size.width;
}

- (CGRect)_underLineFrameAtIndex:(NSInteger)index{
    CGRect cellFrame = [self _cellFrameAtIndex:index];
    CGFloat underLineOriginX = cellFrame.origin.x;
    
    CGRect frame = CGRectNull;
    if (_useConstantUnderLineWidth && self.underLineWidth){
        frame = CGRectMake(underLineOriginX, self.frame.size.height - self.underLineHeight, self.underLineWidth, self.underLineHeight);
    }else{
        frame = CGRectMake(underLineOriginX, self.frame.size.height - self.underLineHeight, cellFrame.size.width, self.underLineHeight);
    }
    return frame;
}
@end
