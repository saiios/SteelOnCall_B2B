//
//  CompareViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 29/11/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "CompareViewController.h"
#import "CompareTableViewCell.h"
#import "BillingInfoViewController.h"
#import "STParsing.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface CompareViewController ()<NIDropDownDelegate>
{
    NSMutableArray *tataVizagArr;//both tata and vizag
     NSMutableArray * compareArr;//compare button list
     NSMutableArray * brandArr;//to compare with tata and vizag list
}

@end

@implementation CompareViewController
@synthesize btnSelect;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _compareListview.dataSource = self;
    _compareListview.delegate = self;
    tataVizagArr = [[NSMutableArray alloc]init];
    compareArr = [[NSMutableArray alloc]init];
    brandArr = [[NSMutableArray alloc]init];
    tonnes_names_ary=[_T_P_Ary mutableCopy];
   self.automaticallyAdjustsScrollViewInsets = NO;
    
    btnSelect.layer.borderWidth = 1;
    btnSelect.layer.borderColor = [[UIColor blackColor] CGColor];
    btnSelect.layer.cornerRadius = 5;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    user_data=[NSUserDefaults standardUserDefaults];
    
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    if ([C_Count isEqual:[NSNull null]]||[C_Count isEqualToString:@""]||C_Count ==nil||[C_Count isEqualToString:@"<nil>"])
    {
        _Cart_count.text=@"0";
        user_data=[NSUserDefaults standardUserDefaults];
        [user_data setValue:@"0" forKey:@"cart_count"];
    }
    else
        _Cart_count.text=C_Count;
    
    
    _Cart_BackgrndView.layer.borderWidth = 1;
    _Cart_BackgrndView.layer.borderColor = [[UIColor blackColor] CGColor];
    _Cart_BackgrndView.layer.cornerRadius = 10;
    
   // tap gesture
    UITapGestureRecognizer *cart_tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(Cart_click:)];
    [_Cart_count addGestureRecognizer:cart_tap];
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    [self.view addGestureRecognizer:tap];
    [tap setNumberOfTapsRequired:1];
    [tap setCancelsTouchesInView:NO];
    
    [self preferredStatusBarStyle];
    [self setNeedsStatusBarAppearanceUpdate];
    self.navigationController.navigationBar.hidden =YES;

   
    [self getcomapare];
}
-(void)tapped{
    
    //    _searchTextField.text =@"";
    //    selectedDic = [[NSDictionary alloc]init];
    //    searchView.hidden =YES;
    [self.view endEditing:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del setShouldRotate:YES];
    self.navigationController.navigationBar.hidden =YES;
    self.automaticallyAdjustsScrollViewInsets = NO;

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    user_data=[NSUserDefaults standardUserDefaults];
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    _Cart_count.text=C_Count;
//    _cart_view.clipsToBounds = YES;
//    _cart_view.layer.cornerRadius = 10;
    
   

}

