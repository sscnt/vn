//
//  UIEditorPreviewImageView.h
//  Vintage
//
//  Created by SSC on 2014/02/16.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "UISelectionPreviewImageView.h"

@interface UIEditorPreviewImageView : UISelectionPreviewImageView
{
    UIImageView* _imageViewOriginal;
}

@property (nonatomic, weak) UIImage* imageOriginal;

@end
