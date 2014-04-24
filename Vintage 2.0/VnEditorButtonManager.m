//
//  VnEditorButtonManager.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEditorButtonManager.h"

@implementation VnEditorButtonManager

static VnEditorButtonManager* sharedVnEditorButtonManager = nil;

+ (VnEditorButtonManager*)instance {
	@synchronized(self) {
		if (sharedVnEditorButtonManager == nil) {
			sharedVnEditorButtonManager = [[self alloc] init];
		}
	}
	return sharedVnEditorButtonManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnEditorButtonManager == nil) {
			sharedVnEditorButtonManager = [super allocWithZone:zone];
			return sharedVnEditorButtonManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark events

- (void)didToolBarButtonTouchUpInside:(VnViewEditorToolBarButton *)button
{
    VnEditorViewManager* vm = [VnEditorViewManager instance];
    [vm openAdjustmentToolView:button.toolId];
}

@end
