//
//  UIBlurredButton.m
//  Vintage
//
//  Created by SSC on 2014/02/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIBlurredButton.h"

@implementation UIBlurredButton


- (id)initWithFrame:(CGRect)frame Type:(BlurredButtonIconType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _isReady = NO;
        [self setTitleEdgeInsets:UIEdgeInsetsMake(1.5f, 0.0f, 0.0f, -6.0f)];
        NSArray *langs = [NSLocale preferredLanguages];
        NSString *currentLanguage = [langs objectAtIndex:0];
        if([currentLanguage compare:@"ja"] == NSOrderedSame) {
            self.titleLabel.font = [UIFont fontWithName:@"mplus-1c-bold" size:16.0f];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(2.0f, 0.0f, 0.0f, -6.0f)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 5.0)];
        } else {
            self.titleLabel.font = [UIFont fontWithName:@"Aller-Bold" size:18.0f];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(3.0f, 0.0f, 0.0f, 0.0f)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 12.0)];
        }
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.70f] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithWhite:1.0f alpha:0.40f] forState:UIControlStateHighlighted];
        [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setIcon:type];
    }
    return self;
}

- (void)setIcon:(BlurredButtonIconType)type
{
    switch (type) {
        case BlurredButtonIconTypeCamera:
            [self setImage:[UIImage imageNamed:@"camera-36-70.png"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"camera-36-40.png"] forState:UIControlStateHighlighted];
            break;
        case BlurredButtonIconTypePhotos:
            [self setImage:[UIImage imageNamed:@"photos-38-70.png"] forState:UIControlStateNormal];
            [self setImage:[UIImage imageNamed:@"photos-38-40.png"] forState:UIControlStateHighlighted];
            break;
        default:
            break;
    }
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
        [solid setColorRed:212.0f/255.0f green:201.0f/255.0f blue:193.0f/255.0f alpha:1.0f];
        GPUImageSoftLightBlendFilter* softlight = [[GPUImageSoftLightBlendFilter alloc] init];
        
        GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
        filter.blurRadiusInPixels = 30.0;
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
            _self.isReady = YES;
            [_self.delegate buttonDidCreateBgImage:_self];
        });
    });
}


- (void)drawRect:(CGRect)rect
{

}


@end
