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
#import "UISliderContainer.h"
#import "UIEditorPreviewImageView.h"
#import "UISaveButton.h"
#import "SVProgressHUD.h"
#import "UIEditorSliderView.h"
#import "GPUKelvinFilter.h"
#import "GPUImageVignette2Filter.h"
#import "GPUimageTumblinBrightnessFilter.h"
#import "GPUImageTumblinLevelsFilter.h"
#import "GPUImageVibranceFilter.h"
#import "GPUImageNaturalSaturationFilter.h"
#import "GPUImageClarityFilter.h"
#import "UIEditorDialogBgImageView.h"
#import "UIResolutionSelectorView.h"
#import "UISaveToView.h"
#import "GPUImageAllAdjustmentsInOneFilter.h"

typedef NS_ENUM(NSInteger, AdjustmentViewId){
    AdjustmentViewIdOpacity = 1,
    AdjustmentViewIdBrightness,
    AdjustmentViewIdColor,
    AdjustmentViewIdContrast
};

typedef NS_ENUM(NSInteger, DialogState){
    DialogStateWillShow = 1,
    DialogStateDidShow,
    DialogStateWillHide,
    DialogStateDidHide,
};

@interface EditorViewController : UIViewController <UIEditorSliderViewDelegate, UIEditorPreviewDelegate, UIEditorDialogBgImageViewDelegate, UIResolutionSelectorViewDelegate, UISaveToViewDelegate>
{
    UIEditorPreviewImageView* _previewImageView;
    UIEditorSliderView* _sliderOpacity;
    UIEditorSliderView* _sliderBrightness;
    UIEditorSliderView* _sliderLevels;
    UIEditorSliderView* _sliderVignette;
    UIEditorSliderView* _sliderContrast;
    UIEditorSliderView* _sliderClarity;
    UIEditorSliderView* _sliderKelvin;
    UIEditorSliderView* _sliderSaturation;
    UIEditorSliderView* _sliderVibrance;
    UIEditorSliderView* _sliderCurrentSelected;
    UINavigationBarView* _topNavigationBar;
    UINavigationBarView* _bottomNavigationBar;
    UINavigationBarButton* _buttonOpacity;
    UINavigationBarButton* _buttonBrightness;
    UINavigationBarButton* _buttonColor;
    UINavigationBarButton* _buttonContrast;
    UISliderContainer* _adjustmentOpacity;
    UISliderContainer* _adjustmentBrightness;
    UISliderContainer* _adjustmentColor;
    UISliderContainer* _adjustmentContrast;
    UISliderContainer* _adjustmentCurrent;
    UIEditorDialogBgImageView* _dialogBgImageView;
    UIResolutionSelectorView* _resolutionSelector;
    UISaveToView* _saveToView;
    CGFloat _valueOpacity;
    CGFloat _valueBrightness;
    CGFloat _valueLevels;
    CGFloat _valueVignette;
    CGFloat _valueContrast;
    CGFloat _valueClarity;
    CGFloat _valueKelvin;
    CGFloat _valueSaturation;
    CGFloat _valueVibrance;
    BOOL _isSaving;
    DialogState _dialogState;
    ImageResolution _currentResolution;
    BOOL _isApplying;
    BOOL _isSliding;
    UIImage* _blurredImage;
    UIImage* _dialogBgImage;
    UILabel* _percentageLabel;
}

@property (nonatomic, assign) EffectId effectId;
@property (nonatomic, assign) BOOL waitingForOtherConversion;
@property (nonatomic, weak) UIImage* imageOriginal;
@property (nonatomic, weak) UIImage* imageResized;
@property (nonatomic, strong) UIImage* imageEffected;

- (void)applyEffect;
- (void)didPressAdjustmentButton:(UINavigationBarButton*)button;
- (void)didPressCloseButton;
- (void)didPressSaveButton;
- (GPUImageEffects*)effect:(EffectId)effectId;
- (void)slideDownAdjustment:(UISliderContainer*)adjustment Completion:(void (^)(BOOL))completion;
- (void)slideUpAdjustment:(UISliderContainer*)adjustment Completion:(void (^)(BOOL))completion;
- (void)slideDownCurrentAdjustmentAndSlideUpAdjustment:(UISliderContainer *)adjustment;

- (void)lockAllSliders;
- (void)unlockAllSliders;

- (UIImage*)resizeImage:(UIImage*)image WithResolution:(ImageResolution)resolution;
- (UIImage*)processImage:(UIImage*)inputImage;
- (UIImage*)processImageClarity:(UIImage*)inputImage;
- (UIImage*)processImageAdjustments:(UIImage*)inputImage;
- (UIImage*)processImageEffect:(UIImage*)inputImage;
- (UIImage*)processImageFinal:(UIImage*)inputImage;

- (void)showSaveDialog;
- (void)hideSaveDialog;
- (void)saveImage:(SaveTo)saveTo;
- (void)didSaveImage:(SaveTo)saveTo;

- (UIImage*)merge2pictureBase:(GPUImagePicture*)basePicture overlay:(GPUImagePicture*)overlayPicture opacity:(CGFloat)opacity;
- (UIImage*)mergeBaseImage:(UIImage*)baseImage overlayImage:(UIImage*)overlayImage opacity:(CGFloat)opacity blendingMode:(MergeBlendingMode)blendingMode;
- (UIImage*)mergeBaseImage:(UIImage*)baseImage overlayFilter:(GPUImageFilter*)overlayFilter opacity:(CGFloat)opacity blendingMode:(MergeBlendingMode)blendingMode;

- (void)applyValueWithSlider:(UIEditorSliderView*)slider;
- (void)showCurrentValueWithSlider:(UIEditorSliderView*)slider;

@end
