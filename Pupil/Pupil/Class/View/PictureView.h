//
//  PictureView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/2/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomImageView.h"
#import "CustomImageView.h"

@protocol PictureViewDelegate <NSObject>
- (void)PictureViewCamera:(UIButton *)btn;
- (void)PictureViewChangeView;
- (void)PictureViewOpenPhotos;
@end

@interface PictureView : UIView

/** 注释 */
@property (nonatomic,weak) CustomImageView *picIv;

@property (nonatomic,weak) id<PictureViewDelegate> delegate;

- (void)recoverPicViewTransform;

@end
