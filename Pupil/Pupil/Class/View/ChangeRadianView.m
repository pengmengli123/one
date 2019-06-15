//
//  ChangeRadianView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "ChangeRadianView.h"
#import "ChangeRadianSubView.h"
@interface ChangeRadianView ()
/** 注释 */
@property (nonatomic,assign) CGFloat leftChangeDictance;
/** 注释 */
@property (nonatomic,assign) CGFloat rightChangeDictance;
/** 注释 */
@property (nonatomic,weak) ChangeRadianSubView *firstView;
@end
@implementation ChangeRadianView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat viewW = frame.size.width * 2;
        self.clipsToBounds = YES;
        ChangeRadianSubView *firstView = [[ChangeRadianSubView alloc] initWithFrame:CGRectMake(frame.size.width/2.0f, 0, viewW, frame.size.height)];
        [self addSubview:firstView];
        _firstView = firstView;
        CGFloat x = firstView.frame.origin.x + firstView.frame.size.width + firstView.space;
        for (int i = 0; i < 10; i++) {
            ChangeRadianSubView *radianSubView = [[ChangeRadianSubView alloc] initWithFrame:CGRectMake(x, 0, viewW, frame.size.height)];
            [self addSubview:radianSubView];
            x += radianSubView.frame.size.width + radianSubView.space;
        }
        x = firstView.frame.origin.x - firstView.frame.size.width - firstView.space;
        for (int i = 0; i < 10; i++) {
            ChangeRadianSubView *radianSubView = [[ChangeRadianSubView alloc] initWithFrame:CGRectMake(x, 0, viewW, frame.size.height)];
            [self addSubview:radianSubView];
            x -= (radianSubView.frame.size.width + radianSubView.space);
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *anyTouch = [touches anyObject];
    CGPoint touchLocation = [anyTouch locationInView:self];
    _leftChangeDictance = touchLocation.x;
    _rightChangeDictance = touchLocation.x;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPoint prevLocation = [touch previousLocationInView:self];
    CGFloat distanceFromPrevious = [self distanceBetweenPoints:location prevLocation:prevLocation];
    if (distanceFromPrevious == 0) {
        _rightChangeDictance = location.x;
        CGFloat change = _leftChangeDictance - location.x;
        [self contentViewAnimation:-change/100];
    }else{
        _leftChangeDictance = location.x;
        CGFloat change = location.x - _rightChangeDictance;
        [self contentViewAnimation:change/100];
    }
}

- (void)contentViewAnimation:(CGFloat)changeDistance{
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[ChangeRadianSubView class]]) {
            CGRect rect = subView.frame;
            rect.origin.x += changeDistance;
            [UIView animateWithDuration:0.1 animations:^{
                subView.frame = rect;
            } completion:^(BOOL finished) {
                
            }];
            
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(ChangeRadianViewChangeRadian:)]) {
        [_delegate ChangeRadianViewChangeRadian:changeDistance/(_firstView.width+_firstView.space)];
    }
}

- (CGFloat)distanceBetweenPoints:(CGPoint)location prevLocation:(CGPoint)prevLocation{
    if (location.x - prevLocation.x > 0) {
        return 1;
    } else {
        return 0;
    }
    return 0;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}


@end
