//
//  RegisterViewController.m
//  SteelonCall
//
//  Created by Manoyadav on 28/07/1938 Saka.
//  Copyright © 1938 Saka Manoyadav. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden= NO;
    [self.emailTf setValue:[UIColor whiteColor]
                   forKeyPath:@"_placeholderLabel.textColor"];
    _emailTf.borderStyle = UITextBorderStyleRoundedRect;
    [_emailTf.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    [_emailTf.layer setBorderWidth:1.0];
    _emailTf.layer.cornerRadius = 3;
    _emailTf.clipsToBounds = YES;
    
    [self.passwordTf setValue:[UIColor whiteColor]
                forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTf.borderStyle = UITextBorderStyleRoundedRect;
    [_passwordTf.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    [_passwordTf.layer setBorderWidth:1.0];
    _passwordTf.layer.cornerRadius = 3;
    _passwordTf.clipsToBounds = YES;
    
    [_confirmPwdTf setValue:[UIColor whiteColor]
                   forKeyPath:@"_placeholderLabel.textColor"];
    _confirmPwdTf.borderStyle = UITextBorderStyleRoundedRect;
    [_confirmPwdTf.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    [_confirmPwdTf.layer setBorderWidth:1.0];
    _confirmPwdTf.layer.cornerRadius = 3;
    _confirmPwdTf.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (IBAction)Register_Click:(id)sender
{
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Register_Dict];
    }
}

-(void)Register_Dict
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[_emailTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dict setObject:[_passwordTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"password"];
    
    NSLog(@"%@",dict);
    [self Register_Service:dict];
}

-(void)Register_Service:(NSDictionary *)Dict
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"register" parameters:Dict requestNumber:Registration showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *response=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"response"]];
             
             if ([response isEqualToString:@"1"])
             {
                 NSString *User_Id=[res_dict valueForKey:@"userId"];
                 if ([User_Id isEqualToString:@""]||[User_Id isEqualToString:@"0"])
                 {
                     [self Alert:@"Something went wrong!"];
                 }
                 else
                 {
                     UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Success" message:@"Please wait for your account to be activated,Thank you for registering with Steeloncall." preferredStyle:UIAlertControllerStyleAlert];
                     
                     [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                         
                         [user_data setValue:User_Id forKey:@"user_id"];
                         [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ckeckLOGIN"];
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
                         //  ALERT_DIALOG(@"Success", @"User regiestered successfully");
                         myNewVC.From=_From;
                         myNewVC.product_id = _product_id1;
                         [self.navigationController pushViewController:myNewVC animated:YES];
                     
                     }]];
                     
                
                     dispatch_async(dispatch_get_main_queue(), ^ {
                         [self presentViewController:alertController animated:YES completion:nil];
                     });
                     
                     
                     
                   
                     
                     user_data=[NSUserDefaults standardUserDefaults];
                    
                 }
            }
             else
             {
                 [self Alert:@"Email you have entered is already registered"];
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
     
}

-(void)Alert:(NSString *)Msg
{
    NSDictionary *options = @{kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              
                              kCRToastTextKey : Msg,
                              
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              
                              kCRToastBackgroundColorKey : [UIColor colorWithRed:13.0/255.0 green:147.0/255.0 blue:68.0/255.0 alpha:1],
                              kCRToastTimeIntervalKey: @(2),
                              //                              kCRToastFontKey:[UIFont fontWithName:@"PT Sans Narrow" size:23],
                              kCRToastInteractionRespondersKey:@[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeSwipeUp
                                                                  
                                                                                                                 automaticallyDismiss:YES
                                                                  
                                                                                                                                block:^(CRToastInteractionType interactionType){
                                                                                                                                    
                                                                                                                                    NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                                }]],
                              kCRToastAnimationInTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationOutTypeKey : @(CRToastAnimationTypeGravity),
                              
                              kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                              
                              kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop)
                              
                              };
    
    [CRToastManager showNotificationWithOptions:options
     
                                completionBlock:^{
                                    
                                    NSLog(@"Completed");
                                    
                                }];
}

-(BOOL)valide_Data
{
    NSString *email_str = [_emailTf.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd_str=_passwordTf.text;
    NSString *Cpwd_str=_confirmPwdTf.text;

    if  ( [email_str length]==0)
    {
        [self Alert :@"Email should not be empty."];
        return NO;
    }
    else if ([self NSStringIsValidEmail:email_str]== NO)
    {
        [self Alert :@"Email should be valid."];
        return NO;
    }
    else if ([pwd_str length] == 0)
    {
        [self Alert :@"Password should not be empty."];
        return NO;
    }
    else if ([pwd_str length] < 6)
    {
        [self Alert :@"Password must be atleast 6 characters long."];
        return NO;
    }
    else if (! [Cpwd_str isEqualToString:pwd_str] )
    {
        [self Alert :@"Password mismatch."];
        return NO;
    }
    return YES;
}

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)login_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
