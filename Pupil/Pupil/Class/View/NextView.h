//
//  NextView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImageView.h"

@protocol NextViewDelegate <NSObject>
- (void)NextViewCamera:(UIButton *)btn;
- (void)NextViewChangeView;
- (void)NextViewOpenPhotos;

@end

@interface NextView : UIView

@property (nonatomic,weak) id<NextViewDelegate> delegate;

/** 注释 */
@property (nonatomic,weak) CustomImageView *picIv;

- (void)recoverNextViewTransform;

@end
