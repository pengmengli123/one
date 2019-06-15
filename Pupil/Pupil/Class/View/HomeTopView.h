//
//  HomeTopView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTextField;

@protocol HomeTopViewDelegate <NSObject>

- (void)HomeTopViewImportMillimeter:(CGFloat)mm;
- (void)HomeTopViewShowOrHideDrawerView;

- (void)HomeTopViewChangeView;
- (void)HomeTopViewscreenView;
- (void)homeTopViewCeShi;


@end

@interface HomeTopView : UIView

- (void)hideSubView;


@property (nonatomic,weak) id<HomeTopViewDelegate> delegate;

- (void)updataTgNumLbText:(CGFloat)tgNum;

- (void)cancelTextFiled;

- (void)setUpCeshiBtnText:(BOOL)textBool;

- (void)removeTfText;

@end
