//
//  UIBlurredButton.m
//  Vintage
//
//  Created by SSC on 2014/02/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIBlurredButton.h"

@implementation UIBlurredButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)generateBackgroundImage
{
    __block UIImage* imageBg = [self imageByRenderingView];
    __block UIBlurredButton* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        //// Gaussian Blur
        GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
        filter.blurRadiusInPixels = 20.0;
        GPUImagePicture* picture = [[GPUImagePicture alloc] initWithCGImage:imageBg.CGImage];
        [picture addTarget:filter];
        [picture processImage];
        imageBg = [filter imageFromCurrentlyProcessedOutput];
        
        dispatch_async(q_main, ^{
            [_self setBackgroundImage:imageBg forState:UIControlStateNormal];
        });
    });
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
