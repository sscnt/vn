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

#pragma mark workspace

+ (VnCurrentSettingsWorkspaceType)workspaceType
{
    return VnCurrentSettingsWorkspaceTypeEssentials;
}

+ (void)setWorkspaceType:(VnCurrentSettingsWorkspaceType)workspaceType
{
    
}

#pragma mark appearance

+ (float)barHeight
{
    return 50.0f;
}

#pragma mark progress

+ (float)previewProgressRadius
{
    return 18.0f;
}

+ (float)thumbnailProgressRadius
{
    return 12.0f;
}

#pragma mark button color

+ (UIColor *)barBgColor
{
    return [UIColor colorWithRed:s255(37.0f) green:s255(35.0f) blue:s255(35.0f) alpha:1.0];
}

+ (UIColor *)buttonIconNormalColor
{
    return [UIColor colorWithWhite:1.0f alpha:0.80f];
}

+ (UIColor *)buttonIconHighlightedColor
{
    return [UIColor colorWithWhite:1.0f alpha:1.0f];
}

+ (UIColor *)buttonIconColoredColor
{
    return [UIColor colorWithRed:s255(231.0f) green:s255(173.0f) blue:s255(13.0f) alpha:1.0f];
}

+ (UIColor *)buttonHighlightedBgColor
{
    return [UIColor colorWithRed:s255(20.0f) green:s255(18.0f) blue:s255(18.0f) alpha:1.0f];
}

@end
