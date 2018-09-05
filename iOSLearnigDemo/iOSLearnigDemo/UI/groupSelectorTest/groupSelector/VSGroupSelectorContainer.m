//
//  VSGroupSelectorContainer.m
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import "VSGroupSelectorContainer.h"
@interface VSGroupSelectorContainer() <UIScrollViewDelegate>{
    CGPoint _beforeOffset;
}
@end

@implementation VSGroupSelectorContainer

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        [self _initProperty];
    }
    return self;
}

- (void)addSubview:(UIView *)view atIndex:(NSInteger)index{
    CGRect frame = CGRectMake(index*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    view.frame = frame;
    [self addSubview:view];
    self.contentSize = CGSizeMake(self.frame.size.width * (index+1), 0);
}

- (void)scrollContainerViewToIndex:(NSInteger)toIndex animated:(BOOL)animated{
    CGPoint offSet = CGPointMake(toIndex *self.frame.size.width, 0);
    [self setContentOffset:offSet animated:animated];
}

#pragma mark - private method
- (void)_initProperty{
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.delegate = self;
    self.pagingEnabled = YES;
    self.userInteractionEnabled = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(self.scrollDelegate && [self.scrollDelegate respondsToSelector:@selector(vsGroupSelectorContainerScrollCurrentOffSet:beforeOffSet:)]){
        [self.scrollDelegate vsGroupSelectorContainerScrollCurrentOffSet:scrollView.contentOffset beforeOffSet:_beforeOffset];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // record
    _beforeOffset = scrollView.contentOffset;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    BOOL inside = [self pointInside:point withEvent:event];
//    if (inside){
//        NSInteger index = self.contentOffset.x / self.width;
//        if (self.subviews.count > index){ // 防止越界
//            UIView *subView = [self.subviews objectAtIndex:index];
//            if ([subView pointInside:point withEvent:event]){
//                return subView;
//            }
//        }
//        
//    }
//    return nil;
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//}
@end
