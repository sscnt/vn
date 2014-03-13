//
//  EditorViewController.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "EditorViewController.h"

@interface EditorViewController ()

@end

@implementation EditorViewController

float absf(float value){
    if (value < 0.0) {
        return -value;
    }
    return value;
}

- (id)init
{
    self = [super init];
    if (self) {
        _valueOpacity = 1.0;
        _isSaving = NO;
        _isApplying = NO;
        _isSliding = NO;
        _dialogState = DialogStateDidHide;
        _currentResolution = ImageResolutionMidium;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];

    
    //// Preview
    CGFloat width = [UIScreen screenSize].width;
    CGFloat height = _imageOriginal.size.height * width / _imageOriginal.size.width;
    CGFloat max_height = [UIScreen screenSize].height - 88.0f - 30.0f;
    if (height > max_height) {
        width *= max_height / height;
        height = max_height;
    }
    _previewImageView = [[UIEditorPreviewImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    _previewImageView.delegate = self;
    _previewImageView.center = self.view.center;
    [self.view addSubview:_previewImageView];
    
    //// Sliders
    //////// Opacity
    _sliderOpacity = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, [UIScreen screenSize].width, 42.0f)];
    _sliderOpacity.tag = EditorSliderIconTypeOpacity;
    _sliderOpacity.delegate = self;
    _sliderOpacity.title = NSLocalizedString(@"Opacity", nil);
    _sliderOpacity.iconType = EditorSliderIconTypeOpacity;
    _sliderOpacity.titlePosition = SliderViewTitlePositionCenter;
    _sliderOpacity.defaultValue = 1.0f;
    //////// Adjustment
    _adjustmentOpacity = [[UISliderContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderOpacity.bounds.size.height + 20.0f)];
    _adjustmentOpacity.tag = AdjustmentViewIdOpacity;
    [_adjustmentOpacity addSubview:_sliderOpacity];
    _adjustmentOpacity.hidden = YES;
    [self.view addSubview:_adjustmentOpacity];
    
    //////// Brightness
    //////////// Global
    _sliderBrightness = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, [UIScreen screenSize].width, 42.0f)];
    _sliderBrightness.tag = EditorSliderIconTypeBrightness;
    _sliderBrightness.delegate = self;
    _sliderBrightness.title = NSLocalizedString(@"Brightness", nil);
    _sliderBrightness.iconType = EditorSliderIconTypeBrightness;
    _sliderBrightness.titlePosition = SliderViewTitlePositionLeft;
    _sliderBrightness.defaultValue = 0.5f;
    //////////// Levels
    _sliderLevels = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderBrightness.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderLevels.tag = EditorSliderIconTypeLevels;
    _sliderLevels.delegate = self;
    _sliderLevels.title = NSLocalizedString(@"Levels", nil);
    _sliderLevels.iconType = EditorSliderIconTypeLevels;
    _sliderLevels.titlePosition = SliderViewTitlePositionLeft;
    _sliderLevels.defaultValue = 0.5f;
    //////////// Levels
    _sliderVignette = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderBrightness.frame.size.height + _sliderLevels.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderVignette.tag = EditorSliderIconTypeVignette;
    _sliderVignette.delegate = self;
    _sliderVignette.title = NSLocalizedString(@"Vignette", nil);
    _sliderVignette.iconType = EditorSliderIconTypeVignette;
    _sliderVignette.titlePosition = SliderViewTitlePositionCenter;
    _sliderVignette.defaultValue = 0.0f;
    //////// Adjustment
    _adjustmentBrightness = [[UISliderContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderBrightness.bounds.size.height * 3.0f + 20.0f)];
    _adjustmentBrightness.tag = AdjustmentViewIdBrightness;
    [_adjustmentBrightness addSubview:_sliderBrightness];
    [_adjustmentBrightness addSubview:_sliderLevels];
    [_adjustmentBrightness addSubview:_sliderVignette];
    _adjustmentBrightness.hidden = YES;
    [self.view addSubview:_adjustmentBrightness];
    
    //////// Contrast
    //////////// Global
    _sliderContrast = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, [UIScreen screenSize].width, 42.0f)];
    _sliderContrast.tag = EditorSliderIconTypeContrast;
    _sliderContrast.delegate = self;
    _sliderContrast.title = NSLocalizedString(@"Contrast", nil);
    _sliderContrast.iconType = EditorSliderIconTypeContrast;
    _sliderContrast.titlePosition = SliderViewTitlePositionLeft;
    _sliderContrast.defaultValue = 0.5f;
    //////////// Local
    _sliderClarity = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderContrast.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderClarity.tag = EditorSliderIconTypeClarity;
    _sliderClarity.delegate = self;
    _sliderClarity.title = NSLocalizedString(@"Clarity", nil);
    _sliderClarity.iconType = EditorSliderIconTypeClarity;
    _sliderClarity.titlePosition = SliderViewTitlePositionCenter;
    _sliderClarity.defaultValue = 0.0f;
    //////// Adjustment
    _adjustmentContrast = [[UISliderContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderContrast.bounds.size.height * 2.0f + 20.0f)];
    _adjustmentContrast.tag = AdjustmentViewIdContrast;
    [_adjustmentContrast addSubview:_sliderContrast];
    [_adjustmentContrast addSubview:_sliderClarity];
    _adjustmentContrast.hidden = YES;
    [self.view addSubview:_adjustmentContrast];
    
    //////// Color
    //////////// Saturation
    _sliderSaturation = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, [UIScreen screenSize].width, 42.0f)];
    _sliderSaturation.tag = EditorSliderIconTypeSaturation;
    _sliderSaturation.delegate = self;
    _sliderSaturation.title = NSLocalizedString(@"Saturation", nil);
    _sliderSaturation.iconType = EditorSliderIconTypeSaturation;
    _sliderSaturation.titlePosition = SliderViewTitlePositionLeft;
    _sliderSaturation.defaultValue = 0.5f;
    //////////// Vibrance
    _sliderVibrance = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderSaturation.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderVibrance.tag = EditorSliderIconTypeVibrance;
    _sliderVibrance.delegate = self;
    _sliderVibrance.title = NSLocalizedString(@"Vibrance", nil);
    _sliderVibrance.iconType = EditorSliderIconTypeVibrance;
    _sliderVibrance.titlePosition = SliderViewTitlePositionLeft;
    _sliderVibrance.defaultValue = 0.5f;
    //////////// Temperature
    _sliderKelvin = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderSaturation.frame.size.height + _sliderVibrance.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderKelvin.tag = EditorSliderIconTypeKelvin;
    _sliderKelvin.delegate = self;
    _sliderKelvin.title = NSLocalizedString(@"Temperature", nil);
    _sliderKelvin.iconType = EditorSliderIconTypeKelvin;
    _sliderKelvin.titlePosition = SliderViewTitlePositionLeft;
    _sliderKelvin.defaultValue = 0.5f;
    //////// Adjustment
    _adjustmentColor = [[UISliderContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderKelvin.bounds.size.height * 3.0f + 20.0f)];
    _adjustmentColor.tag = AdjustmentViewIdColor;
    [_adjustmentColor addSubview:_sliderSaturation];
    [_adjustmentColor addSubview:_sliderVibrance];
    [_adjustmentColor addSubview:_sliderKelvin];
    _adjustmentColor.hidden = YES;
    [self.view addSubview:_adjustmentColor];

    
    //// Bottom Bar
    _bottomNavigationBar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionBottom];
    [_bottomNavigationBar setOpacity:1.0f];
    
    //////// Save
    UISaveButton* buttonSave = [[UISaveButton alloc] init];
    [buttonSave addTarget:self action:@selector(didPressSaveButton) forControlEvents:UIControlEventTouchUpInside];
    [_bottomNavigationBar appendButtonToRight:buttonSave];
    [self.view addSubview:_bottomNavigationBar];
    
    //////// Opacity
    _buttonOpacity = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeOpacity];
    _buttonOpacity.selected = YES;
    _buttonOpacity.tag = AdjustmentViewIdOpacity;
    [_buttonOpacity addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomNavigationBar appendButtonToLeft:_buttonOpacity];
    
    //////// Brightness
    _buttonBrightness = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeBrightness];
    _buttonBrightness.tag = AdjustmentViewIdBrightness;
    [_buttonBrightness addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomNavigationBar appendButtonToLeft:_buttonBrightness];
    
    //////// Contrast
    _buttonContrast = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeContrast];
    _buttonContrast.tag = AdjustmentViewIdContrast;
    [_buttonContrast addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomNavigationBar appendButtonToLeft:_buttonContrast];
    
    //////// Color
    _buttonColor = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeColor];
    _buttonColor.tag = AdjustmentViewIdColor;
    [_buttonColor addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomNavigationBar appendButtonToLeft:_buttonColor];
    
    
    //// Top Bar
    _topNavigationBar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    [_topNavigationBar setTitle:NSLocalizedString(@"EDIT", nil)];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [_topNavigationBar appendButtonToLeft:buttonClose];
    [self.view addSubview:_topNavigationBar];
    
    
    //// Label
    _percentageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, 44.0f)];
    _percentageLabel.center = _previewImageView.center;
    NSArray *langs = [NSLocale preferredLanguages];
    NSString *currentLanguage = [langs objectAtIndex:0];
    if([currentLanguage compare:@"ja"] == NSOrderedSame) {
        _percentageLabel.font = [UIFont fontWithName:@"rounded-mplus-1p-bold" size:20.0f];
    } else {
        _percentageLabel.font = [UIFont fontWithName:@"Aller-Bold" size:20.0f];
    }
    _percentageLabel.textAlignment = NSTextAlignmentCenter;
    _percentageLabel.backgroundColor = [UIColor clearColor];
    _percentageLabel.textColor = [UIColor whiteColor];
    _percentageLabel.numberOfLines = 0;
    _percentageLabel.shadowColor = [UIColor blackColor];
    _percentageLabel.shadowOffset = CGSizeMake(1, 1);
    _percentageLabel.hidden = YES;
    [self.view addSubview:_percentageLabel];
    
    if (!self.waitingForOtherConversion) {
        [self applyEffect];        
    }
}

