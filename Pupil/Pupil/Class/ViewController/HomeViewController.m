//
//  ViewController.m
//  Pupil
//
//  Created by 彭孟力 on 2018/2/7.
//  Copyright © 2018年 彭孟力. All rights reserved.
//

#import "HomeViewController.h"
#import "PictureView.h"
#import "NextViewController.h"
#import<AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>

@interface HomeViewController ()<PictureViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/** 注释 */
@property (nonatomic,strong) PictureView *pictureView;
/** 注释 */
@property (nonatomic,strong) UIImagePickerController *pickerController;
@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.pictureView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePic:) name:kChangePic object:nil];
}

- (PictureView *)pictureView{
    if (!_pictureView) {
        PictureView *pictureView = [[PictureView alloc] initWithFrame:ccr(0, 0, kDeviceWidth, kDeviceHeight)];
        pictureView.delegate = self;
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (UIImagePickerController *)pickerController
{
    if (!_pickerController)
        
    {
        _pickerController=[[UIImagePickerController alloc]init];
        _pickerController.delegate=self;
    }
    return _pickerController;
}


- (void)PictureViewCamera:(UIButton *)btn{
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
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        self.pickerController.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        self.pickerController.allowsEditing = YES;
        //打开相册
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }
}

- (void)cameraAuthStatus{
    //相机权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
    {
        // 无权限 引导去开启
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            [[UIApplication sharedApplication]openURL:url];
        }
    }
}

- (void)photoAuthStatus{
    //相册权限
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author ==ALAuthorizationStatusRestricted ||author==ALAuthorizationStatusDenied){
        //无权限 引导去开启
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }

}

#pragma mark  - PictureViewDelegate
- (void)PictureViewChangeView{
    NextViewController *vc = [[NextViewController alloc] init];
    vc.image = _pictureView.picIv.image;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)PictureViewOpenPhotos{
    [self openPhotosAlbum];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    [self dismissViewControllerAnimated:YES completion:nil];
    [_pictureView recoverPicViewTransform];
    _pictureView.picIv.image = image;

}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
//
//{
    //如果实现了这个代理方法 必须手动退出相册界面
//    [self dismissViewControllerAnimated:YES completion:nil];
//    UIImage *selectImage = info[@"UIImagePickerControllerOriginalImage"];
//    [_pictureView recoverPicViewTransform];
//    _pictureView.picIv.image = selectImage;
//}

- (void)changePic:(NSNotification *)notification{
    UIImage *image = (UIImage *)notification.object[@"pic"];
    [_pictureView recoverPicViewTransform];
    _pictureView.picIv.image = image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
