//
//  SliderManager.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnEditorSliderManager.h"

@implementation VnEditorSliderManager

static VnEditorSliderManager* sharedVnEditorSliderManager = nil;

+ (VnEditorSliderManager*)instance {
	@synchronized(self) {
		if (sharedVnEditorSliderManager == nil) {
			sharedVnEditorSliderManager = [[self alloc] init];
		}
	}
	return sharedVnEditorSliderManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnEditorSliderManager == nil) {
			sharedVnEditorSliderManager = [super allocWithZone:zone];
			return sharedVnEditorSliderManager;
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

@end
