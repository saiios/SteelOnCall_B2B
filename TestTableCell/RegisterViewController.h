//
//  RegisterViewController.h
//  SteelonCall
//
//  Created by Manoyadav on 28/07/1938 Saka.
//  Copyright © 1938 Saka Manoyadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRToastView.h"
#import "STParsing.h"
#import "My_Cart.h"

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    NSUserDefaults *user_data;
}
@property (weak, nonatomic) IBOutlet UITextField *emailTf;

@property (weak, nonatomic) IBOutlet UITextField *passwordTf;
- (IBAction)login_click:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwdTf;
@property (strong, nonatomic)  NSString *From;
@property(strong, nonatomic)NSString *product_id1;

@end
