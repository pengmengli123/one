//
//  FunctionView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/1.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "FunctionView.h"

@implementation FunctionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *lockBtn = [self setUpButtonWithFrame:ccr(0, 0, SCREEN_FIT_6(96), SCREEN_FIT_6(96)) normalImage:[UIImage imageNamed:@"unlock"] selectedImage:[UIImage imageNamed:@"lock"] sel:@selector(lockOrUnlockPic:)];
        [self addSubview:lockBtn];
        
        UIButton *cameraBtn = [self setUpButtonWithFrame:ccr(0, lockBtn.bottom + SCREEN_FIT_6(20), SCREEN_FIT_6(96), SCREEN_FIT_6(96)) normalImage:[UIImage imageNamed:@"canmer"] selectedImage:[UIImage imageNamed:@"canmer"] sel:@selector(camera:)];
        [self addSubview:cameraBtn];
        
        UIButton *addBtn = [self setUpButtonWithFrame:ccr(0, cameraBtn.bottom + SCREEN_FIT_6(20), SCREEN_FIT_6(96), SCREEN_FIT_6(96)) normalImage:[UIImage imageNamed:@"add"] selectedImage:[UIImage imageNamed:@"add"] sel:@selector(amplifyPic:)];
        [self addSubview:addBtn];
        
        UIButton *subtractBtn = [self setUpButtonWithFrame:ccr(0, addBtn.bottom + SCREEN_FIT_6(20), SCREEN_FIT_6(96), SCREEN_FIT_6(96)) normalImage:[UIImage imageNamed:@"jian"] selectedImage:[UIImage imageNamed:@"jian"] sel:@selector(shrinkPic:)];
        [self addSubview:subtractBtn];
    }
    return self;
}

- (UIButton *)setUpButtonWithFrame:(CGRect)frame
                   normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage sel:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    [btn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)lockOrUnlockPic:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.isSelected;
    if (_delegate && [_delegate respondsToSelector:@selector(FunctionViewLockOrUnlockPic:)]) {
        [_delegate FunctionViewLockOrUnlockPic:!btn.selected];
    }
}

- (void)camera:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(FunctionViewCamera:)]) {
        [_delegate FunctionViewCamera:sender];
    }
}

- (void)amplifyPic:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(FunctionViewAmplifyPic:)]) {
        [_delegate FunctionViewAmplifyPic:sender];
    }
}

- (void)shrinkPic:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(FunctionViewShrinkPic:)]) {
        [_delegate FunctionViewShrinkPic:sender];
    }
}


@end
