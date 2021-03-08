//
//  VSGroupSelector.h
//  MPVideoStudio
//
//  Created by 罗富中 on 2018/8/21.
//

#import <UIKit/UIKit.h>

//@protocol VSGroupSelectorDataSource <NSObject>
//- (NSArray<NSString *> *)titlesForHeader;
//- (NSArray<Class> *)classAtIndex:(NSInteger)index;
//- (NSArray<id> *)dataSourceAtIndex:(NSInteger)index;
//@end

@protocol VSGroupSelectorDelegate <NSObject>
- (void)clickHeaderAtIndex:(NSInteger)index titleStr:(NSString *)title;
@end
@interface VSGroupSelector : UIView
@property (nonatomic, assign) NSInteger currentSelectIndex;
@property (nonatomic, weak) id<VSGroupSelectorDelegate> delegate;
@end
