//
//  OrderReviewViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 02/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "OrderReviewViewController.h"
#import "OrderReview_HeadingTableViewCell.h"
#import "OrderReview_DetailsTableViewCell.h"
#import "OrderReview_AddressTableViewCell.h"
#import "OrderReview_AmountTableViewCell.h"
#import "PaymentType_ViewController.h"
#import "LoginViewController.h"
#import "My_Cart.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OrderReviewViewController ()
{
    NSMutableArray *quoteArr;
    NSMutableArray *sellers_info;
    NSMutableArray *shipping_address;
    NSMutableArray *seller_address;
    NSMutableArray *productsArr;
    NSMutableString *shipping_address1;
    NSMutableString * seller_address1;
    
    NSString *total_distance;
    NSString *total_price;
    NSString *total_tons;
}


@end

@implementation OrderReviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.automaticallyAdjustsScrollViewInsets = NO;
    _orderRecordTableview.dataSource = self;
    _orderRecordTableview.delegate = self;
    
     quoteArr = [[NSMutableArray alloc]init];
     sellers_info = [[NSMutableArray alloc]init];
     shipping_address = [[NSMutableArray alloc]init];
     seller_address = [[NSMutableArray alloc]init];
    productsArr = [[NSMutableArray alloc]init];
    
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];

    // servic
    NSString *url_form=[NSString stringWithFormat:@"getShippingAndHandling?customer_id=%@",user_id];
   // NSString *respo = [self getDataFrom:url_form];
   // NSLog(@"%@",respo);
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:url_form requestNumber:Shipping_Handling showProgress:YES withHandler:^(BOOL success, id data)
     {
         NSDictionary *billingAddressService=data;
         
         if (success)
         {
             quoteArr =[billingAddressService valueForKey:@"quote"];
             sellers_info =  [billingAddressService valueForKey:@"sellers_info"];
            productsArr = [[billingAddressService valueForKey:@"sellers_info"] valueForKey:@"products"];
           
             for(NSArray *subArray in productsArr)
             {
                 NSLog(@"Array in myArray: %@",subArray);
             }
            
             shipping_address = [sellers_info valueForKey:@"shipping_address" ];
             seller_address = [sellers_info valueForKey:@"seller_address" ];
             [_orderRecordTableview reloadData];
         }
         else
         {
         }
     }];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    user_data=[NSUserDefaults standardUserDefaults];
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    _cart_CountLbl.text=C_Count;
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
//        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
//        return nil;
//    }
//    
//    
//    
//    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
//}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (sellers_info.count==0)
    {
        return 0;
    }
    else
        return [sellers_info count]+1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //base View
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, 44)];
    
    UILabel *prdctLbl = [[UILabel alloc]initWithFrame:CGRectMake(8, 0, ([UIScreen mainScreen].bounds.size.width-16)/2-1, vi.frame.size.height)];
    prdctLbl.text = @"Product";
    prdctLbl.textColor =   [UIColor whiteColor];
    prdctLbl.backgroundColor = [UIColor colorWithRed:44/255.0f green:52/255.0f blue:75/255.0f alpha:1.0f];
    prdctLbl.textAlignment = NSTextAlignmentCenter;
    
    vi.backgroundColor = [UIColor whiteColor];
    [vi addSubview:prdctLbl];
    
    UILabel *QntyLbl = [[UILabel alloc]initWithFrame:CGRectMake(prdctLbl.frame.origin.x+prdctLbl.frame.size.width+1, 0, prdctLbl.frame.size.width, vi.frame.size.height)];
    QntyLbl.text = @"Quantity";
    QntyLbl.textColor = [UIColor whiteColor];
    QntyLbl.backgroundColor = [UIColor colorWithRed:44/255.0f green:52/255.0f blue:75/255.0f alpha:1.0f];
    QntyLbl.textAlignment = NSTextAlignmentCenter;
    
    vi.backgroundColor = [UIColor whiteColor];
    [vi addSubview:QntyLbl];
    return vi;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (sellers_info.count==0)
    {
        return 0;
    }
    else
    {
        if ([sellers_info count] == section )
        {
            return 1;
        }
        else
        {
        return [[[sellers_info objectAtIndex:section] valueForKey:@"products"] count]+1;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([sellers_info count]>0)
    {
       if ([sellers_info count] == indexPath.section )
       {
           static NSString *simpleTableIdentifier = @"cellamount";
           OrderReview_AmountTableViewCell *cell = (OrderReview_AmountTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
           
           if (cell == nil)
           {
               NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderReview_AmountTableViewCell" owner:self options:nil];
               cell = (OrderReview_AmountTableViewCell *)[nib objectAtIndex:0];
               
               [cell.continueBtnOutlet addTarget:self action:@selector(continuePayment) forControlEvents:UIControlEventTouchUpInside];
           }
           
           cell.shipping_Amount_Lbl.text =[NSString stringWithFormat:@"₹ %@",[[quoteArr objectAtIndex:0] valueForKey:@"total_amount"]];
           cell.total_Hndling_Price_Lbl.text =[NSString stringWithFormat:@"₹ %@",[[quoteArr objectAtIndex:0] valueForKey:@"handling_price"]];
           cell.shippnig_Handling_Charges.text =[NSString stringWithFormat:@"₹ %@",[[quoteArr objectAtIndex:0] valueForKey:@"shipping_handling_price"]];
           cell.selectionStyle=UITableViewCellSelectionStyleNone;
           
           return cell;

       }
       else
       {
        NSLog(@"%ld : %ld  : %ld",(long)indexPath.section,(long)indexPath.row,[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] count]);

    if ([[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] count] == indexPath.row) {
        
        static NSString *simpleTableIdentifier = @"celladdressdetails";
        OrderReview_AddressTableViewCell *cell = (OrderReview_AddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderReview_AddressTableViewCell" owner:self options:nil];
            cell = (OrderReview_AddressTableViewCell *)[nib objectAtIndex:0];
        }
        //seller_address
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.seller_NameLbl.text = [[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"seller_address"] objectAtIndex:0] valueForKey:@"name"];
        
        NSString *street = [[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"seller_address"] objectAtIndex:0] valueForKey:@"street"];
        NSString *city = [[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"seller_address"] objectAtIndex:0] valueForKey:@"name"];
        NSString *pincode = [[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"seller_address"] objectAtIndex:0] valueForKey:@"pincode"];
        
        seller_address1 = [@"Address: " mutableCopy];
        if ([street isEqual:[NSNull null] ]||[street isEqualToString:@"<null>"]||[street isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            seller_address1 = [[seller_address1  stringByAppendingString:street] mutableCopy];
        }
        
        if ([city isEqual:[NSNull null] ]||[city isEqualToString:@"<null>"]||[city isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            seller_address1 = [seller_address1 mutableCopy];
        }
        if ([pincode isEqual:[NSNull null] ]||[pincode isEqualToString:@"<null>"]||[pincode isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            seller_address1 = [[seller_address1 stringByAppendingString:pincode] mutableCopy];
        }
        
        
        cell.sellar_AddressTXtView.text = seller_address1;
        
        
        
        shipping_address1 = [@"Address: " mutableCopy];
        NSString *f_name=[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"firstname"];
        
        
        if ([f_name isEqual:[NSNull null] ]||[f_name isEqualToString:@"<null>"]||[f_name isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            cell.shipping_NameLbl.text = [[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"firstname"];
            
        }
        
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"street1"]]);
        NSString *street1=[NSString stringWithFormat:@"%@",[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"street1"]];
        NSString *street2=[NSString stringWithFormat:@"%@",[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"street2"]];
        
        if ([street1 isEqual:[NSNull null] ]||[street1 isEqualToString:@"<null>"]||[street1 isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            shipping_address1=[[shipping_address1 stringByAppendingString:street1]mutableCopy] ;
        }
        
        if ([street2 isEqual:[NSNull null] ]||[street2 isEqualToString:@"<null>"]||[street2 isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            shipping_address1=[[shipping_address1 stringByAppendingString:street2] mutableCopy];
        }
        
        
        NSString *city_str=[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"city"];
        NSString *district_str=[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"district"];
        NSString *region_str=[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"region"];
        NSString *postcode_str=[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"shipping_address"] objectAtIndex:0] valueForKey:@"postcode"];
        
        if ([city_str isEqual:[NSNull null] ]||[city_str isEqualToString:@"<null>"]||[city_str isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            shipping_address1= [[shipping_address1 stringByAppendingString:city_str] mutableCopy];
        }
        
        if ([district_str isEqual:[NSNull null] ]||[district_str isEqualToString:@"<null>"]||[district_str isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            shipping_address1=[[shipping_address1 stringByAppendingString:district_str]mutableCopy];
        }
        if ([region_str isEqual:[NSNull null] ]||[region_str isEqualToString:@"<null>"]||[region_str isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            shipping_address1=[[shipping_address1 stringByAppendingString:region_str]mutableCopy];
        }
        if ([postcode_str isEqual:[NSNull null] ]||[postcode_str isEqualToString:@"<null>"]||[postcode_str isEqualToString:@""])
        {
            NSLog(@"null");
        }
        else
        {
            shipping_address1=[[shipping_address1 stringByAppendingString:postcode_str]mutableCopy] ;
        }
     
        NSString * distance = [NSString stringWithFormat:@"%@",[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"total_distance" ]];
        
         if ([distance isEqual:[NSNull null]]||[distance isEqualToString:@"<nil>"]||distance == nil||[distance isEqualToString:@""]||[distance isEqualToString:@"0"])
         {
              cell.distanceLbl.text = @"Not Avilable";
         }
        else
        {
        cell.distanceLbl.text = [NSString stringWithFormat:@"%@",[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"total_distance" ]];
        }
        
        cell.shipping_AmontLbl.text = [NSString stringWithFormat:@"₹%@",[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"total_price" ]];
        //cell.distanceLbl.text = [NSString stringWithFormat:@"%@",[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"total_tons"]];
        
        cell.Shipping_AddressTxtView.text = shipping_address1;
        
        return cell;
    }else{
        static NSString *simpleTableIdentifier = @"cellorderdetails";
        OrderReview_DetailsTableViewCell *cell = (OrderReview_DetailsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderReview_DetailsTableViewCell" owner:self options:nil];
            cell = (OrderReview_DetailsTableViewCell *)[nib objectAtIndex:0];
        }
        
           // if (indexPath.row!=0) {
                
              //  for (int i = 1; i<[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] count]; i++) {
        NSLog(@" >>> %ld : %ld",(long)indexPath.section,(long)indexPath.row);

            
         if (indexPath.row < [[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] count] ) {
             
                    cell.order_title_lbl.text = [[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] objectAtIndex:indexPath.row] valueForKey:@"name"];
                    
                    cell.Tons_Lbl.text =[NSString stringWithFormat:@"Tons: %d",[[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] objectAtIndex:indexPath.row] valueForKey:@"tons"] intValue]] ;
                    
                    
                    cell.pices_Lbl.text =[NSString stringWithFormat:@"Piece: %d",[[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] objectAtIndex:indexPath.row] valueForKey:@"piece"] intValue]];
             
             
             
            
             
             SDWebImageManager *manager = [SDWebImageManager sharedManager];
             
             NSURL *ImageUrl = [NSURL URLWithString:[[[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] objectAtIndex:indexPath.row] valueForKey:@"img"]];
             
             [manager downloadImageWithURL:ImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
              
              {
                  
                  
              } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                  
                  if(image){
                      
                      cell.order_Image.image = image;
                      NSLog(@"image=====%@",image);
                  }
              }];
             

             
             
             
             
             
         }
             //   }
        
          //  }
            
            

        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
       
        
        return cell;
    
       }
       }
    }else{
        
                    static NSString *simpleTableIdentifier = @"cellheading";
                    OrderReview_HeadingTableViewCell *cell = (OrderReview_HeadingTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
                    if (cell == nil)
                    {
                        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"OrderReview_HeadingTableViewCell" owner:self options:nil];
                        cell = (OrderReview_HeadingTableViewCell *)[nib objectAtIndex:0];
                    }
        
        
        
        
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    
                    
                    
                    return cell;

    }
  

   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //    UIViewController *billController = [[BillingInfoViewController alloc] initWithNibName:@"BillingInfoViewController" bundle:nil];
    //
    //    [self.navigationController pushViewController:billController animated:YES];
    
   
    
    //nothing to do now
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([sellers_info count] == section ) {
        
        return 0;
    }else{
          return 44;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
        
            
  
    if ([sellers_info count]>0) {
         if ([sellers_info count] == indexPath.section ) {
              return 204;
         }else{
        if ([[[sellers_info objectAtIndex:indexPath.section] valueForKey:@"products"] count] == indexPath.row) {
            return 263;
        }else{
            return 130;
            
        }
         }
    }else{
      return  162;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[_orderRecordTableview class]]) {
        
        
        CGFloat sectionHeaderHeight = 44;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
}
-(void)shipping_method
{
    NSString *shipping_handling_price = [NSString stringWithFormat:@"%@", [ [quoteArr objectAtIndex:0]   valueForKey:@"shipping_handling_price"]];
    
    NSString *url_form=[NSString stringWithFormat:@"saveShippingMethod?customer_id=%@&amount=%@",user_id,shipping_handling_price];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString: url_form requestNumber:Shipping_Method showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *res_dict=data;
             NSString *response=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"response"]];
             if ([response isEqualToString:@"1"])
             {
                 PaymentType_ViewController *paymentType_ViewController = [[PaymentType_ViewController alloc] initWithNibName:@"PaymentType_ViewController" bundle:nil];
                 
                 paymentType_ViewController.shippingAddress = shipping_address;
                 [self.navigationController pushViewController:paymentType_ViewController animated:YES];
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

-(void)continuePayment
{
    [self shipping_method];
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
