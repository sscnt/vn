//
//  UIScreen+Gravy.m
//  Gravy_1.0
//
//  Created by SSC on 2013/10/14.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import "UIScreen+extend.h"

@implementation UIScreen (extend)

+ (CGSize)screenSize
{
    CGSize size = [[self mainScreen] bounds].size;
    if ([UIDevice isiPad]) {
        return CGSizeMake(MAX(size.width, size.height), MIN(size.width, size.height));
    }
    return size;
}

+ (CGRect)screenRect
{
    return CGRectMake([[self mainScreen] bounds].origin.x, [[self mainScreen] bounds].origin.y, [[self mainScreen] bounds].size.width, [[self mainScreen] bounds].size.height);
}
+ (CGFloat)height
{
    return [self screenSize].height;
}
+(CGFloat)width
{
    return [self screenSize].width;
}

@end