- (GPUImageEffects*)effect:(EffectId)effectId
{
    switch (effectId) {
        case EffectIdBeachVintage:
            return [[GPUEffectBeachVintage alloc] init];
            break;
        case EffectIdCreamyNoon:
            return [[GPUEffectCreamyNoon alloc] init];
            break;
        case EffectIdCavalleriaRusticana:
            return [[GPUEffectCavalleriaRusticana alloc] init];
            break;
        case EffectIdDreamyVintage:
            return [[GPUEffectDreamyVintage alloc] init];
            break;
        case EffectIdFaerieVintage:
            return [[GPUEffectFaerieVintage alloc] init];
            break;
        case EffectIdGentleMemories:
            return [[GPUEffectGentleMemories alloc] init];
            break;
        case EffectIdGirder:
            return [[GPUEffectGirder alloc] init];
            break;
        case EffectIdHaze3:
            return [[GPUEffectHaze3 alloc] init];
            break;
        case EffectIdHazelnut:
            return [[GPUEffectHazelnut alloc] init];
            break;
        case EffectIdJoyful:
            return [[GPUEffectJoyful alloc] init];
            break;
        case EffectIdMiami:
            return [[GPUEffectMiami alloc] init];
            break;
        case EffectIdOldTone:
            return [[GPUEffectOldTone alloc] init];
            break;
        case EffectIdPinkBubbleTea:
            return [[GPUEffectPinkBubbleTea alloc] init];
            break;
        case EffectIdSummers:
            return [[GPUEffectSummers alloc] init];
            break;
        case EffectIdSunsetCarnevale:
            return [[GPUEffectSunsetCarnevale alloc] init];
            break;
        case EffectIdVintage1:
            return [[GPUEffectVintage1 alloc] init];
            break;
        case EffectIdVintage2:
            return [[GPUEffectVintage2 alloc] init];
            break;
        case EffectIdVintageFilm:
            return [[GPUEffectVintageFilm alloc] init];
            break;
        case EffectIdVividVintage:
            return [[GPUEffectVividVintage alloc] init];
            break;
        case EffectIdWarmAutumn:
            return [[GPUEffectWarmAutumn alloc] init];
            break;
        case EffectIdWarmSpringLight:
            return [[GPUEffectWarmSpringLight alloc] init];
            break;
        case EffectIdWeekend:
            return [[GPUEffectWeekend alloc] init];
            break;
    }
}

