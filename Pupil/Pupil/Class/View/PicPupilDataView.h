//
//  PicPupilDataView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/12.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPDLbW SCREEN_FIT_6(220)
#define kPDLbH SCREEN_FIT_6(40)
#define kPDLbHSpace SCREEN_FIT_6(0)
#define kPDLbVSpace SCREEN_FIT_6(10)
@interface PicPupilDataView : UIView

/** 注释 */
@property (nonatomic,assign) CGFloat clickNum;
- (void)updataSubViewData:(CGFloat)mm;

@end
