//
//  VnViewEditorEffectPresetItemView.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorEffectPresetItemView.h"

@implementation VnViewEditorEffectPresetItemView

- (id)initWithEffect:(VnObjectEffect *)effect
{
    self = [super initWithFrame:[VnEditorViewManager thumbnailViewBounds]];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:[VnEditorViewManager thumbnailImageBounds]];
        _imageView.backgroundColor = [UIColor blackColor];
        [_imageView setX:[VnEditorViewManager thumbnailViewPadding]];
        [_imageView setY:[VnEditorViewManager thumbnailViewPadding]];
        [self addSubview:_imageView];
        _progressView = [[VnViewProgress alloc] initWithFrame:[VnEditorViewManager thumbnailImageBounds] Radius:[VnCurrentSettings thumbnailProgressRadius]];
        [_imageView addSubview:_progressView];
    }
    return self;
}

- (void)removeProgress
{
    
}

@end
