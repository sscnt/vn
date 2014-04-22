//
//  VnViewIndicator.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/22.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewProgress.h"

@implementation VnViewProgress

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _progressView = [[EVCircularProgressView alloc] init];
        _progressView.tintColor = [UIColor colorWithWhite:1.0f alpha:0.80f];
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
    [_progressView setProgress:progress];
}

- (void)setTintColor:(UIColor *)tintColor
{
    [_progressView setTintColor:tintColor];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    [_progressView setProgress:progress animated:YES];
}

@end
