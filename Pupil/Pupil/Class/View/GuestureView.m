//
//  GuestureView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/9.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "GuestureView.h"
#import "CustomImageView.h"
@interface GuestureView ()
/** 注释 */
@property (nonatomic,assign) CGFloat test1;

@end
@implementation GuestureView

- (instancetype)initWithFrame:(CGRect)frame
               recognizerView:(CustomImageView *)recognizerView{
    self = [super initWithFrame:frame];
    if (self) {
        _test1 = 0;
        _recognizerView = recognizerView;
        [self addPicGesture];
    }
    return self;
}

//添加图片上的手势
- (void)addPicGesture{
    //移动
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self                                               action:@selector(picHandlePan:)];
    [self addGestureRecognizer:panGestureRecognizer];
    
    
    //添加捏合手势识别器，changeImageSize:方法实现图片的放大与缩小
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(picHandlePinch:)];
    [self addGestureRecognizer:pinchRecognizer];
    
//    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
//    [self addGestureRecognizer:rotation];

}

- (void) picHandlePinch:(UIPinchGestureRecognizer*) recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        _recognizerView.isFirstRote = YES;
        _recognizerView.zoomScale = 1;
        if (_recognizerView.width <= _recognizerView.originW && recognizer.scale < 1) {
            _recognizerView.transform = CGAffineTransformScale(_recognizerView.transform, 1, 1);

        }else{
            _recognizerView.transform = CGAffineTransformScale(_recognizerView.transform, recognizer.scale, recognizer.scale);
//            _recognizerView.zoomScale += recognizer.scale;
        }
        recognizer.scale = 1;
    }
    if (_recognizerView.origin.y > self.height/2.0f) {
        _recognizerView.frame = ccr(_recognizerView.origin.x, self.height/2.0f, _recognizerView.width,_recognizerView.height);
    }
}
- (void)picHandlePan:(UIPanGestureRecognizer*) recognizer
{
//    CustomImageView *imageView = (CustomImageView *)_recognizerView;
//    CGFloat scale = 1/*(imageView.image.size.width/2.0f)/imageView.size.width*/;
//    CGFloat surperScale = kDeviceWidth/_recognizerView.superview.width;
//    NSLog(@"scale : %f",scale);
//    NSLog(@"surperScale : %f",surperScale);
    if (recognizer.state == UIGestureRecognizerStateBegan || recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:_recognizerView];
        _recognizerView.transform = CGAffineTransformTranslate(_recognizerView.transform, translation.x, translation.y);
        [recognizer setTranslation:CGPointZero inView:recognizer.view.superview];
    }
    
}

////旋转事件
//-(void)rotationAction:(UIRotationGestureRecognizer *)rote
//{
//    //通过transform 进行旋转变换
//    _recognizerView.transform = CGAffineTransformRotate(_recognizerView.transform, rote.rotation);
//    //将旋转角度 置为 0
//    rote.rotation = 0;
//}


@end
