//
//  HomeTopView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "HomeTopView.h"
#import "CustomTextField.h"

@interface HomeTopView()<CustomTextFieldDelegate>
/** 注释 */
@property (nonatomic,weak) UILabel *jkgLb;
/** 注释 */
@property (nonatomic,weak) CustomTextField *jkgTf;

/** 注释 */
@property (nonatomic,weak) UILabel *tgLb;
/** 注释 */
@property (nonatomic,weak) UILabel *tgNumLb;
/** 注释 */
@property (nonatomic,weak) UIButton *ceshiBtn;
@end

@implementation HomeTopView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *homeIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        homeIconBtn.frame = ccr(SCREEN_FIT_6(20), frame.size.height - SCREEN_FIT_6(96), SCREEN_FIT_6(96), SCREEN_FIT_6(96));
        [homeIconBtn setImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
        [homeIconBtn addTarget:self action:@selector(showDrawerView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:homeIconBtn];
        
        CGFloat wenZiH = 50;
        UIFont *font = HW_TWENTY_FIVE_FONT_6;
        UILabel *jkgLb = [[UILabel alloc] initWithFrame:ccr(homeIconBtn.right + SCREEN_FIT_6(30), homeIconBtn.center.y - SCREEN_FIT_6(wenZiH)/2.0f, SCREEN_FIT_6(6*wenZiH-30), SCREEN_FIT_6(wenZiH))];
        jkgLb.text = @"镜框高(mm):";
        jkgLb.textColor = UIColorFromRGB(0x313131);
        jkgLb.font = font;
        [self addSubview:jkgLb];
        _jkgLb = jkgLb;
        
        CustomTextField *jkgTf = [[CustomTextField alloc] initWithFrame:ccr(jkgLb.right, homeIconBtn.center.y - SCREEN_FIT_6(wenZiH)/2.0f, SCREEN_FIT_6(105), SCREEN_FIT_6(wenZiH))];
        jkgTf.textColor = UIColorFromRGB(0xe83e3f);
        jkgTf.font = font;
        jkgTf.keyboardType = UIKeyboardTypeDecimalPad;
        jkgTf.placeholder = @"40";
        jkgTf.tDelegate = self;
        [self addSubview:jkgTf];
        _jkgTf = jkgTf;
        
        UILabel *tgLb = [[UILabel alloc] initWithFrame:ccr(jkgTf.right + SCREEN_FIT_6(10), homeIconBtn.center.y - SCREEN_FIT_6(wenZiH)/2.0f, SCREEN_FIT_6(5*wenZiH-20), SCREEN_FIT_6(wenZiH))];
        tgLb.textColor = UIColorFromRGB(0x313131);
        tgLb.font = font;
        tgLb.text = @"瞳高(mm):";
        [self addSubview:tgLb];
        _tgLb = tgLb;
        
        UILabel *tgNumLb = [[UILabel alloc] initWithFrame:ccr(tgLb.right, homeIconBtn.center.y - SCREEN_FIT_6(wenZiH)/2.0f, SCREEN_FIT_6(5*wenZiH), SCREEN_FIT_6(wenZiH))];
        tgNumLb.textColor = UIColorFromRGB(0xe83e3f);
        tgNumLb.font = font;
        tgNumLb.text = @"0.00mm";
        [self addSubview:tgNumLb];
        _tgNumLb = tgNumLb;
        
        UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        changeBtn.frame = ccr(kDeviceWidth - SCREEN_FIT_6(20) - SCREEN_FIT_6(72), homeIconBtn.center.y - SCREEN_FIT_6(72)/2.0f, SCREEN_FIT_6(72), SCREEN_FIT_6(72));
        [changeBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
        [changeBtn setImage:[UIImage imageNamed:@"switch_use"] forState:UIControlStateNormal];
        [self addSubview:changeBtn];

        
        UIButton *screenshotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        screenshotBtn.frame = ccr(changeBtn.left - SCREEN_FIT_6(20) - SCREEN_FIT_6(96),  homeIconBtn.center.y - SCREEN_FIT_6(96)/2.0f, SCREEN_FIT_6(96), SCREEN_FIT_6(96));
        [screenshotBtn addTarget:self action:@selector(screenView:) forControlEvents:UIControlEventTouchUpInside];
        [screenshotBtn setImage:[UIImage imageNamed:@"shot_screen"] forState:UIControlStateNormal];
        [self addSubview:screenshotBtn];
        
        UIButton *ceshiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        ceshiBtn.backgroundColor = [UIColor whiteColor];
        ceshiBtn.frame = ccr(screenshotBtn.left - SCREEN_FIT_6(20) - SCREEN_FIT_6(100), homeIconBtn.center.y - SCREEN_FIT_6(50)/2.0f, SCREEN_FIT_6(100), SCREEN_FIT_6(50));
        ceshiBtn.titleLabel.font = HW_TWENTY_FIVE_FONT_6;
        [ceshiBtn setTitleColor:UIColorFromRGB(0x313131) forState:UIControlStateNormal];
        [ceshiBtn setTitle:@"保存" forState:UIControlStateNormal];
        [ceshiBtn addTarget:self action:@selector(ceshi:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:ceshiBtn];
        _ceshiBtn = ceshiBtn;
    }
    return self;
}

- (void)setUpCeshiBtnText:(BOOL)textBool{
    if (textBool) {
        [_ceshiBtn setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        [_ceshiBtn setTitle:@"重测" forState:UIControlStateNormal];
    }
}

- (void)hideSubView{
    self.jkgLb.hidden = YES;;
    self.jkgTf.hidden = YES;
    self.tgLb.hidden = YES;;
    self.tgNumLb.hidden = YES;
    self.ceshiBtn.hidden = YES;
}

- (void)showDrawerView:(id)sender{
    UIButton *btn = (UIButton *)sender;
    btn.selected = !btn.isSelected;
    if (_delegate && [_delegate respondsToSelector:@selector(HomeTopViewShowOrHideDrawerView)]) {
        [_delegate HomeTopViewShowOrHideDrawerView];
    }
}

- (void)CustomTextFieldFinishClick{
    if (_jkgTf.text.length == 0 || [_jkgTf.text hasPrefix:@"."]) {
        [_jkgTf resignFirstResponder];
        return;
    }
    if ([_jkgTf.text floatValue] > 100 || [_jkgTf.text floatValue] < 20) {
        UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:nil message:@"镜框高度设置范围为20mm-100mm" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alterView show];
        return;
    }
    [_jkgTf resignFirstResponder];
    if (_delegate && [_delegate respondsToSelector:@selector(HomeTopViewImportMillimeter:)]) {
        [_delegate HomeTopViewImportMillimeter:[_jkgTf.text floatValue]];
    }
}

- (void)cancelTextFiled{
    [_jkgTf resignFirstResponder];
}

- (void)changeView:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(HomeTopViewChangeView)]) {
        [_delegate HomeTopViewChangeView];
    }
}

- (void)screenView:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(HomeTopViewscreenView)]) {
        [_delegate HomeTopViewscreenView];
    }
}

- (void)updataTgNumLbText:(CGFloat)tgNum{
    _tgNumLb.text = [NSString stringWithFormat:@"%.2fmm",tgNum];
}

- (void)ceshi:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(homeTopViewCeShi)]) {
        [_delegate homeTopViewCeShi] ;
    }
}

- (void)removeTfText{
    _jkgTf.text = @"";
}

@end
