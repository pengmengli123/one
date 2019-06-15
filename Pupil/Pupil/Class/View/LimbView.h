//
//  LimbView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLineTall SCREEN_FIT_6(40)

@interface LimbView : UIView
- (void)setLimbValue:(float)limbValue
       limbDirection:(LimbDirection)limbDirection;
/** 注释 */
@property (nonatomic,assign) CGFloat originalY;
@property (nonatomic,assign) CGFloat originalX;
/** 注释 */
@property (nonatomic,assign) CGFloat limbH;
@property (nonatomic,assign) CGFloat scale;
/** 注释 */
@property (nonatomic,assign) CGFloat limbValue;
/** 注释 */
@property (nonatomic,assign) LimbDirection limbDirection;

- (void)updataParams:(CGFloat)scale;


@end