- (UIImage*)resizeImage:(UIImage *)image WithResolution:(ImageResolution)resolution
{
    if(resolution == ImageResolutionMax){
        return image;
    }
    if(resolution == ImageResolutionMidium){
        return [image resizedImage:CGSizeMake(roundf(image.size.width / 2.0f), roundf(image.size.height / 2.0f)) interpolationQuality:kCGInterpolationHigh];
    }
    if(resolution == ImageResolutionSmall){
        return [image resizedImage:CGSizeMake(roundf(image.size.width / 4.0f), roundf(image.size.height / 4.0f)) interpolationQuality:kCGInterpolationHigh];
    }
    return image;
}

- (UIImage*)processImage:(UIImage *)inputImage
{
    inputImage = [self processImageClarity:inputImage];
    inputImage = [self processImageAdjustments:inputImage];
    inputImage = [self processImageEffect:inputImage];
    inputImage = [self processImageFinal:inputImage];
    return inputImage;
}

- (UIImage*)processImageClarity:(UIImage *)inputImage
{
    //// Clarity
    if (_sliderClarity.value != 0.0f) {
        LOG(@"clarity enabled. %f", _sliderClarity.value);
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
        GPUImageClarityFilter* filter = [[GPUImageClarityFilter alloc] init];
        filter.blurRadiusInPixels = 40.0f;
        filter.intensity = (_valueClarity + 1.0f);
        [base addTarget:filter];
        [base processImage];
        inputImage = [filter imageFromCurrentlyProcessedOutput];
    }
    return inputImage;
}

