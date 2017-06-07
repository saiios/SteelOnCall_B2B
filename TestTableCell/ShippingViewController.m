//
//  ShippingViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 01/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "ShippingViewController.h"
#import "billingInfoTableViewCell.h"
#import "OrderReviewViewController.h"
#import "LoginViewController.h"
#import "My_Cart.h"


@interface ShippingViewController ()
{
    NSMutableArray *infoPlaceholderArray;
    NSMutableArray *labelTitlesArr;
    NSMutableArray *shippingAddressDict;
    NSString *firstName;
    NSString *lastName;
    NSString *company;
    NSString *street;
    NSString *city;
    NSString *state;
    NSString *pincode;
    NSString *phoneNo;
    NSString *pan;
    NSString *cst;
    NSString *tin;
    NSString *checkPincode;
    BOOL keyboardIsShown;
}

@end

@implementation ShippingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    // Do any additional setup after loading the view from its nib.
    
    _shippingTableView.dataSource = self;
    _shippingTableView.delegate = self;
    labelTitlesArr = [[NSMutableArray alloc]initWithObjects:@"First Name *",@"Last Name *",@"Company ",@"Street *",@"City *", @"State *",@"Pincode *",@"Phone No *",@"PAN No *",@"CST ",@"TIN ",nil];
    infoPlaceholderArray = [[NSMutableArray alloc]initWithObjects:@"First Name ",@"Last Name ",@"Company ",@"Street ",@"City ", @"State ",@"Pincode ",@"Phone No ",@"PAN No ",@"CST ",@"TIN ",nil];
    self.navigationController.navigationBar.hidden =false;
    
     shippingAddressDict = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [_shippingTableView addGestureRecognizer:gestureRecognizer];
    //notifications
    keyboardIsShown = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    user_data=[NSUserDefaults standardUserDefaults];
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    _cart_CountLbl.text=C_Count;

    [self getShippingInfo];
}

- (void)getShippingInfo
{
    NSString *url_form=[NSString stringWithFormat:@"getShippingAddress?cid=%@",user_id];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url_form requestNumber:WS_GET_BUILDING_INFO showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data)
             {
                 shippingAddressDict =data;
             }
             else
             {
                 
             }
             
             [_shippingTableView reloadData];
         }
         else
         {
             //            UIAlertController * alert=   [UIAlertController
             //                                          alertControllerWithTitle:@"Alert"
             //                                          message:[NSString stringWithFormat:@"%@",[data valueForKey:@"error_message"]]
             //                                          preferredStyle:UIAlertControllerStyleAlert];
             //
             //            UIAlertAction* ok = [UIAlertAction
             //                                 actionWithTitle:@"OK"
             //                                 style:UIAlertActionStyleDefault
             //                                 handler:^(UIAlertAction * action)
             //                                 {
             //                                     [alert dismissViewControllerAnimated:YES completion:nil];
             //                                 }];
             //            [alert addAction:ok];
             //            [self presentViewController:alert animated:YES completion:nil];
         }
     }];
}

