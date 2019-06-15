//
//  NextView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "NextView.h"
#import "HomeTopView.h"
#import "LimbView.h"
#import "SlideBarView.h"
#import "TransformPixel.h"
#import "FunctionView.h"
#import "CustomTextField.h"
#import "PupilDataView.h"
#import "DrawerView.h"
#import "ChangeMainView.h"
#import "GuestureView.h"

#define kSliderBarTag 1000
#define kPicIvSizeW SCREEN_FIT_6(600)
#define kPicIvSizeH SCREEN_FIT_6(600)
#define kXiuZhengZhi (-0.2) //修正值，测出来有误差

@interface NextView()<HomeTopViewDelegate,SlideBarViewDelegate,FunctionViewDelegate,CustomTextFieldDelegate,HomeTopViewDelegate,DrawerViewDelegate,ChangeMainViewDelegate>

/** 注释 */
@property (nonatomic,weak) UIView *bottomView;
/** 注释 */
@property (nonatomic,weak) LimbView *limbView;

/** 注释 */
@property (nonatomic,assign) SlideBarView *leftSliderBar;
/** 注释 */
@property (nonatomic,assign) SlideBarView *rightSliderBar;
/** 注释 */
//@property (nonatomic,assign) CGFloat bothSliderSapce;
/** 注释 */
@property (nonatomic,assign) CGFloat picScale;
/** 注释 */
@property (nonatomic,weak) CustomTextField *jkgTf;
/** 注释 */
@property (nonatomic,weak) PupilDataView *pupilDataView;
/** 注释 */
@property (nonatomic,assign) UIImageView *assistView;
/** 注释 */
@property (nonatomic,strong) DrawerView *drawerView;
/** 注释 */
@property (nonatomic,weak) UIImageView *leftLineIv;
/** 注释 */
@property (nonatomic,weak) UIImageView *rightLineIv;
/** 注释 */
@property (nonatomic,weak) GuestureView *guestureView;
@end

