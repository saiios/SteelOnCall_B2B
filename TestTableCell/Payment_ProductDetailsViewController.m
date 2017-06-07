//
//  Payment_ProductDetailsViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "Payment_ProductDetailsViewController.h"
#import "Pay_ProductDetailsTableViewCell.h"
#import "Pay_Amount_TableViewCell.h"
#import "Pat_AmountOnline_TableViewCell.h"
#import "SuccessOrderViewController.h"
#import "CCWebViewController.h"

@interface Payment_ProductDetailsViewController ()
{
    NSMutableArray* products;
    NSMutableArray* billingInfo;
    NSString *subtotal;
    NSString *grandtotal;
    NSString *shipping_price;
    
    //values to ccavenue
    
    NSString *CCsubtotal;
    NSString *CCgrandtotal;
    NSString *CCshipping_price;
    
}

@end

@implementation Payment_ProductDetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    products = [[NSMutableArray alloc] init];
    _paymentTableView.dataSource = self;
    _paymentTableView.delegate = self;
    
     [self getOrderReview];
    _paymentTableView.estimatedRowHeight = 80;//the estimatedRowHeight but if is more this autoincremented with autolayout
    _paymentTableView.rowHeight = UITableViewAutomaticDimension;
    [_paymentTableView setNeedsLayout];
    [_paymentTableView layoutIfNeeded];

   }

