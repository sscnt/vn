//
//  UIEditorPreviewImageView.m
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UIEditorPreviewImageView.h"

@implementation UIEditorPreviewImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)setImageOriginal:(UIImage *)imageOriginal
{
    _imageOriginal = imageOriginal;
    
    _imageViewOriginal = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)];
    [_imageViewOriginal setImage:_imageOriginal];
    [self addSubview:_imageViewOriginal];
    [self bringSubviewToFront:self.imageViewPreview];
}

- (void)setHighlighted:(BOOL)highlighted
{
    if (highlighted) {
        self.imageViewPreview.alpha = 0.0f;
    }else{
        self.imageViewPreview.alpha = 1.0;
    }

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
