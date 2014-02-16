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
    [self.view addSubview:bar];
    //////// Top Bar
    bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    [self.view addSubview:bar];
    
    //// Preview
    CGFloat width = [UIScreen screenSize].width;
    CGFloat height = _imageOriginal.size.height * width / _imageOriginal.size.width;
    _imageViewPreview = [[UISelectionPreviewImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    _imageViewPreview.center = self.view.center;
    [self.view addSubview:_imageViewPreview];
    
    if (!self.waitingForOtherConversion) {
        [self applyEffect];        
    }
}

- (void)applyEffect
{
    GPUImageEffects* effect;
    switch (_effectId) {
        case EffectIdBeachVintage:
            effect = [[GPUEffectBeachVintage alloc] init];
            break;
        case EffectIdCreamyNoon:
            effect = [[GPUEffectCreamyNoon alloc] init];
            break;
        case EffectIdCavalleriaRusticana:
            effect = [[GPUEffectCavalleriaRusticana alloc] init];
            break;
        case EffectIdDreamyVintage:
            effect = [[GPUEffectDreamyVintage alloc] init];
            break;
        case EffectIdFaerieVintage:
            effect = [[GPUEffectFaerieVintage alloc] init];
            break;
        case EffectIdGentleMemories:
            effect = [[GPUEffectGentleMemories alloc] init];
            break;
        case EffectIdGirder:
            effect = [[GPUEffectGirder alloc] init];
            break;
        case EffectIdHaze3:
            effect = [[GPUEffectHaze3 alloc] init];
            break;
        case EffectIdHazelnut:
            effect = [[GPUEffectHazelnut alloc] init];
            break;
        case EffectIdJoyful:
            effect = [[GPUEffectJoyful alloc] init];
            break;
        case EffectIdMiami:
            effect = [[GPUEffectMiami alloc] init];
            break;
        case EffectIdOldTone:
            effect = [[GPUEffectOldTone alloc] init];
            break;
        case EffectIdPinkBubbleTea:
            effect = [[GPUEffectPinkBubbleTea alloc] init];
            break;
        case EffectIdSummers:
            effect = [[GPUEffectSummers alloc] init];
            break;
        case EffectIdSunsetCarnevale:
            effect = [[GPUEffectSunsetCarnevale alloc] init];
            break;
        case EffectIdVintage1:
            effect = [[GPUEffectVintage1 alloc] init];
            break;
        case EffectIdVintage2:
            effect = [[GPUEffectVintage2 alloc] init];
            break;
        case EffectIdVintageFilm:
            effect = [[GPUEffectVintageFilm alloc] init];
            break;
        case EffectIdVividVintage:
            effect = [[GPUEffectVividVintage alloc] init];
            break;
        case EffectIdWarmAutumn:
            effect = [[GPUEffectWarmAutumn alloc] init];
            break;
        case EffectIdWarmSpringLight:
            effect = [[GPUEffectWarmSpringLight alloc] init];
            break;
        case EffectIdWeekend:
            effect = [[GPUEffectWeekend alloc] init];
            break;
    }
    effect.imageToProcess = _imageResized;
    GPUImagePicture* base = [[GPUImagePicture alloc] initWithImage:_imageResized];
    _imageEffected = [effect process];
    LOG(@"%@", _imageEffected);
    GPUImagePicture* overlay = [[GPUImagePicture alloc] initWithImage:_imageEffected];
    _imageEffected = [self merge2pictureBase:base overlay:overlay opacity:_strength];
    [_imageViewPreview removeLoadingIndicator];
    [_imageViewPreview.imageViewPreview setImage:_imageEffected];
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
