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

- (id)init
{
    self = [super init];
    if (self) {
        _valueOpacity = 1.0;
        _isSaving = NO;
        _blurredImage = nil;
        _isApplying = NO;
        _isSliding = NO;
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
    //////// Adjustment
    _adjustmentOpacity = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderOpacity.bounds.size.height + 20.0f)];
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
    _sliderBrightness.value = 0.5f;
    //////////// Levels
    _sliderLevels = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderBrightness.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderLevels.tag = EditorSliderIconTypeLevels;
    _sliderLevels.delegate = self;
    _sliderLevels.title = NSLocalizedString(@"Levels", nil);
    _sliderLevels.iconType = EditorSliderIconTypeLevels;
    _sliderLevels.titlePosition = SliderViewTitlePositionLeft;
    _sliderLevels.value = 0.5f;
    //////////// Levels
    _sliderVignette = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderBrightness.frame.size.height + _sliderLevels.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderVignette.tag = EditorSliderIconTypeVignette;
    _sliderVignette.delegate = self;
    _sliderVignette.title = NSLocalizedString(@"Vignette", nil);
    _sliderVignette.iconType = EditorSliderIconTypeVignette;
    _sliderVignette.titlePosition = SliderViewTitlePositionCenter;
    _sliderVignette.value = 0.0f;
    //////// Adjustment
    _adjustmentBrightness = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderBrightness.bounds.size.height * 3.0f + 20.0f)];
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
    _sliderContrast.value = 0.5f;
    //////////// Local
    _sliderClarity = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + _sliderContrast.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderClarity.tag = EditorSliderIconTypeClarity;
    _sliderClarity.delegate = self;
    _sliderClarity.title = NSLocalizedString(@"Clarity", nil);
    _sliderClarity.iconType = EditorSliderIconTypeClarity;
    _sliderClarity.titlePosition = SliderViewTitlePositionCenter;
    _sliderClarity.value = 0.0f;
    //////// Adjustment
    _adjustmentContrast = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderContrast.bounds.size.height * 2.0f + 20.0f)];
    _adjustmentContrast.tag = AdjustmentViewIdContrast;
    [_adjustmentContrast addSubview:_sliderContrast];
    [_adjustmentContrast addSubview:_sliderClarity];
    _adjustmentContrast.hidden = YES;
    [self.view addSubview:_adjustmentContrast];
    
    //////// Color
    _sliderKelvin = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f, [UIScreen screenSize].width, 42.0f)];
    _sliderKelvin.tag = EditorSliderIconTypeKelvin;
    _sliderKelvin.delegate = self;
    _sliderKelvin.title = NSLocalizedString(@"Temperature", nil);
    _sliderKelvin.iconType = EditorSliderIconTypeKelvin;
    _sliderKelvin.titlePosition = SliderViewTitlePositionLeft;
    _sliderKelvin.value = 0.5f;
    //////// Adjustment
    _adjustmentColor = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderKelvin.bounds.size.height + 20.0f)];
    _adjustmentColor.tag = AdjustmentViewIdColor;
    [_adjustmentColor addSubview:_sliderKelvin];
    _adjustmentColor.hidden = YES;
    [self.view addSubview:_adjustmentColor];

    
    //// Bottom Bar
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionBottom];
    [bar setOpacity:1.0f];
    
    //////// Save
    UISaveButton* buttonSave = [[UISaveButton alloc] init];
    [buttonSave addTarget:self action:@selector(didPressSaveButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToRight:buttonSave];
    [self.view addSubview:bar];
    
    //////// Opacity
    _buttonOpacity = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeOpacity];
    _buttonOpacity.selected = YES;
    _buttonOpacity.tag = AdjustmentViewIdOpacity;
    [_buttonOpacity addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:_buttonOpacity];
    
    //////// Brightness
    _buttonBrightness = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeBrightness];
    _buttonBrightness.tag = AdjustmentViewIdBrightness;
    [_buttonBrightness addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:_buttonBrightness];
    
    //////// Contrast
    _buttonContrast = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeContrast];
    _buttonContrast.tag = AdjustmentViewIdContrast;
    [_buttonContrast addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:_buttonContrast];
    
    //////// Color
    _buttonColor = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeColor];
    _buttonColor.tag = AdjustmentViewIdColor;
    [_buttonColor addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:_buttonColor];
    
    
    //// Top Bar
    bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    [bar setTitle:NSLocalizedString(@"EDIT", nil)];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:buttonClose];
    [self.view addSubview:bar];
    
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

