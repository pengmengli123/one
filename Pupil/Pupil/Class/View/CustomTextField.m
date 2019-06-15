//
//  CustomTextField.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/28.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "CustomTextField.h"

@interface CustomTextField()<UITextFieldDelegate>
/** 注释 */
@property (nonatomic,weak) UILabel *textLb;
/** 注释 */
@property (nonatomic,weak) UIImageView *flickerIv;
@end

@implementation CustomTextField

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 30)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"确定" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        button.frame = CGRectMake(0, 0, 40, 40);
        [button addTarget:self action:@selector(finishClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *sureItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        UILabel *textLb = [[UILabel alloc] initWithFrame:ccr(0, 0, 100, 30)];
        textLb.font = HW_SEVENTEEN_FONT_6;
        textLb.textColor = [UIColor blackColor];
        _textLb = textLb;
        UIBarButtonItem *textItem = [[UIBarButtonItem alloc] initWithCustomView:textLb];
        [textItem setWidth:kDeviceWidth-40-30];
        tool.items =@[textItem,sureItem];
        self.inputAccessoryView =tool;
        
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIImageView *flickerIv = [[UIImageView alloc] initWithFrame:ccr(0, 0, 2.0f, self.height)];
//        flickerIv.backgroundColor = [UIColor blueColor];
        [self addSubview:flickerIv];
        _flickerIv = flickerIv;
        [self addAnimation];
    }
    return self;
}

- (void)addAnimation{
    CGFloat duration = 1.0f;
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    animation.duration = duration;
    animation.values = @[[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:0.0]];
    animation.keyTimes = @[ @(0),@(1.0)];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VALF;
    [_flickerIv.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
}


- (void)finishClick:(id)sender{
    if (_tDelegate && [_tDelegate respondsToSelector:@selector(CustomTextFieldFinishClick)]) {
        [_tDelegate CustomTextFieldFinishClick];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    _flickerIv.hidden = YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _flickerIv.hidden = NO;
}

- (void)textFieldDidChange:(id)sender{
    _textLb.text = self.text;
    CGSize size = [self sizeOfmyText:self.text font:self.font width:MAXFLOAT lineSpacing:0];
    _flickerIv.frame = ccr(size.width, 0, 2, self.height);
}

#pragma mark - labelSize

-(CGSize)sizeOfmyText:(NSString *)text font:(UIFont*)myfont width:(CGFloat)mywidth lineSpacing:(CGFloat)lineSpacing
{
    if([text isEqual:[NSNull null]] || text==nil || [text isEqualToString:@""])
        return CGSizeMake(0.0f, 0.0f);
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    if (lineSpacing > 0) {
        paragraphStyle.lineSpacing = lineSpacing;
    }
    NSDictionary *attributes = @{NSFontAttributeName:myfont, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelsize = [text boundingRectWithSize:CGSizeMake(mywidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelsize;
}


@end
