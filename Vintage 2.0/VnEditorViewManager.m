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
        
        VnViewEditorToolBarButton* button;
        //////// Effects
        button = [[VnViewEditorToolBarButton alloc] init];
        button.toolId = VnAdjustmentToolIdEffects;
        [self registerButton:button];
        
        //////// Textures
        button = [[VnViewEditorToolBarButton alloc] init];
        button.toolId = VnAdjustmentToolIdTextures;
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
    return self;
}

#pragma mark manager

- (void)registerButton:(VnViewEditorToolBarButton *)button
{
    [_toolBarButtons setObject:button forKey:[NSString stringWithFormat:@"%ld", button.toolId]];
}

- (VnViewEditorToolBarButton *)buttonByToolId:(VnAdjustmentToolId)toolId
{
    return (VnViewEditorToolBarButton*)[_toolBarButtons objectForKey:[NSString stringWithFormat:@"%ld", toolId]];
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
    
    
    //// Effects
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdEffects]];
    
    //// Textures
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdTextures]];
    
    //// Textures
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdTextureOpacity]];
    
    //// Textures
    [_toolBar appendButton:[self buttonByToolId:VnAdjustmentToolIdEffectHistory]];
}

- (void)layoutNavigationBar
{
    //// Navigation Bar
    _navigationBar = [[VnViewEditorToolBar alloc] init];
    [self.view addSubview:_navigationBar];

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

- (void)layoutPreview
{
    //// Preview
    _photoPreview = [[VnViewEditorPhotoPreview alloc] initWithFrame:[VnEditorViewManager previewBounds]];
    [_photoPreview setY:[VnCurrentSettings barHeight]];
    [self.view addSubview:_photoPreview];
    
    //// Progress
    _resizingProgressView = [[VnViewProgress alloc] initWithFrame:[VnEditorViewManager previewBounds]];
    [_resizingProgressView setY:[VnCurrentSettings barHeight]];
    [self.view addSubview:_resizingProgressView];
}

#pragma mark setter

- (void)setPreviewImage:(UIImage *)image
{
    _photoPreview.image = image;
    [_resizingProgressView removeFromSuperview];
    _resizingProgressView = nil;
}

@end