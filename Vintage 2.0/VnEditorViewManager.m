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
        
    }
    return self;
}

#pragma mark layout

- (void)layout
{
    [self layoutToolBar];
}

- (void)layoutToolBar
{
    //// Tool Bar
    _toolBar = [[VnVIewEditorToolBar alloc] init];
    float height = 44.0f * 3.0f;
    if ([UIDevice isiPad]) {
        height = 44.0f * 6.0f;
    } else {
        if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
            height = 44.0f * 2.0f;
        } else {
            
        }
    }
    [_toolBar setY:[UIScreen height] - height - [_toolBar height]];
    [self.view addSubview:_toolBar];
    
    //// Tool Bar Button
    VnViewEditorToolBarButton* button;
    
    //////// Effects
    button = [[VnViewEditorToolBarButton alloc] init];
    button.toolId = VnAdjustmentToolIdEffects;
    [_toolBar appendButton:button];
}

@end
