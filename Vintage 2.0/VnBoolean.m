//
//  VnBoolean.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBoolean.h"

@implementation VnBoolean

static VnBoolean* sharedVnBoolean = nil;

+ (VnBoolean*)instance {
	@synchronized(self) {
		if (sharedVnBoolean == nil) {
			sharedVnBoolean = [[self alloc] init];
		}
	}
	return sharedVnBoolean;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnBoolean == nil) {
			sharedVnBoolean = [super allocWithZone:zone];
			return sharedVnBoolean;
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
        _homeSettingsScrolling = false;
    }
    return self;
}

#pragma mark editor

+ (BOOL)isEditorToolBarButtonTouchable
{
    return YES;
}

@end
