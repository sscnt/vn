//
//  UIView+Gravy.h
//  Gravy_1.0
//
//  Created by SSC on 2013/10/15.
//  Copyright (c) 2013年 SSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extend)
- (float)height;
- (float)width;
- (float)bottom;
- (float)right;
- (void)setShadow;
- (void)setX:(float)x;
- (void)setY:(float)y;
- (void)setCenterX:(float)x;
- (void)setCenterY:(float)y;
- (void)setWidth:(float)width;
- (void)setHeight:(float)height;
- (void)setOrigin:(CGPoint)point;
- (void)setSize:(CGSize)size;

- (UIImage *) imageByRenderingViewOpaque:(BOOL) opaque Rect:(CGRect)rect;
- (UIImage *) imageByRenderingView;
- (UIImage *) imageByRenderingViewWithRect:(CGRect)rect;

@end
