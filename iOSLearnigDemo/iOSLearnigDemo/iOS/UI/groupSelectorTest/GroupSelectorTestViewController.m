//
//  GroupSelectorTestViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/22.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "GroupSelectorTestViewController.h"
#import "VSGroupSelector.h"
#import "VSGroupSelectorHeader.h"
#import "YXLiveRoomSpendPanelTabSelector.h"

@interface GroupSelectorTestViewController () <YXLiveRoomSpendPanelTabSelectorDelegate>
@property (nonatomic) VSGroupSelector *groupSelector;
@end

@implementation GroupSelectorTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.groupSelector.frame = CGRectMake(0, self.view.nn_height - self.groupSelector.nn_height, self.view.nn_width, self.groupSelector.nn_height);
//    [self.view addSubview:self.groupSelector];
    
    VSGroupSelectorHeader *header = [[VSGroupSelectorHeader alloc] initWithSize:CGSizeMake(self.view.nn_width, 57)];
    header.frame = CGRectMake(0, 100, header.nn_width, header.nn_height);
    [header setupSubViews];
    [self.view addSubview:header];
    
    YXLiveRoomSpendPanelTabSelector *tabSelector = [[YXLiveRoomSpendPanelTabSelector alloc] initWithFrame:CGRectMake(0, 200, self.view.nn_width, 36)];
    tabSelector.delegate = self;
    [tabSelector setupSubViews];
    [self.view addSubview:tabSelector];
}

- (VSGroupSelector *)groupSelector{
    if (_groupSelector == nil){
        _groupSelector = [[VSGroupSelector alloc] init];
    }
    return _groupSelector;
}

- (void)_addSubViews{
    
}
@end
