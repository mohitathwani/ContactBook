//
//  CBAddContactViewController.h
//  ContactBook
//
//  Created by Labs on 2/11/14.
//  Copyright (c) 2014 Tera Mo Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@protocol CBAddContactViewControllerDelegate <NSObject>

@optional
/**
 *  Delegate call back to instruct the presenting VC to hide the pop over
 */
-(void)hidePopOver;

@end
@interface CBAddContactViewController : UIViewController<UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(weak, nonatomic) id <CBAddContactViewControllerDelegate> delegate;

@end
