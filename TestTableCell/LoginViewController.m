
//
//  LoginViewController.m
//  SteelonCall
//
//  Created by Manoyadav on 28/07/1938 Saka.
//  Copyright © 1938 Saka Manoyadav. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "URLS.h"
#import "Products_List.h"


@interface LoginViewController ()
{
    NSString *errMsg;
}

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    user_data=[NSUserDefaults standardUserDefaults];
     errMsg = @"Please Enter Email Id";

   // self.passwordTF.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0);
    [self.emailTF setValue:[UIColor whiteColor]
                    forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTF setValue:[UIColor whiteColor]
                forKeyPath:@"_placeholderLabel.textColor"];
        _emailTF.borderStyle = UITextBorderStyleRoundedRect;
    [_emailTF.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    [_emailTF.layer setBorderWidth:1.0];
    _emailTF.layer.cornerRadius = 3;
    _emailTF.clipsToBounds = YES;
    _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    [_passwordTF.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    [_passwordTF.layer setBorderWidth:1.0];
    _passwordTF.layer.cornerRadius = 3;
    _passwordTF.clipsToBounds = YES;
    
    [_registerBtnOutlet.layer setBorderWidth:1.0];
     [_loginBtnOutlet.layer setBorderWidth:1.0];
    [_registerBtnOutlet.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
     [_loginBtnOutlet.layer setBorderColor:[[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]];
    _registerBtnOutlet.layer.cornerRadius = 3;
    _loginBtnOutlet.layer.cornerRadius = 3;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    errMsg = @"Please Enter Email Id";
     self.navigationController.navigationBar.hidden = YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerBtnActn:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController *myNewVC = (RegisterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"RegisterViewControllerID"];
    myNewVC.From=_From;
    myNewVC.product_id1 = _product_id;
    [self.navigationController pushViewController:myNewVC animated:YES];
}

- (IBAction)loginBtnActn:(id)sender
{
    [self.view endEditing:YES];
    
    if ([self valide_Data] == YES)
    { // checking if the either of the string is empty and other validations
        [self Login_Dict];
    }
}

-(void)Login_Dict
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:[_emailTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"email"];
    [dict setObject:[_passwordTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] forKey:@"password"];
    
    NSLog(@"%@",dict);
    [self Login_Service:dict];
}

-(void)Login_Service:(NSDictionary *)Dict
{
    NSDictionary *params = @{@"email": _emailTF.text,@"password": _passwordTF.text};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"userLogin" parameters:params requestNumber:WS_Login showProgress:YES withHandler:^(BOOL success, id data)
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
                     user_data=[NSUserDefaults standardUserDefaults];
                     [user_data setValue:User_Id forKey:@"user_id"];
                     
                     //cart service
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ckeckLOGIN"];
                    [self kartCntService:User_Id];
                   
                 }
             }
             else
             {
                 [self Alert:@"Login failed!"];
             }
         }
         else
         {
             [self Alert:@"Something went wrong"];
         }
     }];
}

-(void)service:(NSDictionary *)parameters
{
    _HUD.hidden =NO;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.responseSerializer =responseSerializer;
    NSString *urlString;
    urlString= [NSString stringWithFormat:@"%@addProductsToCart",MAIN_Url];
    NSError *error;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    
    [request addValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"text/html" forHTTPHeaderField:@"Accept"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:jsonData2];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                          {
                                              if (!error)
                                              {
                                                  // [activityView removeFromSuperview];
                                                  //_HUD.hidden =YES;
                                                  NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                  
                                                  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                       options:kNilOptions
                                                                                                         error:&error];
                                                  NSLog(@"%@",json);
                                                  NSString *response=[NSString stringWithFormat:@"%@",[json valueForKey:@"response"]];
                                                  
                                                  if ([response isEqualToString:@"1"])
                                                  {
                                                      //Background Thread
                                                      // _HUD.hidden =YES;
                                                      dispatch_async(dispatch_get_main_queue(), ^(void){
                                                          //Run UI Updates
                                                          //  [_HUD removeFromSuperview];
                                                          
                                                          //_HUD.hidden =YES;
                                                          //[activityView removeFromSuperview];
                                                          
                                                          My_Cart *define = [[My_Cart alloc]init];
                                                          define.From_check=@"login";
                                                          [self.navigationController pushViewController:define animated:YES];
                                                      });
                                                      
                                                  }
                                                  else
                                                  {
                                                      
                                                      
                                                      
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^(void){
                                                          
                                                          
                                                          //[activityView removeFromSuperview];
                                                      });
                                                      
                                                      //   [self Alert:@"Something went wrong"];
                                                      
                                                      ALERT_DIALOG(@"Alert", @"Something went wrong");
                                                      NSLog(@" Something went wrong");
                                                  }
                                              }
                                              else
                                              {
                                                  // _HUD.hidden =YES;
                                                  dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                                                 {
                                                                     //Background Thread
                                                                     // _HUD.hidden =YES;
                                                                     dispatch_async(dispatch_get_main_queue(), ^(void){
                                                                         
                                                                         
                                                                         
                                                                        // [activityView removeFromSuperview];
                                                                     });
                                                                 });
                                                  NSString *str =[NSString stringWithFormat:@"%@",error];
                                                  
                                                  ALERT_DIALOG(@"Alert",str);
                                                  
                                                  
                                                  //[self Alert:[NSString stringWithFormat:@"%@",error]];
                                                  //            NSLog(@"Error: %@", error);
                                              }
                                              
                                          }];
    
    [postDataTask resume];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    _HUD.hidden =YES;
}

