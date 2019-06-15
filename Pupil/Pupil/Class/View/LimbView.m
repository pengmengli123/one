//
//  LimbView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "LimbView.h"
#import "TransformPixel.h"

//#define kLineTag 2000
//#define kNumLbTag 3000
//#define kTopLineTag 5000
//#define kBlowLineTag 6000

@interface LimbView ()
///** 注释 */
//@property (nonatomic,strong) NSMutableArray *lineArr;
///** 注释 */
//@property (nonatomic,strong) NSMutableArray *numLbArr;
@end

@implementation LimbView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
////        self.clipsToBounds = YES;
//        _lineArr = [NSMutableArray arrayWithCapacity:0];
//        _numLbArr = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)setLimbValue:(float)limbValue
       limbDirection:(LimbDirection)limbDirection{
    _limbValue = limbValue;
    _limbDirection = limbDirection;
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    int mCount = floorf(limbValue);
    CGFloat allDistance = [TransformPixel mmTransformPixel:1] * limbValue;
    _limbH = allDistance;
    CGFloat x = limbDirection == VerticalType ? 0 : (self.width - allDistance)/2.0f;
    _originalX = x;
    CGFloat y = limbDirection == VerticalType ? (self.height - allDistance)/2.0f : 0;
    _originalY = y;
    CGFloat lineW = limbDirection == VerticalType ? kLineTall : 1.0;
    CGFloat lineH = limbDirection == VerticalType ? 1.0 : kLineTall;
    CGFloat space = (allDistance - (mCount + 1) * 1.0f)/mCount;
    for (int i = 0; i < mCount+1; i ++) {
        if (i%5 == 0) {
            if (limbDirection == VerticalType) {
                lineW = kLineTall+SCREEN_FIT_6(10);
            }else{
                lineH = kLineTall+SCREEN_FIT_6(10);
            }
        }
        if (i%10 == 0) {
            if (limbDirection == VerticalType) {
                lineW = kLineTall+SCREEN_FIT_6(20);
            }else{
                lineH = kLineTall+SCREEN_FIT_6(20);
            }
        }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:ccr(x, y, lineW, lineH)];
        iv.backgroundColor = [UIColor whiteColor];
//        iv.tag = kLineTag + i;
        [self addSubview:iv];
//        [_lineArr addObject:iv];
        if (i%10 == 0) {
            if (limbDirection == VerticalType) {
                UILabel *lb = [[UILabel alloc] initWithFrame:ccr(iv.right + SCREEN_FIT_6(6), iv.center.y - SCREEN_FIT_6(24)/2.0f, SCREEN_FIT_6(48), SCREEN_FIT_6(24))];
                lb.textColor = [UIColor whiteColor];
                lb.font = HW_TWELVE_FONT_6;
                lb.text = [NSString stringWithFormat:@"%d",(int)floorf(i/10)];
                [self addSubview:lb];
            }else{
                UILabel *lb = [[UILabel alloc] initWithFrame:ccr(iv.center.x - SCREEN_FIT_6(48)/2.0f, iv.bottom + SCREEN_FIT_6(6), SCREEN_FIT_6(48), SCREEN_FIT_6(24))];
                lb.textColor = [UIColor whiteColor];
                lb.font = HW_TWELVE_FONT_6;
                lb.textAlignment = NSTextAlignmentCenter;
                lb.text = [NSString stringWithFormat:@"%d",(int)floorf(i/10)];
                [self addSubview:lb];
            }
        }
        
        if (limbDirection == VerticalType) {
            lineW = kLineTall;
            y += lineH + space;
        }else{
            lineH = kLineTall;
            x += lineW + space;
        }
    }
    if (limbDirection == VerticalType) {
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:ccr(0, (self.height - allDistance)/2.0f + lineH/2.0f - 2/2.0f, kDeviceWidth+SCREEN_FIT_6(2000), 2)];
        topLine.backgroundColor = UIColorFromRGB(0x009944);
        [self addSubview:topLine];
        
        UIImageView *blowLine = [[UIImageView alloc] initWithFrame:ccr(0, (self.height - allDistance)/2.0f + allDistance - lineH/2.0f - 2/2.0f, kDeviceWidth+SCREEN_FIT_6(2000), 2)];
        blowLine.backgroundColor = UIColorFromRGB(0x009944);
        [self addSubview:blowLine];
    }else{
        UIImageView *topLine = [[UIImageView alloc] initWithFrame:ccr((self.width - allDistance)/2.0f + lineW/2.0f - 2/2.0f, 0, 2, kDeviceHeight+SCREEN_FIT_6(2000))];
        topLine.backgroundColor = UIColorFromRGB(0x009944);
        [self addSubview:topLine];
        
        UIImageView *blowLine = [[UIImageView alloc] initWithFrame:ccr((self.width - allDistance)/2.0f + allDistance - lineW/2.0f - 2/2.0f, 0, 2, kDeviceHeight+SCREEN_FIT_6(2000))];
        blowLine.backgroundColor = UIColorFromRGB(0x009944);
        [self addSubview:blowLine];
    }
}

- (void)updataParams:(CGFloat)scale{
    CGFloat allDistance = [TransformPixel mmTransformPixel:1] * _limbValue;
    _limbH = allDistance*scale;
    _originalX = (self.width - _limbH)/2.0f;
    _originalY = (self.height - _limbH)/2.0f;
}

//- (void)layoutSubviews{
//    self.backgroundColor = [UIColor redColor];
//    [super layoutSubviews];
//    for (UIView *subView in self.subviews) {
//        CGRect rect = subView.frame;
//        rect.origin.x = 0;
//        subView.frame = rect;
//    }
//}

@end
