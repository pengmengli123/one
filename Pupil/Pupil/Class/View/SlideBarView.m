//
//  SlideBarView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "SlideBarView.h"

@implementation SlideBarView
- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                limbDirection:(LimbDirection)limbDirection{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor blueColor];
        _limbDirection = limbDirection;
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(handlePan:)];
        [self addGestureRecognizer:panGestureRecognizer];

    }
    return self;
}

- (void)handlePan:(UIPanGestureRecognizer*) recognizer
{
    CGPoint translation = [recognizer translationInView:self];
    if (_limbDirection == VerticalType) {
        if (recognizer.view.tag == kSliderBarTag+1 && recognizer.view.center.y <= kDeviceHeight/2.0f - 60 && translation.y < 0) {
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y);
        }else{
            if (recognizer.view.origin.y <= _maxY && translation.y < 0) {
                //
            }else{
                if (recognizer.view.origin.y >= _minimumY && translation.y < 0) {
                    //
                }else{
                    recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y + translation.y);
                }
            }
        }
    }else{
        if (recognizer.view.tag == kSliderBarTag && recognizer.view.center.x >= kDeviceWidth/2.0f - 30 && translation.x > 0) {
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y);
        }else if(recognizer.view.tag == kSliderBarTag + 1 && recognizer.view.center.x <= kDeviceWidth/2.0f + 30 && translation.x < 0){
            recognizer.view.center = CGPointMake(recognizer.view.center.x, recognizer.view.center.y);
        }else{
            recognizer.view.center = CGPointMake(recognizer.view.center.x+translation.x, recognizer.view.center.y);
        }
    }
    [recognizer setTranslation:CGPointZero inView:self];
    
    if (_delegate && [_delegate respondsToSelector:@selector(slideBarViewSliderDelegate:)]) {
        [_delegate slideBarViewSliderDelegate:recognizer];
    }
}

@end
