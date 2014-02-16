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
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];
    //////// Bottom Bar
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionBottom];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:buttonClose];
    UISaveButton* buttonSave = [[UISaveButton alloc] init];
    [buttonSave addTarget:self action:@selector(didPressSaveButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToRight:buttonSave];
    [self.view addSubview:bar];
    //////// Top Bar
    bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    [bar setTitle:NSLocalizedString(@"Edit", nil)];
    [self.view addSubview:bar];
    
    //// Preview
    CGFloat width = [UIScreen screenSize].width;
    CGFloat height = _imageOriginal.size.height * width / _imageOriginal.size.width;
    _imageViewPreview = [[UIEditorPreviewImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    _imageViewPreview.center = self.view.center;
    [self.view addSubview:_imageViewPreview];
    
    //// Sliders
    _sliderStrength = [[UIEditorSliderView alloc] initWithFrame:CGRectMake(0.0f, 420.0f, [UIScreen screenSize].width, 48.0f)];
    [self.view addSubview:_sliderStrength];
    
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
    GPUImageEffects* effect = [self effect:_effectId];
    effect.imageToProcess = _imageResized;
    GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:_imageResized];
    _imageEffected = [effect process];
    GPUImagePicture* overlay = [[GPUImagePicture alloc] initWithImage:_imageEffected];
    _imageEffected = [self merge2pictureBase:base overlay:overlay opacity:_strength];
    [_imageViewPreview removeLoadingIndicator];
    [_imageViewPreview.imageViewPreview setImage:_imageEffected];
    _imageViewPreview.imageOriginal = _imageResized;
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

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
