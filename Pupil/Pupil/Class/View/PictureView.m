//
//  PictureView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "PictureView.h"
#import "LimbView.h"
#import "SlideBarView.h"
#import "TransformPixel.h"
#import "HomeTopView.h"
#import "FunctionView.h"
#import "DrawerView.h"
#import "ChangeMainView.h"
#import "GuestureView.h"
#import "PicPupilDataView.h"

#define kPicIvSizeW SCREEN_FIT_6(600)
#define kPicIvSizeH SCREEN_FIT_6(600)

@interface PictureView()<SlideBarViewDelegate,HomeTopViewDelegate,FunctionViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,DrawerViewDelegate,ChangeMainViewDelegate>
/** 移动缩放后图片的中心 */
//@property (nonatomic,assign) CGPoint centerPoint;
/** 最后一次旋转角度 */
//@property (nonatomic,assign) CGFloat lastRotation;
/** 注释 */
@property (nonatomic,assign) SlideBarView *topSliderBar;
/** 注释 */
@property (nonatomic,assign) SlideBarView *blowSliderBar;
/** 注释 */
//@property (nonatomic,assign) CGFloat bothSliderSapce;
/** 注释 */
@property (nonatomic,weak) LimbView *limbView;
/** 注释 */
@property (nonatomic,assign) CGFloat picScale;
/** 注释 */
@property (nonatomic,weak) UIView *bottomView;
/** 注释 */
@property (nonatomic,assign) UIImageView *assistView;
/** 注释 */
@property (nonatomic,strong) UIDatePicker *clockDatePicker;
/** 注释 */
@property (nonatomic,strong) UIAlertView *alertView;
/** 注释 */
@property (nonatomic,strong) DrawerView *drawerView;
/** 注释 */
@property (nonatomic,weak) HomeTopView *topView;
/** 注释 */
@property (nonatomic,weak) UIImageView *topLineIv;
/** 注释 */
@property (nonatomic,weak) UIImageView *blowLineIv;
/** 注释 */
@property (nonatomic,weak) GuestureView *guestureView;
/** 注释 */
@property (nonatomic,weak) PicPupilDataView *pupilDataView;
/** 注释 */



@end

