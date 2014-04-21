//
//  VnBoolean.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VnBoolean : NSObject

+ (VnBoolean*)instance;

+ (BOOL)isEditorToolBarButtonTouchable;

@property (nonatomic, assign) BOOL homeSettingsScrolling;

@end
