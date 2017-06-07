//
//  BillingInfoViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 01/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "BillingInfoViewController.h"
#import "billingInfoTableViewCell.h"
#import "ShippingViewController.h"
#import "URLS.h"
#import "STParsing.h"
#import "LoginViewController.h"
#import "My_Cart.h"

@interface BillingInfoViewController ()
{
    NSMutableArray *infoPlaceholderArray;
    NSMutableArray *labelTitlesArr;
    NSMutableDictionary *billingAddressDict;
    NSMutableDictionary *textFieldDict;
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
   
}

@end

@implementation BillingInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    
   
    billingAddressDict =@{@"first_name":@""
                     ,@"last_name":@""
                      ,@"company":@""
                      ,@"street1":@""
                      ,@"city":@""
                      ,@"region":@""
                      ,@"postcode":@""
                      ,@"telephone":@""
                      ,@"pan":@""
                      ,@"cst":@""
                      ,@"tin":@""
                      };
    
    // Do any additional setup after loading the view from its nib.
    _billingInfoTableView.dataSource = self;
    _billingInfoTableView.delegate = self;
    
    labelTitlesArr = [[NSMutableArray alloc]initWithObjects:@"First Name *",@"Last Name *",@"Company ",@"Street *",@"City *", @"State *",@"Pincode *",@"Phone No *",@"PAN No *",@"CST ",@"TIN ",nil];
    
     infoPlaceholderArray = [[NSMutableArray alloc]initWithObjects:@"First Name ",@"Last Name ",@"Company ",@"Street ",@"City ", @"State ",@"Pincode ",@"Phone No ",@"PAN No *",@"CST ",@"TIN ",nil];
    
   // billingAddressDict = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.hidden =false;
    
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [_billingInfoTableView addGestureRecognizer:gestureRecognizer];
    
    keyboardIsShown = NO;
    
    //notifications
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
    

    [self getBuildingInfo];
    
}
-(void)viewDidAppear:(BOOL)animated{
    tableHeight = _billingInfoTableView.frame.size.height;
}
- (void)getBuildingInfo{

    NSString *url_form=[NSString stringWithFormat:@"getBillingAddress?cid=%@",user_id];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url_form requestNumber:WS_GET_BUILDING_INFO showProgress:YES withHandler:^(BOOL success, id data)
    {
        if (success)
        {
            if (data)
            {
                billingAddressDict =data;
            }
            else
            {
                
            }
            
            [_billingInfoTableView reloadData];
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


- (void)keyboardWillHide:(NSNotification *)n
{
   // self.view.userInteractionEnabled =NO;
    NSDictionary* userInfo = [n userInfo];

    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the scrollview
    CGRect viewFrame = self.billingInfoTableView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height -50);
    if (viewFrame.size.height < tableHeight) {
        viewFrame.size.height = tableHeight;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.billingInfoTableView setFrame:viewFrame];
    [UIView commitAnimations];
  
    keyboardIsShown = NO;
   
}
-(void)enableView{
    
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
    CGRect viewFrame = self.billingInfoTableView.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 50);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.billingInfoTableView setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
    
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
    
    _cart_BackgroundView.layer.cornerRadius = 10;
    
    //tap gesture
    UITapGestureRecognizer *cart_tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(cart_Click_Actn:)];
    [_cart_BackgroundView addGestureRecognizer:cart_tap];
    
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
    else
        [ cell.textView setKeyboardType:UIKeyboardTypeDefault];

    

    
    if (billingAddressDict.allKeys.count>0) {

    
    switch (indexPath.row) {
        case 0:
             if ( ![[billingAddressDict valueForKey:@"first_name"]isKindOfClass:[NSNull class]]) {
               cell.textView.text = [billingAddressDict valueForKey:@"first_name"];
                firstName = [billingAddressDict valueForKey:@"first_name"];
             }
            break;
        case 1:
            if ( ![[billingAddressDict valueForKey:@"last_name"]isKindOfClass:[NSNull class]]) {
            
            cell.textView.text = [billingAddressDict valueForKey:@"last_name"];
            lastName = [billingAddressDict valueForKey:@"last_name"];

            }
            break;
        case 2:
           if ( ![[billingAddressDict valueForKey:@"company"]isKindOfClass:[NSNull class]]) {
            NSLog(@"%@",[[billingAddressDict valueForKey:@"company"] class]);
                company = [billingAddressDict valueForKey:@"company"];
                cell.textView.text = [billingAddressDict valueForKey:@"company"];
            }
            

            break;
        case 3:
             if ( ![[billingAddressDict valueForKey:@"street1"]isKindOfClass:[NSNull class]]) {
            street = [billingAddressDict valueForKey:@"street1"];
            cell.textView.text = [billingAddressDict valueForKey:@"street1"];
             }
            break;
        case 4:
             if ( ![[billingAddressDict valueForKey:@"city"]isKindOfClass:[NSNull class]]) {
            city = [billingAddressDict valueForKey:@"city"];
            cell.textView.text = [billingAddressDict valueForKey:@"city"];
             }
            break;
        case 5:
             if ( ![[billingAddressDict valueForKey:@"region"]isKindOfClass:[NSNull class]]) {
            state = [billingAddressDict valueForKey:@"region"];
            cell.textView.text = [billingAddressDict valueForKey:@"region"];
             }
            break;
        case 6:
             if ( ![[billingAddressDict valueForKey:@"postcode"]isKindOfClass:[NSNull class]]) {
            pincode = [billingAddressDict valueForKey:@"postcode"];
            cell.textView.text = [billingAddressDict valueForKey:@"postcode"];
             }
            break;
        case 7:
             if ( ![[billingAddressDict valueForKey:@"telephone"]isKindOfClass:[NSNull class]]) {
            phoneNo = [billingAddressDict valueForKey:@"telephone"];
            cell.textView.text = [billingAddressDict valueForKey:@"telephone"];
             }
            break;
        case 8:
            if ( ![[billingAddressDict valueForKey:@"pan"]isKindOfClass:[NSNull class]]) {
                pan = [billingAddressDict valueForKey:@"pan"];
                cell.textView.text = [billingAddressDict valueForKey:@"pan"];
            }
            break;
        case 9:
            if ( ![[billingAddressDict valueForKey:@"cst"]isKindOfClass:[NSNull class]]) {
                cst = [billingAddressDict valueForKey:@"cst"];
                cell.textView.text = [billingAddressDict valueForKey:@"cst"];
            }
            break;
        case 10:
            if ( ![[billingAddressDict valueForKey:@"tin"]isKindOfClass:[NSNull class]]) {
                tin = [billingAddressDict valueForKey:@"tin"];
                cell.textView.text = [billingAddressDict valueForKey:@"tin"];
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
    NSDictionary *oldDict = (NSDictionary *)billingAddressDict;
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

    billingAddressDict =newDict;
    
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
   // billingInfoTableViewCell *cell = (billingInfoTableViewCell *)[_billingInfoTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    
    
    if (firstName.length ==0||lastName.length ==0||street.length ==0||city.length ==0||state.length ==0||pincode.length ==0||phoneNo.length ==0||pan.length == 0) {//||company.length ==0
        
        [self alertControllTitle:@"Alert" message:@"Please fill all mandatory fields"];
        
    }
    
    else if (phoneNo.length <10)
    {
       [self alertControllTitle:@"Alert" message:@"Invalid mobile Number"];
    }
    
//   else if (cell.textView.tag ==7)
//   {
//      
//       
//    }
    else
    {
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
        
       [self saveBuildingInfo:dic];
        
        
        
        
    }
    
    


    
}

-(void)alertControllTitle:(NSString *)title message:(NSString *)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:ok];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)backBtnActn:(id)sender
{
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
-(void)saveBuildingInfo :(NSDictionary *)params
{
[[STParsing sharedWebServiceHelper]requesting_POST_ServiceWithString1:@"saveBilling" parameters:params requestNumber:WS_BUILDING_INFO showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *response=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"response"]];
             if ([response isEqualToString:@"1"])
             {
                ShippingViewController *shippingViewController = [[ShippingViewController alloc]init];
                [self.navigationController pushViewController:shippingViewController animated:YES];
            }
             else
             {
                ALERT_DIALOG(@"Alert",[response valueForKey:@"message"]);
            }
         }
         else
         {
         }
     }];
}

@end