-(BOOL)valide_Data
{
    NSString *email_str = [_emailTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *pwd_str=_passwordTF.text;
    
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
    return YES;
}

- (IBAction)forgetPwdBtnActn:(id)sender
{
   
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:errMsg preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Please Enter Email Id";
        [alertController addAction:[UIAlertAction actionWithTitle:@"Submit" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self forgot_pwd_service:textField.text];
                                    }]];
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                                     errMsg = @"Please Enter Email Id";
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }]];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

-(void)forgot_pwd_service:(NSString *)msg
{
    if  ( msg.length==0)
    {
        errMsg = @"Please enter Email Id";
      
        [self forgetPwdBtnActn:(id)0];
    }
    
  else if  ([self NSStringIsValidEmail:msg]== NO)
    {
        errMsg = @"entered email is not valid";
        
        [self forgetPwdBtnActn:(id)0];

    }
    else
        [self Fwd_Dict:msg];
}

-(void)Fwd_Dict:(NSString *)msg
{
    NSMutableDictionary *dict = [NSMutableDictionary new];
    [dict setObject:msg forKey:@"email"];
    
    NSLog(@"%@",dict);
    [self Fwd_Service:dict];
}

-(void)Fwd_Service:(NSDictionary *)Dict
{
    NSString *url_form=[NSString stringWithFormat:@"sendForgotPasswordLink?/"];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
   [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:urlEncoded parameters:Dict requestNumber:fwd showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *response=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"response"]];
             
             if ([response isEqualToString:@"Reset Password Link send to your email"])
             {
                [self Alert:response];
             }
             else
             {
                 [self Alert:@"Entered Email does not exist"];
             }
         }
         else
         {
            [self Alert:@"Something went wrong"];
         }
     }];
}
- (void)alertTextFieldDidChange:(UITextField *)sender
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *email = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = email.text.length > 2;
    }
}

//-(BOOL)emailValidation:(NSString *)emailTxt
//{
//    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
//    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
//    return [emailTest evaluateWithObject:emailTxt];
//    
//}

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

-(BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)kartCntService:(NSString *)userId
{
    NSDictionary *params = @{@"customer_id":userId};
    
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"getCartCountAfterLogin" parameters:params requestNumber:WS_Login showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *cartCount=[NSString stringWithFormat:@"%@",[[[res_dict valueForKey:@"cart"] objectAtIndex:0] valueForKey:@"cart_count"]];
             
             if (cartCount == nil) {
                 cartCount =@"0";
             }
                    [user_data setValue:cartCount forKey:@"cart_count"];
            
             
              [self success:userId];
             
        }
         else
         {
             [self success:userId];
             [self Alert:@"Something went wrong"];
         }
     }];
}
-(void)success:(NSString *)User_Id{
    if ([_From isEqualToString:@"orders"])
    {
        YourOrdersViewController *define = [[YourOrdersViewController alloc]initWithNibName:@"YourOrdersViewController" bundle:nil];
        define.From=@"Login";
        [self.navigationController pushViewController:define animated:YES];
    }
    else if ([_From isEqualToString:@"management"])
    {
        AccountManageViewController *ac = [[AccountManageViewController alloc]initWithNibName:@"AccountManageViewController" bundle:nil];
        ac.From=@"Login";
        [self.navigationController pushViewController:ac animated:YES];
    }
    else if ([_From isEqualToString:@"listingPage"])
    {
        Products_List *ac = [[Products_List alloc]initWithNibName:@"Products_List" bundle:nil];
        ac.product_id=_product_id;
        ac.From = @"Login";
        
        [self.navigationController pushViewController:ac animated:YES];
    }
    
    else
    {
        
        
        if ([_From isEqualToString:@"define"]) {
            [_cart_dict setValue:User_Id forKey:@"customer_id"];
            [self service:_cart_dict];
        }
        
        
        else
        {
            My_Cart *define = [[My_Cart alloc]init];
            define.From_check=@"login";
            [self.navigationController pushViewController:define animated:YES];
        }
        //                         activityView.frame = [UIScreen mainScreen].bounds;
        //                         [self.view addSubview:activityView];
    }
}

@end
