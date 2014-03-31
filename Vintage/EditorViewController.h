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
#import "UISaveDialogView.h"
#import "GPUImageAllAdjustmentsInOneFilter.h"
#import "GPUImageFocusFilter.h"
#import "GPUImageLensBlurFilter.h"
#import "UIFocusControlView.h"
#import "UIFocusTypeSelectButton.h"

typedef NS_ENUM(NSInteger, AdjustmentViewId){
    AdjustmentViewIdOpacity = 1,
    AdjustmentViewIdBrightness,
    AdjustmentViewIdContrast,
    AdjustmentViewIdColor,
    AdjustmentViewIdFocus
};

typedef NS_ENUM(NSInteger, DialogState){
    DialogStateWillShow = 1,
    DialogStateDidShow,
    DialogStateWillHide,
    DialogStateDidHide,
};

@interface EditorViewController : UIViewController <UIEditorSliderViewDelegate, UIEditorPreviewDelegate, UIEditorDialogBgImageViewDelegate, UIResolutionSelectorViewDelegate, UISaveDialogViewDelegate, UIFocusControlViewDelegate>
{
    UIEditorSliderView* _sliderOpacity;
    UIEditorSliderView* _sliderBrightness;
    UIEditorSliderView* _sliderLevels;
    UIEditorSliderView* _sliderVignette;
    UIEditorSliderView* _sliderContrast;
    UIEditorSliderView* _sliderClarity;
    UIEditorSliderView* _sliderKelvin;
    UIEditorSliderView* _sliderSaturation;
    UIEditorSliderView* _sliderVibrance;
    UIEditorSliderView* _sliderFocusDistance;
    UIEditorSliderView* _sliderFocusStrength;
    UIEditorSliderView* _sliderCurrentSelected;
    UINavigationBarButton* _buttonOpacity;
    UINavigationBarButton* _buttonBrightness;
    UINavigationBarButton* _buttonColor;
    UINavigationBarButton* _buttonContrast;
    UINavigationBarButton* _buttonFocus;
    CGFloat _valueBrightness;
    CGFloat _valueLevels;
    CGFloat _valueVignette;
    CGFloat _valueContrast;
    CGFloat _valueClarity;
    CGFloat _valueKelvin;
    CGFloat _valueSaturation;
    CGFloat _valueVibrance;
    CGFloat _valueFocusDistance;
    CGFloat _valueFocusStrength;
    CGFloat _valueFocusAngle;
    CGPoint _valueFocusPosition;
    CGFloat _maxImageLength;
    ImageResolution _currentResolution;
    UILabel* _percentageLabel;
    FocusType _currentSelectedFocusType;
}

@property (nonatomic, assign) CGFloat valueOpacity;
@property (nonatomic, assign) DialogState dialogState;
@property (nonatomic, assign) BOOL isSaving;
@property (nonatomic, assign) BOOL isApplying;
@property (nonatomic, assign) BOOL isSliding;
@property (nonatomic, assign) EffectId effectId;
@property (nonatomic, assign) BOOL waitingForOtherConversion;
@property (nonatomic, weak) UIImage* imageOriginal;
@property (nonatomic, weak) UIImage* imageResized;
@property (nonatomic, strong) UIImage* imageEffected;
@property (nonatomic, strong) UIImage* blurredImage;
@property (nonatomic, strong) UIImage* dialogBgImage;
@property (nonatomic, strong) UIResolutionSelectorView* resolutionSelector;
@property (nonatomic, strong) UISaveDialogView* saveDialogView;
@property (nonatomic, strong) UIEditorDialogBgImageView* dialogBgImageView;
@property (nonatomic, strong) UINavigationBarView* topNavigationBar;
@property (nonatomic, strong) UINavigationBarView* bottomNavigationBar;
@property (nonatomic, weak) UISliderContainer* adjustmentCurrent;
@property (nonatomic, strong) UIEditorPreviewImageView* previewImageView;
@property (nonatomic, strong) UISliderContainer* adjustmentOpacity;
@property (nonatomic, strong) UISliderContainer* adjustmentBrightness;
@property (nonatomic, strong) UISliderContainer* adjustmentColor;
@property (nonatomic, strong) UISliderContainer* adjustmentContrast;
@property (nonatomic, strong) UISliderContainer* adjustmentFocus;
@property (nonatomic, strong) UIFocusControlView* focusControlView;
@property (nonatomic, strong) UIFocusTypeSelectButton* focusTypeButtonTopAndBottom;
@property (nonatomic, strong) UIFocusTypeSelectButton* focusTypeButtonTopOnly;
@property (nonatomic, strong) UIFocusTypeSelectButton* focusTypeButtonCircle;

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
