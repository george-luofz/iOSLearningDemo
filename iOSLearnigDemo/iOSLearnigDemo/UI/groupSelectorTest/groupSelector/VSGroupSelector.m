//
//  VSGroupSelector.m
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import "VSGroupSelector.h"
#import "VSGroupSelectorHeader.h"
#import "VSGroupSelectorContainer.h"
#import "VSFilterGroupSelector.h"
#import "VSBeautyGroupSelector.h"

static CGFloat const KVSGroupSelectorHeaderHeight = 50.f;
static CGFloat const KVSGroupSelectorContainerHeight = 107.f;

@interface VSGroupSelector() <VSGroupSelectorHeaderDelegate, VSGroupSelectorContainerDelegate, VSBeautyGroupSelectorDelegate>
@property (nonatomic, strong) VSGroupSelectorHeader *header; //头部视图
@property (nonatomic, strong) VSGroupSelectorContainer  *selectorContainer; //容器
@property (nonatomic, strong) VSFilterGroupSelector *filterGroupSelector; // 滤镜视图
@property (nonatomic, strong) VSBeautyGroupSelector *beautyGroupSelector; // 美颜视图
@property (nonatomic, strong) VSBeautyGroupSelector *bigFaceGroupSelector; //大眼瘦脸视图
@end

@implementation VSGroupSelector

- (instancetype)init{
    
    if (self = [super init]){
        self.bounds = CGRectMake(0, 0, self.frame.size.width, KVSGroupSelectorHeaderHeight + KVSGroupSelectorContainerHeight);;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:.5f];
//        self.needTapAirDisappear = YES;
        [self _addSubViews];
    }
    return self;
}

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex{
    _currentSelectIndex = currentSelectIndex;
    // TODO:
}

- (void)_addSubViews{
    [self addSubview:self.header];
    [self addSubview:self.selectorContainer];
    
    [self.selectorContainer addSubview:self.beautyGroupSelector atIndex:0];
    [self.selectorContainer addSubview:self.filterGroupSelector atIndex:1];
    [self.selectorContainer addSubview:self.bigFaceGroupSelector atIndex:2];
}
#pragma mark - getters
- (VSGroupSelectorHeader *)header{
    if (_header == nil){
        _header = [[VSGroupSelectorHeader alloc] initWithSize:CGSizeMake(self.frame.size.width, KVSGroupSelectorHeaderHeight)];
        _header.groupSelector = self;
        _header.delegate = self;
        [_header setupSubViews];
    }
    return _header;
}

- (VSGroupSelectorContainer *)selectorContainer{
    if (_selectorContainer == nil){
        _selectorContainer = [[VSGroupSelectorContainer alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.header.frame), self.frame.size.width, KVSGroupSelectorContainerHeight)];
        _selectorContainer.scrollDelegate = self;
    }
    return _selectorContainer;
}

- (VSFilterGroupSelector *)filterGroupSelector{
    if (_filterGroupSelector == nil){
        _filterGroupSelector = [[VSFilterGroupSelector alloc] initWithFrame:self.selectorContainer.bounds];
//        _filterGroupSelector.delegate = self;
//        _filterGroupSelector.useBeauty = NO;
    }
    return _filterGroupSelector;
}

- (VSBeautyGroupSelector *)beautyGroupSelector{
    if (_beautyGroupSelector ==nil){
        _beautyGroupSelector = [[VSBeautyGroupSelector alloc] initWithSize:self.selectorContainer.bounds.size];
        _beautyGroupSelector.delegate = self;
        _beautyGroupSelector.backgroundColor = [UIColor greenColor];
    }
    return _beautyGroupSelector;
}

- (VSBeautyGroupSelector *)bigFaceGroupSelector{
    if (_bigFaceGroupSelector ==nil){
        _bigFaceGroupSelector = [[VSBeautyGroupSelector alloc] initWithSize:self.selectorContainer.bounds.size];
        _bigFaceGroupSelector.delegate = self;
        _bigFaceGroupSelector.backgroundColor = [UIColor orangeColor];
    }
    return _bigFaceGroupSelector;
}

#pragma mark - header delegate
- (void)clickAtIndex:(NSInteger)index titleStr:(NSString *)title{
    // change container
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickHeaderAtIndex:titleStr:)]){
        [self.delegate clickHeaderAtIndex:index titleStr:title];
    }
}

#pragma mark - container delegate
- (void)vsGroupSelectorContainerScrollCurrentOffSet:(CGPoint)curOffSet beforeOffSet:(CGPoint)beforeOffSet{
    
}

#pragma mark - fileter delegate

#pragma mark - beauty delegate
- (void)vsBeautyGroupSelector:(VSBeautyGroupSelector *)selector selectLevel:(NSUInteger)level{
    if ([selector isEqual:self.beautyGroupSelector]){
        
    }else if ([selector isEqual:self.bigFaceGroupSelector]){
        
    }
}
#pragma mark - bigface delegate
@end
