//
//  VnCurrentSettings.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnCurrentSettings.h"

@implementation VnCurrentSettings

static VnCurrentSettings* sharedVnCurrentSettings = nil;

+ (VnCurrentSettings*)instance {
	@synchronized(self) {
		if (sharedVnCurrentSettings == nil) {
			sharedVnCurrentSettings = [[self alloc] init];
		}
	}
	return sharedVnCurrentSettings;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnCurrentSettings == nil) {
			sharedVnCurrentSettings = [super allocWithZone:zone];
			return sharedVnCurrentSettings;
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
