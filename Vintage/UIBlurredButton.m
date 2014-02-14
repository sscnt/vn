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
        self.titleLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-heavy" size:18.0f];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(1.5f, 0.0f, 0.0f, -6.0f)];
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            [self setTitleEdgeInsets:UIEdgeInsetsMake(2.0f, 0.0f, 0.0f, -6.0f)];
        }
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.70f] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.40f] forState:UIControlStateHighlighted];
        [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)generateBackgroundImageByCaputuredImage:(UIImage *)inputImage
{
    __block UIImage* imageBg = inputImage;
    __block UIBlurredButton* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        //// Gaussian Blur
        GPUImageSolidColorGenerator* solid = [[GPUImageSolidColorGenerator alloc] init];
        [solid setColorRed:207.0f/255.0f green:200.0f/255.0f blue:194.0f/255.0f alpha:1.0f];
        GPUImageSoftLightBlendFilter* softlight = [[GPUImageSoftLightBlendFilter alloc] init];
        
        GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
        filter.blurRadiusInPixels = 40.0;
        GPUImagePicture* picture = [[GPUImagePicture alloc] initWithCGImage:imageBg.CGImage];
        [picture addTarget:filter];
        [picture processImage];
        imageBg = [filter imageFromCurrentlyProcessedOutput];
        
        picture = [[GPUImagePicture alloc] initWithImage:imageBg];
        [solid addTarget:softlight atTextureLocation:1];
        [picture addTarget:solid];
        [picture addTarget:softlight];
        [picture processImage];
        imageBg = [softlight imageFromCurrentlyProcessedOutput];
        
        dispatch_async(q_main, ^{
            [_self setBackgroundImage:imageBg forState:UIControlStateNormal];
        });
    });
}


- (void)drawRect:(CGRect)rect
{

}


@end
