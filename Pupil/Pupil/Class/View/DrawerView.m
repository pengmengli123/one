//
//  DrawerView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/5.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "DrawerView.h"
#import "InstructionView.h"
@interface DrawerView()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
/** 注释 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 注释 */
@property (nonatomic,weak) UITableView *tb;
/** 注释 */
@property (nonatomic,weak) UIView *coverView;
/** 注释 */
@property (nonatomic,assign) BOOL isShow;

/** 注释 */
@property (nonatomic,strong) InstructionView *instructionView;

@end
@implementation DrawerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isShow = NO;
        self.backgroundColor = [UIColor clearColor];
        _dataArr = [NSMutableArray arrayWithArray:@[@{@"text":@"使用说明",
                                                      @"icon":@"ic_menu_explain"
                                                      },
                                                    @{@"text":@"关于我们",
                                                      @"icon":@"guan_yu_wo_men"
                                                      },
                                                    @{@"text":@"相册",
                                                      @"icon":@"ic_menu_file"
                                                      }]];
        
        UIView *coverView = [[UIView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height)];
        coverView.backgroundColor = [UIColor blackColor];
        coverView.alpha = 0.0;
        [self addSubview:coverView];
        _coverView = coverView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawerViewShowOrHide)];
        [_coverView addGestureRecognizer:tap];
        
        UITableView *tb = [[UITableView alloc] initWithFrame:ccr(-SCREEN_FIT_6(400), 0, SCREEN_FIT_6(400), frame.size.height)];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = [UIColor blackColor];
        tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tb];
        _tb = tb;
        
        UIImageView *headerIv = [[UIImageView alloc] initWithFrame:ccr(0, 0, tb.width, SCREEN_FIT_6(266))];
        headerIv.image = [UIImage imageNamed:@"heder_icon"];
        _tb.tableHeaderView = headerIv;
        
        UILabel *lb = [[UILabel alloc] initWithFrame:ccr(0, headerIv.height - SCREEN_FIT_6(30) - SCREEN_FIT_6(40), headerIv.width, SCREEN_FIT_6(40))];
        lb.textColor = [UIColor blackColor];
        lb.font = HW_TWENTY_FONT_6;
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"瞳距瞳高测量工具";
        [headerIv addSubview:lb];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = @"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor blackColor];
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    UIImageView *iconIv = [[UIImageView alloc] initWithFrame:ccr(SCREEN_FIT_6(20), (cell.height - SCREEN_FIT_6(50))/2.0f, SCREEN_FIT_6(50), SCREEN_FIT_6(50))];
    iconIv.image = [UIImage imageNamed:dic[@"icon"]];
    [cell.contentView addSubview:iconIv];
    
    UILabel *textLb = [[UILabel alloc] initWithFrame:ccr(iconIv.right + SCREEN_FIT_6(20), (cell.height - SCREEN_FIT_6(30))/2.0f, SCREEN_FIT_6(200), SCREEN_FIT_6(30))];
    textLb.text = dic[@"text"];
    textLb.textColor = [UIColor whiteColor];
    [cell.contentView addSubview:textLb];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self hideTb];
        [self showInstructionView];
    }
    if (indexPath.row == 1) {
        [self hideTb];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"联系地址:\n联系电话:" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    if (indexPath.row == 2) {
        [self drawerViewShowOrHide];
        if (_delegate && [_delegate respondsToSelector:@selector(DrawerViewOpenPhotosAlbumDelegate)]) {
            [_delegate DrawerViewOpenPhotosAlbumDelegate];
        }
    }
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self drawerViewShowOrHide];
    }
}


- (void)drawerViewShowOrHide{
    _isShow = !_isShow;
    self.hidden = !_isShow;//为no才显示
    CGRect rect = _tb.frame;
    CGFloat alptha = 0.0f;
    if (_isShow) {
        alptha = 0.5;
        rect.origin.x = 0;
    }else{
        self.instructionView.hidden = YES;
        alptha = 0;
        rect.origin.x = -SCREEN_FIT_6(400);
    }
    [UIView animateWithDuration:0.5f animations:^{
        _coverView.alpha = alptha;
        _tb.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideTb{
    CGRect rect = _tb.frame;
    rect.origin.x = -SCREEN_FIT_6(400);
    [UIView animateWithDuration:0.5f animations:^{
        _tb.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

- (InstructionView *)instructionView{
    if (!_instructionView) {
        _instructionView = [[InstructionView alloc] initWithFrame:ccr(SCREEN_FIT_6(180), SCREEN_FIT_6(100), self.width - 2*SCREEN_FIT_6(180), self.height - 2*SCREEN_FIT_6(100))];
        _instructionView.hidden = YES;
        [self addSubview:_instructionView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drawerViewShowOrHide)];
        [_instructionView addGestureRecognizer:tap];
    }
    return _instructionView;
}

- (void)showInstructionView{
    self.instructionView.hidden = NO;
}

@end
