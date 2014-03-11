//
//  EffectsViewController.m
//  Vintage
//
//  Created by SSC on 2014/02/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        _currentProcessingIndex = 0;
        _imageOriginal = image;
        _isProcessing = NO;
        _paused = NO;
        _viewDidOnceAppear = NO;
        _editorViewController = nil;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    _paused = NO;
    if (_currentProcessingIndex > 0 && _viewDidOnceAppear) {
        LOG(@"resumed.");
        [self applyEffectAtIndex:_currentProcessingIndex + 1];
    }
    _viewDidOnceAppear = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    _paused = YES;
    LOG(@"paused because view did disappear");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //// Init
    _numberOfEffects = 22;
    _arrayPreviews = [NSMutableArray array];
    CGFloat width = ([UIScreen screenSize].width - 3.0f) / 2.0f;
    CGFloat height = roundf(self.imageOriginal.size.height * width / self.imageOriginal.size.width);
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height)];
    [_scrollView setContentSize:CGSizeMake([UIScreen screenSize].width, ceilf((CGFloat)_numberOfEffects / 2.0f) * height + ceilf((CGFloat)_numberOfEffects / 2.0f) + 44.0f)];
    
    //// Effects
    _arrayEffects = [NSMutableArray array];
    [_arrayEffects addObject:[[GPUEffectVintageFilm alloc] init]];
    [_arrayEffects addObject:[[GPUEffectVintage1 alloc] init]];
    [_arrayEffects addObject:[[GPUEffectVintage2 alloc] init]];
    [_arrayEffects addObject:[[GPUEffectWeekend alloc] init]];
    [_arrayEffects addObject:[[GPUEffectVividVintage alloc] init]];
    [_arrayEffects addObject:[[GPUEffectOldTone alloc] init]];
    [_arrayEffects addObject:[[GPUEffectMiami alloc] init]];
    [_arrayEffects addObject:[[GPUEffectGirder alloc] init]];
    [_arrayEffects addObject:[[GPUEffectCavalleriaRusticana alloc] init]];
    [_arrayEffects addObject:[[GPUEffectFaerieVintage alloc] init]];
    [_arrayEffects addObject:[[GPUEffectHazelnut alloc] init]];    
    [_arrayEffects addObject:[[GPUEffectGentleMemories alloc] init]];
    [_arrayEffects addObject:[[GPUEffectHaze3 alloc] init]];
    [_arrayEffects addObject:[[GPUEffectBeachVintage alloc] init]];
    [_arrayEffects addObject:[[GPUEffectDreamyVintage alloc] init]];
    [_arrayEffects addObject:[[GPUEffectCreamyNoon alloc] init]];
    [_arrayEffects addObject:[[GPUEffectJoyful alloc] init]];
    [_arrayEffects addObject:[[GPUEffectPinkBubbleTea alloc] init]];
    [_arrayEffects addObject:[[GPUEffectSummers alloc] init]];
    [_arrayEffects addObject:[[GPUEffectWarmAutumn alloc] init]];
    [_arrayEffects addObject:[[GPUEffectSunsetCarnevale alloc] init]];
    [_arrayEffects addObject:[[GPUEffectWarmSpringLight alloc] init]];
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];
    [self.view addSubview:_scrollView];
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:buttonClose];
    [bar setTitle:NSLocalizedString(@"EFFECTS", nil)];
    [self.view addSubview:bar];
    
    //// Preview
    CGFloat left = 1.0;
    CGFloat top = 44.0f;
    CGRect rect;
    for (int i = 0; i < _numberOfEffects; i++) {
        left = (i % 2 == 0) ? 1.0 : left * 2.0 + width;
        rect = CGRectMake(left, top, width, height);
        UISelectionPreviewImageView* preview = [[UISelectionPreviewImageView alloc] initWithFrame:rect];
        [preview addTarget:self action:@selector(didSelectPreview:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:preview];
        [_arrayPreviews addObject:preview];
        top += (i % 2 == 0) ? 0.0 : 1.0 + height;
    }
    
    //// Resize
    __block SelectionViewController* _self = self;
    dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t q_main = dispatch_get_main_queue();
    dispatch_async(q_global, ^{
        [_self setValue:[_self.imageOriginal resizedImage:CGSizeMake(width, height) interpolationQuality:kCGInterpolationHigh] forKey:@"_imageResized"];
        [_self setValue:[_self.imageOriginal resizedImage:CGSizeMake([UIScreen screenSize].width, height * [UIScreen screenSize].width / width) interpolationQuality:kCGInterpolationHigh] forKey:@"_imageResizedForEditor"];
        dispatch_async(q_main, ^{
            //// Effect
            [_self applyEffectAtIndex:0];
        });
    });
}

- (void)applyEffectAtIndex:(int)index
{
    if (_paused) {
        LOG(@"canceled.");
        if (_editorViewController) {
            LOG(@"waiting finished.");
            _editorViewController.waitingForOtherConversion = NO;
            [_editorViewController applyEffect];
        }
        return;
    }
    if (index < _numberOfEffects) {
        LOG(@"applying %d", index);
        _isProcessing = YES;
        _currentProcessingIndex = index;
        __block SelectionViewController* _self = self;
        __block GPUImageEffects* effect = [_arrayEffects objectAtIndex:index];
        __block UIImage* imageToProcess = _imageResized;
        __block UISelectionPreviewImageView* preview = [_arrayPreviews objectAtIndex:index];
        __block UIImage* imageApplied;
        if ([effect respondsToSelector:@selector(imageToProcess)]) {
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{
                effect.imageToProcess = imageToProcess;
                imageApplied = [effect process];
                preview.effectId = effect.effectId;
                dispatch_async(q_main, ^{
                    [preview removeLoadingIndicator];
                    [preview setPreviewImage:imageApplied WithDuration:0.20f];
                    [preview setIsPreviewReady:YES];
                    _isProcessing = NO;
                    [_self applyEffectAtIndex:index + 1];
                });
                
            });
        }
    }
}


#pragma mark events

- (void)didSelectPreview:(UISelectionPreviewImageView *)preview
{
    if (preview.isPreviewReady == NO) {
        LOG(@"not ready.");
        return;
    }
    LOG(@"Effect selected.");
    _paused = YES;
    EditorViewController* controller = [[EditorViewController alloc] init];
    controller.effectId = preview.effectId;
    controller.imageResized = _imageResizedForEditor;
    controller.imageEffected = preview.previewImageView.image;
    controller.imageOriginal = _imageOriginal;
    if (_isProcessing) {
        controller.waitingForOtherConversion = YES;
    }
    _editorViewController = controller;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    LOG(@"welcome back!");
    _editorViewController = nil;
}

- (void)didPressCloseButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
