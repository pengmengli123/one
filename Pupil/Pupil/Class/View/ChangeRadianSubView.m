//
//  ChangeRadianSubView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "ChangeRadianSubView.h"

@implementation ChangeRadianSubView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
        int count = (int)frame.size.width/10;
        CGFloat x = 0;
        CGFloat w = 0.5;
        CGFloat h = 20;
        CGFloat space = (frame.size.width-(count+1)*0.5)/count;
        _space = space;
        for (int i = 0; i < count+1; i++) {
            if (i == 0) {
                h = 35;
            }else{
                h = 20;
            }
            UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(x, (frame.size.height - h)/2.0f, w, h)];
            if (i == 0) {
                iv.image = [UIImage imageNamed:@"change_radian_line"];
            }else{
                iv.image = [UIImage imageNamed:@"heixian_cion"];
            }
            [self addSubview:iv];
            x += w+space;
        }
    }
    return self;
}
@end
