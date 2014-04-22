//
//  VnViewEditorPhotoPreview.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/21.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnViewEditorPhotoPreview.h"

@implementation VnViewEditorPhotoPreview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentSize = [VnCurrentImage previewImageViewSize];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.maximumZoomScale = 1.0f;
        _scrollView.minimumZoomScale = MIN(1.0, MIN(frame.size.width / [VnCurrentImage previewImageViewSize].width, frame.size.height / [VnCurrentImage previewImageViewSize].height));
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [VnCurrentImage previewImageViewSize].width, [VnCurrentImage previewImageViewSize].height)];
        [_scrollView addSubview:_imageView];
        [_scrollView setContentOffset:CGPointMake(([VnCurrentImage previewImageViewSize].width - frame.size.width) / 2.0f, ([VnCurrentImage previewImageViewSize].height - frame.size.height) / 2.0f)];
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _imageView.image = image;
}

#pragma mark delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat y = MAX(0.0f, self.frame.size.height - scrollView.contentSize.height);
    CGFloat x = MAX(0.0f, self.frame.size.width - scrollView.contentSize.width);
    [scrollView setX:x / 2.0f];
    [scrollView setY:y / 2.0f];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    
}

- (void)dealloc
{
    _scrollView.delegate = nil;
}

@end
