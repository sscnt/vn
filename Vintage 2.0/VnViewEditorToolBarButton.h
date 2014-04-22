//
//  VnViewEditorToolBarButton.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VnViewEditorToolBarButton;

@protocol VnViewEditorToolBarButtonDelegate
- (void)didToolBarButtonTouchUpInside:(VnViewEditorToolBarButton*)button;
@end

@interface VnViewEditorToolBarButton : UIButton

@property (nonatomic, assign) VnAdjustmentToolId toolId;
@property (nonatomic, strong) NSMutableArray* childButtons;
@property (nonatomic, weak) id<VnViewEditorToolBarButtonDelegate> delegate;
@property (nonatomic, assign) BOOL highlighted;
@property (nonatomic, assign) BOOL enabled;

- (void)didTouchUpInside;

- (UIColor*)fillColor;
- (void)drawRectEffects:(CGRect)rect;
- (void)drawRectEffectOpacity:(CGRect)rect;
- (void)drawRectEffectHistroy:(CGRect)rect;
- (void)drawRectTextures:(CGRect)rect;
- (void)drawRectTextureOpacity:(CGRect)rect;
- (void)drawRectTextureHistroy:(CGRect)rect;

@end
