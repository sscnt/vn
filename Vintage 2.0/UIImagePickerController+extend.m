//
//  UIImagePickerController+extend.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/29.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIImagePickerController+extend.h"

@implementation UIImagePickerController (extend)

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
