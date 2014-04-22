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
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [VnCurrentImage previewImageViewSize].width, [VnCurrentImage previewImageViewSize].height)];
        [_scrollView addSubview:_imageView];
        [_scrollView setContentOffset:CGPointMake(([VnCurrentImage previewImageViewSize].width - frame.size.width) / 2.0f, ([VnCurrentImage previewImageViewSize].height - frame.size.height) / 2.0f)];
        LOG_POINT(CGPointMake(([VnCurrentImage previewImageViewSize].width - frame.size.width) / 2.0f, ([VnCurrentImage previewImageViewSize].height - frame.size.height) / 2.0f));
        [self addSubview:_scrollView];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _imageView.image = image;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
