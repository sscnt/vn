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
        _maxImageLength = 2400.0f;
        _currentSelectedFocusType = FocusTypeTopAndBottom;
        _valueOpacity = 1.0;
        _valueFocusDistance = 0.5f;
        _valueFocusAngle = 0.0f;
        _valueFocusPosition = CGPointMake(0.50f, 0.50f);
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
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];

    
    //// Preview
    CGFloat width = [UIScreen screenSize].width;
    CGFloat height = _imageOriginal.size.height * width / _imageOriginal.size.width;
    CGFloat max_height = [UIScreen screenSize].height - 254.0f;
    if (height > max_height) {
        width *= max_height / height;
        height = max_height;
    }
    _previewImageView = [[UIEditorPreviewImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    _previewImageView.delegate = self;
    if([UIDevice resolution] == UIDeviceResolution_iPhoneRetina4){
        _previewImageView.center = CGPointMake([UIScreen screenSize].width / 2.0f, [UIScreen screenSize].height / 2.0f - MAX(([UIScreen screenSize].height - 128.0f - height) / 2.0f, 0.0f));
    }else{
        _previewImageView.center = CGPointMake([UIScreen screenSize].width / 2.0f, [UIScreen screenSize].height / 2.0f - MIN(MAX(([UIScreen screenSize].height - height - 118.0f) / 2.0f, 0.0f), 83.0f));
    }
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
    
    //////// Focus
    //////////// Buttons
    CGFloat focusTypeButtonBetween = 50.0f;
    CGFloat viewCenter = [UIScreen screenSize].width / 2.0f;
    CGFloat focusTypeButtonsAreaHeight = 30.0f;
    _focusTypeButtonTopAndBottom = [[UIFocusTypeSelectButton alloc] initWithType:FocusTypeTopAndBottom];
    [_focusTypeButtonTopAndBottom addTarget:self action:@selector(didPressFocusTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    _focusTypeButtonTopAndBottom.center = CGPointMake(viewCenter - focusTypeButtonBetween, focusTypeButtonsAreaHeight / 2.0f);
    _focusTypeButtonTopAndBottom.selected = YES;
    _focusTypeButtonTopOnly = [[UIFocusTypeSelectButton alloc] initWithType:FocusTypeTopOnly];
    [_focusTypeButtonTopOnly addTarget:self action:@selector(didPressFocusTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    _focusTypeButtonTopOnly.center = CGPointMake(viewCenter, focusTypeButtonsAreaHeight / 2.0f);
    _focusTypeButtonCircle = [[UIFocusTypeSelectButton alloc] initWithType:FocusTypeCircle];
    [_focusTypeButtonCircle addTarget:self action:@selector(didPressFocusTypeButton:) forControlEvents:UIControlEventTouchUpInside];
    _focusTypeButtonCircle.center = CGPointMake(viewCenter + focusTypeButtonBetween, focusTypeButtonsAreaHeight / 2.0f);
    //////////// Distance
    _sliderFocusDistance = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + focusTypeButtonsAreaHeight, [UIScreen screenSize].width, 42.0f)];
    _sliderFocusDistance.tag = EditorSliderIconTypeFocusDistance;
    _sliderFocusDistance.delegate = self;
    _sliderFocusDistance.title = NSLocalizedString(@"Distance", nil);
    _sliderFocusDistance.iconType = EditorSliderIconTypeFocusDistance;
    _sliderFocusDistance.titlePosition = SliderViewTitlePositionLeft;
    _sliderFocusDistance.defaultValue = 0.5f;
    //////////// Strength
    _sliderFocusStrength = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 10.0f + focusTypeButtonsAreaHeight + _sliderFocusDistance.frame.size.height, [UIScreen screenSize].width, 42.0f)];
    _sliderFocusStrength.tag = EditorSliderIconTypeFocusStrength;
    _sliderFocusStrength.delegate = self;
    _sliderFocusStrength.title = NSLocalizedString(@"Strength", nil);
    _sliderFocusStrength.iconType = EditorSliderIconTypeFocusStrength;
    _sliderFocusStrength.titlePosition = SliderViewTitlePositionCenter;
    _sliderFocusStrength.defaultValue = 0.0f;
    //////// Adjustment
    _adjustmentFocus = [[UISliderContainer alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen screenSize].width, _sliderFocusDistance.bounds.size.height * 2.0f + 20.0f + focusTypeButtonsAreaHeight)];
    _adjustmentFocus.tag = AdjustmentViewIdFocus;
    [_adjustmentFocus addSubview:_focusTypeButtonTopAndBottom];
    [_adjustmentFocus addSubview:_focusTypeButtonTopOnly];
    [_adjustmentFocus addSubview:_focusTypeButtonCircle];
    [_adjustmentFocus addSubview:_sliderFocusDistance];
    [_adjustmentFocus addSubview:_sliderFocusStrength];
    _adjustmentFocus.hidden = YES;
    [self.view addSubview:_adjustmentFocus];
    
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
    
    //////// Focus
    _buttonFocus = [[UINavigationBarButton alloc] initWithType:NavigationBarButtonTypeFocus];
    _buttonFocus.tag = AdjustmentViewIdFocus;
    [_buttonFocus addTarget:self action:@selector(didPressAdjustmentButton:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomNavigationBar appendButtonToLeft:_buttonFocus];
    
    //// Top Bar
    _topNavigationBar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    [_topNavigationBar setTitle:NSLocalizedString(@"EDIT", nil)];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [_topNavigationBar appendButtonToLeft:buttonClose];
    [self.view addSubview:_topNavigationBar];
    
    //// Focus Control
    _focusControlView = [[UIFocusControlView alloc] initWithFrame:_previewImageView.frame];
    _focusControlView.type = _currentSelectedFocusType;
    _focusControlView.hidden = YES;
    _focusControlView.delegate = self;
    [self.view addSubview:_focusControlView];
    
    
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
        case EffectIdVampire:
            return [[GPUEffectVampire alloc] init];
            break;
    }
}

