//
//  VnViewIndicator.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewProgress.h"

@implementation VnViewProgress

- (id)initWithFrame:(CGRect)frame Radius:(float)radius
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _progressView = [[EVCircularProgressView alloc] initWithRadius:radius];
        _progressView.progressTintColor = [UIColor colorWithWhite:1.0f alpha:0.80f];
        _progressView.progress = 0.0f;
        _progressView.center = self.center;
        [self addSubview:_progressView];
    }
    return self;
}

- (float)progress
{
    return [_progressView progress];
}

- (void)setProgress:(float)progress
{
    _progressView.progress = progress;
}

- (void)setTintColor:(UIColor *)tintColor
{
    _progressView.progressTintColor = tintColor;
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    [_progressView setProgress:progress animated:YES];
}

@end
