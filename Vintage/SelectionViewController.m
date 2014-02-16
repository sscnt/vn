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
        _paused = NO;
        _viewDidOnceAppear = NO;
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
    _numberOfEffects = 24;
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
    [_arrayEffects addObject:[[GPUEffectVanilla alloc] init]];
    [_arrayEffects addObject:[[GPUEffectWarmAutumn alloc] init]];
    [_arrayEffects addObject:[[GPUEffectSunsetCarnevale alloc] init]];
    [_arrayEffects addObject:[[GPUEffectWarmSpringLight alloc] init]];
    [_arrayEffects addObject:[[GPUEffectColorfulCandy alloc] init]];
    
    //// Layout
    [self.view setBackgroundColor:[UIColor colorWithWhite:26.0f/255.0f alpha:1.0]];
    [self.view addSubview:_scrollView];
    UINavigationBarView* bar = [[UINavigationBarView alloc] initWithPosition:NavigationBarViewPositionTop];
    UICloseButton* buttonClose = [[UICloseButton alloc] init];
    [buttonClose addTarget:self action:@selector(didPressCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [bar appendButtonToLeft:buttonClose];
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
        [_self resizeOriginalImageWidth:width Height:height];
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
        return;
    }
    if (index < _numberOfEffects) {
        LOG(@"applying %d", index);
        _currentProcessingIndex = index;
        __block SelectionViewController* _self = self;
        __block GPUImageEffects* effect = [_arrayEffects objectAtIndex:index];
        __block UIImage* imageToProcess = _imageResized;
        __block UISelectionPreviewImageView* preview = [_arrayPreviews objectAtIndex:index];
        __block UIImage* imageApplied;
        preview.effectId = effect.effectId;
        if ([effect respondsToSelector:@selector(imageToProcess)]) {
            dispatch_queue_t q_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t q_main = dispatch_get_main_queue();
            dispatch_async(q_global, ^{
                effect.imageToProcess = imageToProcess;
                imageApplied = [effect process];
                dispatch_async(q_main, ^{
                    [preview removeLoadingIndicator];
                    [preview.imageViewPreview setImage:imageApplied];
                    [preview setIsPreviewReady:YES];
                    [_self applyEffectAtIndex:index + 1];
                });
                
            });
        }
    }
}

- (void)resizeOriginalImageWidth:(CGFloat)width Height:(CGFloat)height
{
    if(self.imageOriginal){
        _imageResized = [UIImage resizedImage:self.imageOriginal width:width height:height];
    }
}

#pragma mark events

- (void)didSelectPreview:(UISelectionPreviewImageView *)preview
{
    if (preview.isPreviewReady == NO) {
        LOG(@"paused.");
        return;
    }
    _paused = YES;
    EditorViewController* controller = [[EditorViewController alloc] init];
    controller.effectId = preview.effectId;
    controller.imageResized = _imageResized;
    controller.imageEffected = preview.imageViewPreview.image;
    [self.navigationController pushViewController:controller animated:YES];
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
