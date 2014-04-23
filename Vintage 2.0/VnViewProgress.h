//
//  VnViewIndicator.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVCircularProgressView.h"

@interface VnViewProgress : UIView
{
    EVCircularProgressView* _progressView;
}

@property (nonatomic) float progress;
@property (nonatomic, strong) UIColor *progressTintColor;

- (id)initWithFrame:(CGRect)frame Radius:(float)radius;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end