- (UIImage*)processImageAdjustments:(UIImage *)inputImage
{
    
    GPUImageAllAdjustmentsInOneFilter* adjustmentFilter = [[GPUImageAllAdjustmentsInOneFilter alloc] init];
    
    //// Brightness
    if (_sliderBrightness.value != 0.5f) {
        LOG(@"brightness enabled. %f", _sliderBrightness.value);
        adjustmentFilter.brightness = _valueBrightness;
    }
    
    //// Levels
    if (_sliderLevels.value != 0.5f) {
        LOG(@"levels enabled. %f", _sliderLevels.value);
        [adjustmentFilter setLevelsMin:0.0f gamma:_valueLevels max:1.0f];
    }
    
    //// Contrast
    if (_sliderContrast.value != 0.5f) {
        LOG(@"contrast enabled. %f", _sliderContrast.value);
        adjustmentFilter.contrast = _valueContrast;
    }
    
    //// Temperature
    if (_sliderKelvin.value != 0.5f) {
        LOG(@"temperature enabled. %f", _sliderKelvin.value);
        adjustmentFilter.kelvin = 6500.0 - 6500.0 * _valueKelvin * 2.0f / 3.0f;
        adjustmentFilter.kelvinStrength = MIN(abs(_valueKelvin * 50), 50);
    }
    
    //// Saturation
    if (_sliderSaturation.value != 0.5f) {
        LOG(@"saturation enabled. %f", _sliderSaturation.value);
        adjustmentFilter.saturation = _valueSaturation;
    }
    
    //// Vibrance
    if (_sliderVibrance.value != 0.5f) {
        LOG(@"vibrance enabled. %f", _sliderVibrance.value);
        adjustmentFilter.vibrance = _valueVibrance;
    }
    
    GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
    [base addTarget:adjustmentFilter];
    [base processImage];
    inputImage = [adjustmentFilter imageFromCurrentlyProcessedOutput];
    return inputImage;
}

- (UIImage*)processImageEffect:(UIImage *)inputImage
{
    GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
    GPUImageEffects* effect = [self effect:_effectId];
    effect.imageToProcess = inputImage;
    UIImage* imageEffected = [effect process];
    GPUImagePicture* overlay = [[GPUImagePicture alloc] initWithImage:imageEffected];
    imageEffected = [self merge2pictureBase:base overlay:overlay opacity:_valueOpacity];
    return imageEffected;
}

- (UIImage*)processImageFinal:(UIImage *)inputImage
{
    //// Vignette
    if (_sliderVignette.value != 0.0f) {
        LOG(@"vignette enabled. %f", _sliderVignette.value);
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
        GPUImageVignette2Filter* filter = [[GPUImageVignette2Filter alloc] init];
        filter.scale = _valueVignette;
        [base addTarget:filter];
        [base processImage];
        inputImage = [filter imageFromCurrentlyProcessedOutput];
    }
    return inputImage;
}

- (void)applyEffect
{
    if (_isApplying == YES) {
        LOG(@"Please wait.");
        return;
    }
    _isApplying = YES;
    LOG(@"will apply effect");
    __block EditorViewController* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            
            _imageEffected = [_self processImage:_imageResized];
            
            GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
            filter.blurRadiusInPixels = 8.0f;
            GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:_imageEffected];
            [base addTarget:filter];
            [base processImage];
            _blurredImage = [filter imageFromCurrentlyProcessedOutput];
            
            filter.blurRadiusInPixels = 16.0f;
            [base processImage];
            _dialogBgImage = [filter imageFromCurrentlyProcessedOutput];
        }
        dispatch_async(q_main, ^{
            if(_previewImageView.isPreviewReady){
                _previewImageView.imageBlurred = _blurredImage;
                [_previewImageView setPreviewImage:_imageEffected];
                [_previewImageView toggleBlurredImage:NO WithDuration:0.20f];
                [_self unlockAllSliders];
            }else{
                
                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                dispatch_async(q_global, ^{
                    
                    dispatch_async(q_main, ^{
                        _previewImageView.imageOriginal = _imageResized;
                        _previewImageView.imageBlurred = _blurredImage;
                        _previewImageView.isPreviewReady = YES;
                        [_previewImageView setPreviewImage:_imageEffected];
                        [_previewImageView removeLoadingIndicator];
                        [_self slideUpAdjustment:_adjustmentOpacity Completion:nil];
                        _isApplying = NO;
                    });
                });
            }
        });
        
    });
}

