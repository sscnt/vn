//
//  SaveViewController.h
//  Vintage
//
//  Created by SSC on 2014/03/11.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImageEffectsImport.h"
#import "GPUImageEffects.h"
#import "UINavigationBarView.h"
#import "UICloseButton.h"


@interface SaveViewController : UIViewController

@property (nonatomic, assign) EffectId effectId;
@property (nonatomic, weak) UIImage* imageOriginal;

@end
