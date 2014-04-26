//
//  VnEditorViewManager.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEditorViewManager.h"

@implementation VnEditorViewManager

static VnEditorViewManager* sharedVnEditorViewManager = nil;

+ (VnEditorViewManager*)instance {
	@synchronized(self) {
		if (sharedVnEditorViewManager == nil) {
			sharedVnEditorViewManager = [[self alloc] init];
		}
	}
	return sharedVnEditorViewManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnEditorViewManager == nil) {
			sharedVnEditorViewManager = [super allocWithZone:zone];
			return sharedVnEditorViewManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

- (id)init
{
    self = [super init];
    if (self) {
        _toolBarButtons = [NSMutableDictionary dictionary];
        _adjustmentToolViwes = [NSMutableDictionary dictionary];
    }
    return self;
}

// commonInit - clean
- (void)commonInit
{
    [self initButtons];
}

- (void)initButtons
{
    
    VnViewEditorToolBarButton* button;
    VnViewEditorToolBarButton* parent;
    
    //////// Effects
    parent = [[VnViewEditorToolBarButton alloc] init];
    parent.toolId = VnAdjustmentToolIdEffects;
    [self registerButton:parent];
    
    //////// Effects History
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdEffectHistory;
    [parent addChildButton:button];
    [self registerButton:button];
    
    //////// Effects Opacity
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdEffectOpacity;
    [parent addChildButton:button];
    [self registerButton:button];
    
    //////// Textures
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdTextures;
    [self registerButton:button];
    
    //////// Textures History
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdTextureHistory;
    [self registerButton:button];
    
    //////// Textures Opacity
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdTextureOpacity;
    [self registerButton:button];
    
    //////// Photo Filter
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdPhotoFilters;
    [self registerButton:button];
    
    //////// Photo Filter History
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdPhotoFilterHistory;
    [self registerButton:button];
    
    //////// Photo Filter Opacity
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdPhotoFilterOpacity;
    [self registerButton:button];
    
    //////// Brightness
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdBrightness;
    [self registerButton:button];
    
    //////// Levels
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdLevels;
    [self registerButton:button];
}

#pragma mark manager

- (void)registerButton:(VnViewEditorToolBarButton *)button
{
    [_toolBarButtons setObject:button forKey:[NSString stringWithFormat:@"%d", (int)button.toolId]];
}

- (VnViewEditorToolBarButton *)buttonByToolId:(VnAdjustmentToolId)toolId
{
    return (VnViewEditorToolBarButton*)[_toolBarButtons objectForKey:[NSString stringWithFormat:@"%d", (int)toolId]];
}

- (void)unselectAllButtons
{
    for (NSString* key in [_toolBarButtons allKeys]) {
        @autoreleasepool {
            VnViewEditorToolBarButton* button = [self buttonByToolId:(VnAdjustmentToolId)[key intValue]];
            button.selected = NO;
            button.childButtonsHidden = YES;
        }
    }
}

- (void)hideAllAdjustmentTools
{
    for (NSString* key in [_adjustmentToolViwes allKeys]) {
        @autoreleasepool {
            UIView* view = [self adjustmentToolViewByToolId:(VnAdjustmentToolId)[key intValue]];
            view.hidden = YES;
        }
    }
}

#pragma mark layout

- (void)layout
{
    self.view.backgroundColor = [UIColor colorWithRed:s255(26.0f) green:s255(24.0f) blue:s255(24.0f) alpha:1.0f];
    [self layoutNavigationBar];
    [self layoutToolBar];
    [self layoutPreview];
    [self.view bringSubviewToFront:_toolBar];
}

- (void)layoutToolBar
{
    //// Tool Bar
    _toolBar = [[VnViewEditorToolBar alloc] init];
    
    //// Effects
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdEffects]];
    
    //// Textures
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdBrightness]];
    
    //// Photo Filters
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdLevels]];
    
    [_toolBar setY:[VnEditorViewManager toolBarDefaultY]];
    [self.view addSubview:_toolBar];
    
}

