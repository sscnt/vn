//
//  EffectsViewController.h
//  Vintage
//
//  Created by SSC on 2014/02/15.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UISelectionPreviewImageView.h"

@interface SelectionViewController : UIViewController

@property (nonatomic, strong) UIImage* imageOriginal;
@property (nonatomic, strong) UIImage* imageResized;
@property (nonatomic, strong) NSMutableArray* imagesArray;

- (id)initWithImage:(UIImage*)image;

@end
