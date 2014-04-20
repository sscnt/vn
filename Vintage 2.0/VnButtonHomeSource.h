//
//  UIHomeSourceButton.h
//  Winterpix
//
//  Created by SSC on 2014/04/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VnButtonHomeSourceIconType){
    VnButtonHomeSourceIconTypePhotos = 1,
    VnButtonHomeSourceIconTypeCamera
};

@interface VnButtonHomeSource : UIButton

@property (nonatomic, assign) VnButtonHomeSourceIconType iconType;

@end