@implementation PictureView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelTextField:)];
//        [self addGestureRecognizer:tap];
        
        _picScale = 1;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_ruler"]];
        UIView *bottomView = [[UIView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:bottomView];
        _bottomView = bottomView;
        UIImageView *assistView = [[UIImageView alloc] initWithFrame:ccr(0, 0, 1, kDeviceHeight)];
        assistView.backgroundColor = [UIColor clearColor];
        [self addSubview:assistView];
        _assistView = assistView;
        
        CustomImageView *picIv = [[CustomImageView alloc] initWithFrame:ccr((bottomView.width - kDeviceHeight)/2.0f, (bottomView.height - kDeviceHeight)/2.0f, kDeviceHeight, kDeviceHeight)];
        [bottomView addSubview:picIv];
        _picIv = picIv;
        
        GuestureView *guestureView = [[GuestureView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height) recognizerView:_picIv];
        [self addSubview:guestureView];
        _guestureView = guestureView;
        
//        CustomIv *picIv = [[CustomIv alloc] initWithFrame:ccr(0, 0, bottomView.width,bottomView.height)];
//        [bottomView addSubview:picIv];
//        _picIv = picIv;
        
        ChangeMainView *changeMainView = [[ChangeMainView alloc] initWithFrame:ccr((frame.size.width - 200)/2.0f, frame.size.height - 10 - 37.5, 200, 37.5)];
        changeMainView.delegate = self;
        [self addSubview:changeMainView];
        
        LimbView *limbView = [[LimbView alloc] initWithFrame:ccr(0, 0, kLineTall + SCREEN_FIT_6(75), bottomView.size.height)];
        limbView.backgroundColor = [UIColor clearColor];
        [limbView setLimbValue:40 limbDirection:VerticalType];
        [bottomView addSubview:limbView];
        _limbView = limbView;
        
        CGFloat SliderBarW = SCREEN_FIT_6(76)*1.2;
        CGFloat SliderBarH = SCREEN_FIT_6(48)*1.2;
        UIImageView *topLineIv = [[UIImageView alloc] initWithFrame:ccr(0, frame.size.height/2.0f - SliderBarH - SCREEN_FIT_6(20), kDeviceWidth - SCREEN_FIT_6(200) - SliderBarW, 1.0f)];
        topLineIv.image = [UIImage imageNamed:@"v_slider_red_line"];
        [self addSubview:topLineIv];
        _topLineIv = topLineIv;
        
        UIImage *image = [UIImage imageNamed:@"v_slider_red_bg"];
        SlideBarView *topSliderBar = [[SlideBarView alloc] initWithFrame:ccr(topLineIv.right, topLineIv.center.y - SliderBarH/2.0f, SliderBarW, SliderBarH) image:image limbDirection:VerticalType];
        topSliderBar.tag = kSliderBarTag;
        topSliderBar.delegate = self;
//        UIEdgeInsets edgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREEN_FIT_6(78));
//        UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets];
        topSliderBar.image = image;
        topSliderBar.maxY = SCREEN_FIT_6(120);
        topSliderBar.minimumY = frame.size.height - SliderBarH;
        [self addSubview:topSliderBar];
        _topSliderBar = topSliderBar;
        
        UIImageView *blowLineIv = [[UIImageView alloc] initWithFrame:ccr(0, frame.size.height/2.0f + SliderBarH + SCREEN_FIT_6(20), kDeviceWidth - SCREEN_FIT_6(200) - SliderBarW, 1.0f)];
        blowLineIv.image = [UIImage imageNamed:@"v_slider_yellow_line"];
        [self addSubview:blowLineIv];
        _blowLineIv = blowLineIv;
        
        image = [UIImage imageNamed:@"v_slider_yellow_bg"];
//        SlideBarView *blowSliderBar = [[SlideBarView alloc] initWithFrame:ccr(0, frame.size.height/2.0f + SCREEN_FIT_6(48) + SCREEN_FIT_6(20), kDeviceWidth - SCREEN_FIT_6(200), SCREEN_FIT_6(48)) image:image limbDirection:VerticalType];
        SlideBarView *blowSliderBar = [[SlideBarView alloc] initWithFrame:ccr(blowLineIv.right, blowLineIv.center.y - SliderBarH/2.0f, SliderBarW, SliderBarH) image:image limbDirection:VerticalType];
        blowSliderBar.tag = kSliderBarTag + 1;
        blowSliderBar.delegate = self;
//        edgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREEN_FIT_6(78));
//        newImage = [image resizableImageWithCapInsets:edgeInsets];
        blowSliderBar.minimumY = frame.size.height - SliderBarH;
        blowSliderBar.image = image;
        
        [self addSubview:blowSliderBar];
        _blowSliderBar = blowSliderBar;
//        _bothSliderSapce = (_blowSliderBar.center.y - _topSliderBar.center.y) * [TransformPixel pixelTransformMM:1];
        
        HomeTopView *topView = [[HomeTopView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, SCREEN_FIT_6(120))];
        topView.delegate = self;
        [self addSubview:topView];
        _topView = topView;
        
        FunctionView *functionView = [[FunctionView alloc] initWithFrame:ccr(frame.size.width - SCREEN_FIT_6(116), topView.bottom + SCREEN_FIT_6(20), SCREEN_FIT_6(116), SCREEN_FIT_6(116)*4)];
        functionView.delegate = self;
        [self addSubview:functionView];
        
        PicPupilDataView *pupilDataView = [[PicPupilDataView alloc] initWithFrame:ccr(functionView.left - SCREEN_FIT_6(20) - (3*kPDLbW+2*kPDLbHSpace), topView.bottom + SCREEN_FIT_6(40), 3*kPDLbW+2*kPDLbHSpace, 2*kPDLbH+kPDLbVSpace)];
        [self addSubview:pupilDataView];
        _pupilDataView = pupilDataView;
        
        UILabel *leftLb = [[UILabel alloc] initWithFrame:ccr(_picIv.left - SCREEN_FIT_6(140), _topView.bottom + SCREEN_FIT_6(100), SCREEN_FIT_6(140), SCREEN_FIT_6(50))];
        leftLb.textColor = UIColorFromRGB(0xe83e3f);
        leftLb.font = HW_THIRTY_FONT_6;
        leftLb.text = @"右眼";
        [self addSubview:leftLb];
        
        UILabel *rightLb = [[UILabel alloc] initWithFrame:ccr(_picIv.right + SCREEN_FIT_6(0), _topView.bottom + SCREEN_FIT_6(100), SCREEN_FIT_6(140), SCREEN_FIT_6(50))];
        rightLb.textColor = UIColorFromRGB(0xe83e3f);
        rightLb.font = HW_THIRTY_FONT_6;
        rightLb.text = @"左眼";
        [self addSubview:rightLb];
    }
    return self;
}

- (void)cancelTextField:(id)sender{
    [_topView cancelTextFiled];
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
    if (_delegate && [_delegate respondsToSelector:@selector(PictureViewOpenPhotos)]) {
        [_delegate PictureViewOpenPhotos];
    }
}
#pragma mark SlideBarViewDelegate
- (void)slideBarViewSliderDelegate:(UIPanGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.view.tag == kSliderBarTag) {
        _topLineIv.center = CGPointMake(_topLineIv.center.x, _topSliderBar.center.y);
    }else{
        _blowLineIv.center = CGPointMake(_topLineIv.center.x, _blowSliderBar.center.y);
    }
    //求放大的比例
    [_topView updataTgNumLbText:[TransformPixel pixelTransformMM:_limbView.height-_limbView.originalY - _topSliderBar.center.y]/_picScale];
}
#pragma mark - HomeTopViewDelegate
- (void)HomeTopViewShowOrHideDrawerView{
    [self drawerViewShowOrHide];
}

