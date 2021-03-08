//
//  WBLStickerEditAreaLayoutProtocol.h
//  WBLiveBusiness
//
//  Created by 罗富中 on 2020/8/1.
//  Copyright © 2020 景中杰. All rights reserved.
//

#ifndef WBLStickerEditAreaLayoutProtocol_h
#define WBLStickerEditAreaLayoutProtocol_h

@protocol WBLStickerEditAreaLayoutProtocol <NSObject>

@property (nonatomic, assign) CGRect dragRect; ///拖拽区
@property (nonatomic, assign) CGRect deleteRect; ///删除区
@property (nonatomic, assign) CGRect deleteSureRect; ///删除确认区
@property (nonatomic, assign) CGRect dragAndDeleteRect; ///拖拽包含删除区

@end

#endif /* WBLStickerEditAreaLayoutProtocol_h */