- (UIImage*)mergeBaseImage:(UIImage *)baseImage overlayImage:(UIImage *)overlayImage opacity:(CGFloat)opacity blendingMode:(MergeBlendingMode)blendingMode
{
    GPUImagePicture* overlayPicture = [[GPUImagePicture alloc] initWithImage:overlayImage];
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = opacity;
    [overlayPicture addTarget:opacityFilter];
    
    GPUImagePicture* basePicture = [[GPUImagePicture alloc] initWithImage:baseImage];
    
    id blending = [GPUImageEffects effectByBlendMode:blendingMode];
    [opacityFilter addTarget:blending atTextureLocation:1];
    
    [basePicture addTarget:blending];
    [basePicture processImage];
    [overlayPicture processImage];
    return [blending imageFromCurrentlyProcessedOutput];
    
}

- (UIImage*)mergeBaseImage:(UIImage *)baseImage overlayFilter:(GPUImageFilter *)overlayFilter opacity:(CGFloat)opacity blendingMode:(MergeBlendingMode)blendingMode
{
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = opacity;
    [overlayFilter addTarget:opacityFilter];
    
    GPUImagePicture* picture = [[GPUImagePicture alloc] initWithImage:baseImage];
    [picture addTarget:overlayFilter];
    
    id blending = [GPUImageEffects effectByBlendMode:blendingMode];
    [opacityFilter addTarget:blending atTextureLocation:1];
    
    [picture addTarget:blending];
    [picture processImage];
    return [blending imageFromCurrentlyProcessedOutput];
    
}

- (UIImage*)merge2pictureBase:(GPUImagePicture *)basePicture overlay:(GPUImagePicture *)overlayPicture opacity:(CGFloat)opacity
{
    GPUImageNormalBlendFilter* normalBlend = [[GPUImageNormalBlendFilter alloc] init];
    [basePicture addTarget:normalBlend];
    
    GPUImageOpacityFilter* opacityFilter = [[GPUImageOpacityFilter alloc] init];
    opacityFilter.opacity = opacity;
    
    [opacityFilter addTarget:normalBlend atTextureLocation:1];
    [overlayPicture addTarget:opacityFilter];
    [basePicture processImage];
    [overlayPicture processImage];
    return [normalBlend imageFromCurrentlyProcessedOutput];
}

