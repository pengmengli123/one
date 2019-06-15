//
//  CustomImageView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "CustomImageView.h"

@interface CustomImageView()

@end

@implementation CustomImageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isFirstRote = YES;
        _zoomScale = 1;
        self.userInteractionEnabled = NO;
        self.image = [UIImage imageNamed:@"default.jpg"];
    }
    return self;
}
- (void)setImage:(UIImage *)image{
    [super setImage:image];
    CGFloat wScale = 1;
    CGFloat hScale = 1;
    if (_originW) {
        wScale = (image.size.width/2)/self.width;
        hScale = (image.size.height/2)/self.height;    }
    self.frame = ccr((kDeviceWidth - image.size.width/2)/2.0f, (kDeviceHeight - image.size.height/2)/2.0f, image.size.width/2, image.size.height/2);
    _originW = self.width;
    _originH = self.height;
    
    NSLog(@"_originW : %f _originH : %f",_originW,_originH);
}


@end
