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
    //////// Effects
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdEffects;
    [self registerButton:button];
    
    //////// Textures
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdEffectOpacity;
    [self registerButton:button];
    
    //////// Textures
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdEffectHistory;
    [self registerButton:button];
    
    //////// Textures
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdTextureOpacity;
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
}

- (void)layoutToolBar
{
    //// Tool Bar
    _toolBar = [[VnViewEditorToolBar alloc] init];
    
    //// Effects
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdEffects]];
    
    //// Textures
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdEffectOpacity]];
    
    //// Textures
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdEffectHistory]];
    
    float height = [_toolBar height] * 3.0f;
    if ([UIDevice isiPad]) {
        height = [_toolBar height] * 6.0f;
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            height = [_toolBar height] * 2.0f;
        } else {
            
        }
    }
    [_toolBar setY:[UIScreen height] - height - [_toolBar height]];
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

+ (float)thumbnailViewPadding
{
    return 10.0f;
}

+ (CGRect)thumbnailImageBounds
{
    float padding = [VnEditorViewManager thumbnailViewPadding];
    
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
    [self hideAllAdjustmentTools];
    VnViewEditorToolBarButton* button = [self buttonByToolId:toolId];
    if (button) {
        button.selected = YES;
    }
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