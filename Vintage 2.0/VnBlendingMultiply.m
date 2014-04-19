//
//  VnBlendingMultiply.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingMultiply.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingMultiplyFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlayer = texture2D(inputImageTexture2, textureCoordinate2);
     mediump vec3 rgb = base.rgb * overlayer.rgb * overlayer.a + (1.0 - overlayer.a) * base.rgb;
     gl_FragColor = vec4(rgb, 1.0);
 }
 );
#else
NSString *const kVnBlendingMultiplyFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlayer = texture2D(inputImageTexture2, textureCoordinate2);
     vec3 rgb = base.rgb * overlayer.rgb * overlayer.a + (1.0 - overlayer.a) * base.rgb;
     gl_FragColor = vec4(rgb, 1.0);
 }
 );
#endif


@implementation VnBlendingMultiply

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingMultiplyFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