- (void)slideDownAdjustment:(UISliderContainer *)adjustment Completion:(void (^)(BOOL))completion
{
    if (_isSliding) {
        LOG(@"sliding.");
        return;
    }
    _isSliding = YES;
    [UIView animateWithDuration:0.10f animations:^{
        adjustment.frame = CGRectMake(adjustment.frame.origin.x, [UIScreen screenSize].height - 44.0f, adjustment.frame.size.width, adjustment.frame.size.height);
    } completion:^(BOOL finished){
        adjustment.hidden = YES;
        _isSliding = NO;
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)slideUpAdjustment:(UISliderContainer *)adjustment Completion:(void (^)(BOOL))completion
{
    if (_isSliding) {
        LOG(@"sliding.");
        return;
    }
    _isSliding = YES;
    [adjustment setY:[UIScreen screenSize].height - 44.0f];
    adjustment.hidden = NO;
    _adjustmentCurrent = adjustment;
    [UIView animateWithDuration:0.10f animations:^{
        _adjustmentCurrent.frame = CGRectMake(_adjustmentCurrent.frame.origin.x, [UIScreen screenSize].height - _adjustmentCurrent.bounds.size.height - 44.0f, _adjustmentCurrent.frame.size.width, _adjustmentCurrent.frame.size.height);
    } completion:^(BOOL finished){
        _isSliding = NO;
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)slideDownCurrentAdjustmentAndSlideUpAdjustment:(UISliderContainer *)adjustment
{
    if (_adjustmentCurrent) {
        __block UISliderContainer* _adjustment = adjustment;
        __block EditorViewController* _self = self;
        [self slideDownAdjustment:_adjustmentCurrent Completion:^(BOOL finished){
            [_self slideUpAdjustment:_adjustment Completion:nil];
        }];
    }else{
        [self slideUpAdjustment:adjustment Completion:nil];
    }
}

#pragma mark events

- (void)didPressAdjustmentButton:(UINavigationBarButton *)button
{
    if (_isSliding) {
        return;
    }
    if(_isApplying){
        return;
    }
    _buttonBrightness.selected = NO;
    _buttonColor.selected = NO;
    _buttonContrast.selected = NO;
    _buttonOpacity.selected = NO;
    button.selected = YES;
    UISliderContainer* adjustment;
    switch (button.tag) {
        case AdjustmentViewIdOpacity:
            adjustment = _adjustmentOpacity;
            break;
        case AdjustmentViewIdBrightness:
            adjustment = _adjustmentBrightness;
            break;
        case AdjustmentViewIdColor:
            adjustment = _adjustmentColor;
            break;
        case AdjustmentViewIdContrast:
            adjustment = _adjustmentContrast;
        default:
            break;
    }
    [self slideDownCurrentAdjustmentAndSlideUpAdjustment:adjustment];
}

- (void)didPressSaveButton
{
    if(_isApplying){
        return;
    }
    if(_isSliding){
        return;
    }
    [self showSaveDialog];
}

- (void)showSaveDialog
{
    if(_dialogState != DialogStateDidHide){
        return;
    }
    _dialogState = DialogStateWillShow;
    
    if(!_dialogBgImageView){
        _dialogBgImageView = [[UIEditorDialogBgImageView alloc] init];
        _dialogBgImageView.delegate = self;
    }
    _dialogBgImageView.hidden = YES;
    _dialogBgImageView.alpha = 0.70f;
    [_dialogBgImageView setImage:_dialogBgImage];
    [_dialogBgImageView setCenter:_previewImageView.center];
    [self.view addSubview:_dialogBgImageView];
    
    if(!_resolutionSelector){
        _resolutionSelector = [[UIResolutionSelectorView alloc] init];
        _resolutionSelector.delegate = self;
        _resolutionSelector.maxImageHeight = _imageOriginal.size.height;
        _resolutionSelector.maxImageWidth = _imageOriginal.size.width;
        [_resolutionSelector setResolution:ImageResolutionMidium];
    }
    _resolutionSelector.alpha = 0.0f;
    [_resolutionSelector setY:-_resolutionSelector.frame.size.height];
    [self.view addSubview:_resolutionSelector];
    
    if(!_saveToView){
        _saveToView = [[UISaveToView alloc] init];
        _saveToView.delegate = self;
    }
    _saveToView.alpha = 0.0f;
    [_saveToView setY:[UIScreen screenSize].height];
    [self.view addSubview:_saveToView];
    
    CGFloat width = _dialogBgImage.size.width * [UIScreen screenSize].height / _dialogBgImage.size.height;
    CGFloat height = [UIScreen screenSize].height;
    CGRect frame = CGRectMake(0.0f, 0.0f, width, height);
    _dialogBgImageView.frame = frame;
    _dialogBgImageView.center = _previewImageView.center;
    frame = _dialogBgImageView.frame;
    _dialogBgImageView.frame = _previewImageView.frame;
    _dialogBgImageView.hidden = NO;
    
    CGPoint center = _previewImageView.center;
    CGFloat saveToViewTop = 40.0f + _resolutionSelector.frame.size.height + 40.0f;
    
    [self slideDownAdjustment:_adjustmentCurrent Completion:nil];
    
    __block UIImageView* _bgView = _dialogBgImageView;
    __block UINavigationBarView* topNavBar = _topNavigationBar;
    __block UINavigationBarView* bottomNavBar = _bottomNavigationBar;
    [UIView animateWithDuration:0.20f animations:^{
        _resolutionSelector.alpha = 1.0f;
        [_resolutionSelector setY:40.0f];
        _saveToView.alpha = 1.0f;
        [_saveToView setY:saveToViewTop];
        [topNavBar setY:-44.0f];
        [bottomNavBar setY:[UIScreen screenSize].height];
        _bgView.frame = frame;
        _bgView.center = center;
        _bgView.alpha = 1.0f;
    } completion:^(BOOL finished){
        _dialogState = DialogStateDidShow;
    }];
}

- (void)hideSaveDialog
{
    if(_dialogState != DialogStateDidShow){
        return;
    }
    CGRect frame = _previewImageView.frame;
    __block EditorViewController* _self = self;
    [UIView animateWithDuration:0.20f animations:^{
        [_resolutionSelector setY:-_resolutionSelector.frame.size.height];
        _resolutionSelector.alpha = 0.0f;
        [_saveToView setY:[UIScreen screenSize].height];
        _saveToView.alpha = 0.0f;
        _dialogBgImageView.frame = frame;
        [_topNavigationBar setY:0.0f];
        [_bottomNavigationBar setY:[UIScreen screenSize].height - 44.0f];
    } completion:^(BOOL finished){
        [_resolutionSelector removeFromSuperview];
        [_self slideUpAdjustment:_adjustmentCurrent Completion:nil];
        [UIView animateWithDuration:0.10f animations:^{
            _dialogBgImageView.alpha = 0.0f;
        } completion:^(BOOL finished){
            _dialogState = DialogStateDidHide;
            [_dialogBgImageView removeFromSuperview];
        }];
    }];
}

- (void)saveImage:(SaveTo)saveTo
{
    __block EditorViewController* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        
        UIImage* resultImage = [_self processImage:[_self resizeImage:_imageOriginal WithResolution:_currentResolution]];
        UIImageWriteToSavedPhotosAlbum(resultImage, nil, nil, nil);
        
        dispatch_async(q_main, ^{
            [_self didSaveImage:saveTo];
        });
        
    });

}

- (void)didSaveImage:(SaveTo)saveTo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Saved successfully", nil)];
    __block EditorViewController* _self = self;
    [UIView animateWithDuration:0.20f animations:^{
        _resolutionSelector.alpha = 1.0f;
        _saveToView.alpha = 1.0f;
    } completion:^(BOOL finished){
        _isSaving = NO;
    }];
}

- (void)lockAllSliders
{
    _adjustmentCurrent.locked = YES;
    if(_adjustmentCurrent == _adjustmentBrightness){
        _sliderBrightness.locked = YES;
        _sliderLevels.locked = YES;
        _sliderVignette.locked = YES;
        return;
    }
    if(_adjustmentCurrent == _adjustmentColor){
        _sliderSaturation.locked = YES;
        _sliderVibrance.locked = YES;
        _sliderKelvin.locked = YES;
        return;
    }
    if(_adjustmentCurrent == _adjustmentContrast){
        _sliderContrast.locked = YES;
        _sliderClarity.locked = YES;
        return;
    }
    if(_adjustmentCurrent == _adjustmentOpacity){
        _sliderOpacity.locked = YES;
        return;
    }
}

- (void)unlockAllSliders
{
    
    _adjustmentCurrent.locked = NO;
    if(_adjustmentCurrent == _adjustmentBrightness){
        _sliderBrightness.locked = NO;
        _sliderLevels.locked = NO;
        _sliderVignette.locked = NO;
        return;
    }
    if(_adjustmentCurrent == _adjustmentColor){
        _sliderSaturation.locked = NO;
        _sliderVibrance.locked = NO;
        _sliderKelvin.locked = NO;
        return;
    }
    if(_adjustmentCurrent == _adjustmentContrast){
        _sliderContrast.locked = NO;
        _sliderClarity.locked = NO;
        return;
    }
    if(_adjustmentCurrent == _adjustmentOpacity){
        _sliderOpacity.locked = NO;
        return;
    }

}

#pragma mark delegate

- (void)previewIsReady:(UIEditorPreviewImageView *)preview
{
    LOG(@"Did apply effect");
    _isApplying = NO;
}

- (void)previewDidTouchDown:(UIEditorPreviewImageView *)preview
{
    if(_dialogState == DialogStateDidHide){
        [preview toggleOriginalImage:YES];
        return;
    }
}

- (void)previewDidTouchUp:(UIEditorPreviewImageView *)preview
{
    if(_dialogState == DialogStateDidHide){
        [preview toggleOriginalImage:NO];
        return;
    }
}

- (void)touchesBeganWithBackgroundImageView:(UIEditorDialogBgImageView *)slider
{
    
}
- (void)touchesEndedWithBackgroundImageView:(UIEditorDialogBgImageView *)slider
{
    [self hideSaveDialog];
}
- (void)slider:(UIEditorSliderView*)slider DidValueChange:(CGFloat)value
{
    if (_isApplying) {
        return;
    }
    [self showCurrentValueWithSlider:slider];
}

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selector:(UIResolutionSelectorView *)selector DidSelectResolution:(ImageResolution)resolution
{
    _currentResolution = resolution;
}

- (void)saveToView:(UISaveToView *)view DidSelectSaveTo:(SaveTo)saveTo
{
    
    if (_isSaving) {
        LOG(@"sorry now saving.");
        return;
    }
    _isSaving = YES;
    LOG(@"saving...");

    __block EditorViewController* _self = self;
    [UIView animateWithDuration:0.20f animations:^{
        _resolutionSelector.alpha = 0.30f;
        _saveToView.alpha = 0.30f;
    } completion:^(BOOL finished){
        [_saveToView clearSelected];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [_self saveImage:saveTo];
    }];
}

- (void)touchesBeganWithSlider:(UIEditorSliderView *)slider
{
    if (_isApplying) {
        return;
    }
    LOG(@"touchstart");
    [_previewImageView toggleBlurredImage:YES WithDuration:0.10f];
    
}

- (void)touchesEndedWithSlider:(UIEditorSliderView *)slider
{
    LOG(@"touchesend");
    _percentageLabel.hidden = YES;
    if (!_previewImageView.isPreviewReady) {
        LOG(@"preview not ready.");
        [slider resetToDefaultPosition];
        return;
    }
    
    if (_isApplying) {
        return;
    }
    [self lockAllSliders];
    [self applyValueWithSlider:slider];
    [self applyEffect];
    
}

- (BOOL)sliderShouldValueResetToDefault:(UIEditorSliderView *)slider
{
    if (_isApplying) {
        return false;
    }else{
        [_previewImageView toggleBlurredImage:YES WithDuration:0.10f];
        return true;
    }
}

- (void)sliderDidValueResetToDefault:(UIEditorSliderView *)slider
{
    if (_isApplying) {
        
    }else{
        [self lockAllSliders];
        [self applyValueWithSlider:slider];
        [self applyEffect];        
    }
}

- (void)showCurrentValueWithSlider:(UIEditorSliderView *)slider
{
    _percentageLabel.hidden = NO;
    switch (slider.tag) {
        case EditorSliderIconTypeBrightness:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Brightness", nil), (int)roundf((slider.value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeClarity:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Clarity", nil), (int)roundf(slider.value * 100.0f)];
            break;
        case EditorSliderIconTypeContrast:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Contrast", nil), (int)roundf((slider.value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeKelvin:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Temperature", nil), (int)roundf((slider.value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeLevels:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Levels", nil), (int)roundf((slider.value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeOpacity:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Opacity", nil), (int)roundf(slider.value * 100.0f)];
            break;
        case EditorSliderIconTypeVignette:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Vignette", nil), (int)roundf(slider.value * 100.0f)];
            break;
        case EditorSliderIconTypeSaturation:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Saturation", nil), (int)roundf((slider.value - 0.5f) * 200.0f)];
            break;
        case EditorSliderIconTypeVibrance:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Vibrance", nil), (int)roundf((slider.value - 0.5f) * 200.0f)];
            break;
    }
    

}

