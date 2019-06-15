//
//  ChangeMainView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeMainViewDelegate <NSObject>

- (void)ChangeMainViewChangeRadian:(CGFloat)scale;

@end

@interface ChangeMainView : UIView

@property (nonatomic,weak) id<ChangeMainViewDelegate> delegate;

@end
