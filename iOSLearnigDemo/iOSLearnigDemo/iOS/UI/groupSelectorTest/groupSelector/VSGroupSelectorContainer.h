//
//  VSGroupSelectorContainer.h
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import <UIKit/UIKit.h>

@protocol VSGroupSelectorContainerDelegate <NSObject>
- (void)vsGroupSelectorContainerScrollCurrentOffSet:(CGPoint)curOffSet beforeOffSet:(CGPoint)beforeOffSet;
@end

@interface VSGroupSelectorContainer : UIScrollView
@property (nonatomic, weak) id<VSGroupSelectorContainerDelegate> scrollDelegate;

- (void)scrollContainerViewToIndex:(NSInteger)toIndex animated:(BOOL)animated;

- (void)addSubview:(UIView *)view atIndex:(NSInteger)index;

@end
