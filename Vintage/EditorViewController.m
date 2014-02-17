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
        _strength = 1.0;
        _isSaving = NO;
        _blurredImage = nil;
        _isApplying = NO;
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
    
    //// Bottom Bar
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionBottom];
    UISaveButton* buttonSave = [[UISaveButton alloc] init];
    [buttonSave addTarget:self action:@selector(didPressSaveButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToRight:buttonSave];
    [self.view addSubview:bar];
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

    
    //// Sliders
    _sliderOpacity = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, [UIScreen screenSize].height - 44.0f - 48.0f - 10.0f, [UIScreen screenSize].width, 48.0f)];
    _sliderOpacity.tag = EditorSliderIconTypeOpacity;
    _sliderOpacity.delegate = self;
    _sliderOpacity.title = NSLocalizedString(@"Opacity", nil);
    _sliderOpacity.iconType = EditorSliderIconTypeOpacity;
    [self.view addSubview:_sliderOpacity];
    
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
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        
        GPUImageEffects* effect = [self effect:_effectId];
        effect.imageToProcess = imageResized;
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:imageResized];
        imageEffected = [effect process];
        GPUImagePicture* overlay = [[GPUImagePicture alloc] initWithImage:imageEffected];
        imageEffected = [self merge2pictureBase:base overlay:overlay opacity:_strength];
        
        if (blurredImage == nil) {
            GPUImageGaussianBlurFilter* filter = [[GPUImageGaussianBlurFilter alloc] init];
            filter.blurRadiusInPixels = 8.0f;
            base = [[GPUImagePicture alloc] initWithImage:imageResized];
            [base addTarget:filter];
            [base processImage];
            blurredImage = [filter imageFromCurrentlyProcessedOutput];
        }
        
        dispatch_async(q_main, ^{
            if(previewImageView.isPreviewReady){
                [previewImageView setPreviewImage:imageEffected];
                [previewImageView toggleBlurredImage:NO WithDuration:0.10f];
            }else{
                [NSThread sleepForTimeInterval:1.0f];
                previewImageView.imageOriginal = imageResized;
                previewImageView.imageBlurred = blurredImage;
                previewImageView.isPreviewReady = YES;
                [previewImageView setPreviewImage:imageEffected WithDuration:0.50f];
                [previewImageView removeLoadingIndicator];
            }
            LOG(@"did apply effect");
            _isApplying = NO;
        });
        
    });
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
        UIImage* resultImage;
        GPUImageEffects* effect = [self effect:_effectId];
        effect.imageToProcess = imageOriginal;
        
        GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:_imageOriginal];
        UIImage* imageEffected = [effect process];
        GPUImagePicture* overlay = [[GPUImagePicture alloc] initWithImage:imageEffected];
        resultImage = [_self merge2pictureBase:base overlay:overlay opacity:_strength];

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
    if (slider.tag == EditorSliderIconTypeOpacity) {
        _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Opacity", nil), (int)roundf(value * 100.0f)];
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
    if (slider.tag == EditorSliderIconTypeOpacity) {
        _percentageLabel.hidden = NO;
        _percentageLabel.text = [NSString stringWithFormat:@"%@: %d", NSLocalizedString(@"Opacity", nil), (int)roundf(_strength * 100.0f)];
    }
}

- (void)touchesEndedWithSlider:(UIEditorSliderView *)slider
{
    LOG(@"touchesend");
    _percentageLabel.hidden = YES;
    if (slider.tag == EditorSliderIconTypeOpacity) {
        if (!_previewImageView.isPreviewReady) {
            LOG(@"preview not ready.");
            _sliderOpacity.value = 1.0;
            return;
        }
        _strength = slider.value;
        [self applyEffect];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
