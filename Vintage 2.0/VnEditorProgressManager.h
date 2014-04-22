//
//  VnEditorProgressManager.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VnEditorProgressManager : NSObject

+ (VnEditorViewManager*)instance;

+ (void)setResizingProgress:(float)progress;
+ (void)setPreviewProgress:(float)progress;

@end
