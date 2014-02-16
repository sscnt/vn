//
//  EditorViewController.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImageEffects.h"
#import "UINavigationBarView.h"
#import "UICloseButton.h"

@interface EditorViewController : UIViewController

@property (nonatomic, assign) EffectId effectId;
@property (nonatomic, weak) UIImage* imageResized;
@property (nonatomic, weak) UIImage* imageEffected;

- (void)didPressCloseButton;

@end