-(void)getcomapare{
    
    NSString *url_form=[NSString stringWithFormat:@"getcomapare?ids=%@&location=%@",_selected_ids,_Location];
    
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:WS_GET_GetComapare showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data)
             {
                 tataVizagArr = [[data valueForKey:@"brandsInfoList"] valueForKey:@"brandinfo"];
                 compareArr = [data valueForKey:@"otherbrands"];
             }
             else
             {
                 
             }
             
             [_compareListview reloadData];
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
- (void)viewDidUnload {
    //    [btnSelect release];
    btnSelect = nil;
    [self setBtnSelect:nil];
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tataVizagArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
           
        static NSString *simpleTableIdentifier = @"CellIdentifier";
        CompareTableViewCell *cell = (CompareTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompareTableViewCell" owner:self options:nil];
            cell = (CompareTableViewCell *)[nib objectAtIndex:0];
        }
    
    NSArray *ar = tataVizagArr[indexPath.row];
    for (NSDictionary *dictt in ar)
    {
        // accessing the custom objects inside the nested arrays
            if ([[dictt valueForKey:@"brand"]isEqualToString:@"Vizag Steel"])
            {
                if ([[dictt valueForKey:@"seller"]isEqualToString:@""])
                {
                    cell.vizagPriceLbl.text = @"Not Avilable";
                    cell.VizagSellerNameLbl.text = @"Not Avilable";
                }
                else
                {
                cell.vizagPriceLbl.text = [NSString stringWithFormat:@"₹ %@",[dictt valueForKey:@"price"]];
                cell.VizagSellerNameLbl.text = [NSString stringWithFormat:@" %@",[dictt valueForKey:@"seller"]];
                    
                float tonsFromScreen = [[NSString stringWithFormat:@"%@",[[tonnes_names_ary valueForKey:@"tonnes"]objectAtIndex:indexPath.row]] floatValue];
                    
                cell.vizagFinalPriceLbl.text = [NSString stringWithFormat:@"₹ %.2f",[[dictt valueForKey:@"price"] intValue]*tonsFromScreen];
                }
             }
            
            if ([[dictt valueForKey:@"brand"]isEqualToString:@"Tata Steel"])
            {
                if ([[dictt valueForKey:@"seller"]isEqualToString:@""]) {
                    cell.tataPriceLbl.text = @"Not Avilable";
                    cell.tataSellerNameLbl.text = @"Not Avilable";
                }
                else
                {
                    cell.tataPriceLbl.text = [NSString stringWithFormat:@"₹ %@",[dictt valueForKey:@"price"]];
                    cell.tataSellerNameLbl.text = [NSString stringWithFormat:@" %@",[dictt valueForKey:@"seller"]];
                     float tonsFromScreen = [[NSString stringWithFormat:@"%@",[[tonnes_names_ary valueForKey:@"tonnes"]objectAtIndex:indexPath.row]] floatValue];
                    
                    cell.tataFinalPriceLbl.text = [NSString stringWithFormat:@"₹ %.2f",[[dictt valueForKey:@"price"] intValue]*tonsFromScreen];//pass on of tons
                    
                }
            }
        cell.name.text=[[tonnes_names_ary valueForKey:@"name"]objectAtIndex:indexPath.row];
        cell.tonnes.text=[NSString stringWithFormat:@"%@ tonnes",[[tonnes_names_ary valueForKey:@"tonnes"]objectAtIndex:indexPath.row]];

        NSURL *imageURL = [NSURL URLWithString:[[tonnes_names_ary valueForKey:@"img"]objectAtIndex:indexPath.row]];
        [cell.img sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [cell.img.layer setBorderColor: [[UIColor colorWithRed:213.0/255.0 green:216.0/255.0 blue:224.0/255.0 alpha:1] CGColor]];
        [cell.img.layer setBorderWidth: 2.0];
    }
    
    
    if (!([brandArr count] == 0)) {
        
      //  NSArray *arr = brandArr[indexPath.row];
        
            
                if ([[[brandArr objectAtIndex:indexPath.row] valueForKey:@"seller"]isEqualToString:@""]) {
                    cell.comparePriceLbl.text = @"Not Avilable";
                    cell.compareCellarNameLbl.text = @"Not Avilable";
                }
                else
                {
                    cell.comparePriceLbl.text = [NSString stringWithFormat:@"₹ %@",[[brandArr objectAtIndex:indexPath.row] valueForKey:@"price"]];
                    cell.compareCellarNameLbl.text = [NSString stringWithFormat:@" %@",[[brandArr objectAtIndex:indexPath.row] valueForKey:@"seller"]];
                    float tonsFromScreen = [[NSString stringWithFormat:@"%@",[[tonnes_names_ary valueForKey:@"tonnes"]objectAtIndex:indexPath.row]] floatValue];
                    
                    cell.compareFinalPriceLbl.text = [NSString stringWithFormat:@"₹ %.2f",[[[brandArr objectAtIndex:indexPath.row] valueForKey:@"price"] intValue]*tonsFromScreen];//pass no of tonns
                }
             
        
        
    }
    
    else {
        cell.comparePriceLbl.text = @"Not Avilable";
        cell.compareCellarNameLbl.text = @"Not Avilable";
    }
    
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    //nothing to do now
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectClicked:(id)sender
{
    NSArray * arr = [[NSArray alloc] init];
    arr = [compareArr copy];
   

   
    if(dropDown == nil) {
        CGFloat f = 200;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :arr :@"down"];
        dropDown.delegate = self;
        dropDown.userInteractionEnabled =YES;
        _compareListview.userInteractionEnabled = false;
        [self.view bringSubviewToFront:dropDown];
    }
    else {
        _compareListview.userInteractionEnabled = true;
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (IBAction)backButtonClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Cart_click:(id)sender {
    
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

- (void) niDropDownDelegateMethod: (NIDropDown *) sender selectedTXT:(NSString *)selctedTitle {
    
    [self rel];
    
    NSLog(@"%@", selctedTitle);
    NSString *brand = selctedTitle;
    if (![selctedTitle isEqualToString:@"--Select Brand--"]){
        
            [self getBrandInfo:brand];
    }else{
        
            [btnSelect setTitle:@"Select Brand" forState:UIControlStateNormal];
    }

    

    
}


-(void)rel{
    _compareListview.userInteractionEnabled = true;
    dropDown = nil;
}
-(void)getBrandInfo:(NSString *)brand{
    
    NSString *url_form=[NSString stringWithFormat:@"getBrandInfo?ids==%@&location=%@&brand=%@",_selected_ids,_selected_ids,brand];
    
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:WS_GET_GetBrandInfo showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data)
             {
            
                     
                     brandArr = data;
                     
                     [_compareListview reloadData];
                     
                 }
             
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
