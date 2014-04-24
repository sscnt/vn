//
//  VnViewEditorEffectPresetItemView.h
//  Vintage 2.0
//
//  Created by SSC on 2014/04/23.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VnViewProgress.h"
#import "VnObjectEffect.h"

@interface VnViewEditorEffectPresetItemView : UIView
{
    UIImageView* _imageView;
    VnViewProgress* _progressView;
}
@property (nonatomic, strong) UIImage* image;

- (id)initWithEffect:(VnObjectEffect*)effect;
- (void)removeProgress;

@end
