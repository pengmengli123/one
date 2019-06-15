//
//  ChangeMainView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "ChangeMainView.h"
#import "ChangeRadianView.h"
@interface ChangeMainView ()<ChangeRadianViewDelegate>
@end
@implementation ChangeMainView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        ChangeRadianView *changeRadianView = [[ChangeRadianView alloc] initWithFrame:ccr(2, 0, frame.size.width - 2*2, frame.size.height)];
        changeRadianView.delegate = self;
        changeRadianView.backgroundColor = [UIColor clearColor];
        [self addSubview:changeRadianView];
        
        UIImageView*imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"change_radian"]];
        imageView.frame=CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:imageView];
        [self sendSubviewToBack:imageView];
    }
    return self;
}

#pragma mark  - ChangeRadianViewDelegate
- (void)ChangeRadianViewChangeRadian:(CGFloat)scale{
    if (_delegate && [_delegate respondsToSelector:@selector(ChangeMainViewChangeRadian:)]) {
        [_delegate ChangeMainViewChangeRadian:-scale];
    }
}


@end
