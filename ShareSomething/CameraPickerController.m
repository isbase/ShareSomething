//
//  CameraPickerController.m
//  Zijiazhushou
//
//  Created by wanghw on 13-12-9.
//  Copyright (c) 2013年 zijiazhushou.com. All rights reserved.
//

#import "CameraPickerController.h"
#import "Common.h"

#import "ALAssetsLibrary+CustomPhotoAlbum.h"

@interface CameraPickerController ()

@end


@implementation CameraPickerController

@synthesize pickerDelegate;

- (id)initWithFrame:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.view.frame = rect;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (UIViewController *)childViewControllerForStatusBarHidden
{
    return nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        [self prefersStatusBarHidden];
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    self.view.backgroundColor = [UIColor clearColor];
    
    cameraView = [[UIView alloc]initWithFrame:CGRectMake(0, IOS7?45:-20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    cameraView.userInteractionEnabled = YES;
    [self.view addSubview:cameraView];
    
    imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.showsCameraControls = NO;
    imagePicker.wantsFullScreenLayout = YES;
    
    
    showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, IOS7?45:-20, SCREEN_WIDTH, SCREEN_HEIGHT-(IOS7?141:76))];
    showImageView.backgroundColor = [UIColor blackColor];
    showImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:showImageView];
    [showImageView setHidden:YES];
    
    
    flashButton = [[UIButton alloc] initWithFrame:CGRectMake(10, IOS7?5:-15, 69, 35)];
    [flashButton setBackgroundImage:[UIImage imageNamed:@"flash1_on.png"] forState:UIControlStateNormal];
    [flashButton setBackgroundImage:[UIImage imageNamed:@"flash1_on.png"] forState:UIControlStateHighlighted];
    [flashButton addTarget:self action:@selector(flashButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    positionButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-79,IOS7?5:-15, 69, 35)];
    [positionButton setBackgroundImage:[UIImage imageNamed:@"turn_on.png"] forState:UIControlStateNormal];
    [positionButton setBackgroundImage:[UIImage imageNamed:@"turn_on.png"] forState:UIControlStateHighlighted];
    [positionButton addTarget:self action:@selector(positionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    
    
    
    toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-96-(IOS7?45:-20), SCREEN_WIDTH, 96)];
    toolsView.backgroundColor = [UIColor blackColor];
    
    
    cameraToolsView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 96)];
    cameraToolsView.image = [UIImage imageNamed:@"camera_bg.png"];
    cameraToolsView.userInteractionEnabled = YES;
    [toolsView addSubview:cameraToolsView];
    
    closeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 96/2-34/2, 53, 34)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"but_cancel_on.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"but_cancel_off.png"] forState:UIControlStateHighlighted];
    [closeButton addTarget:self action:@selector(closeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cameraToolsView addSubview:closeButton];
    
    
    takePhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-77/2, 96/2-77/2, 77, 77)];
    [takePhotoButton setBackgroundImage:[UIImage imageNamed:@"big_camera_on.png"] forState:UIControlStateNormal];
    [takePhotoButton setBackgroundImage:[UIImage imageNamed:@"big_camera_off.png"] forState:UIControlStateHighlighted];
    [takePhotoButton addTarget:self action:@selector(takePhotoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cameraToolsView addSubview:takePhotoButton];
    
    
    photoToolsView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 96)];
    photoToolsView.image = [UIImage imageNamed:@"camera_bg.png"];
    photoToolsView.userInteractionEnabled = YES;
    [photoToolsView setHidden:YES];
    [toolsView addSubview:photoToolsView];
    
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 96/2-34/2, 53, 34)];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"but_again_on.png"] forState:UIControlStateNormal];
    [cancelButton setBackgroundImage:[UIImage imageNamed:@"but_again_off.png"] forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [photoToolsView addSubview:cancelButton];
    
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-53-10, 96/2-34/2, 53, 34)];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"but_use_on.png"] forState:UIControlStateNormal];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"but_use_off.png"] forState:UIControlStateHighlighted];
    [saveButton addTarget:self action:@selector(saveButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [photoToolsView addSubview:saveButton];
    
    imagePicker.cameraOverlayView = toolsView;
    imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
    
    
    [cameraView addSubview:imagePicker.view];
    [self.view addSubview:flashButton];
    [self.view addSubview:positionButton];
}


- (void)takePhotoButtonPressed:(id)sender
{
    [imagePicker takePicture];
    [self hollowCloseToView:IOS7?self.view:cameraView];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]) {
        finishImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //NSLog(@"finishImage size : %@",NSStringFromCGSize(finishImage.size));
        
        showImageView.image = finishImage;
        [showImageView setHidden:NO];
        [self showPhotoTools:YES];
        
    }
}

