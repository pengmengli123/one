//
//  InstructionView.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/5.
//  Copyright © 2018年 彭孟力. All rights reserved.
//
#import "InstructionView.h"
@interface InstructionView()<UITableViewDelegate,UITableViewDataSource>
/** 注释 */
@property (nonatomic,weak) UITableView *tb;
/** 注释 */
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation InstructionView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = [NSMutableArray arrayWithArray:@[@{@"text":@"未锁定状态,此时可以调整图片位置",
                                                      @"icon":@"unlock"
                                                      },
                                                    @{@"text":@"锁定状态,此时可以拖动测量线进行测量",
                                                      @"icon":@"lock"
                                                      },
                                                    @{@"text":@"调用相机进行拍照",
                                                      @"icon":@"canmer"
                                                      },
                                                    @{@"text":@"等比例放大图片刻度尺",
                                                      @"icon":@"add"
                                                      },
                                                    @{@"text":@"等比例缩小图片刻度尺",
                                                      @"icon":@"jian"
                                                      },
                                                    @{@"text":@"截屏",
                                                      @"icon":@"shot_screen"
                                                      },
                                                    @{@"text":@"瞳高瞳距测量切换",
                                                      @"icon":@"switch_use"
                                                      }]];
        UITableView *tb = [[UITableView alloc] initWithFrame:ccr(0, 0, frame.size.width, frame.size.height)];
        tb.delegate = self;
        tb.dataSource = self;
        tb.backgroundColor = [UIColor whiteColor];
        [self addSubview:tb];
        _tb = tb;
        UILabel *titleLb = [[UILabel alloc] initWithFrame:ccr(0, 0, tb.width, SCREEN_FIT_6(80))];
        titleLb.text = @"使用说明";
        titleLb.textColor = [UIColor blackColor];
        titleLb.font = HW_TWENTY_FONT_6;
        titleLb.textAlignment = NSTextAlignmentCenter;
        tb.tableHeaderView = titleLb;
        
        UILabel *footerLb = [[UILabel alloc] initWithFrame:ccr(SCREEN_FIT_6(10), 0, tb.width - 2*SCREEN_FIT_6(10), SCREEN_FIT_6(80))];
        footerLb.textColor = [UIColor redColor];
        footerLb.font = HW_SIXTEEN_FONT_6;
        footerLb.text = @"镜框高度设置范围为20mm-100mm,镜框宽度设置范围为100mm-500mm";
        footerLb.numberOfLines = 2;
        tb.tableFooterView = footerLb;
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
    }
    NSDictionary *dic = _dataArr[indexPath.row];
    UIImageView *iconIv = [[UIImageView alloc] initWithFrame:ccr(SCREEN_FIT_6(20), (cell.height - SCREEN_FIT_6(50))/2.0f, SCREEN_FIT_6(50), SCREEN_FIT_6(50))];
    iconIv.image = [UIImage imageNamed:dic[@"icon"]];
    [cell.contentView addSubview:iconIv];
    
    UILabel *textLb = [[UILabel alloc] initWithFrame:ccr(iconIv.right + SCREEN_FIT_6(20), (cell.height - SCREEN_FIT_6(30))/2.0f, tableView.width - (iconIv.right + SCREEN_FIT_6(20)), SCREEN_FIT_6(30))];
    textLb.text = dic[@"text"];
    textLb.textColor = [UIColor blackColor];
    [cell.contentView addSubview:textLb];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
