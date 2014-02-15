//
//  UIImage+extend.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extend)

+(UIImage*)animatedGIFNamed:(NSString*)name;
+(UIImage*)animatedGIFWithData:(NSData *)data;

-(UIImage*)animatedImageByScalingAndCroppingToSize:(CGSize)size;

@end