@implementation NextView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTextField:)];
//        [self addGestureRecognizer:tap];
        
        _picScale = 1.0f;
        UIView *bottomView = [[UIView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        
        UIImageView *assistView = [[UIImageView alloc] initWithFrame:ccr(0, 0, frame.size.width, 1)];
        assistView.backgroundColor = [UIColor clearColor];
        [self addSubview:assistView];
        _assistView = assistView;
        
        CustomImageView *picIv = [[CustomImageView alloc] initWithFrame:ccr((_bottomView.size.width - kDeviceHeight)/2.0f, (_bottomView.size.height - kDeviceHeight)/2.0f, kDeviceHeight, kDeviceHeight)];
        [_bottomView addSubview:picIv];
        _picIv = picIv;
        
        GuestureView *guestureView = [[GuestureView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height) recognizerView:_picIv];
        [self addSubview:guestureView];
        _guestureView = guestureView;
        
        CGFloat SliderBarH = SCREEN_FIT_6(76)*1.2;
        CGFloat SliderBarW = SCREEN_FIT_6(48)*1.2;
        UIImageView *leftLineIv = [[UIImageView alloc] initWithFrame:ccr(frame.size.width/2.0f - SliderBarW - SCREEN_FIT_6(20), 0, 1.0f, kDeviceHeight - SCREEN_FIT_6(120) - SliderBarH)];
        leftLineIv.image = [UIImage imageNamed:@"h_slider_red_line"];
        [self addSubview:leftLineIv];
        _leftLineIv = leftLineIv;
        
        UIImage *image = [UIImage imageNamed:@"h_slider_red_bg"];
        SlideBarView *leftSliderBar = [[SlideBarView alloc] initWithFrame:ccr(leftLineIv.center.x - SliderBarW/2.0f,leftLineIv.bottom , SliderBarW, SliderBarH) image:image limbDirection:TransversalType];
        leftSliderBar.tag = kSliderBarTag;
        leftSliderBar.delegate = self;
//        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, SCREEN_FIT_6(78), 0);
//        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        leftSliderBar.image = image;
        [self addSubview:leftSliderBar];
        _leftSliderBar = leftSliderBar;
        
        UIImageView *rightLineIv = [[UIImageView alloc] initWithFrame:ccr(frame.size.width/2.0f + SliderBarW + SCREEN_FIT_6(20), 0, 1.0, kDeviceHeight - SCREEN_FIT_6(120) - SliderBarH)];
        rightLineIv.image = [UIImage imageNamed:@"h_slider_red_line"];
        [self addSubview:rightLineIv];
        _rightLineIv = rightLineIv;

//        SlideBarView *rightSliderBar = [[SlideBarView alloc] initWithFrame:ccr(frame.size.width/2.0f + SCREEN_FIT_6(48) + SCREEN_FIT_6(20), 0, SCREEN_FIT_6(48), kDeviceHeight - SCREEN_FIT_6(120)) image:image limbDirection:TransversalType];
        SlideBarView *rightSliderBar = [[SlideBarView alloc] initWithFrame:ccr(rightLineIv.center.x - SliderBarW/2.0f, rightLineIv.bottom, SliderBarW, SliderBarH) image:image limbDirection:TransversalType];
        rightSliderBar.tag = kSliderBarTag + 1;
        rightSliderBar.delegate = self;
        rightSliderBar.image = image;
        [self addSubview:rightSliderBar];
        _rightSliderBar = rightSliderBar;
        
        HomeTopView *topView = [[HomeTopView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, SCREEN_FIT_6(120))];
        topView.delegate = self;
        [topView hideSubView];
        [self addSubview:topView];
        
        LimbView *limbView = [[LimbView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, kLineTall + SCREEN_FIT_6(75))];
        limbView.backgroundColor = [UIColor clearColor];
        [limbView setLimbValue:100 limbDirection:TransversalType];
        [bottomView addSubview:limbView];
        _limbView = limbView;
        
        FunctionView *functionView = [[FunctionView alloc] initWithFrame:ccr(frame.size.width - SCREEN_FIT_6(116), topView.bottom + SCREEN_FIT_6(20), SCREEN_FIT_6(116), SCREEN_FIT_6(116)*4)];
        functionView.delegate = self;
        [self addSubview:functionView];
        
        PupilDataView *pupilDataView = [[PupilDataView alloc] initWithFrame:ccr(functionView.left - 4*kDataViewW - 3*kDataViewHSpace - SCREEN_FIT_6(40), frame.size.height - SCREEN_FIT_6(90) - 5*kDataViewH - 4*kDataViewVSpace, 4*kDataViewW + 3*kDataViewHSpace, 5*kDataViewH + 4*kDataViewVSpace)];
        [self addSubview:pupilDataView];
        _pupilDataView = pupilDataView;
        
        CGFloat wenZiH = 50;
        UIFont *font = HW_TWENTY_FIVE_FONT_6;
        UILabel *jkgLb = [[UILabel alloc] initWithFrame:ccr(functionView.left - SCREEN_FIT_6(6*wenZiH-30) - SCREEN_FIT_6(105), pupilDataView.top - SCREEN_FIT_6(wenZiH)-SCREEN_FIT_6(50), SCREEN_FIT_6(6*wenZiH-30), SCREEN_FIT_6(wenZiH))];
        jkgLb.text = @"镜框宽(mm):";
        jkgLb.textColor = UIColorFromRGB(0x313131);
        jkgLb.font = font;
        [self addSubview:jkgLb];
        
        CustomTextField *jkgTf = [[CustomTextField alloc] initWithFrame:ccr(jkgLb.right, jkgLb.center.y - SCREEN_FIT_6(wenZiH)/2.0f, SCREEN_FIT_6(105), SCREEN_FIT_6(wenZiH))];
        jkgTf.textColor = UIColorFromRGB(0xe83e3f);
        jkgTf.font = font;
        jkgTf.keyboardType = UIKeyboardTypeDecimalPad;
        jkgTf.tDelegate = self;
        jkgTf.placeholder = @"100";
        [self addSubview:jkgTf];
        _jkgTf = jkgTf;
        
        ChangeMainView *changeMainView = [[ChangeMainView alloc] initWithFrame:ccr((frame.size.width - 200)/2.0f, frame.size.height - 10 - 35.7, 200, 35.7)];
        changeMainView.delegate = self;
        [self addSubview:changeMainView];
    }
    return self;
}