- (void)layoutNavigationBar
{
    //// Navigation Bar
    _navigationBar = [[VnViewEditorToolBar alloc] init];
    [self.view addSubview:_navigationBar];

}


- (void)layoutPreview
{
    //// Preview
    _photoPreview = [[VnViewEditorPhotoPreview alloc] initWithFrame:[VnEditorViewManager previewBounds]];
    [_photoPreview setY:[VnCurrentSettings barHeight]];
    [self.view addSubview:_photoPreview];
    
    //// Progress
    _resizingProgressView = [[VnViewProgress alloc] initWithFrame:[VnEditorViewManager previewBounds] Radius:[VnCurrentSettings previewProgressRadius]];
    [_resizingProgressView setY:[VnCurrentSettings barHeight]];
    [self.view addSubview:_resizingProgressView];
}

- (void)layoutAdjustmentEffects
{
    if ([self adjustmentToolViewByToolId:VnAdjustmentToolIdEffects] == nil) {
        UIView* wrapper = [[UIView alloc] initWithFrame:[VnEditorViewManager adjustmentToolViewFrame]];
        wrapper.userInteractionEnabled = YES;
        VnViewEditorEffectPresetsListView* view = [[VnViewEditorEffectPresetsListView alloc] initWithFrame:[VnEditorViewManager adjustmentToolViewBounds]];
        
        for (int i = 0; i < [VnDataEffects effectsCount]; i++) {
            VnObjectEffect* efx = [VnDataEffects effectAtIndex:i];
            if (efx) {
                [view addItemByEffectObject:efx];
            }
        }
        [wrapper addSubview:view];
        [self.view addSubview:wrapper];
        [self registerAdjustmentToolView:wrapper ByToolId:VnAdjustmentToolIdEffects];
    }
}

#pragma mark view sizes

+ (float)toolBarDefaultY
{
    float height = [VnCurrentSettings barHeight] * 3.0f;
    if ([UIDevice isiPad]) {
        height = [VnCurrentSettings barHeight] * 6.0f;
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            height = [VnCurrentSettings barHeight] * 2.0f;
        } else {
            
        }
    }
    return [UIScreen height] - height - [VnCurrentSettings barHeight];
}

+ (CGRect)previewBounds
{
    float barh = [VnCurrentSettings barHeight];
    float adjh = barh * 3.0f;
    if ([UIDevice isiPad]) {
        adjh = barh * 6.0f;
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            adjh = barh * 2.0f;
        } else {
            
        }
    }
    
    float height = [UIScreen height] - barh - adjh - barh;
    CGRect bounds = CGRectMake(0.0f, 0.0f, [UIScreen width], height);
    return bounds;
}

+ (CGRect)thumbnailViewBounds
{
    
    float barh = [VnCurrentSettings barHeight];
    float adjh = barh * 3.0f;
    if ([UIDevice isiPad]) {
        
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            adjh = barh * 2.0f;
        } else {
            
        }
    }
    CGRect bounds = CGRectMake(0.0f, 0.0f, adjh / 1.20f, adjh);
    return bounds;
}

+ (float)thumbnailViewPaddingTop
{
    return 10.0f;
}

+ (float)thumbnailViewPaddingLeft
{
    return 5.0f;
}

+ (CGRect)thumbnailImageBounds
{
    float padding = [VnEditorViewManager thumbnailViewPaddingLeft];
    
    float barh = [VnCurrentSettings barHeight];
    float adjh = barh * 3.0f;
    if ([UIDevice isiPad]) {
        
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            adjh = barh * 2.0f;
        } else {
            
        }
    }
    float width = adjh / 1.20f - padding * 2.0f;
    CGRect bounds = CGRectMake(0.0f, 0.0f, width, width);
    return bounds;
}