-(void)getOrderReview
{
    
    NSString *url_form=[NSString stringWithFormat:@"getOrderReview?customer_id=%@",user_id];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url_form requestNumber:WS_GET_GetOrderReview showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data)
             {
                 products =[data valueForKey:@"products"];//products array
                 
                 subtotal = [NSString stringWithFormat:@"₹ %@",[data valueForKey:@"subtotal"]];
                 grandtotal = [NSString stringWithFormat:@"₹ %@",[data valueForKey:@"grandtotal"]];
                 shipping_price = [NSString stringWithFormat:@"₹ %@",[data valueForKey:@"shipping_price"]];
                 billingInfo = [[NSMutableArray alloc]init];
                 billingInfo = [data valueForKey:@"billing_address"];

                 
                 // same values to send ccAvenue
                 
                 
                 CCsubtotal = [NSString stringWithFormat:@"%@",[data valueForKey:@"subtotal"]];
                 CCgrandtotal = [NSString stringWithFormat:@"%@",[data valueForKey:@"grandtotal"]];
                 CCshipping_price = [NSString stringWithFormat:@"%@",[data valueForKey:@"shipping_price"]];
                 
                 
             }
             else
             {
                 
             }
             
             [_paymentTableView reloadData];
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
//
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
//        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
//        return nil;
//    }
//    
//    
//    
//    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return [products count]+1;// 4= arr , 1 = sub celll
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
            if (indexPath.row != [products count])//arr count
    {
        
        static NSString *simpleTableIdentifier = @"payproduct";
        Pay_ProductDetailsTableViewCell *cell = (Pay_ProductDetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Pay_ProductDetailsTableViewCell" owner:self options:nil];
            cell = (Pay_ProductDetailsTableViewCell *)[nib objectAtIndex:0];
            
        }
        
        cell.seller_NameLbl.text = [[products objectAtIndex:indexPath.row]valueForKey:@"sellerName"];
        cell.product_NameLbl.text = [[products objectAtIndex:indexPath.row]valueForKey:@"name"];
        cell.brand_NameLbl.text = [[products objectAtIndex:indexPath.row]valueForKey:@"brand"];
        cell.grade_nameLbl.text = [[products objectAtIndex:indexPath.row]valueForKey:@"grade"];
        cell.price_per_tonLbl.text = [NSString stringWithFormat:@"%@",[[products objectAtIndex:indexPath.row]valueForKey:@"tonprice"]];//price
        cell.Quantity_Lbl.text = [NSString stringWithFormat:@"%@(Tons),%@(Pieces)",[[products objectAtIndex:indexPath.row]valueForKey:@"quantityInTonnes"],[[products objectAtIndex:indexPath.row]valueForKey:@"quantityInPieces"]];
//        unsigned long price = [[[products objectAtIndex:indexPath.row]valueForKey:@"price"] longLongValue];
//        unsigned long tons = [[[products objectAtIndex:indexPath.row]valueForKey:@"quantityInTonnes"] longLongValue];
//        
//        unsigned long long subtotl = price * tons;
//  
        
       // cell.sub_toatal.text = [NSString stringWithFormat:@"%lu",subtotl];
        
       // cell.sub_toatal.text = [NSString stringWithFormat:@"%@",[[products objectAtIndex:indexPath.row]valueForKey:@"price"]];
        
        cell.sub_toatal.text = subtotal;
        
//        [NSString stringWithFormat:@"₹ %ld",(long)[[products objectAtIndex:indexPath.row]valueForKey:@"quantityInTonnes"]*(long)[[products objectAtIndex:indexPath.row]valueForKey:@"price"]];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
            else{
                
                if ([_payType isEqualToString:@"21"])
                {
                    static NSString *simpleTableIdentifier = @"payamountonline";
                    Pat_AmountOnline_TableViewCell *cell = (Pat_AmountOnline_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                    
                    
                    if (cell == nil)
                    {
                        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Pat_AmountOnline_TableViewCell" owner:self options:nil];
                        cell = (Pat_AmountOnline_TableViewCell *)[nib objectAtIndex:0];
                    }
                    
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                     [cell.Online_OrderPlaceBtnOutlet addTarget:self action:@selector(OnlineplaceOrderClicked) forControlEvents:UIControlEventTouchUpInside];
                    cell.sub_total.text=subtotal;
                    cell.Grand_total.text=grandtotal;
                    cell.shipping_handling.text=shipping_price;
                    cell.Shipping_Handling_Charges.text=shipping_price;

                    return cell;
                }
                
                else
                {
                    static NSString *simpleTableIdentifier = @"payamount";
                    Pay_Amount_TableViewCell *cell = (Pay_Amount_TableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
                    
                    if (cell == nil)
                    {
                        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Pay_Amount_TableViewCell" owner:self options:nil];
                        cell = (Pay_Amount_TableViewCell *)[nib objectAtIndex:0];
                    }
                    
                    if([_payType isEqualToString:@"1"])
                    {
                        [cell.Offline_OrderPlacedBtnOutlet addTarget:self action:@selector(OnlineplaceOrderClicked) forControlEvents:UIControlEventTouchUpInside];
                    }
                    else
                     [cell.Offline_OrderPlacedBtnOutlet addTarget:self action:@selector(OfflineplaceOrderClicked) forControlEvents:UIControlEventTouchUpInside];
                    
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    
                    cell.sub_total.text=subtotal;
                    cell.Grand_total.text=grandtotal;
                    cell.shipping_handling.text=shipping_price;
                    cell.Shipping_Handling_Charges.text=shipping_price;
                    
                    return cell;
                  
                }
                
  }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (indexPath.row != [products count]) {
         
         
         return 327;
     }
    else
    {
        if ([_payType isEqualToString:@"21"]) {//online
            return 478;
        }
        else
            return 693;
        
    }
   
}

-(void)OnlineplaceOrderClicked
{
    
    [self placeOrder];
    
}

-(void)OfflineplaceOrderClicked
{
    
    [self placeOrder];
   
}

-(void)placeOrder
{
    
    NSString *url_form=[NSString stringWithFormat:@"placeOrder?customer_id=%@",user_id];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url_form requestNumber:WS_GET_PlaceOrderReview showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             if (data)
             {
                 if ([[data valueForKey:@"response"]isEqualToString:@"Order Placed Successfully"])
                     
                 {
                     
                     
                     if ([_payType isEqualToString:@"21"]) {//online
                         
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         
                         
                         CCWebViewController *myNewVC = (CCWebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CCWebViewControllerId"];
                         myNewVC.shipping = _shippingaddress;
                         myNewVC.billing = billingInfo;
                         myNewVC.amount = CCshipping_price;
                         myNewVC.orderId = [data valueForKey:@"order_inc_id"];
                         
                         [self.navigationController pushViewController:myNewVC animated:YES];
                         
                     }
                     
                     else if ([_payType isEqualToString:@"1"]) {//online
                         
                         UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                         CCWebViewController *myNewVC = (CCWebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CCWebViewControllerId"];
                         myNewVC.amount = CCgrandtotal;
                         myNewVC.shipping = _shippingaddress;
                         myNewVC.orderId = [data valueForKey:@"order_inc_id"];
                         myNewVC.billing = billingInfo;
                         
                         [self.navigationController pushViewController:myNewVC animated:YES];
                         
                     }
                     
                     else{
                         
                         SuccessOrderViewController *myControllerHastag = [[SuccessOrderViewController alloc]initWithNibName:@"SuccessOrderViewController" bundle:nil];
                         myControllerHastag.responce = data;
                         
                         [self.navigationController pushViewController:myControllerHastag animated:YES];
                       
                     }
                     
                 }
                 
                 
                     else
                     {
                         ALERT_DIALOG(@"Alert", @"Check your Orders and try again please..");
                     }
             }
         
             else
             {
                 ALERT_DIALOG(@"Alert", @"Something went wrong Please try again");
             }
             
            
         }
         else
         {
            
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

- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
