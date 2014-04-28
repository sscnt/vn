//
//  UIViewController+extend.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/28.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIViewController+extend.h"

@implementation UIViewController (extend)

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if ([UIDevice isiPad]) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

@end
