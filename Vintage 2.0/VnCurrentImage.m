//
//  CurrentImage.m
//  Vintage
//
//  Created by SSC on 2014/04/03.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnCurrentImage.h"

@implementation VnCurrentImage

static VnCurrentImage* sharedVnCurrentImage = nil;

NSString* const pathForOriginalImage = @"tmp/original_image";
NSString* const pathForTmpImage = @"tmp/tmp_image";
NSString* const pathForPreviewImage = @"tmp/preview_image";
NSString* const pathForBlurredPreviewImage = @"tmp/blurred_preview_image";
NSString* const pathForProcessedPreviewImage = @"tmp/processed_preview_image";
NSString* const pathForLastSavedImage = @"tmp/last_saved_image";
NSString* const pathForDialogBgImage = @"tmp/dialog_bg_image";
NSString* const pathForPresetBaseImage = @"tmp/preset_base_image";

+ (VnCurrentImage*)instance {
	@synchronized(self) {
		if (sharedVnCurrentImage == nil) {
			sharedVnCurrentImage = [[self alloc] init];
		}
	}
	return sharedVnCurrentImage;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedVnCurrentImage == nil) {
			sharedVnCurrentImage = [super allocWithZone:zone];
			return sharedVnCurrentImage;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone*)zone {
	return self;  // シングルトン状態を保持するため何もせず self を返す
}

+ (UIImage*)imageAtPath:(NSString *)path
{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:path] ){
        NSData *data = [NSData dataWithContentsOfURL:fileURL];
        UIImage *img = [[UIImage alloc] initWithData:data];
        return img;
    }
    
    return nil;
}

+ (UIImage*)originalPreviewImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForPreviewImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)tmpImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForTmpImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)originalImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)lastSavedImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)dialogBgImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForDialogBgImage];
    return [self imageAtPath:filePath];
}

+ (UIImage*)presetBaseImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForPresetBaseImage];
    return [self imageAtPath:filePath];
}

+ (UIImage *)blurredPreviewImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForBlurredPreviewImage];
    return [self imageAtPath:filePath];
}

+ (UIImage *)processedPreviewImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForProcessedPreviewImage];
    return [self imageAtPath:filePath];
}

+ (BOOL)saveOriginalImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveOriginalPreviewImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForPreviewImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveLastSavedImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)savePrestBaseImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForPresetBaseImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveDialogBgImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForDialogBgImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveTmpImage:(UIImage *)image
{
    [VnCurrentImage instance].tmpImageSize = image.size;
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForTmpImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveBlurredPreviewImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForBlurredPreviewImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (BOOL)saveProcessedPreviewImage:(UIImage *)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.99f);
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForProcessedPreviewImage];
    return [imageData writeToFile:filePath atomically:YES];
}

+ (CGSize)originalImageSize
{
    return [self instance].originalImageSize;
}

+ (CGSize)previewImageSize
{
    CGSize size = [VnCurrentImage previewImageViewSize];
    return CGSizeMake(size.width * [[UIScreen mainScreen] scale], size.height * [[UIScreen mainScreen] scale]);
}

+ (CGSize)presetBaseImageSize
{
    CGRect bounds = [VnEditorViewManager presetImageBounds];
    return CGSizeMake(bounds.size.width * [[UIScreen mainScreen] scale], bounds.size.height * [[UIScreen mainScreen] scale]);
}

+ (CGSize)tmpImageSize
{
    return [VnCurrentImage instance].tmpImageSize;
}

+ (CGSize)previewImageViewSize
{
    CGRect bounds = [VnEditorViewManager previewBounds];
    CGSize originalImageSize = [VnCurrentImage originalImageSize];
    float width, height;
    if (originalImageSize.width > originalImageSize.height) {
        height = bounds.size.height;
        width = originalImageSize.width * height / originalImageSize.height;
    } else {
        width = bounds.size.width;
        height = originalImageSize.height * width / originalImageSize.width;
    }
    return CGSizeMake(width, height);
}

+ (BOOL)lastSavedImageExists
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if( [filemgr fileExistsAtPath:filePath] ){
        return YES;
    }
    return NO;
}

+ (BOOL)originalImageExists
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath:filePath]){
        return YES;
    }
    return NO;
}

+ (BOOL)deleteImageAtPath:(NSString *)path
{
    NSFileManager *filemgr = [NSFileManager defaultManager];
    NSURL *pathurl = [NSURL fileURLWithPath:path];
    
    if( [filemgr fileExistsAtPath:path] ){
        LOG(@"deleting the image at %@" ,path);
        return [filemgr removeItemAtURL:pathurl error:nil];
    }
    return YES;
}

+ (BOOL)deleteLastSavedImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForLastSavedImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteTmpImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForTmpImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteOriginalImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForOriginalImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteOriginalPreviewImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForPreviewImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteDialogBgImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForDialogBgImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteBlurredPreviewImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForBlurredPreviewImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deleteProcessedPreviewImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForProcessedPreviewImage];
    return [self deleteImageAtPath:filePath];
}

+ (BOOL)deletePresetBaseImage
{
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:pathForProcessedPreviewImage];
    return [self deleteImageAtPath:filePath];
}

+ (void)clean
{
    [VnCurrentImage deleteOriginalPreviewImage];
    [VnCurrentImage deleteOriginalImage];
    [VnCurrentImage deleteLastSavedImage];
    [VnCurrentImage deleteDialogBgImage];
    [VnCurrentImage deleteBlurredPreviewImage];
    [VnCurrentImage deleteProcessedPreviewImage];
    [VnCurrentImage deleteTmpImage];
    [VnCurrentImage deletePresetBaseImage];
}

@end
