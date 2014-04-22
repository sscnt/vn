
//
//  VnEditorProgressManager.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEditorProgressManager.h"

@implementation VnEditorProgressManager

static VnEditorProgressManager* sharedVnEditorProgressManager = nil;

+ (VnEditorProgressManager*)instance {
	@synchronized(self) {
		if (sharedVnEditorProgressManager == nil) {
			sharedVnEditorProgressManager = [[self alloc] init];
		}
	}
	return sharedVnEditorProgressManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnEditorProgressManager == nil) {
			sharedVnEditorProgressManager = [super allocWithZone:zone];
			return sharedVnEditorProgressManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

#pragma mark resizing

+ (void)setResizingProgress:(float)progress
{
    VnEditorViewManager* manager = [VnEditorViewManager instance];
    if (manager.resizingProgressView) {
        [manager.resizingProgressView setProgress:progress animated:YES];
    }
}

#pragma mark preview

+ (void)setPreviewProgress:(float)progress
{
    
}

@end