- (void)applyValueWithSlider:(UIEditorSliderView *)slider
{
    switch (slider.tag) {
        case EditorSliderIconTypeBrightness:
            _valueBrightness = (slider.value - 0.5f) * 1.0f;
            break;
        case EditorSliderIconTypeClarity:
            _valueClarity = slider.value;
            break;
        case EditorSliderIconTypeContrast:
            _valueContrast = MAX((slider.value - 0.5) + 1.0f, 0.0f);
            break;
        case EditorSliderIconTypeKelvin:
            _valueKelvin = (slider.value - 0.5f) * 2.0f;
            break;
        case EditorSliderIconTypeLevels:
            _valueLevels = powf(2.718,(slider.value - 0.5f));
            _valueLevels *= _valueLevels;
            break;
        case EditorSliderIconTypeOpacity:
            _valueOpacity = slider.value;
            break;
        case EditorSliderIconTypeVignette:
            _valueVignette = slider.value;
            break;
        case EditorSliderIconTypeSaturation:
            _valueSaturation = slider.value * 2.0f;
            break;
        case EditorSliderIconTypeVibrance:
            _valueVibrance = slider.value * 2.0f;
            break;
    }

}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)dealloc
{
    _previewImageView.delegate = nil;
    _sliderBrightness.delegate = nil;
    _sliderClarity.delegate = nil;
    _sliderContrast.delegate = nil;
    _sliderKelvin.delegate = nil;
    _sliderLevels.delegate = nil;
    _sliderOpacity.delegate = nil;
    _sliderSaturation.delegate = nil;
    _sliderVibrance.delegate = nil;
    _sliderVignette.delegate = nil;
    _dialogBgImageView.delegate = nil;
    _resolutionSelector.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
