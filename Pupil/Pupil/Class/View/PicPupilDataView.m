//
//  PicPupilDataView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/12.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "PicPupilDataView.h"
@interface PicPupilDataView()
/** 注释 */
@property (nonatomic,weak) UILabel *leftDataLb;
/** 注释 */
@property (nonatomic,weak) UILabel *rightDataLb;
/** 注释 */
@property (nonatomic,weak) UILabel *luoChaDataLb;
@end
@implementation PicPupilDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        _clickNum = 1;
        UILabel *leftLb = [[UILabel alloc] initWithFrame:ccr(0, 0, kPDLbW, kPDLbH)];
        leftLb.textColor = UIColorFromRGB(0x00FFFF);
        leftLb.font = HW_TWENTY_FONT_6;
        leftLb.text = @"右瞳高(mm)";
        leftLb.textAlignment = NSTextAlignmentCenter;
//        leftLb.backgroundColor = [UIColor redColor];
        [self addSubview:leftLb];
        
        UILabel *leftDataLb = [[UILabel alloc] initWithFrame:ccr(0, leftLb.bottom + kPDLbVSpace, leftLb.width, leftLb.height)];
        leftDataLb.textColor = UIColorFromRGB(0x00FFFF);
        leftDataLb.font = HW_TWENTY_FONT_6;
//        leftDataLb.backgroundColor = [UIColor redColor];
        leftDataLb.text = @"0.00";
        leftDataLb.textAlignment = NSTextAlignmentCenter;
        [self addSubview:leftDataLb];
        _leftDataLb = leftDataLb;
        
        UILabel *rightLb = [[UILabel alloc] initWithFrame:ccr(leftLb.right + kPDLbHSpace, 0,leftLb.width, leftLb.height)];
        rightLb.textColor = UIColorFromRGB(0x00FFFF);
        rightLb.font = HW_TWENTY_FONT_6;
//        rightLb.backgroundColor = [UIColor redColor];
        rightLb.textAlignment = NSTextAlignmentCenter;
        rightLb.text = @"左瞳高(mm)";
        [self addSubview:rightLb];
        
        UILabel *rightDataLb = [[UILabel alloc] initWithFrame:ccr(rightLb.left, rightLb.bottom + kPDLbVSpace, rightLb.width, kPDLbH)];
        rightDataLb.textColor = UIColorFromRGB(0x00FFFF);
        rightDataLb.font = HW_TWENTY_FONT_6;
//        rightDataLb.backgroundColor = [UIColor redColor];
        rightDataLb.textAlignment = NSTextAlignmentCenter;
        rightDataLb.text = @"0.00";
        [self addSubview:rightDataLb];
        _rightDataLb = rightDataLb;
        
        UILabel *luoChaLb = [[UILabel alloc] initWithFrame:ccr(rightLb.right + kPDLbHSpace, 0, leftLb.width, leftLb.height)];
        luoChaLb.textColor = UIColorFromRGB(0x00FFFF);
        luoChaLb.font = HW_TWENTY_FONT_6;
//        leftLb.backgroundColor = [UIColor redColor];
        luoChaLb.textAlignment = NSTextAlignmentCenter;
        luoChaLb.text = @"落差(mm) ";
        [self addSubview:luoChaLb];
        
        UILabel *luoChaDataLb = [[UILabel alloc] initWithFrame:ccr(luoChaLb.left, luoChaLb.bottom + kPDLbVSpace, leftLb.width, leftLb.height)];
        luoChaDataLb.textColor = UIColorFromRGB(0x00FFFF);
        luoChaDataLb.font = HW_TWENTY_FONT_6;
//        luoChaDataLb.backgroundColor = [UIColor redColor];
        luoChaDataLb.textAlignment = NSTextAlignmentCenter;
        luoChaDataLb.text = @"0.00";
        [self addSubview:luoChaDataLb];
        _luoChaDataLb = luoChaDataLb;
    }
    return self;
}

- (void)updataSubViewData:(CGFloat)mm{
    if (_clickNum == 1) {
        _clickNum ++;
        _leftDataLb.text = [NSString stringWithFormat:@"%.2f",mm];
        return;
    }
    if (_clickNum == 2) {
        _clickNum ++;
        _rightDataLb.text = [NSString stringWithFormat:@"%.2f",mm];
        _luoChaDataLb.text = [NSString stringWithFormat:@"%.2f",fabsf([_rightDataLb.text floatValue] - [_leftDataLb.text floatValue])];
        return;
    }
    if (_clickNum == 3) {
        _leftDataLb.text = @"0.00";
        _rightDataLb.text = @"0.00";
        _luoChaDataLb.text = @"0.00";
        _clickNum = 1;
        return;
    }
}

@end
