//
//  AccountManageViewController.m
//  SteelonCall
//
//  Created by Manoyadav on 05/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "AccountManageViewController.h"
#import "URLS.h"
#import "LoginViewController.h"
#import "STParsing.h"
@interface AccountManageViewController ()

@end

@implementation AccountManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _accountMAnaheConstraint.constant = 0;
    _manageAddressConstraint.constant =0;
    _accountSettings_view.hidden =YES;
    _addressView.hidden =YES;
    _mailBtn.hidden =YES;
    _passBtn.hidden =YES;
    keyboardIsShown =NO;
    
    [self.view layoutIfNeeded];
    
    
    for (UITextField *field in _changeAccountFields) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        field.leftView = paddingView;
        field.leftViewMode = UITextFieldViewModeAlways;

        field.layer.cornerRadius = 5;
        
        field.layer.masksToBounds =YES;
        field.layer.borderColor = [UIColor blackColor].CGColor;
        field.layer.borderWidth =1;
    }
    
    for (UITextField *field in _manageAddressFields) {
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        field.leftView = paddingView;
        field.leftViewMode = UITextFieldViewModeAlways;

        field.layer.cornerRadius = 5;
        
        field.layer.masksToBounds =YES;
        field.layer.borderColor = [UIColor blackColor].CGColor;
        field.layer.borderWidth =1;
    }
    
    [self getUserData];
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    scrollHeight = _scrollView.frame.size.height;
}
-(void)getUserData{

NSString *user_id =[[ NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
//73
if (user_id.length>0)
{
    NSString *urlString = [NSString stringWithFormat:@"getcustomer?id=%@",user_id];
    
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlString requestNumber:WS_GET_ACCOUNT_INFO showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             
             if (data) {
                 NSArray *ary = data;
                 if (ary.count>1) {
                     
                 for (UITextField *field in _changeAccountFields) {
                     
                     switch (field.tag) {
                         case 0:{
                             if (![[[data objectAtIndex:0]valueForKey:@"email"] isKindOfClass:[NSNull class]]) {
                                 field.text = [[data objectAtIndex:0]valueForKey:@"email"];
                             }
                             
                         }
                             
                             break;
                             
                         default:
                             break;
                     }
                 }
                 
                 for (UITextField *field in _manageAddressFields) {
                     
                     
                     switch (field.tag) {
                         case 0:{
                             if (![[[data objectAtIndex:1]valueForKey:@"street"] isKindOfClass:[NSNull class]]) {
                                 field.text = [[data objectAtIndex:1]valueForKey:@"street"];
                             }
                             
                         }
                             
                             break;
                         case 1:{
                             if (![[[data objectAtIndex:1]valueForKey:@"city"] isKindOfClass:[NSNull class]]) {
                                 field.text = [[data objectAtIndex:1]valueForKey:@"city"];
                             }
                         }
                             
                             break;
                         case 2:{
                             if (![[[data objectAtIndex:1]valueForKey:@"region"] isKindOfClass:[NSNull class]]) {
                                 field.text = [[data objectAtIndex:1]valueForKey:@"region"];
                             }

                             
                         }
                             
                             
                             break;
                         case 3:{
                             if (![[[data objectAtIndex:1]valueForKey:@"postcode"] isKindOfClass:[NSNull class]]) {
                                 field.text = [[data objectAtIndex:1]valueForKey:@"postcode"];
                             }
                             
                             
                         }
                             
                             
                             break;
                         case 4:{
                             if (![[[data objectAtIndex:1]valueForKey:@"telephone"] isKindOfClass:[NSNull class]]) {
                                 field.text = [[data objectAtIndex:1]valueForKey:@"telephone"];
                             }
                             
                             
                         }
                             
                             
                             break;
                             
                         default:
                             break;
                     }
                 }

                 
                 
                     
                     
                 }
         }
         
                 
             }else{
                 
                 
             }
         
             
         
         
         
     }];
    
}
else
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
    [self.navigationController pushViewController:myNewVC animated:YES];
}

}
//    userorders?id=" + user_id
//    userorders
//    calculate/userservice/orderdetails/?id="+mainOrderId


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)returnExit:(id)sender
{
}

