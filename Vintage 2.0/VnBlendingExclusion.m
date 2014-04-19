//
//  VnBlendingExclusion.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingExclusion.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingExclusionFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     mediump vec4 result = (base + overlay - 2.0 * base * overlay) * overlay.a + (1.0 - overlay.a) * base;
     result.a = 1.0;
     gl_FragColor = result;
 }
 );
#else
NSString *const kVnBlendingExclusionFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     vec4 result = (base + overlay - 2.0 * base * overlay) * overlay.a + (1.0 - overlay.a) * base;
     result.a = 1.0;
     gl_FragColor = result;
 }
 );
#endif

@implementation VnBlendingExclusion

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingExclusionFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
