//
//  VnBlendingHardLight.m
//  Vintage 2.0
//
//  Created by SSC on 2014/04/19.
//  Copyright (c) 2014年 SSC. All rights reserved.
//

#import "VnBlendingHardLight.h"

#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
NSString *const kVnBlendingHardLightFragmentShaderString = SHADER_STRING
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
     
     mediump float ra;
     if (overlay.r < 0.5) {
         ra = base.r * overlay.r * 2.0;
     } else {
         ra = 2.0 * (base.r + overlay.r - base.r * overlay.r) - 1.0;
     }
     mediump float ga;
     if (overlay.g < 0.5) {
         ga = base.g * overlay.g * 2.0;
     } else {
         ga = 2.0 * (base.g + overlay.g - base.g * overlay.g) - 1.0;
     }
     mediump float ba;
     if (overlay.b < 0.5) {
         ba = base.b * overlay.b * 2.0;
     } else {
         ba = 2.0 * (base.b + overlay.b - base.b * overlay.b) - 1.0;
     }
     
     ra = ra * overlay.a + (1.0 - overlay.a) * base.r;
     ga = ga * overlay.a + (1.0 - overlay.a) * base.g;
     ba = ba * overlay.a + (1.0 - overlay.a) * base.b;
     gl_FragColor = vec4(ra, ga, ba, 1.0);
     
 }
 );
#else
NSString *const kVnBlendingHardLightFragmentShaderString = SHADER_STRING
(
 varying vec2 textureCoordinate;
 varying vec2 textureCoordinate2;
 
 uniform sampler2D inputImageTexture;
 uniform sampler2D inputImageTexture2;
 
 const vec3 W = vec3(0.2125, 0.7154, 0.0721);
 
 void main()
 {
     vec4 base = texture2D(inputImageTexture, textureCoordinate);
     vec4 overlay = texture2D(inputImageTexture2, textureCoordinate2);
     
     float ra;
     if (overlay.r < 0.5) {
         ra = base.r * overlay.r * 2.0;
     } else {
         ra = 2.0 * (base.r + overlay.r - base.r * overlay.r) - 1.0;
     }
     float ga;
     if (overlay.g < 0.5) {
         ga = base.g * overlay.g * 2.0;
     } else {
         ga = 2.0 * (base.g + overlay.g - base.g * overlay.g) - 1.0;
     }
     float ba;
     if (overlay.b < 0.5) {
         ba = base.b * overlay.b * 2.0;
     } else {
         ba = 2.0 * (base.b + overlay.b - base.b * overlay.b) - 1.0;
     }
     
     ra = ra * overlay.a + (1.0 - overlay.a) * base.r;
     ga = ga * overlay.a + (1.0 - overlay.a) * base.g;
     ba = ba * overlay.a + (1.0 - overlay.a) * base.b;
     gl_FragColor = vec4(ra, ga, ba, 1.0);
 }
 );
#endif

@implementation VnBlendingHardLight

- (id)init;
{
    if (!(self = [super initWithFragmentShaderFromString:kVnBlendingHardLightFragmentShaderString]))
    {
		return nil;
    }
    
    return self;
}

@end