- (IBAction)changeAccountSettingsActionClicked:(UIButton *)sender
{
    [_addressBtn setSelected:NO];

    if (sender.selected) {
        [sender setSelected:NO];
        _accountMAnaheConstraint.constant = 0;
        _manageAddressConstraint.constant =0;
        _accountSettings_view.hidden =NO;
        _mailBtn.hidden =YES;
        _passBtn.hidden =YES;
        sender.enabled =NO;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            sender.enabled =YES;
            _addressView.hidden =YES;
            _accountSettings_view.hidden =YES;

        }];

    }else{
        [sender setSelected:YES];
        _accountMAnaheConstraint.constant = 298;
        _manageAddressConstraint.constant =0;
        _accountSettings_view.hidden =NO;
        sender.enabled =NO;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            _mailBtn.hidden =NO;
            _passBtn.hidden =NO;
            _addressView.hidden =YES;
            sender.enabled =YES;
        }];

    }
    
    
}


- (IBAction)manageAddressClicked:(UIButton *)sender {
    
    [_settingsBtn setSelected:NO];
    if (sender.selected) {
        [sender setSelected:NO];
        _accountMAnaheConstraint.constant = 0;
        _manageAddressConstraint.constant =0;
        _addressView.hidden =NO;
        _mailBtn.hidden =YES;
        _passBtn.hidden =YES;
        sender.enabled =NO;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            
            _accountSettings_view.hidden =YES;
             _addressView.hidden =YES;
            _mailBtn.hidden =NO;
            _passBtn.hidden =NO;
            sender.enabled =YES;
            
        }];
    }else{
        [sender setSelected:YES];
        _mailBtn.hidden =YES;
        _passBtn.hidden =YES;
        _accountMAnaheConstraint.constant = 0;
        _manageAddressConstraint.constant =303;
        _addressView.hidden =NO;
        sender.enabled =NO;
        [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
            
        } completion:^(BOOL finished) {
            sender.enabled =YES;
            _accountSettings_view.hidden =YES;
            
        }];
    }
  
}

- (IBAction)backBtnClicked:(id)sender
{
    if ([_From isEqualToString:@"Login"])
    {
        NSArray *currentControllers = self.navigationController.viewControllers;
        
        
        BOOL ischeck = false;
        
        for (UIViewController *view in currentControllers ) {
            if ([view isKindOfClass:[HomeViewController class]]) {
                ischeck =YES;
                [self.navigationController popToViewController:view animated:YES];
                break;
                
            }
        }
        
        if (!ischeck) {
            HomeViewController *con = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            /* Create a mutable array out of this array */
            NSMutableArray *newControllers = [NSMutableArray
                                              arrayWithArray:@[con]];
            
            /* Remove the last object from the array */
            
            
            /* Assign this array to the Navigation Controller */
            self.navigationController.viewControllers = newControllers;
            [self.navigationController pushViewController:con animated:YES];
            
            
        }
    }
    else
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 0);
    if (viewFrame.size.height <scrollHeight) {
        viewFrame.size.height = scrollHeight;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.scrollView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 0);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.scrollView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

- (IBAction)updateEmailFieldAction:(id)sender {
    
    if ([self valide_email]) {
        [self updateEmail];
        
    }
}
- (IBAction)updatePasswordField:(id)sender {
    
    if ([self valide_password]) {
        [self updatePassword];
        
    }
    
}
- (IBAction)updateShippingAddress:(id)sender {
    if ([self validateAddress]) {
        [self updateAddress];
    }
    
}



