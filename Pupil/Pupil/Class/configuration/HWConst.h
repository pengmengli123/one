//
//  QCConst.h
//  YOUXINBAO
//
//  Created by ZHANGMIAO on 14-3-4.
//  Copyright (c) 2014年 北京全彩时代网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

//正确的 1 像素写法
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
//调用AppDelegate
#define SHAREDAPP ((AppDelegate *)[UIApplication sharedApplication].delegate)
//获取设备屏幕宽
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
//获取设备屏幕高
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
//navBar高度
#define NAVBAR_HEIGHT  ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?64.0f:44.0f)





#define IPHONE5 (kDeviceWidth == 568)
#define IPHONE4 (kDeviceWidth == 480)
#define IPHONE6 (kDeviceWidth == 667)
#define IPHONE6PLUS (kDeviceWidth == 736)
#define IPHONEX (kDeviceWidth == 812)

#define IPADAIR (kDeviceWidth == 1024)
#define IPADPRO10 (kDeviceWidth == 1112)
#define IPADPRO12 (kDeviceWidth == 1366)
//#define IPHONE6 (kDeviceWidth == 667)
//#define IPHONE6PLUS (kDeviceWidth == 736)
//#define IPHONEX (kDeviceWidth == 812)


/**
 *   电池栏高度
 */
#define k_StatusBar_H [[UIApplication sharedApplication] statusBarFrame].size.height

/**
 *   导航栏高度
 */
#define k_NavBar_H  (44 + k_StatusBar_H)

/**
 *   底部UItabbar高度
 */
#define k_TabBar_H 49

//获取设备系统版本
#define KDeviceOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//三色值
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//背景色值
#define kCustomBackground rgb(255,244,238,1)
//线条色值
//#define kLineColor rgb(255,221,202,1) (242, 241, 239, 1)
#define kLineColor rgb(242, 241, 239, 1)
#define kRGB(r, g, b) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]
//十六进制颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ccr(x,y,w,h) CGRectMake(x,y,w,h)
//************************************************************

//文字大小适配比例以6为基准
#define PPL_FONT_SCALE_6 \
({\
CGFloat fontScale = 1.0; \
if(IPHONE5){ \
fontScale = 0.80;\
}else if (IPHONE4){ \
fontScale = 0.80;\
}else if (IPHONE6PLUS){ \
fontScale = 1.04;\
}else if (IPADAIR){ \
fontScale = 1.15;\
}else{\
fontScale = (PPL_SCREEN_SCALE_6/1.06);\
}\
fontScale;\
})

//屏幕适配比例以6为基准
#define PPL_SCREEN_SCALE_6 \
({\
CGFloat screenScale = 1.0; \
if(IPHONE5){ \
screenScale = 0.85;\
}else if (IPHONE4){ \
screenScale = 0.85;\
}else if (IPHONE6PLUS){ \
screenScale = 1.104;\
}else if (IPADAIR){ \
screenScale = 1.25;\
}else{\
screenScale = ((kDeviceHeight > 0 ? kDeviceHeight : 375)/375);\
}\
screenScale;\
})
//坐标和size做适配 //以6(750)为基准
#define SCREEN_FIT_6(d) (PPL_SCREEN_SCALE_6 * (d)/2)

#define HW_TEN_FONT_6              [UIFont systemFontOfSize:(10.0f * PPL_FONT_SCALE_6)]
#define HW_NINE_FONT_6             [UIFont systemFontOfSize:(9.0f * PPL_FONT_SCALE_6)]
#define HW_TWELVE_FONT_6           [UIFont systemFontOfSize:(12.0f * PPL_FONT_SCALE_6)]
#define HW_FIFTEEN_FONT_6          [UIFont systemFontOfSize:(15.0f * PPL_FONT_SCALE_6)]
#define HW_THIRTY_FONT_6           [UIFont systemFontOfSize:(30.0f * PPL_FONT_SCALE_6)]
#define HW_TWENTYFIVE_FONT_6       [UIFont systemFontOfSize:(25.0f * PPL_FONT_SCALE_6)]
#define HW_SEVENTEEN_FONT_6        [UIFont systemFontOfSize:(17.0f * PPL_FONT_SCALE_6)]
#define HW_SIXTEEN_FONT_6          [UIFont systemFontOfSize:(16.0f * PPL_FONT_SCALE_6)]
#define HW_THIRTEEN_FONT_6         [UIFont systemFontOfSize:(13.0f * PPL_FONT_SCALE_6)]
#define HW_EIGHTEEN_FONT_6         [UIFont systemFontOfSize:(18.0f * PPL_FONT_SCALE_6)]
#define HW_FOURTEEN_FONT_6         [UIFont systemFontOfSize:(14.0f * PPL_FONT_SCALE_6)]
#define HW_EIGHT_FONT_6            [UIFont systemFontOfSize:(8.0f * PPL_FONT_SCALE_6)]
#define HW_TWENTYTWO_FONT_6        [UIFont systemFontOfSize:(22.0f * PPL_FONT_SCALE_6)]
#define HW_ELEVEN_FONT_6           [UIFont systemFontOfSize:(11.0f * PPL_FONT_SCALE_6)]
#define HW_TWENTY_FONT_6           [UIFont systemFontOfSize:(20.0f * PPL_FONT_SCALE_6)]
#define HW_SIX_FONT_6              [UIFont systemFontOfSize:(6.0f * PPL_FONT_SCALE_6)]
#define HW_TWENTYSIX_FONT_6        [UIFont systemFontOfSize:(26.0f * PPL_FONT_SCALE_6)]
#define HW_TWENTY_FIVE_FONT_6      [UIFont systemFontOfSize:(25.0f * PPL_FONT_SCALE_6)]