- (UIImage*)resizeImage:(UIImage *)image WithResolution:(ImageResolution)resolution
{
    if(resolution == ImageResolutionMax){
        if([UIDevice underIPhone5s]){
            CGFloat width, height;
            if(image.size.width > image.size.height){
                height = image.size.height * _maxImageLength / image.size.width;
                width = _maxImageLength;
            }else{
                width = image.size.width * _maxImageLength / image.size.height;
                height = _maxImageLength;
            }
            return [image resizedImage:CGSizeMake(width, height) interpolationQuality:kCGInterpolationHigh];
        }else{
            return image;
        }
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
    @autoreleasepool {
        inputImage = [self processImageClarity:inputImage];
    }
    @autoreleasepool {
        inputImage = [self processImageAdjustments:inputImage];
    }
    @autoreleasepool {
        inputImage = [self processImageEffect:inputImage];        
    }
    @autoreleasepool {
        inputImage = [self processImageFinal:inputImage];
    }
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
        [filter forceProcessingAtSize:inputImage.size];
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
    
    [adjustmentFilter forceProcessingAtSize:inputImage.size];
    
    GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
    [base addTarget:adjustmentFilter atTextureLocation:0];
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
    
    //// Focus
    if (_sliderFocusStrength.value != _sliderFocusStrength.defaultValue) {
        LOG(@"focus enabled. %f", _sliderFocusStrength.value);
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
        GPUImageLensBlurFilter* filter = [[GPUImageLensBlurFilter alloc] init];
        filter.distance = _valueFocusDistance * 0.40f;
        filter.type = _currentSelectedFocusType;
        filter.position = _valueFocusPosition;
        filter.angle = _valueFocusAngle;
        CGFloat strength = 16.0f * _valueFocusStrength * inputImage.size.width / _imageResized.size.width;
        if(strength > 20.0f){
            CGFloat times = ceil(strength / 20.0f);
            filter.blurPasses = (NSInteger)times * 2;
            filter.strength = strength / times;
        }else{
            filter.strength = strength;
        }
        [base addTarget:filter];
        [base processImage];
        inputImage = [filter imageFromCurrentlyProcessedOutput];
    }
    
    //// Vignette
    if (_sliderVignette.value != 0.0f) {
        LOG(@"vignette enabled. %f", _sliderVignette.value);
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:inputImage];
        GPUImageVignette2Filter* filter = [[GPUImageVignette2Filter alloc] init];
        filter.scale = _valueVignette;
        [filter forceProcessingAtSize:inputImage.size];
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
            
            _self.imageEffected = [_self processImage:_imageResized];
            
            GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
            filter.blurRadiusInPixels = 8.0f;
            GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:_imageEffected];
            [base addTarget:filter];
            [base processImage];
            _self.blurredImage = [filter imageFromCurrentlyProcessedOutput];
            
            filter.blurRadiusInPixels = 16.0f;
            [base processImage];
            _self.dialogBgImage = [filter imageFromCurrentlyProcessedOutput];
        }
        dispatch_async(q_main, ^{
            if(_self.previewImageView.isPreviewReady){
                _self.previewImageView.imageBlurred = _self.blurredImage;
                [_self.previewImageView setPreviewImage:_self.imageEffected];
                [_self.previewImageView toggleBlurredImage:NO WithDuration:0.20f];
                [_self unlockAllSliders];
            }else{
                
                dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_queue_t q_main = dispatch_get_main_queue();
                dispatch_async(q_global, ^{
                    
                    dispatch_async(q_main, ^{
                        _self.previewImageView.imageOriginal = _self.imageResized;
                        _self.previewImageView.imageBlurred = _self.blurredImage;
                        _self.previewImageView.isPreviewReady = YES;
                        [_self.previewImageView setPreviewImage:_self.imageEffected];
                        [_self.previewImageView removeLoadingIndicator];
                        [_self slideUpAdjustment:_self.adjustmentOpacity Completion:nil];
                        _self.isApplying = NO;
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
    __block EditorViewController* _self = self;
    __block UISliderContainer* _adjustment = adjustment;
    [UIView animateWithDuration:0.10f animations:^{
        _adjustment.frame = CGRectMake(_adjustment.frame.origin.x, [UIScreen screenSize].height - 44.0f, _adjustment.frame.size.width, _adjustment.frame.size.height);
    } completion:^(BOOL finished){
        _adjustment.hidden = YES;
        _self.isSliding = NO;
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
    __block EditorViewController* _self = self;
    [UIView animateWithDuration:0.10f animations:^{
        _self.adjustmentCurrent.frame = CGRectMake(_self.adjustmentCurrent.frame.origin.x, [UIScreen screenSize].height - _self.adjustmentCurrent.bounds.size.height - 44.0f, _self.adjustmentCurrent.frame.size.width, _self.adjustmentCurrent.frame.size.height);
    } completion:^(BOOL finished){
        _self.isSliding = NO;
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

- (void)didPressFocusTypeButton:(UIFocusTypeSelectButton*)button
{
    if (_isApplying) {
        return;
    }
    _focusTypeButtonCircle.selected = NO;
    _focusTypeButtonTopAndBottom.selected = NO;
    _focusTypeButtonTopOnly.selected = NO;
    button.selected = YES;
    _currentSelectedFocusType = button.type;
    _focusControlView.type = button.type;
    [self lockAllSliders];
    [self applyEffect];
}

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
    _buttonFocus.selected = NO;
    _buttonOpacity.selected = NO;
    button.selected = YES;
    _focusControlView.hidden = YES;
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
            break;
        case AdjustmentViewIdFocus:
            _focusControlView.hidden = NO;
            adjustment = _adjustmentFocus;
            break;
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
        
        if([UIDevice underIPhone5s]){
            if(_imageOriginal.size.width > _imageOriginal.size.height){
                _resolutionSelector.maxImageHeight = _imageOriginal.size.height * _maxImageLength / _imageOriginal.size.width;
                _resolutionSelector.maxImageWidth = _maxImageLength;
            }else{
                _resolutionSelector.maxImageWidth = _imageOriginal.size.width * _maxImageLength / _imageOriginal.size.height;
                _resolutionSelector.maxImageHeight = _maxImageLength;
            }
        }else{
            _resolutionSelector.maxImageHeight = _imageOriginal.size.height;
            _resolutionSelector.maxImageWidth = _imageOriginal.size.width;
        }
        if(_imageOriginal.size.width > 3000.0f || _imageOriginal.size.height > 3000.0f){
            _currentResolution = ImageResolutionMidium;
            [_resolutionSelector setResolution:ImageResolutionMidium];
        }else{
            _currentResolution = ImageResolutionMax;
            [_resolutionSelector setResolution:ImageResolutionMax];
        }
    }
    _resolutionSelector.alpha = 0.0f;
    [_resolutionSelector setY:-_resolutionSelector.frame.size.height];
    [self.view addSubview:_resolutionSelector];
    
    if(!_saveDialogView){
        _saveDialogView = [[UISaveDialogView alloc] init];
        _saveDialogView.delegate = self;
    }
    _saveDialogView.alpha = 0.0f;
    [_saveDialogView setY:[UIScreen screenSize].height];
    [self.view addSubview:_saveDialogView];
    
    CGFloat width = _dialogBgImage.size.width * [UIScreen screenSize].height / _dialogBgImage.size.height;
    CGFloat height = [UIScreen screenSize].height;
    if (width < [UIScreen screenSize].width) {
        height *= [UIScreen screenSize].width / width;
        width = [UIScreen screenSize].width;
    }
    CGRect frame = CGRectMake(0.0f, 0.0f, width, height);
    _dialogBgImageView.frame = frame;
    _dialogBgImageView.center = _previewImageView.center;
    frame = _dialogBgImageView.frame;
    _dialogBgImageView.frame = _previewImageView.frame;
    _dialogBgImageView.hidden = NO;
    
    CGPoint center = self.view.center;
    CGFloat saveToViewTop = 40.0f + _resolutionSelector.frame.size.height + 40.0f;
    
    [self slideDownAdjustment:_adjustmentCurrent Completion:nil];
    
    if(_adjustmentCurrent == _adjustmentFocus){
        _focusControlView.hidden = YES;
    }

    __block EditorViewController* _self = self;
    [UIView animateWithDuration:0.20f animations:^{
        _self.resolutionSelector.alpha = 1.0f;
        [_self.resolutionSelector setY:40.0f];
        _self.saveDialogView.alpha = 1.0f;
        [_self.saveDialogView setY:saveToViewTop];
        [_self.topNavigationBar setY:-44.0f];
        [_self.bottomNavigationBar setY:[UIScreen screenSize].height];
        _self.dialogBgImageView.frame = frame;
        _self.dialogBgImageView.center = center;
        _self.dialogBgImageView.alpha = 1.0f;
    } completion:^(BOOL finished){
        _self.dialogState = DialogStateDidShow;
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
        [_self.resolutionSelector setY:-_self.resolutionSelector.frame.size.height];
        _self.resolutionSelector.alpha = 0.0f;
        [_self.saveDialogView setY:[UIScreen screenSize].height];
        _self.saveDialogView.alpha = 0.0f;
        _self.dialogBgImageView.frame = frame;
        [_self.topNavigationBar setY:0.0f];
        [_self.bottomNavigationBar setY:[UIScreen screenSize].height - 44.0f];
    } completion:^(BOOL finished){
        [_self.resolutionSelector removeFromSuperview];
        [_self slideUpAdjustment:_adjustmentCurrent Completion:nil];
        [UIView animateWithDuration:0.10f animations:^{
            _self.dialogBgImageView.alpha = 0.0f;
        } completion:^(BOOL finished){
            _self.dialogState = DialogStateDidHide;
            [_self.dialogBgImageView removeFromSuperview];
            if(_self.adjustmentCurrent == _self.adjustmentFocus){
                _self.focusControlView.hidden = NO;
            }
        }];
    }];
}

- (void)saveImage:(SaveTo)saveTo
{
    __block EditorViewController* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        @autoreleasepool {
            UIImage* resultImage = [_self resizeImage:_imageOriginal WithResolution:_currentResolution];
            resultImage = [_self processImage:resultImage];
            UIImageWriteToSavedPhotosAlbum(resultImage, nil, nil, nil);
        }
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
    double delayInSeconds = 1.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [UIView animateWithDuration:0.20f animations:^{
            _self.resolutionSelector.alpha = 1.0f;
            _self.saveDialogView.alpha = 1.0f;
        } completion:^(BOOL finished){
            _self.isSaving = NO;
        }];
    });

}

- (void)lockAllSliders
{
    if(_adjustmentCurrent.locked){
        return;
    }
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

- (void)focus:(UIFocusControlView *)view didAngleChange:(CGFloat)angle
{
    LOG(@"focusAngleDidChange");
    _valueFocusAngle = angle;
    if (_isApplying) {
        return;
    }
    [self lockAllSliders];
    [self applyEffect];
}

- (void)focus:(UIFocusControlView *)view didPositionChange:(CGPoint)position
{
    LOG(@"focusRotationDidChange");
    _valueFocusPosition = position;
    if (_isApplying) {
        return;
    }
    [self lockAllSliders];
    [self applyEffect];
}

- (BOOL)focusShouldChange
{
    if(_previewImageView.isPreviewReady == NO){
        return NO;
    }
    if(_isApplying){
        return NO;
    }
    return YES;
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
    if(slider.tag == EditorSliderIconTypeFocusDistance){
        _focusControlView.distance = slider.value;
    }else{
        [self showCurrentValueWithSlider:slider];
    }
}

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)selector:(UIResolutionSelectorView *)selector DidSelectResolution:(ImageResolution)resolution
{
    _currentResolution = resolution;
}

- (void)saveToView:(UISaveDialogView *)view DidSelectSaveTo:(SaveTo)saveTo
{
    
    if (_isSaving) {
        LOG(@"sorry now saving.");
        return;
    }
    _isSaving = YES;
    LOG(@"saving...");

    __block EditorViewController* _self = self;
    [UIView animateWithDuration:0.20f animations:^{
        _self.resolutionSelector.alpha = 0.30f;
        _self.saveDialogView.alpha = 0.30f;
    } completion:^(BOOL finished){
        [_self.saveDialogView clearSelected];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [_self saveImage:saveTo];
    }];
}

- (void)focusTouchesBegan:(UIFocusControlView *)view
{
    if (_isApplying) {
        return;
    }
    LOG(@"touchstart");
    [_previewImageView toggleBlurredImage:YES WithDuration:0.10f];
    [self lockAllSliders];
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
        case EditorSliderIconTypeFocusDistance:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Distance", nil), (int)roundf(slider.value * 100.0f)];
            break;
        case EditorSliderIconTypeFocusStrength:
            _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Strength", nil), (int)roundf(slider.value * 100.0f)];
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
        case EditorSliderIconTypeFocusDistance:
            _valueFocusDistance = slider.value;
            _focusControlView.distance = slider.value;
            break;
        case EditorSliderIconTypeFocusStrength:
            _valueFocusStrength = slider.value ;
            break;
    }

}

- (BOOL)shouldAutorotate
{
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
