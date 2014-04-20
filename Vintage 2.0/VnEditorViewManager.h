//
//  VnEditorViewManager.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/20.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VnEditorSliderManager.h"


@interface VnEditorViewManager : NSObject
{
    VnEditorSliderManager* _sliderManager;
}

@property (nonatomic, weak) UIView* view;

- (void)layout;

@end
