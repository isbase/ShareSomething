//
//  CameraPickerController.h
//  Zijiazhushou
//
//  Created by wanghw on 13-12-9.
//  Copyright (c) 2013年 zijiazhushou.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>


@protocol CameraPickerDelegate <NSObject>

- (void)forwardEditorContent:(NSString *)imageName;

@end

@interface CameraPickerController : UIViewController <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    ALAssetsLibrary* library;
    UIImagePickerController *imagePicker;
    
    UIButton *takePhotoButton;
    UIButton *flashButton;
    UIButton *positionButton;
    UIButton *saveButton;
    UIButton *cancelButton;
    UIButton *closeButton;
    
    UIView *cameraView;
    UIImageView *showImageView;
    UIView *toolsView;
    UIImageView *cameraToolsView;
    UIImageView *photoToolsView;
    UIImage *finishImage;
}

@property (nonatomic,assign) NSInteger travelId;
@property (nonatomic, assign) id<CameraPickerDelegate> pickerDelegate;
- (id)initWithFrame:(CGRect)rect;
@end
