//
//  VnCurrentSettings.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, VnCurrentSettingsWorkspaceType){
    VnCurrentSettingsWorkspaceTypeEssentials = 1,
    VnCurrentSettingsWorkspaceTypeAdvanced
};

@interface VnCurrentSettings : NSObject

@property (nonatomic, assign) VnCurrentSettingsWorkspaceType workspaceType;

@end