- (void)showPhotoTools:(BOOL)show
{
    if (show) {
        if (!IOS7) {
            [flashButton setHidden:YES];
            [positionButton setHidden:YES];
        }
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.8; //动画时长
        //animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //animation.fillMode = kCAFillModeForwards;
        animation.type = @"oglFlip"; //过度效果
        //animation.removedOnCompletion = NO;
        animation.subtype = kCATransitionFromBottom; //过渡方向
        [cameraToolsView setHidden:YES];
        [photoToolsView setHidden:NO];
        [toolsView.layer addAnimation:animation forKey:@"animation"];
    }else{
        if (!IOS7) {
            [flashButton setHidden:NO];
            [positionButton setHidden:NO];
        }
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.8; //动画时长
        //animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //animation.fillMode = kCAFillModeForwards;
        animation.type = @"oglFlip"; //过度效果
        //animation.removedOnCompletion = NO;
        animation.subtype = kCATransitionFromTop; //过渡方向
        [cameraToolsView setHidden:NO];
        [photoToolsView setHidden:YES];
        [toolsView.layer addAnimation:animation forKey:@"animation"];
    }
    
}

- (void)flashButtonPressed:(id)sender
{
    [flashButton setEnabled:NO];
    
    if(imagePicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeAuto){
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOff;
        [flashButton setBackgroundImage:[UIImage imageNamed:@"flash1_on.png"] forState:UIControlStateNormal];
        [flashButton setBackgroundImage:[UIImage imageNamed:@"flash1_on.png"] forState:UIControlStateHighlighted];
    }
    else if(imagePicker.cameraFlashMode == UIImagePickerControllerCameraFlashModeOn){
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
        [flashButton setBackgroundImage:[UIImage imageNamed:@"flash3_on.png"] forState:UIControlStateNormal];
        [flashButton setBackgroundImage:[UIImage imageNamed:@"flash3_on.png"] forState:UIControlStateHighlighted];
    }
    else{
        imagePicker.cameraFlashMode = UIImagePickerControllerCameraFlashModeOn;
        [flashButton setBackgroundImage:[UIImage imageNamed:@"flash2_on.png"] forState:UIControlStateNormal];
        [flashButton setBackgroundImage:[UIImage imageNamed:@"flash2_on.png"] forState:UIControlStateHighlighted];
    }
    
    [flashButton setEnabled:YES];
}

- (void)positionButtonPressed:(id)sender
{
    //添加动画
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = .8f;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"oglFlip";
    
    if (imagePicker.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        animation.subtype = kCATransitionFromRight;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }else{
        animation.subtype = kCATransitionFromLeft;
        imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    [cameraView.layer addAnimation:animation forKey:@"animation"];
}

- (void)saveButtonPressed:(id)sender
{
//    NSTimeInterval time=[[Commons getNowDate] timeIntervalSince1970];
//    NSString *name = [NSString stringWithFormat:@"%li%d",lround(floor(time / 60.)),arc4random()%10];
//    [Commons saveImage:[finishImage fixOrientation] WithName:[NSString stringWithFormat:@"/%@_org.jpg",name]];
//    
//
//    [showImageView removeFromSuperview];
//    finishImage = nil;
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self dismissModalViewControllerAnimated:YES];
    
  //  [pickerDelegate forwardEditorContent:name];
}

- (void)cancelButtonPressed:(id)sender
{
    [self hollowOpenToView:IOS7?self.view:cameraView];
    [self showPhotoTools:NO];
    [showImageView setHidden:YES];
    showImageView.image = nil;
    finishImage = nil;
}

- (void)closeButtonPressed:(id)sender
{
    CATransition *animation = [CATransition animation];//初始化动画
    animation.duration = 0.5f;//间隔的时间
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cameraIrisHollowClose";
    [[self.view.window layer] addAnimation:animation forKey:nil];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self dismissModalViewControllerAnimated:NO];
    
}

- (void)hollowOpenToView:(UIView *)view
{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.delegate = self;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = @"cameraIrisHollowOpen";
    [view.layer addAnimation:animation forKey:@"animation"];
}

- (void)hollowCloseToView:(UIView *)view
{
    CATransition *animation = [CATransition animation];//初始化动画
    animation.duration = 0.5f;//间隔的时间
    animation.delegate = self;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = @"cameraIrisHollowClose";
    
    [view.layer addAnimation:animation forKey:@"HollowClose"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    if(imagePicker)imagePicker.delegate = nil;
}
@end
