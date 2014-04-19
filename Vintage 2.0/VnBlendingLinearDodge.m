//
//  VnBlendingLinearDodge.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingLinearDodge.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE

NSString *const kVnBlendingLinearDodgeFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 const highp vec3 W = vec3(0.2125, 0.7154, 0.0721);
 
 void main()
 {
     mediump vec4 base = texture2D(inputImageTexture, textureCoordinate);
     mediump vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     
     mediump vec3 result = base.rgb + overlay.rgb;
     result.r = min(result.r, 1.0);
     result.g = min(result.g, 1.0);
     result.b = min(result.b, 1.0);
     
     gl_FragColor = vec4(result * overlay.a + base.rgb * (1.0 - overlay.a), 1.0);
 }
 );

#else
NSString *const kVnBlendingLinearDodgeFragmentShaderString = SHADER_STRING
(
 varying highp vec2 textureCoordinate;
 varying highp vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 const vec3 W = vec3(0.2125, 0.7154, 0.0721);
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     vec3 result = base.rgb + overlay.rgb;
     result.r = min(result.r, 1.0);
     result.g = min(result.g, 1.0);
     result.b = min(result.b, 1.0);
     
     gl_FragColor = vec4(result * overlay.a + base.rgb * (1.0 - overlay.a), 1.0);
 }
 );

#endif

@implementation VnBlendingLinearDodge

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingLinearDodgeFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
