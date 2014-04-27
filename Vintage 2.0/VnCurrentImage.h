//
//  CurrentImage.h
//  Vintage
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VnCurrentImage : NSObject

@property (nonatomic, assign) CGSize originalImageSize;
@property (nonatomic, assign) CGSize tmpImageSize;

+ (VnCurrentImage*)instance;
+ (BOOL)lastSavedImageExists;
+ (BOOL)originalImageExists;
+ (UIImage*)imageAtPath:(NSString*)path;
+ (UIImage*)tmpImage;
+ (UIImage*)originalPreviewImage;
+ (UIImage*)processedPreviewImage;
+ (UIImage*)blurredPreviewImage;
+ (UIImage*)originalImage;
+ (UIImage*)lastSavedImage;
+ (UIImage*)dialogBgImage;
+ (UIImage*)presetBaseImage;
+ (BOOL)saveTmpImage:(UIImage*)image;
+ (BOOL)saveOriginalImage:(UIImage*)image;
+ (BOOL)saveOriginalPreviewImage:(UIImage*)image;
+ (BOOL)saveProcessedPreviewImage:(UIImage*)image;
+ (BOOL)saveBlurredPreviewImage:(UIImage*)image;
+ (BOOL)saveLastSavedImage:(UIImage*)image;
+ (BOOL)saveDialogBgImage:(UIImage*)image;
+ (BOOL)savePrestBaseImage:(UIImage*)image;
+ (CGSize)originalImageSize;
+ (CGSize)previewImageSize;
+ (CGSize)previewImageViewSize;
+ (CGSize)presetBaseImageSize;
+ (CGSize)tmpImageSize;
+ (BOOL)deleteImageAtPath:(NSString*)path;
+ (BOOL)deleteTmpImage;
+ (BOOL)deleteLastSavedImage;
+ (BOOL)deleteOriginalImage;
+ (BOOL)deleteDialogBgImage;
+ (BOOL)deleteOriginalPreviewImage;
+ (BOOL)deleteProcessedPreviewImage;
+ (BOOL)deleteBlurredPreviewImage;
+ (BOOL)deletePresetBaseImage;
+ (void)clean;

@end