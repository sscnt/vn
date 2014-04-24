//
//  VnViewEditorToolBarButtonBgView.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/24.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VnViewEditorToolBarButtonBgView : UIView

@property (nonatomic, assign) VnAdjustmentToolId toolId;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL colored;

- (UIColor*)fillColor;
- (void)drawRectEffects:(CGRect)rect;
- (void)drawRectEffectOpacity:(CGRect)rect;
- (void)drawRectEffectHistroy:(CGRect)rect;
- (void)drawRectTextures:(CGRect)rect;
- (void)drawRectTextureOpacity:(CGRect)rect;
- (void)drawRectTextureHistroy:(CGRect)rect;

@end
