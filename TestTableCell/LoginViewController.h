//
//  LoginViewController.h
//  SteelonCall
//
//  Created by Manoyadav on 28/07/1938 Saka.
//  Copyright © 1938 Saka Manoyadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "CRToastView.h"
#import "STParsing.h"
#import "My_Cart.h"
#import "MBProgressHUD.h"
#import "YourOrdersViewController.h"
#import "AccountManageViewController.h"

@interface LoginViewController :UIViewController<MBProgressHUDDelegate>
{
    BOOL Networkstatus;
    UIView *network_view;
    NSUserDefaults *user_data;
}
@property (nonatomic, strong) MBProgressHUD  *HUD;

@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *registerBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *loginBtnOutlet;
@property (strong, nonatomic)  NSString *From;
@property (strong, nonatomic)  NSDictionary *cart_dict;
@property(strong, nonatomic)NSString *product_id;
 


- (IBAction)back_click:(id)sender;

- (IBAction)registerBtnActn:(id)sender;
- (IBAction)loginBtnActn:(id)sender;
- (IBAction)forgetPwdBtnActn:(id)sender;

@end
