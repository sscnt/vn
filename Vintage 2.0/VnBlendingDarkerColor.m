//
//  VnBlendingDarkerColor.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingDarkerColor.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE

NSString *const kVnBlendingDarkerColorFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     if(overlay.r < base.r){
         base.r = overlay.r;
     }
     if(overlay.g < base.g){
         base.g = overlay.g;
     }
     if(overlay.b < base.b){
         base.b = overlay.b;
     }
     gl_FragColor = base;
 }
 );
#else

NSString *const kVnBlendingDarkerColorFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     if(overlay.r < base.r){
         base.r = overlay.r;
     }
     if(overlay.g < base.g){
         base.g = overlay.g;
     }
     if(overlay.b < base.b){
         base.b = overlay.b;
     }
     gl_FragColor = base;
 }
 );

#endif

@implementation VnBlendingDarkerColor

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingDarkerColorFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
