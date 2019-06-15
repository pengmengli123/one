//
//  TransformPixel.h
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransformPixel : NSObject

//像素转化为毫米
+ (CGFloat)pixelTransformMM:(CGFloat)pixel;
//毫米转化为像素
+(CGFloat)mmTransformPixel:(CGFloat)mm;

@end
