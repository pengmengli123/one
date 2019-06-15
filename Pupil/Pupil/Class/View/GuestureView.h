//
//  GuestureView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/9.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomImageView;
@interface GuestureView : UIView

/** 注释 */
@property (nonatomic,strong) CustomImageView *recognizerView;

- (instancetype)initWithFrame:(CGRect)frame
               recognizerView:(CustomImageView *)recognizerView;

@end
