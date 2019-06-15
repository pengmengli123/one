//
//  CustomTextField.h
//  Pupil
//
//  Created by 彭孟力 on 2018/2/28.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTextFieldDelegate <NSObject>
- (void)CustomTextFieldFinishClick;
@end

@interface CustomTextField : UITextField

@property (nonatomic,weak) id<CustomTextFieldDelegate> tDelegate;

@end
