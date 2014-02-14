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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
