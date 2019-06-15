//
//  PupilDataView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "PupilDataView.h"

@implementation PupilDataView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        NSArray *dataArr = @[@[@"距离(cm)",@"瞳距(mm)",@"左眼(mm)",@"右眼(mm)"],
                             @[@"30",@"0.00",@"0.00",@"0.00"],
                             @[@"50",@"0.00",@"0.00",@"0.00"],
                             @[@"100",@"0.00",@"0.00",@"0.00"],
                             @[@"+∞",@"0.00",@"0.00",@"0.00"]];
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = kDataViewW;
        CGFloat h = kDataViewH;
        CGFloat hSpace = kDataViewHSpace;
        CGFloat vSpace = kDataViewVSpace;
        for (int i = 0; i < 5; i++) {
            NSArray *subArr = dataArr[i];
            for (int j = 0; j < 4; j++) {
                NSString *str = subArr[j];
                UILabel *lb = [[UILabel alloc] initWithFrame:ccr(x, y, w, h)];
                lb.textAlignment = NSTextAlignmentCenter;
                lb.font = HW_TWENTY_FONT_6;
                lb.textColor = UIColorFromRGB(0x00FFFF);
                lb.tag = i*5+j;
                lb.text = str;
                [self addSubview:lb];
                x += w+hSpace;
            }
            x = 0;
            y += h+vSpace;
        }
    }
    return self;
}

- (void)updataPupilDataViewData:(CGFloat)zuoYanData
                     youYanData:(CGFloat)rightData{
    CGFloat tongju = zuoYanData + rightData;
    NSArray *ndArr = @[[NSNumber numberWithFloat:300.0f],[NSNumber numberWithFloat:500.0f],[NSNumber numberWithFloat:1000.0f]];
    NSArray *pdArr = @[[NSNumber numberWithFloat:tongju],[NSNumber numberWithFloat:zuoYanData],[NSNumber numberWithFloat:rightData]];
    for (int i = 0; i < 5; i++) {
        for (int j= 0; j < 4 ; j++) {
            UILabel *lb = [self viewWithTag:i*5+j];
            if ((i > 0 && i < 4) && j > 0) {
                CGFloat nd = [ndArr[i - 1] floatValue];
                CGFloat pd = [pdArr[j - 1] floatValue];
                lb.text = [NSString stringWithFormat:@"%.2f",[self getPn:pd nd:nd]];
            }
            if (i == 4 && j > 0) {
                lb.text = [NSString stringWithFormat:@"%.2f",[pdArr[j - 1] floatValue]];
            }
        }
    }
    
}

- (CGFloat)getPn:(CGFloat)result nd:(CGFloat)nd
{
    return [self getPd:result] * ((nd - 12) / (nd + 13));
    
}

- (CGFloat)getPd:(CGFloat)pn{
    return pn * ((1000 + 13) / (1000 - 12));
}

@end
