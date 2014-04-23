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
        _progressView = [[VnViewProgress alloc] initWithFrame:[VnEditorViewManager thumbnailImageBounds]];
        [self addSubview:_progressView];
    }
    return self;
}

- (void)removeProgress
{
    
}

@end
