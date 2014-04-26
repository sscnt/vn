//
//  VnEditorViewManager.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnEditorSliderManager.h"
#import "VnViewEditorToolBarButton.h"
#import "VnViewEditorToolBar.h"
#import "VnViewEditorPhotoPreview.h"
#import "VnViewProgress.h"
#import "VnViewEditorEffectPresetsListView.h"

@protocol VnEditorViewManagerDelegate
- (void)adjustmentToolViewDidChange:(VnAdjustmentToolId)toolId;
@end

@interface VnEditorViewManager : NSObject

@property (nonatomic, weak) id<VnEditorViewManagerDelegate> delegate;
@property (nonatomic, weak) UIView* view;
@property (nonatomic, strong) VnViewEditorToolBar* toolBar;
@property (nonatomic, strong) VnViewEditorToolBar* navigationBar;
@property (nonatomic, strong) NSMutableDictionary* toolBarButtons;
@property (nonatomic, strong) NSMutableDictionary* adjustmentToolViwes;
@property (nonatomic, strong) VnViewEditorPhotoPreview* photoPreview;
@property (nonatomic, strong) VnViewProgress* resizingProgressView;
@property (nonatomic, assign) VnAdjustmentToolId currentToolId;

+ (VnEditorViewManager*)instance;
+ (CGRect)previewBounds;
+ (CGRect)adjustmentToolViewFrame;
+ (CGRect)adjustmentToolViewBounds;
+ (CGRect)thumbnailViewBounds;
+ (float)thumbnailViewPaddingTop;
+ (float)thumbnailViewPaddingLeft;
+ (float)toolBarDefaultY;
+ (float)toolBarDefaultX;
+ (CGRect)thumbnailImageBounds;
+ (void)clean;
- (void)clean;

- (void)commonInit;
- (void)initButtons;

- (void)layout;
- (void)layoutNavigationBar;
- (void)layoutToolBar;
- (void)layoutPreview;
- (void)layoutAdjustmentEffects;

- (void)setPreviewImage:(UIImage*)image;

- (void)openAdjustmentToolView:(VnAdjustmentToolId)toolId;
- (UIView*)adjustmentToolViewByToolId:(VnAdjustmentToolId)toolId;
- (void)registerAdjustmentToolView:(UIView*)view ByToolId:(VnAdjustmentToolId)toolId;
- (void)hideAllAdjustmentTools;

- (void)registerButton:(VnViewEditorToolBarButton*)button;
- (VnViewEditorToolBarButton*)buttonByToolId:(VnAdjustmentToolId)toolId;
- (void)unselectAllButtons;



@end
