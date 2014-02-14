//
//  ViewController.m
//  Vintage
//
//  Created by SSC on 2014/02/14.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //// Background Image
    UIImageView* imageViewBg;
    UIImage* imageBg;
    if ([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4) {
        imageBg = [UIImage imageNamed:@"home.jpg"];
    }else if([UIDevice resolution] == UIDeviceResolution_iPhoneRetina5){
        imageBg = [UIImage imageNamed:@"home-568h.jpg"];
    }
    imageViewBg = [[UIImageView alloc] initWithImage:imageBg];
    [self.view addSubview:imageViewBg];
    
    //// Action Button
    CGFloat top = 414.0f;
    buttonCamera = [[UIBlurredButton alloc] initWithFrame:CGRectMake(15.0f, top, [UIScreen screenSize].width - 30.0f, 50.0)];
    [buttonCamera setTitle:NSLocalizedString(@"Camera", nil) forState:UIControlStateNormal];
    [self.view addSubview:buttonCamera];
    
    top = buttonCamera.bottom + 15.0f;
    buttonPhotos = [[UIBlurredButton alloc] initWithFrame:CGRectMake(15.0f, top, [UIScreen screenSize].width - 30.0f, 50.0)];
    [buttonPhotos setTitle:NSLocalizedString(@"Photos", nil) forState:UIControlStateNormal];
    [self.view addSubview:buttonPhotos];
    
    //// Gaussian Blur
    [self generateBlurredImage];
    
}

- (void)generateBlurredImage
{
    UIImage* imageCaptured;
    CGRect rect = buttonPhotos.frame;
    
    //// Camera
    imageCaptured = [self.view imageByRenderingViewWithRect:buttonCamera.frame];
    [buttonCamera generateBackgroundImageByCaputuredImage:imageCaptured];
    
    //// Photos
    imageCaptured = [self.view imageByRenderingViewWithRect:buttonPhotos.frame];
    [buttonPhotos generateBackgroundImageByCaputuredImage:imageCaptured];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
