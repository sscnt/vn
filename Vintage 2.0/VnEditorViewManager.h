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


@interface VnEditorViewManager : NSObject

@property (nonatomic, weak) UIView* view;
@property (nonatomic, strong) VnViewEditorToolBar* toolBar;
@property (nonatomic, strong) NSMutableDictionary* toolBarButtons;
@property (nonatomic, strong) NSMutableDictionary* adjustmentToolViwes;
@property (nonatomic, strong) VnViewEditorPhotoPreview* photoPreview;

+ (VnEditorViewManager*)instance;
+ (CGRect)previewBounds;

- (void)layout;
- (void)layoutToolBar;
- (void)layoutPreview;

- (void)setPreviewImage:(UIImage*)image;

- (void)registerButton:(VnViewEditorToolBarButton*)button;
- (VnViewEditorToolBarButton*)buttonByToolId:(VnAdjustmentToolId)toolId;

@end
