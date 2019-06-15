//
//  NextViewController.m
//  Pupil
//
//  Created by 彭孟力 on 2018/3/2.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "NextViewController.h"
#import "NextView.h"

@interface NextViewController ()<NextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 注释 */
@property (nonatomic,strong) UIImagePickerController *pickerController;
/** 注释 */
@property (nonatomic,weak) NextView *nextView;

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_ruler"]];
    NextView *nextView = [[NextView alloc] initWithFrame:ccr(0, 0, self.view.width, self.view.height)];
    nextView.delegate = self;
    [self.view addSubview:nextView];
    _nextView = nextView;
    _nextView.picIv.image = _image;
}

#pragma mark - HomeTopViewDelegate

- (UIImagePickerController *)pickerController
{
    if (!_pickerController)
        
    {
        _pickerController=[[UIImagePickerController alloc]init];
        _pickerController.delegate=self;
    }
    return _pickerController;
}


- (void)NextViewCamera:(UIButton *)btn{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"照片选择方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionOne = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            
        {
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.pickerController.allowsEditing = YES;
            [self presentViewController:self.pickerController animated:YES completion:nil];
            
        }else
            
        {
            NSLog(@"打开失败");
        }
        
    }];
    
    [alertController addAction:actionOne];
    
    UIAlertAction *actionTwo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            
        {
            self.pickerController.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            self.pickerController.allowsEditing = YES;
            //打开相册
            [self presentViewController:self.pickerController animated:YES completion:nil];
        }
    }];
    [alertController addAction:actionTwo];
    UIAlertAction *actionThree = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:actionThree];
    UIPopoverPresentationController *popPresenter = [alertController
                                                     popoverPresentationController];
    popPresenter.sourceView = btn; // 这就是挂靠的对象
    popPresenter.sourceRect = btn.bounds;
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)openPhotosAlbum{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        
    {
        self.pickerController.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        self.pickerController.allowsEditing = YES;
        //打开相册
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }
}


- (void)NextViewChangeView{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)NextViewOpenPhotos{
    [self openPhotosAlbum];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    [_nextView recoverNextViewTransform];
    _nextView.picIv.image = image;
    NSDictionary *dic = @{@"pic":image};
    [[NSNotificationCenter defaultCenter] postNotificationName:kChangePic object:dic];
}


//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
//{
//    //如果实现了这个代理方法 必须手动退出相册界面
//    [self dismissViewControllerAnimated:YES completion:nil];
//    UIImage *selectImage = info[@"UIImagePickerControllerOriginalImage"];
//    [_nextView recoverNextViewTransform];
//    _nextView.picIv.image = selectImage;
//    NSDictionary *dic = @{@"pic":selectImage};
//    [[NSNotificationCenter defaultCenter] postNotificationName:kChangePic object:dic];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
