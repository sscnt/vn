//
//  UISelectionPreviewImageView.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISelectionPreviewImageView.h"

@implementation UISelectionPreviewImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _drawImage = NO;
        _isPreviewReady = NO;
        [self setBackgroundColor:[UIColor colorWithWhite:33.0f/255.0f alpha:1.0f]];
        
        //// Original
        _previewImageView = [[UIPortrateImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        [self addSubview:_previewImageView];
        
        //// Loading
        _imageViewLoading = [[UIPortrateImageView alloc] initWithImage:[UIImage animatedGIFNamed:@"loading-48"]];
        _imageViewLoading.center = CGPointMake(roundf(frame.size.width / 2.0), roundf(frame.size.height / 2.0));
        [self addSubview:_imageViewLoading];
    }
    return self;
}

- (void)removeLoadingIndicator
{
    if (_imageViewLoading) {
        [_imageViewLoading removeFromSuperview];
        _imageViewLoading = nil;
    }
}

- (void)setOpacity:(CGFloat)opacity
{
    _opacity = opacity;
}

- (void)setPreviewImage:(UIImage *)image
{
    _previewImageView.image = image;
    [self setNeedsDisplay];
}

- (void)setPreviewImage:(UIImage *)image WithDuration:(CGFloat)duration
{
    _previewImageView.image = image;
    _previewImageView.alpha = 0.0f;
    _previewImageView.hidden = NO;
    __block UISelectionPreviewImageView* _self = self;
    [UIView animateWithDuration:duration animations:^{
        _self.previewImageView.alpha = 1.0f;
    } completion:^(BOOL finished){
        _self.drawImage = YES;
        [_self setNeedsDisplay];
    }];
}

- (void)setSelected:(BOOL)selected
{
    LOG(@"Tapped: %d", selected);
    if (selected) {
        self.previewImageView.alpha = 0.50f;
    }else{
        self.previewImageView.alpha = 1.0f;
    }
}

- (void)reset
{
    _drawImage = NO;
    _isPreviewReady = NO;
    _previewImageView.image = nil;
    if(_imageViewLoading){
        [_imageViewLoading removeFromSuperview];
        _imageViewLoading = nil;
    }
    
    _imageViewLoading = [[UIPortrateImageView alloc] initWithImage:[UIImage animatedGIFNamed:@"loading-48"]];
    _imageViewLoading.center = CGPointMake(roundf(self.frame.size.width / 2.0), roundf(self.frame.size.height / 2.0));
    [self addSubview:_imageViewLoading];
}


- (void)drawRect:(CGRect)rect
{
    LOG(@"drawRect");
    if(_drawImage && self.previewImageView.image){
        [self.previewImageView.image drawInRect:rect];
        self.previewImageView.image = nil;
    }
    _drawImage = NO;
}


@end