-(BOOL)valide_email
{
    NSString *email_str = [_emailField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if  ( [email_str length]==0)
    {
        ALERT_DIALOG(@"Alert",@"Email should not be empty");
     
        return NO;
    }
    else{
        if ([self NSStringIsValidEmail: email_str]){
            
            
            return YES;
        }else{
              ALERT_DIALOG(@"Alert",@"Please provide valid email id");
        }
        
            }
        return YES;
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(BOOL)valide_password
{
    NSString *oldPSWD = [_oldPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _oldPasswordField.text = oldPSWD;
       NSString *newPSWD = [_latestPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _latestPasswordField.text = newPSWD;
     NSString *confirmPSWD = [_confirmPasswordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _confirmPasswordField.text = confirmPSWD;
    
    
    
    if  ( [oldPSWD length]==0)
    {
        ALERT_DIALOG(@"Alert",@"Old password should not be empty");
        
        return NO;
    }else if  ( [newPSWD length]==0)
    {
        ALERT_DIALOG(@"Alert",@"New password should not be empty");
        
        return NO;
    }else if  ( [confirmPSWD length]==0)
    {
        ALERT_DIALOG(@"Alert",@"Latest password should not be empty");
        
        return NO;
    } else if ([newPSWD length] < 6)
    {
        
        ALERT_DIALOG(@"Alert",@"Password must be atleast 6 characters long");

        return NO;
    }
    
    else if  ( ![newPSWD isEqualToString:confirmPSWD])
    {
        ALERT_DIALOG(@"Alert",@"New password should match confirm password");
        
        return NO;
    }
   
    return YES;
}

-(BOOL)validateAddress{
    NSString *st = [_streetField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _streetField.text = st;
    NSString *city = [_cityField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _cityField.text = city;
    NSString *reg = [_regionField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _regionField.text = reg;
    NSString *pincode = [_pinCodeField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _pinCodeField.text = pincode;
    NSString *phone = [_mobileNumberField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    _mobileNumberField.text = phone;
    if  ( [st length]==0  ||  [city length]==0 || [reg length]==0 ||  [pincode length]==0||  [phone length]==0)
    {
        ALERT_DIALOG(@"Alert",@"Fields should not be empty");
        return NO;

    }else if ([pincode length] < 6){
        ALERT_DIALOG(@"Alert",@"Please provide valid Zipcode ");
           return NO;

    }else if ([phone length] < 10){
        ALERT_DIALOG(@"Alert",@"Please provide valid mobile number ");
           return NO;
        
    }

    return YES;
}

-(void)updateEmail{
    NSDictionary *params = @{@"email": _emailField.text,@"id":[[ NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"updateUserEmail" parameters:params requestNumber:WS_UPDATE_EMAIL showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             ALERT_DIALOG(@"ALert", [data valueForKey:@"message"]);
             
           
         }
         else
         {
             ALERT_DIALOG(@"ALert", @"Something went wrong Please try again");
         }
     }];
    
    

    
}

-(void)updatePassword{
    NSDictionary *params = @{@"oldpassword": _oldPasswordField.text
                             ,@"id":[[ NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]
                             ,@"newpassword": _latestPasswordField.text
                             };
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"updateUserPassword" parameters:params requestNumber:WS_UPDATE_PASSWORD showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             ALERT_DIALOG(@"Alert", [data valueForKey:@"message"]);
             _oldPasswordField.text =@"";
             _latestPasswordField.text =@"";
             _confirmPasswordField.text =@"";
             
             
         }
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong Please try again");
         }
     }];
    
    
    
    
}
-(void)updateAddress{
    NSDictionary *params = @{@"street": _streetField.text
                             ,@"id":[[ NSUserDefaults standardUserDefaults]valueForKey:@"user_id"]
                             ,@"city": _cityField.text
                             ,@"region": _regionField.text
                             ,@"postcode": _pinCodeField.text
                             ,@"phone": _mobileNumberField.text
                             };
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"updateCustomerAddress" parameters:params requestNumber:WS_UPDATE_ADDRESS showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             
             ALERT_DIALOG(@"Alert", [data valueForKey:@"message"]);
             
             
         }
         else
         {
             ALERT_DIALOG(@"Alert", @"Something went wrong Please try again");
         }
     }];
    
    
    
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string.length)
        return YES;
    
    if (textField == self.pinCodeField || textField == self.mobileNumberField)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
        

        if (textField == self.pinCodeField){
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 6;
        }else{
            if(range.length + range.location > textField.text.length)
            {
                return NO;
            }
            
            NSUInteger newLength = [textField.text length] + [string length] - range.length;
            return newLength <= 10;

        }
        
        
    }
    return YES;
}

@end
