//
//  VnFilterTemperature.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "GPUImageFilter.h"

@interface VnFilterTemperature : GPUImageFilter

@property (nonatomic, assign) float kelvin;
@property (nonatomic, assign) float strength;

@end