- (UIImage*)processImage:(UIImage *)inputImage
{
    
    UIImage* baseImage = inputImage;
    
    //// Brightness
    if (_valueBrightness != 0.0f) {
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:baseImage];
        GPUImageBrightnessFilter* filter = [[GPUImageBrightnessFilter alloc] init];
        filter.brightness = _valueBrightness;
        [base addTarget:filter];
        [base processImage];
        baseImage = [filter imageFromCurrentlyProcessedOutput];
    }
    
    //// Levels
    if (_valueLevels != 0.0f) {
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:baseImage];
        GPUImageLevelsFilter* filter = [[GPUImageLevelsFilter alloc] init];
        [filter setMin:0.0f gamma:_valueLevels max:1.0f];
        [base addTarget:filter];
        [base processImage];
        baseImage = [filter imageFromCurrentlyProcessedOutput];
    }
    
    //// Contrast
    if (_valueContrast != 0.0f) {
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:baseImage];
        GPUImageContrastFilter* filter = [[GPUImageContrastFilter alloc] init];
        filter.contrast = _valueContrast;
        [base addTarget:filter];
        [base processImage];
        baseImage = [filter imageFromCurrentlyProcessedOutput];
    }
    
    //// Clarity
    if (_valueClarity != 0.0f) {
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:baseImage];
        GPUImageUnsharpMaskFilter* filter = [[GPUImageUnsharpMaskFilter alloc] init];
        filter.blurRadiusInPixels = 30.0f;
        filter.intensity = (_valueClarity + 1.0f);
        [base addTarget:filter];
        [base processImage];
        UIImage* unsharpImage = [filter imageFromCurrentlyProcessedOutput];
        baseImage = [self mergeBaseImage:baseImage overlayImage:unsharpImage opacity:1.0f blendingMode:MergeBlendingModeDarkerColor];
    }
    
    //// Kelvin
    if (_valueKelvin != 0.0f) {
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:baseImage];
        GPUKelvinFilter* filter = [[GPUKelvinFilter alloc] init];
        filter.kelvin = 6500.0 - 6500.0 * _valueKelvin;
        filter.strength = MIN(abs(_valueKelvin * 50), 50);
        [base addTarget:filter];
        [base processImage];
        baseImage = [filter imageFromCurrentlyProcessedOutput];

    }
    
    GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:baseImage];
    GPUImageEffects* effect = [self effect:_effectId];
    effect.imageToProcess = baseImage;
    UIImage* imageEffected = [effect process];
    GPUImagePicture* overlay = [[GPUImagePicture alloc] initWithImage:imageEffected];
    imageEffected = [self merge2pictureBase:base overlay:overlay opacity:_valueOpacity];
    
    //// Vignette
    if (_valueVignette != 0.0f) {
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:imageEffected];
        GPUImageVignette2Filter* filter = [[GPUImageVignette2Filter alloc] init];
        filter.scale = _valueVignette;
        [base addTarget:filter];
        [base processImage];
        imageEffected = [filter imageFromCurrentlyProcessedOutput];
    }
    
    return imageEffected;

}

