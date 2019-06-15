//
//  PupilDataView.h
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDataViewW SCREEN_FIT_6(200)
#define kDataViewH SCREEN_FIT_6(50)
#define kDataViewHSpace SCREEN_FIT_6(0)
#define kDataViewVSpace SCREEN_FIT_6(20)

@interface PupilDataView : UIView

- (void)updataPupilDataViewData:(CGFloat)zuoYanData
                     youYanData:(CGFloat)rightData;

@end
