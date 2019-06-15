//
//  TransformPixel.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "TransformPixel.h"

@implementation TransformPixel

+(CGFloat)mmTransformPixel:(CGFloat)mm{
    CGFloat sc_w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat sc_h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat ff = [[UIScreen mainScreen] nativeBounds].size.height/2;
    
    CGFloat sc_s;
    if (ff == 480) {//iphone3gs iphone4
        sc_s = 3.5;
    }else if(ff == 568){//iphone5
        sc_s = 4.0;
    }else if (ff== 667){//iphone6 iphone7 iphone8
        sc_s = 4.7;
    }else if (ff== 736){//iphone6p iphone7p iphone8p
        sc_s = 5.5;
    }else if (ff==812){//iphoneX
        sc_s = 5.8;
    }else if (ff==1024){//ipad1和2 ipadair
        sc_s = 9.7;
    }else if(ff == 1112){//ipad pro
        sc_s = 10.5;
    }else if(ff == 1366){//ipad pro
        sc_s = 12.9;
    }else{
        sc_s = 3.5;
    }
    return mm * (sqrt(sc_w * sc_w + sc_h * sc_h)/(sc_s * 25.4));//mm
}

+ (CGFloat)pixelTransformMM:(CGFloat)pixel{
    CGFloat sc_w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat sc_h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat ff = [[UIScreen mainScreen] nativeBounds].size.height/2;
    
    CGFloat sc_s;
    if (ff == 480) {//iphone3gs iphone4
        sc_s = 3.5;
    }else if(ff == 568){//iphone5
        sc_s = 4.0;
    }else if (ff== 667){//iphone6 iphone7 iphone8
        sc_s = 4.7;
    }else if (ff== 736){//iphone6p iphone7p iphone8p
        sc_s = 5.5;
    }else if (ff==812){//iphoneX
        sc_s = 5.8;
    }else if (ff==1024){//ipad1和2 ipadair
        sc_s = 9.7;
    }else if(ff == 1112){//ipad pro
        sc_s = 10.5;
    }else if(ff == 1366){//ipad pro
        sc_s = 12.9;
    }else{
        sc_s = 3.5;
    }
    return pixel * ((sc_s * 25.4)/sqrt(sc_w * sc_w + sc_h * sc_h));//mm
}


@end
