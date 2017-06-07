//
//  AccountManageViewController.h
//  SteelonCall
//
//  Created by Manoyadav on 05/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountManageViewController : UIViewController<UIScrollViewDelegate,UITextFieldDelegate>
{
    BOOL keyboardIsShown;
    int scrollHeight;
}
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *changeAccountFields;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *manageAddressFields;
- (IBAction)returnExit:(id)sender;
//298
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *accountMAnaheConstraint;
//303
@property (strong, nonatomic)  NSString *From;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *manageAddressConstraint;
@property (strong, nonatomic) IBOutlet UIView *accountSettings_view;
@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UIButton *settingsBtn;
@property (strong, nonatomic) IBOutlet UIButton *addressBtn;
@property (strong, nonatomic) IBOutlet UIButton *mailBtn;
@property (strong, nonatomic) IBOutlet UIButton *passBtn;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UITextField *emailField;

@property (strong, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (strong, nonatomic) IBOutlet UITextField *latestPasswordField;

@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordField;

@property (strong, nonatomic) IBOutlet UITextField *streetField;
@property (strong, nonatomic) IBOutlet UITextField *cityField;
@property (strong, nonatomic) IBOutlet UITextField *regionField;
@property (strong, nonatomic) IBOutlet UITextField *pinCodeField;
@property (strong, nonatomic) IBOutlet UITextField *mobileNumberField;



@end
