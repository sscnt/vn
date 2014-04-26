//
//  VnEffect.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"

@interface VnEffect : NSObject

@property (nonatomic, weak) UIImage* imageToProcess;
@property (nonatomic, assign) VnEffectId effectId;
@property (nonatomic, assign) CGFloat defaultOpacity;
@property (nonatomic, assign) CGFloat faceOpacity;

- (UIImage*)process;
- (void)mergeAndSaveTmpImageWithOverlayImage:(UIImage*)overlayImage opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode;
- (void)mergeAndSaveTmpImageWithOverlayFilter:(GPUImageFilter*)overlayFilter opacity:(CGFloat)opacity blendingMode:(VnBlendingMode)blendingMode;


@end