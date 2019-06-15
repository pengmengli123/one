//
//  SlideBarView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/2/27.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SlideBarView;
#define kSliderBarTag 1000
@protocol SlideBarViewDelegate <NSObject>

- (void)slideBarViewSliderDelegate:(UIPanGestureRecognizer *)gestureRecognizer;

@end

@interface SlideBarView : UIImageView

@property (nonatomic,weak) id<SlideBarViewDelegate> delegate;

@property (nonatomic,assign) LimbDirection limbDirection;

/** 注释 */
@property (nonatomic,assign) CGFloat maxY;
/** 注释 */
@property (nonatomic,assign) CGFloat minimumY;



- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                limbDirection:(LimbDirection)limbDirection;

@end
