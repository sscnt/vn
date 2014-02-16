//
//  EditorViewController.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImageEffectsImport.h"
#import "GPUImageEffects.h"
#import "UINavigationBarView.h"
#import "UICloseButton.h"
#import "UIEditorPreviewImageView.h"
#import "UISaveButton.h"
#import "SVProgressHUD.h"

@interface EditorViewController : UIViewController
{
    UIEditorPreviewImageView* _imageViewPreview;
    CGFloat _strength;
    BOOL _isSaving;
}

@property (nonatomic, assign) EffectId effectId;
@property (nonatomic, assign) BOOL waitingForOtherConversion;
@property (nonatomic, weak) UIImage* imageOriginal;
@property (nonatomic, weak) UIImage* imageResized;
@property (nonatomic, strong) UIImage* imageEffected;

- (void)applyEffect;
- (void)didPressCloseButton;
- (void)didPressSaveButton;
- (GPUImageEffects*)effect:(EffectId)effectId;

- (UIImage*)merge2pictureBase:(GPUImagePicture*)basePicture overlay:(GPUImagePicture*)overlayPicture opacity:(CGFloat)opacity;

@end
