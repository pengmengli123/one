//
//  CustomImageView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomImageView : UIImageView
/** 注释 */
@property (nonatomic,assign) CGFloat originW;
/** 注释 */
@property (nonatomic,assign) CGFloat originH;
/** 注释 */
@property (nonatomic,assign) CGFloat zoomScale;
@property (nonatomic,assign) BOOL isFirstRote;//如果通过旋转改变frame，要除于zoomScale


@end