- (void)cancelTextField:(id)sender{
    [_jkgTf resignFirstResponder];
}

- (DrawerView *)drawerView{
    if (!_drawerView) {
        _drawerView = [[DrawerView alloc] initWithFrame:ccr(0, 0, self.width, self.height)];
        _drawerView.hidden = YES;
        _drawerView.delegate = self;
        [self addSubview:_drawerView];
    }
    return _drawerView;
}

- (void)drawerViewShowOrHide{
    [self.drawerView drawerViewShowOrHide];
}

#pragma mark - DrawerViewDelegate
- (void)DrawerViewOpenPhotosAlbumDelegate{
    if (_delegate && [_delegate respondsToSelector:@selector(NextViewOpenPhotos)]) {
        [_delegate NextViewOpenPhotos];
    }
}

#pragma mark - HomeTopViewDelegate
- (void)HomeTopViewShowOrHideDrawerView{
    [self drawerViewShowOrHide];
}
- (void)HomeTopViewChangeView{
    if (_delegate && [_delegate respondsToSelector:@selector(NextViewChangeView)]) {
        [_delegate NextViewChangeView];
    }
}

- (void)HomeTopViewscreenView{
    UIImage *scurrentImage = [self captureCurrentView:self];
    UIImageWriteToSavedPhotosAlbum(scurrentImage, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"保存成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"保存失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alertView show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        });
    }
}
- (void)recoverNextViewTransform{
    _bottomView.transform = CGAffineTransformIdentity;
    _picIv.transform = CGAffineTransformIdentity;
    _bottomView.frame = ccr(_bottomView.origin.x, _bottomView.origin.y, _bottomView.width, _bottomView.height);
    
    CGPoint assistViewConvertPoint = [self convertPoint:_assistView.center toView:_bottomView];
    _limbView.frame = ccr(_limbView.origin.x,assistViewConvertPoint.y, _limbView.width, _limbView.height);
    _jkgTf.text = @"";
}

#pragma mark - FunctionViewDelegate
- (void)FunctionViewLockOrUnlockPic:(BOOL)isLock{
    _guestureView.userInteractionEnabled = isLock;
}
- (void)FunctionViewCamera:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(NextViewCamera:)]) {
        [_delegate NextViewCamera:btn];
    }
}
- (void)FunctionViewAmplifyPic:(id)sender{
    _picScale += 0.1;
    _bottomView.transform = CGAffineTransformMakeScale(_picScale, _picScale);
    CGPoint assistViewConvertPoint = [self convertPoint:_assistView.center toView:_bottomView];
    _limbView.frame = ccr(_limbView.origin.x,assistViewConvertPoint.y, _limbView.width, _limbView.height);
}
- (void)FunctionViewShrinkPic:(id)sender{
    _picScale -= 0.1;
    _bottomView.transform = CGAffineTransformMakeScale(_picScale, _picScale);
    CGPoint assistViewConvertPoint = [self convertPoint:_assistView.center toView:_bottomView];
    _limbView.frame = ccr(_limbView.origin.x,assistViewConvertPoint.y, _limbView.width, _limbView.height);
}

