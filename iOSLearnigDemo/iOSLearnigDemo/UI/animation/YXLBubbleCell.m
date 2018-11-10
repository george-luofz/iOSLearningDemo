//
//  YXLBubbleCell.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/11/7.
//  Copyright © 2018 George_luofz. All rights reserved.
//

#import "YXLBubbleCell.h"

static CGFloat kBubbleAvatarMaxH = 40;

@interface YXLBubbleCell ()

@property (nonatomic, strong) UIImageView *avaterImgV;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *titleLbl;

@end

@implementation YXLBubbleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.avaterImgV];
    [self addSubview:self.nameLbl];
    [self addSubview:self.titleLbl];
    
    [self.avaterImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(2);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.avaterImgV.mas_right).offset(4);
        make.bottom.equalTo(self.avaterImgV.mas_centerY);
        make.right.equalTo(self).offset(-8);
    }];
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLbl);
        make.top.equalTo(self.avaterImgV.mas_centerY);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    if (isValidNSString(self.model.nickname) && self.nameLbl.nn_width > 0){
//        NSString *resultStr = [NSString clipNSStringMaxWidth:self.nameLbl.nn_width font:self.nameLbl.font lineHeight:self.nameLbl.nn_height string:self.model.nickname];
//        self.nameLbl.text = resultStr;
//    }
}
#pragma mark - Setter/Getter
//- (void)setModel:(YXLiveModel *)model
//{
//    _model = model;
//
//    [YXLiveTool yySetImageView:self.avaterImgV url:model.avatar defaultImage:[UIImage imageNamed:@"YXLDefaultAvatar"]];
//    if (isValidNSString(model.title)) {
//        self.titleLbl.text = model.title;
//    }
//}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        _titleLbl.numberOfLines = 1;
        UIFont *fnt = [UIFont fontWithName:@"PingFangSC-Semibold" size:10];
        _titleLbl.font =  fnt ? fnt : [UIFont systemFontOfSize:10];
        _titleLbl.alpha = 0.75f;
        _titleLbl.text = @"我是标题";
        _titleLbl.textColor = [UIColor whiteColor];
    }
    return _titleLbl;
}

- (UILabel *)nameLbl
{
    if (!_nameLbl) {
        _nameLbl = [UILabel new];
        _nameLbl.numberOfLines = 1;
        UIFont *fnt = [UIFont fontWithName:@"PingFangSC-Semibold" size:12];
        _nameLbl.font =  fnt ? fnt : [UIFont systemFontOfSize:12];
        _nameLbl.text = @"我是昵称";
        _nameLbl.textColor = [UIColor whiteColor];
    }
    return _nameLbl;
}

- (UIImageView *)avaterImgV
{
    if (!_avaterImgV) {
        _avaterImgV = [UIImageView new];
        _avaterImgV.layer.cornerRadius = kBubbleAvatarMaxH / 2;
        _avaterImgV.backgroundColor = [UIColor blackColor];
        _avaterImgV.clipsToBounds = YES;
    }
    return _avaterImgV;
}

@end