//- (NSString *) getDataFrom:(NSString *)url{
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setHTTPMethod:@"GET"];
//    [request setURL:[NSURL URLWithString:url]];
//    
//    NSError *error = [[NSError alloc] init];
//    NSHTTPURLResponse *responseCode = nil;
//    
//    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
//    
//    
//    if([responseCode statusCode] != 200){
//        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
//        return nil;
//    }
//    
//    
//    
//    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//}
-(void)viewDidAppear:(BOOL)animated{
    tableHeight = _shippingTableView.frame.size.height;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden =YES;
    // self.automaticallyAdjustsScrollViewInsets = NO;
     user_data=[NSUserDefaults standardUserDefaults];
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    if ([C_Count isEqual:[NSNull null]]||[C_Count isEqualToString:@""]||C_Count ==nil||[C_Count isEqualToString:@"<nil>"])
    {
        _cart_CountLbl.text=@"0";
        user_data=[NSUserDefaults standardUserDefaults];
        [user_data setValue:@"0" forKey:@"cart_count"];
    }
    else
        _cart_CountLbl.text=C_Count;
    
    _cart_BackgrndView.layer.cornerRadius = 10;
    
    //tap gesture
    UITapGestureRecognizer *cart_tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cart_Click_Actn:)];
    [_cart_BackgrndView addGestureRecognizer:cart_tap];
    
}
- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the scrollview
    CGRect viewFrame = self.shippingTableView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 50);
    if (viewFrame.size.height <tableHeight) {
        viewFrame.size.height = tableHeight;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.shippingTableView setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown)
    {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.shippingTableView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 50);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.shippingTableView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [infoPlaceholderArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *simpleTableIdentifier = @"Identifier";
    
    billingInfoTableViewCell *cell = (billingInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"billingInfoTableViewCell" owner:self options:nil];
        cell = (billingInfoTableViewCell *)[nib objectAtIndex:0];
    }
    cell.labelTitles.text = [labelTitlesArr objectAtIndex:indexPath.row];
    cell.textView.placeholder = [infoPlaceholderArray objectAtIndex:indexPath.row];
    cell.textView.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textView.layer.borderWidth = 1.0;
    cell.textView.layer.cornerRadius =2.0;
    cell.textView.tag = indexPath.row;
    cell.tag = indexPath.row;
    
    if (indexPath.row == 6) {
        [ cell.textView setKeyboardType:UIKeyboardTypeNumberPad];
        
    }else if(indexPath.row == 7)
    {
        [ cell.textView setKeyboardType:UIKeyboardTypePhonePad];
    }
    
    
    if (shippingAddressDict.count>0) {
        
        
        switch (indexPath.row) {
            case 0:
                 if ( ![[shippingAddressDict valueForKey:@"first_name"]isKindOfClass:[NSNull class]]) {
                cell.textView.text = [shippingAddressDict valueForKey:@"first_name"];
                firstName = [shippingAddressDict valueForKey:@"first_name"];
                 }
                break;
            case 1:
                 if ( ![[shippingAddressDict valueForKey:@"last_name"]isKindOfClass:[NSNull class]]) {
                cell.textView.text = [shippingAddressDict valueForKey:@"last_name"];
                lastName = [shippingAddressDict valueForKey:@"last_name"];
                 }
                break;
            case 2:
                
                if ( ![[shippingAddressDict valueForKey:@"company"]isKindOfClass:[NSNull class]]) {
                    NSLog(@"%@",[[shippingAddressDict valueForKey:@"company"] class]);
                    company = [shippingAddressDict valueForKey:@"company"];
                    cell.textView.text = [shippingAddressDict valueForKey:@"company"];
                }
            break;
            case 3:
                 if ( ![[shippingAddressDict valueForKey:@"street1"]isKindOfClass:[NSNull class]]) {
                street = [shippingAddressDict valueForKey:@"street1"];
                cell.textView.text = [shippingAddressDict valueForKey:@"street1"];
                 }
                
                break;
            case 4:
                 if ( ![[shippingAddressDict valueForKey:@"city"]isKindOfClass:[NSNull class]]) {
                city = [shippingAddressDict valueForKey:@"city"];
                cell.textView.text = [shippingAddressDict valueForKey:@"city"];
                 }
                
                break;
            case 5:
                 if ( ![[shippingAddressDict valueForKey:@"region"]isKindOfClass:[NSNull class]]) {
                state = [shippingAddressDict valueForKey:@"region"];
                cell.textView.text = [shippingAddressDict valueForKey:@"region"];
                 }
                
                break;
            case 6:
                 if ( ![[shippingAddressDict valueForKey:@"postcode"]isKindOfClass:[NSNull class]]) {
                pincode = [shippingAddressDict valueForKey:@"postcode"];
                cell.textView.text = [shippingAddressDict valueForKey:@"postcode"];
                 }
                
                break;
            case 7:
                 if ( ![[shippingAddressDict valueForKey:@"telephone"]isKindOfClass:[NSNull class]]) {
                phoneNo = [shippingAddressDict valueForKey:@"telephone"];
                cell.textView.text = [shippingAddressDict valueForKey:@"telephone"];
                 }
                
                break;
            case 8:
                if ( ![[shippingAddressDict valueForKey:@"pan"]isKindOfClass:[NSNull class]]) {
                   pan = [shippingAddressDict valueForKey:@"pan"];
                    cell.textView.text = [shippingAddressDict valueForKey:@"pan"];
                }
                break;
            case 9:
                if ( ![[shippingAddressDict valueForKey:@"cst"]isKindOfClass:[NSNull class]]) {
                    cst = [shippingAddressDict valueForKey:@"cst"];
                    cell.textView.text = [shippingAddressDict valueForKey:@"cst"];
                }
                break;
            case 10:
                if ( ![[shippingAddressDict valueForKey:@"tin"]isKindOfClass:[NSNull class]]) {
                    tin = [shippingAddressDict valueForKey:@"tin"];
                    cell.textView.text = [shippingAddressDict valueForKey:@"tin"];
                }
                break;
            default:
                
                break;
        }
        
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    //    UITableViewCell *cell = (UITableViewCell*) textField.superview.superview;
    //    NSIndexPath *indexPath = [self.billingInfoTableView indexPathForCell:cell];
    //    [self.billingInfoTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    NSLog(@"%ld",(long)textField.tag);
    if (textField.tag == 6||textField.tag == 7) {
        
        // allow backspace
        if (!string.length)
        {
            return YES;
        }
        
        // Prevent invalid character input, if keyboard is numberpad
        if (textField.keyboardType == UIKeyboardTypeNumberPad)
        {
            if ([string rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet].location != NSNotFound)
            {
                // BasicAlert(@"", @"This field accepts only numeric entries.");
                return NO;
            }
        }
        
        // verify max length has not been exceeded
        NSString *proposedText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (textField.tag == 6) {
            if (proposedText.length > 6)
            {
                // suppress the max length message only when the user is typing
                // easy: pasted data has a length greater than 1; who copy/pastes one character?
                if (string.length > 1)
                {
                    // BasicAlert(@"", @"This field accepts a maximum of 4 characters.");
                }
                
                return NO;
            }
            
        }
        else
        {
            if (proposedText.length > 13)
            {
                // suppress the max length message only when the user is typing
                // easy: pasted data has a length greater than 1; who copy/pastes one character?
                if (string.length > 1)
                {
                    // BasicAlert(@"", @"This field accepts a maximum of 4 characters.");
                }
                
                return NO;
            }
            
        }
        
        // only enable the OK/submit button if they have entered all numbers for the last four of their SSN (prevents early submissions/trips to authentication server)
        //self.answerButton.enabled = (proposedText.length == 4);
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    [textField resignFirstResponder];
    
    return YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
    NSDictionary *oldDict = (NSDictionary *)shippingAddressDict;
    [newDict addEntriesFromDictionary:oldDict];
    
    switch (textField.tag) {
        case 0:
            [newDict  setObject:textField.text forKey:@"first_name"];
            
            firstName = textField.text;
            break;
        case 1:
            [newDict  setObject:textField.text forKey:@"last_name"];
            
            lastName = textField.text;
            break;
        case 2:
            [newDict  setObject:textField.text forKey:@"company"];
            
            
            company = textField.text;
            break;
        case 3:
            
            [newDict  setObject:textField.text forKey:@"street1"];
            
            street = textField.text;
            break;
        case 4:
            [newDict  setObject:textField.text forKey:@"city"];
            
            
            city = textField.text;
            break;
        case 5:
            
            [newDict  setObject:textField.text forKey:@"region"];
            
            state = textField.text;
            break;
        case 6:
            [newDict  setObject:textField.text forKey:@"postcode"];
            
            pincode = textField.text;
            break;
        case 7:
            [newDict  setObject:textField.text forKey:@"telephone"];
            phoneNo = textField.text;
            break;
            
        case 8:
            [newDict  setObject:textField.text forKey:@"pan"];
            pan = textField.text;
            break;
            
        case 9:
            [newDict  setObject:textField.text forKey:@"cst"];
            cst = textField.text;
            break;
            
        case 10:
            [newDict  setObject:textField.text forKey:@"tin"];
            tin = textField.text;
            
            break;
            
        default:
            break;
            
    }
    
}


- (void)hideKeyboard {
    
    
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

- (IBAction)continueBtnAction:(id)sender {
    
     [self.view endEditing:YES];
      //  billingInfoTableViewCell *cell = (billingInfoTableViewCell *)[_shippingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    
    
        if (firstName.length ==0||lastName.length ==0||street.length ==0||city.length ==0||state.length ==0||pincode.length ==0||phoneNo.length ==0||pan.length == 0) {//||company.length ==0
    
            [self alertControllTitle:@"Alert" message:@"Please fill all mandatory fields"];
    
        }
    
        else if (phoneNo.length <10)
        {
           [self alertControllTitle:@"Alert" message:@"Invalid mobile Number"];
        }
    
//       else if (cell.textView.tag ==7) {
//    
//           NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
//           if ([phoneNo rangeOfCharacterFromSet:notDigits].location == NSNotFound)
//           {
//               [self alertControllTitle:@"Alert" message:@"Phone No should contain only numbers"];
//           }
//    
//        }
        else
        {
             //service call
if ([company isEqual:[NSNull null]]||[company isEqualToString:@"<nil>"]||company == nil)
{
    company = @"";
}
            
            
            if (pan == nil) {
                pan =@"";
                
            }
            if (cst == nil) {
                cst =@"";
                
            }
            if (tin == nil) {
                tin =@"";
                
            }
    
            NSDictionary *dic = @{@"firstname":firstName,
                                  @"lastname":lastName,
                                  @"company":company,
                                  @"street":street,
                                  @"city":city,
                                  @"region":state,
                                  @"postcode":pincode,
                                  @"telephone":phoneNo,
                                  @"pan":pan,
                                  @"cst":cst,
                                  @"tin":tin,
                                  @"id":user_id};
            
            [self saveShippingInfo:dic];
        }
    
    
//
    
    
}
-(void)saveShippingInfo :(NSDictionary *)params
{
    [[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"saveShipping" parameters:params requestNumber:WS_Shipping_INFO showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *response=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"response"]];
             if ([response isEqualToString:@"success"])
             {
                 OrderReviewViewController *orderReviewViewController = [[OrderReviewViewController alloc]init];
                     [self.navigationController pushViewController:orderReviewViewController animated:YES];
             }
             else
             {
                 ALERT_DIALOG(@"Alert",@"Error");
             }
         }
         else
         {
              ALERT_DIALOG(@"Alert",@"Something went wrong please try again..!");
         }
     }];
}


-(void)alertControllTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cart_Click_Actn:(id)sender {
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
        [self.navigationController pushViewController:myNewVC animated:YES];
    }
    else//go to cart page
    {
        My_Cart *define = [[My_Cart alloc]init];
        [self.navigationController pushViewController:define animated:YES];
    }
}
@end