- (void)HomeTopViewImportMillimeter:(CGFloat)mm{
//    _picIv.transform = CGAffineTransformIdentity;
    _picIv.isFirstRote = YES;
    _picIv.zoomScale = 1;
    [_limbView setLimbValue:mm limbDirection:VerticalType];
    CGPoint topSliderConvertPoint = [self convertPoint:_topSliderBar.center toView:_bottomView];
    CGPoint blowSliderConvertPoint = [self convertPoint:_blowSliderBar.center toView:_bottomView];
    CGFloat topAndPicYSpace =  topSliderConvertPoint.y - _picIv.origin.y;
    CGFloat picIvChangeH = (_limbView.limbH/(blowSliderConvertPoint.y - topSliderConvertPoint.y)) * _picIv.height;//图片放大的高度
    CGFloat scale = picIvChangeH/_picIv.height;
    CGFloat originH = _picIv.height;
    CGFloat limbViewAndPicIvSpace = _limbView.originalY - _picIv.origin.y;
    
    CGFloat rotateScale = 1;
    if (_picIv.transform.a >= 1) {
        rotateScale = 1;
    }else{
        rotateScale = fabsf(cos(acosf(_picIv.transform.a)));
    }
    NSLog(@"%f",rotateScale);
    _picIv.transform = CGAffineTransformScale(_picIv.transform, scale, scale);
    CGFloat zoomScale = sqrt(_picIv.height * _picIv.height  + _picIv.width*_picIv.width)/sqrt(_picIv.originW*_picIv.originW + _picIv.originH*_picIv.originH);
    _picIv.transform = CGAffineTransformTranslate(_picIv.transform,0,((((_picIv.height - originH)/2.0f + limbViewAndPicIvSpace)/zoomScale)/rotateScale));
    _picIv.transform = CGAffineTransformTranslate(_picIv.transform,0,-(topAndPicYSpace*scale/zoomScale)/rotateScale);
}

- (void)HomeTopViewChangeView{
    if (_delegate && [_delegate respondsToSelector:@selector(PictureViewChangeView)]) {
        [_delegate PictureViewChangeView];
    }
}

- (void)HomeTopViewscreenView{
    UIImage *scurrentImage = [self captureCurrentView:self];
    UIImageWriteToSavedPhotosAlbum(scurrentImage, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

- (void)homeTopViewCeShi{
    [_topView setUpCeshiBtnText:_pupilDataView.clickNum != 2];
    [_pupilDataView updataSubViewData:[TransformPixel pixelTransformMM:_limbView.height-_limbView.originalY - _topSliderBar.center.y]/_picScale];
    
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

#pragma mark - FunctionViewDelegate
- (void)FunctionViewLockOrUnlockPic:(BOOL)isLock{
    _guestureView.userInteractionEnabled = isLock;
}
- (void)FunctionViewCamera:(id)sender{
    UIButton *btn = (UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(PictureViewCamera:)]) {
        [_delegate PictureViewCamera:btn];
    }
}
- (void)FunctionViewAmplifyPic:(id)sender{
    _picScale += 0.1;
    _bottomView.transform = CGAffineTransformMakeScale(_picScale, _picScale);
    CGPoint assistViewConvertPoint = [self convertPoint:_assistView.center toView:_bottomView];
    _limbView.frame = ccr(assistViewConvertPoint.x, _limbView.origin.y, _limbView.width, _limbView.height);
    [_limbView updataParams:_picScale];
}
- (void)FunctionViewShrinkPic:(id)sender{
    if (_picScale == 1) {
        return;
    }
    _picScale -= 0.1;
    _bottomView.transform = CGAffineTransformMakeScale(_picScale, _picScale);
    _bottomView.frame = ccr(_bottomView.origin.x, _bottomView.origin.y, _bottomView.width, _bottomView.height);
    CGPoint assistViewConvertPoint = [self convertPoint:_assistView.center toView:_bottomView];
    _limbView.frame = ccr(assistViewConvertPoint.x, _limbView.origin.y, _limbView.width, _limbView.height);
     [_limbView updataParams:_picScale];
}

- (void)recoverPicViewTransform{
    _bottomView.transform = CGAffineTransformIdentity;
    _picIv.transform = CGAffineTransformIdentity;
    _bottomView.frame = ccr(_bottomView.origin.x, _bottomView.origin.y, _bottomView.width, _bottomView.height);

    CGPoint assistViewConvertPoint = [self convertPoint:_assistView.center toView:_bottomView];
    _limbView.frame = ccr(assistViewConvertPoint.x, _limbView.origin.y, _limbView.width, _limbView.height);
    [_limbView updataParams:_picScale];
    [_topView removeTfText];

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
