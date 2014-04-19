//
//  SliderManager.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnSliderManager.h"

@implementation VnSliderManager

static VnSliderManager* sharedSliderManager = nil;

+ (VnSliderManager*)instance {
	@synchronized(self) {
		if (sharedSliderManager == nil) {
			sharedSliderManager = [[self alloc] init];
		}
	}
	return sharedSliderManager;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedSliderManager == nil) {
			sharedSliderManager = [super allocWithZone:zone];
			return sharedSliderManager;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

@end