- (void)applyEffect
{
    if (_isApplying) {
        return;
    }
    _isApplying = YES;
    LOG(@"will apply effect");
    __block UIImage* imageEffected = _imageEffected;
    __block UIImage* imageResized = _imageResized;
    __block UIEditorPreviewImageView* previewImageView = _previewImageView;
    __block UIImage* blurredImage = _blurredImage;
    __block EditorViewController* _self = self;
    __block UIView* adjustment = _adjustmentOpacity;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            
            imageEffected = [_self processImage:imageResized];
            
            GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
            filter.blurRadiusInPixels = 8.0f;
            GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:imageEffected];
            [base addTarget:filter];
            [base processImage];
            blurredImage = [filter imageFromCurrentlyProcessedOutput];
            
        }
        dispatch_async(q_main, ^{
            if(previewImageView.isPreviewReady){
                previewImageView.imageBlurred = blurredImage;
                [previewImageView setPreviewImage:imageEffected];
                [previewImageView toggleBlurredImage:NO WithDuration:0.10f];
            }else{
                
                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                dispatch_async(q_global, ^{
                    
                    [NSThread sleepForTimeInterval:0.50f];

                    dispatch_async(q_main, ^{
                        previewImageView.imageOriginal = imageResized;
                        previewImageView.imageBlurred = blurredImage;
                        previewImageView.isPreviewReady = YES;
                        [previewImageView setPreviewImage:imageEffected WithDuration:0.50f];
                        [previewImageView removeLoadingIndicator];
                        [_self slideUpAdjustment:adjustment Completion:nil];
                    });
                });
            }
            LOG(@"did apply effect");
            _isApplying = NO;
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

- (void)slideDownAdjustment:(UIView *)adjustment Completion:(void (^)(BOOL))completion
{
    if (_isSliding) {
        LOG(@"sliding.");
        return;
    }
    _isSliding = YES;
    __block UIView* _adjustment = adjustment;
    [UIView animateWithDuration:0.10f animations:^{
        _adjustment.frame = CGRectMake(adjustment.frame.origin.x, [UIScreen screenSize].height - 44.0f, _adjustment.frame.size.width, _adjustment.frame.size.height);
    } completion:^(BOOL finished){
        _adjustment.hidden = YES;
        _isSliding = NO;
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)slideUpAdjustment:(UIView *)adjustment Completion:(void (^)(BOOL))completion
{
    if (_isSliding) {
        LOG(@"sliding.");
        return;
    }
    _isSliding = YES;
    [adjustment setY:[UIScreen screenSize].height - 44.0f];
    adjustment.hidden = NO;
    __block UIView* _adjustment = adjustment;
    _adjustmentCurrent = adjustment;
    [UIView animateWithDuration:0.10f animations:^{
        _adjustment.frame = CGRectMake(_adjustment.frame.origin.x, [UIScreen screenSize].height - _adjustment.bounds.size.height - 44.0f, _adjustment.frame.size.width, _adjustment.frame.size.height);
    } completion:^(BOOL finished){
        _isSliding = NO;
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)slideDownCurrentAdjustmentAndSlideUpAdjustment:(UIView *)adjustment
{
    if (_adjustmentCurrent) {
        __block UIView* _adjustment = adjustment;
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
    _buttonBrightness.selected = NO;
    _buttonColor.selected = NO;
    _buttonContrast.selected = NO;
    _buttonOpacity.selected = NO;
    button.selected = YES;
    UIView* adjustment;
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
    if (_isSaving) {
        LOG(@"sorry now saving.");
        return;
    }
    if (_isApplying) {
        return;
    }
    if (!_previewImageView.isPreviewReady) {
        return;
    }
    _isSaving = YES;
    LOG(@"saving...");
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    
    __block UIImage* imageOriginal = _imageOriginal;
    __block EditorViewController* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        
        UIImage* resultImage = [_self processImage:imageOriginal];
        UIImageWriteToSavedPhotosAlbum(resultImage, nil, nil, nil);
        
        dispatch_async(q_main, ^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Saved successfully", nil)];
            _isSaving = NO;
        });
        
    });

}

#pragma mark delegate

- (void)slider:(UIEditorSliderView*)slider DidValueChange:(CGFloat)value
{
    switch (slider.tag) {
        case EditorSliderIconTypeBrightness:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Brightness", nil), (int)roundf((value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeClarity:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Clarity", nil), (int)roundf(value * 100.0f)];
            break;
        case EditorSliderIconTypeContrast:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Contrast", nil), (int)roundf((value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeKelvin:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Temperature", nil), (int)roundf((value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeLevels:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Levels", nil), (int)roundf((value - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeOpacity:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Opacity", nil), (int)roundf(value * 100.0f)];
            break;
        case EditorSliderIconTypeVignette:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Vignette", nil), (int)roundf(value * 100.0f)];
            break;
    }
}

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBeganWithSlider:(UIEditorSliderView *)slider
{
    LOG(@"touchstart");
    [_previewImageView toggleBlurredImage:YES WithDuration:0.10f];
    
    _percentageLabel.hidden = NO;
    switch (slider.tag) {
        case EditorSliderIconTypeBrightness:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Brightness", nil), (int)roundf((_valueBrightness - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeClarity:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Clarity", nil), (int)roundf(_valueClarity * 100.0f)];
            break;
        case EditorSliderIconTypeContrast:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Contrast", nil), (int)roundf((_valueContrast - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeKelvin:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Temperature", nil), (int)roundf((_valueKelvin - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeLevels:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Levels", nil), (int)roundf((_valueLevels - 0.50f) * 200.0f)];
            break;
        case EditorSliderIconTypeOpacity:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Opacity", nil), (int)roundf(_valueOpacity * 100.0f)];
            break;
        case EditorSliderIconTypeVignette:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Vignette", nil), (int)roundf(_valueVignette * 100.0f)];
            break;
    }
    
}

- (void)touchesEndedWithSlider:(UIEditorSliderView *)slider
{
    LOG(@"touchesend");
    _percentageLabel.hidden = YES;
    if (!_previewImageView.isPreviewReady) {
        LOG(@"preview not ready.");
        switch (slider.tag) {
            case EditorSliderIconTypeBrightness:
                _sliderBrightness.value = 0.5f;
                break;
            case EditorSliderIconTypeClarity:
                _sliderClarity.value = 0.0f;
                break;
            case EditorSliderIconTypeContrast:
                _sliderContrast.value = 0.5f;
                break;
            case EditorSliderIconTypeKelvin:
                _sliderKelvin.value = 0.5f;
                break;
            case EditorSliderIconTypeLevels:
                _sliderLevels.value = 0.5f;
                break;
            case EditorSliderIconTypeOpacity:
                _sliderOpacity.value = 1.0f;
                break;
            case EditorSliderIconTypeVignette:
                _sliderVignette.value = 0.0f;
                break;
        }
        return;
    }
    
    switch (slider.tag) {
        case EditorSliderIconTypeBrightness:
            _valueBrightness = (slider.value - 0.5f) * 1.0f;
            break;
        case EditorSliderIconTypeClarity:
            _valueClarity = slider.value;
            break;
        case EditorSliderIconTypeContrast:
            _valueContrast = MAX((slider.value - 0.5) * 2.0 + 1.1f, 0.1f);
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
    }
    [self applyEffect];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