- (void)CustomTextFieldFinishClick{
    if (_jkgTf.text.length == 0 || [_jkgTf.text hasPrefix:@"."]) {
        [_jkgTf resignFirstResponder];
        return;
    }
    if ([_jkgTf.text floatValue] > 500 || [_jkgTf.text floatValue] < 100) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"镜框宽度设置范围为100mm-500mm" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    [_jkgTf resignFirstResponder];
    CGFloat mm = [_jkgTf.text floatValue];
    _picIv.isFirstRote = YES;
    _picIv.zoomScale = 1;
    
    [_limbView setLimbValue:mm limbDirection:TransversalType];
    CGPoint leftSliderConvertPoint = [self convertPoint:_leftSliderBar.center toView:_bottomView];
    CGPoint rightSliderConvertPoint = [self convertPoint:_rightLineIv.center toView:_bottomView];
    CGFloat leftAndPicXSpace =  leftSliderConvertPoint.x - _picIv.origin.x;
    CGFloat picIvChangeW = (_limbView.limbH/(rightSliderConvertPoint.x - leftSliderConvertPoint.x)) * _picIv.width;//图片放大的高度
    CGFloat scale = picIvChangeW/_picIv.width;
    CGFloat originW = _picIv.width;
    CGFloat limbViewAndPicIvSpace = _limbView.originalX - _picIv.origin.x;
    
    CGFloat rotateScale = 1;
    if (_picIv.transform.a >= 1) {
        rotateScale = 1;
    }else{
        rotateScale = sin(asin(_picIv.transform.a));
    }
    _picIv.transform = CGAffineTransformScale(_picIv.transform, scale, scale);
    CGFloat testScale = sqrt(_picIv.height * _picIv.height  + _picIv.width*_picIv.width)/sqrt(_picIv.originW*_picIv.originW + _picIv.originH*_picIv.originH);
    _picIv.transform = CGAffineTransformTranslate(_picIv.transform,(((_picIv.width - originW)/2.0f + limbViewAndPicIvSpace)/testScale)/rotateScale,0);
    _picIv.transform = CGAffineTransformTranslate(_picIv.transform,-(leftAndPicXSpace*scale/testScale)/rotateScale,0);
}

- (UIImage *)captureCurrentView:(UIView *)view {
    CGRect frame = view.frame;
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:contextRef];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark  - SlideBarViewDelegate
- (void)slideBarViewSliderDelegate:(UIPanGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.view.tag == kSliderBarTag) {
        _leftLineIv.center = CGPointMake(_leftSliderBar.center.x, _leftLineIv.center.y);
    }else{
        _rightLineIv.center = CGPointMake(_rightSliderBar.center.x, _rightLineIv.center.y);
    }
    
    CGPoint leftSliderConvertPoint = [self convertPoint:_leftSliderBar.center toView:_bottomView];
    CGPoint rightSliderConvertPoint = [self convertPoint:_rightSliderBar.center toView:_bottomView];
    
    CGFloat leftSAndPCenterSpace = _limbView.center.x - leftSliderConvertPoint.x;
    CGFloat rightSAndPCenterSpace =  rightSliderConvertPoint.x - _limbView.center.x;
    [_pupilDataView updataPupilDataViewData:[TransformPixel pixelTransformMM:rightSAndPCenterSpace]+kXiuZhengZhi youYanData:[TransformPixel pixelTransformMM:leftSAndPCenterSpace]+kXiuZhengZhi];
    
//    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
//        _bothSliderSapce = (_rightSliderBar.center.y - _leftSliderBar.center.y) * [TransformPixel pixelTransformMM:1];
//    }
}

#pragma mark - ChangeMainViewDelegate
- (void)ChangeMainViewChangeRadian:(CGFloat)scale{
    if (_picIv.isFirstRote) {
        _picIv.zoomScale = _picIv.width/_picIv.originW;
        _picIv.isFirstRote = NO;
    }

    _picIv.transform = CGAffineTransformRotate(_picIv.transform, 2*M_PI*scale);
    _picIv.originW = _picIv.width/_picIv.zoomScale;
    _picIv.originH = _picIv.height/_picIv.zoomScale;
}
@end
