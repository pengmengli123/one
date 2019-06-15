//
//  DrawerView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/5.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawerViewDelegate <NSObject>
- (void)DrawerViewOpenPhotosAlbumDelegate;
@end

@interface DrawerView : UIView
@property (nonatomic,weak) id<DrawerViewDelegate> delegate;

- (void)drawerViewShowOrHide;

@end
