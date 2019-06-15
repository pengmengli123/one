//
//  FunctionView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/1.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FunctionViewDelegate <NSObject>
- (void)FunctionViewLockOrUnlockPic:(BOOL)isLock;
- (void)FunctionViewCamera:(id)sender;
- (void)FunctionViewAmplifyPic:(id)sender;
- (void)FunctionViewShrinkPic:(id)sender;
@end

@interface FunctionView : UIView

@property (nonatomic,weak) id<FunctionViewDelegate> delegate;

@end
