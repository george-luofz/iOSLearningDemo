//
//  WBLStickerModuleDefine.h
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/7/29.
//  Copyright © 2020 景中杰. All rights reserved.
//

#ifndef WBLStickerModuleDefine_h
#define WBLStickerModuleDefine_h

typedef NS_ENUM(NSUInteger, WBLStickerType) { ///贴纸类型
    WBLStickerType_none = 0,  ///默认类型，代表全部类型
    WBLStickerType_text = 1,  ///文字
    WBLStickerType_image = 2, ///图片
};

#define kScreenWidth       ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight      ([UIScreen mainScreen].bounds.size.height)

#define kRealWidth ((kScreenWidth > kScreenHeight) ? kScreenHeight : kScreenWidth)
#define kRealHeight ((kScreenWidth < kScreenHeight) ? kScreenHeight : kScreenWidth)

#define kPerDegreeForPi   (180 / M_PI)


#pragma mark - performer

static CGFloat kWBLImageStickerScaleMaxValue = 2.f;
static CGFloat kWBLImageStickerScaleMinValue = .7f;

#pragma mark - audience

typedef NS_ENUM(NSUInteger, WBLAudienceImageStickerAction) { ///贴纸类型
    WBLAudienceImageStickerAction_none = 0,     ///默认类型
    WBLAudienceImageStickerAction_add = 1,      ///增加
    WBLAudienceImageStickerAction_delete = 9,   ///删除
};

static NSTimeInterval kWBLStikerUpdateNotifyServerInterval = 2.f; ///通知服务端间隔

static CGFloat kWBLStickerScreenScaleValue = 9 / 16.f; ///屏幕缩放系数
#endif /* WBLStickerModuleDefine_h */
