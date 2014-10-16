//
//  SendViewController.m
//  ShareSomething
//
//  Created by dev on 14-10-14.
//  Copyright (c) 2014年 Today. All rights reserved.
//

#import "SendViewController.h"
#import "Common.h"
#import "CameraPickerController.h"

@interface SendViewController ()
{
    UITextView          *contentTextView;
    UIButton            *cameraButton;
    UIImageView         *photoImageView;
}

@end

@implementation SendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(9, SCREEN_OFFSET_Y + 44, SCREEN_WIDTH - 18, 120)];
    contentTextView.contentSize = CGSizeMake(SCREEN_WIDTH, 110);
    contentTextView.delegate = self;
    contentTextView.scrollEnabled = YES;
    contentTextView.returnKeyType = UIReturnKeyDefault;
    contentTextView.keyboardType = UIKeyboardTypeDefault;
    contentTextView.backgroundColor = [UIColor clearColor];
    contentTextView.textAlignment = NSTextAlignmentJustified;
    contentTextView.textColor = [Common hexStringToColor:@"#333333"];
    contentTextView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:contentTextView];
    
    
    cameraButton = [[UIButton alloc]initWithFrame:CGRectMake(10,SCREEN_HEIGHT - 366, 66, 66)];
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"no_photo_on.png"] forState:UIControlStateNormal];
    [cameraButton setBackgroundImage:[UIImage imageNamed:@"no_photo_off.png"] forState:UIControlStateHighlighted];
    [cameraButton addTarget:self action:@selector(cameraButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraButton];
    
    
    photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, SCREEN_HEIGHT - 366, 66, 66)];
    photoImageView.image = [UIImage imageNamed:@"photo_mark1.png"];
    photoImageView.userInteractionEnabled = YES;
    photoImageView.layer.borderWidth = 2;
    photoImageView.layer.borderColor = [[UIColor whiteColor] CGColor];
    photoImageView.layer.shadowOffset = CGSizeMake(0, 0);
    photoImageView.layer.shadowOpacity = 1;
    photoImageView.layer.shadowRadius  = 1;
    photoImageView.layer.shadowColor = [[Common hexStringToColor:@"#bbbbbb"] CGColor];
    [self.view addSubview:photoImageView];
    
}


#pragma mark - 打开相机
- (void)cameraButtonPressed
{
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO))return;
    CameraPickerController *controller = [[CameraPickerController alloc]init];
    controller.pickerDelegate = self;
    CATransition *animation = [CATransition animation];
    animation.duration = 0.5f;
    animation.delegate = self;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.type = @"cameraIrisHollowOpen";
    [[self.view.window layer] addAnimation:animation forKey:nil];
    [self presentModalViewController:controller animated:NO];
}


-(void)canleButtonClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)sendButtonCLick:(id)sender
{
    NSLog(@"发送");
}

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