+ (CGRect)adjustmentToolViewFrame
{
    
    float barh = [VnCurrentSettings barHeight];
    float adjh = barh * 3.0f;
    if ([UIDevice isiPad]) {
        adjh = barh * 6.0f;
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            adjh = barh * 2.0f;
        } else {
            
        }
    }
    CGRect bounds = CGRectMake(0.0f, [UIScreen height] - adjh, [UIScreen width], adjh);
    return bounds;
}

+ (CGRect)adjustmentToolViewBounds
{
    CGRect bounds = CGRectMake(0.0f, 0.0f, [VnEditorViewManager adjustmentToolViewFrame].size.width, [VnEditorViewManager adjustmentToolViewFrame].size.height);
    return bounds;
}

#pragma mark adjustment tool

- (void)registerAdjustmentToolView:(UIView*)view ByToolId:(VnAdjustmentToolId)toolId
{
    [_adjustmentToolViwes setObject:view forKey:[NSString stringWithFormat:@"%d", (int)toolId]];
}

- (id)adjustmentToolViewByToolId:(VnAdjustmentToolId)toolId
{
    return [_adjustmentToolViwes objectForKey:[NSString stringWithFormat:@"%d", (int)toolId]];
}

- (void)openAdjustmentToolView:(VnAdjustmentToolId)toolId
{
    [self unselectAllButtons];
    VnViewEditorToolBarButton* button = [self buttonByToolId:toolId];
    if (button == nil) {
        return;
    }
    int childCount = [button childButtonsCount];
    if (button.isChild) {
        VnViewEditorToolBarButton* parent = button.parentButton;
        if (parent) {
            parent.childButtonsHidden = NO;
            [_toolBar openButton:parent];
            childCount = [parent childButtonsCount];
        }
    }else{
        button.childButtonsHidden = !button.childButtonsHidden;
        [_toolBar openButton:button];
    }
    int stage = childCount + 1;
    _toolBar.stage = stage;
    [_toolBar setY:[VnEditorViewManager toolBarDefaultY] - (float)childCount * [VnCurrentSettings barHeight]];
    [self hideAllAdjustmentTools];
    button.selected = YES;    
    UIView* view;
    switch (toolId) {
        case VnAdjustmentToolIdEffects:
            [self layoutAdjustmentEffects];
            view = [self adjustmentToolViewByToolId:VnAdjustmentToolIdEffects];
            break;
            
        default:
            break;
    }
    [view setHidden:NO];
    _currentToolId = toolId;
    [self.delegate adjustmentToolViewDidChange:toolId];
}

#pragma mark setter

- (void)setPreviewImage:(UIImage *)image
{
    _photoPreview.image = image;
    [_resizingProgressView removeFromSuperview];
    _resizingProgressView = nil;
}

+ (void)clean
{
    [[VnEditorViewManager instance] clean];
}

- (void)clean
{
    
    for (NSString* key in [_toolBarButtons allKeys]) {
        @autoreleasepool {
            VnViewEditorToolBarButton* button = [self buttonByToolId:(VnAdjustmentToolId)[key intValue]];
            [button removeFromSuperview];
        }
    }

    for (NSString* key in [_adjustmentToolViwes allKeys]) {
        @autoreleasepool {
            UIView* view = [self adjustmentToolViewByToolId:(VnAdjustmentToolId)[key intValue]];
            [view removeFromSuperview];
        }
    }
    [_adjustmentToolViwes removeAllObjects];
    [_toolBarButtons removeAllObjects];
    [_toolBar removeFromSuperview];
    _toolBar = nil;
    [_photoPreview removeFromSuperview];
    _photoPreview = nil;
    [_navigationBar removeFromSuperview];
    _navigationBar = nil;
    if (_resizingProgressView) {
        [_resizingProgressView removeFromSuperview];
        _resizingProgressView = nil;
    }
    
}

@end