//
//  VnBlendingDarken.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingDarken.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingDarkenFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlayer = texture2D(inputImageTexture2, textureCoordinate2);
     gl_FragColor = vec4(min(overlayer.rgb, base.rgb) * overlayer.a + (1.0 - overlayer.a) * base.rgb, 1.0);
 }
 );
#else
NSString *const kVnBlendingDarkenFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlayer = texture2D(inputImageTexture2, textureCoordinate2);
     gl_FragColor = vec4(min(overlayer.rgb, base.rgb) * overlayer.a + (1.0 - overlayer.a) * base.rgb, 1.0);
 }
 );
#endif


@implementation VnBlendingDarken

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingDarkenFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
