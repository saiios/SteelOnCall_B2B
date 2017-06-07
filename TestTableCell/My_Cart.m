//
//  My_Cart.m
//  SteelonCall
//
//  Created by Manoyadav on 02/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//
//
#import "My_Cart.h"
//
@interface My_Cart ()
{
    NSMutableArray *checkSixTonnesArr;
}

@end

@implementation My_Cart
@synthesize activityView;


-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del setShouldRotate:NO];
    [activityView removeFromSuperview];
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:44.0/255.0 green:52.0/255.0 blue:75.0/255.0 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
     UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 188, 40)];
    navigationImage.image=[UIImage imageNamed:@"logo.png"];
    self.navigationItem.titleView=navigationImage;
    
    UIButton *cameraButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, 40.0f, 40.0f)];
    UIImage *cameraImage = [UIImage imageNamed:@"Back"];
    [cameraButton setBackgroundImage:cameraImage forState:UIControlStateNormal];
    [cameraButton addTarget:self action:@selector(Back_click) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* cameraButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    self.navigationItem.leftBarButtonItem = cameraButtonItem;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    _cart_count.text=[NSString stringWithFormat:@"My Cart (%@)",[user_data valueForKey:@"cart_count"]];
    Grand_total=0;
    
    _cart_table.dataSource = self;
    _cart_table.delegate = self;
    _cart_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _cart_table.allowsSelection=NO;
    Cart_Products_ary=[[NSMutableArray alloc]init];
    _cart_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    pieces_per_ton_ary=[[NSMutableArray alloc]init];
    Grand_Total_Dict=[[NSMutableDictionary alloc]init];
    
    keyboardIsShown=NO;
    //notifications
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillShow:)
//                                                 name:UIKeyboardWillShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillHide:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
    
    //tap gesture
    singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.cart_table addGestureRecognizer:singleFingerTap];
    
    [self card_products];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    [self.view endEditing:YES];
}
-(void)viewDidAppear:(BOOL)animated{
    tableHeight = self.cart_table.frame.size.height;
}

-(void)card_products
{
    NSString *url_form=[NSString stringWithFormat:@"getCustomerQuote?customer_id=%@",user_id];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Getting_Carts showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *Cart_Products_dict=data;
             NSArray *Products_ary=[Cart_Products_dict valueForKey:@"response"];
             NSString *check=[NSString stringWithFormat:@"%@",Products_ary];
             
             if ([check isEqualToString:@"0"])
             {
             }
             else
             {
                 Grand_total=0;
                 for (int d=0; d<Products_ary.count; d++)
                 {
                    if (d==0)
                    {
                        product_ids_str=[[Products_ary valueForKey:@"id"]objectAtIndex:d];
                    }
                    else
                        product_ids_str=[NSString stringWithFormat:@"%@_%@",product_ids_str,[[Products_ary valueForKey:@"id"]objectAtIndex:d]];
                     
                     [Cart_Products_ary addObject:[Products_ary objectAtIndex:d]];
                     NSString *pri_str=[[Cart_Products_ary valueForKey:@"price"]objectAtIndex:d];
                     float prict_int=[pri_str floatValue];
                     Grand_total=Grand_total+prict_int;
                     [Grand_Total_Dict setObject:pri_str forKey:[NSString stringWithFormat:@"%d",d]];
                 }
                // _Grand_lbl.text=[NSString stringWithFormat:@"₹ %.2f",Grand_total];
                 _Grand_lbl.text=[NSString stringWithFormat:@"₹ %@",[data valueForKey:@"grandtotal"]];
                
                 user_data=[NSUserDefaults standardUserDefaults];
                 [user_data setValue:[NSString stringWithFormat:@"%lu",(unsigned long)Cart_Products_ary.count] forKey:@"cart_count"];

                 _cart_count.text=[NSString stringWithFormat:@"My Cart (%@)",[user_data valueForKey:@"cart_count"]];
                 [self call_tonnes_service];
                 
                 [_cart_table reloadData];
             }
         }
         else
         {
            
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Cart_Products_ary.count==0)
    {
        return 0;
    }
    else
    return Cart_Products_ary.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==Cart_Products_ary.count )
    {
        static NSString *simpleTableIdentifier = @"Coupan_cell";
        Coupan_cell *cell = (Coupan_cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        cell.border_view.layer.borderColor=[UIColor blackColor].CGColor;
        cell.border_view.layer.borderWidth = 2.0f;
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Coupan_cell" owner:self options:nil];
            cell = (Coupan_cell *)[nib objectAtIndex:0];
        }
        [cell.send addTarget:self action:@selector(send_click) forControlEvents:UIControlEventTouchUpInside];
        cell.coupon.text=@"";
        return cell;
    }
    else
    {
    static NSString *simpleTableIdentifier = @"MyCart_Cell";
    MyCart_Cell *cell = (MyCart_Cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCart_Cell" owner:self options:nil];
        cell = (MyCart_Cell *)[nib objectAtIndex:0];
    }
        cell.remove.tag=indexPath.row;
        cell.save.tag=indexPath.row;

        [cell.remove addTarget:self action:@selector(remove_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.save addTarget:self action:@selector(save_click:) forControlEvents:UIControlEventTouchUpInside];
        cell.name.text=[[Cart_Products_ary valueForKey:@"name"]objectAtIndex:indexPath.row];
         cell.seller_name.text=[[Cart_Products_ary valueForKey:@"sellerName"]objectAtIndex:indexPath.row];
         cell.brand.text=[[Cart_Products_ary valueForKey:@"brand"]objectAtIndex:indexPath.row];
         cell.price.text=[NSString stringWithFormat:@"₹%@",[[Cart_Products_ary valueForKey:@"tonprice"]objectAtIndex:indexPath.row]];//changed to price
        cell.Discount_lbl.text = [NSString stringWithFormat:@"₹%@",[[Cart_Products_ary valueForKey:@"discount"]objectAtIndex:indexPath.row]];
         cell.tonnnes.text=[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"quantityInTonnes"]objectAtIndex:indexPath.row]];
         cell.pieces.text=[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"quantityInPieces"]objectAtIndex:indexPath.row]];
         cell.rolling.text=[[Cart_Products_ary valueForKey:@"grade"]objectAtIndex:indexPath.row];
        NSURL *imageURL = [NSURL URLWithString:[[Cart_Products_ary valueForKey:@"img"]objectAtIndex:indexPath.row]];
        [cell.img sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleBordered target:self
                                                                      action:@selector(doneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        cell.tonnnes.inputAccessoryView = keyboardDoneButtonView;
        cell.pieces.inputAccessoryView = keyboardDoneButtonView;
        cell.tonnnes.delegate = self;
        cell.pieces.delegate = self;
        
        NSString *Home_tag=[NSString stringWithFormat:@"1%ld",(long)indexPath.row];
        int Home_tag_int=[Home_tag intValue];
        NSString *Away_tag=[NSString stringWithFormat:@"2%ld",(long)indexPath.row];
        int Away_tag_int=[Away_tag intValue];
        
        cell.tonnnes.tag = Home_tag_int;
        cell.pieces.tag = Away_tag_int;
        
        UIColor *color = [UIColor grayColor];
        cell.tonnnes.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Quantity in Tonnes"
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:@"Arial" size:12.0]
                                                     }
         ];
        cell.pieces.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Quantity in Pieces"
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:@"Arial" size:12.0]
                                                     }
         ];

        float ton_price_int=[cell.price.text floatValue];
        float tons_int=[cell.tonnnes.text floatValue];
        float total_ton_price=ton_price_int*tons_int;
        cell.total_price.text=[NSString stringWithFormat:@"₹%@",[[Cart_Products_ary valueForKey:@"price"]objectAtIndex:indexPath.row]];
        return cell;
    }
}

- (IBAction)save_click:(id)sender
{
    /*
        int tag=[sender tag];
    NSString *parent_id=[[Cart_Products_ary valueForKey:@"id"]objectAtIndex:tag];
    NSString *child_id=[[Cart_Products_ary valueForKey:@"childId"]objectAtIndex:tag];
    NSString *quantity=[[Cart_Products_ary valueForKey:@"quantityInTonnes"]objectAtIndex:tag];

        NSString *url_form=[NSString stringWithFormat:@"editProductQty?parent_id=%@&child_id=%@&qty=%@&customer_id=%@",parent_id,child_id,quantity,user_id];
        NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Save_cart showProgress:YES withHandler:^(BOOL success, id data)
         {
             if (success)
             {
                 NSDictionary *Cart_Products_dict=data;
                 NSLog(@"Status %@",Cart_Products_dict);
            }
             else
             {
             }
         }];
     */
}

-(void)remove_click:(id)sender
{
    int tag=[sender tag];
    NSString *url_form=[NSString stringWithFormat:@"deleteCartItem?customer_id=%@&product_id=%@",user_id,[[Cart_Products_ary valueForKey:@"id"]objectAtIndex:tag]];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Remove_cart showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSDictionary *Cart_Products_dict=data;
             NSLog(@"Status %@",Cart_Products_dict);
             [Cart_Products_ary removeObjectAtIndex:tag];
             [pieces_per_ton_ary removeObjectAtIndex:tag];
             Grand_total =0;
             
             for (int d=0; d<Cart_Products_ary.count; d++)
             {
                 NSString *pri_str=[[Cart_Products_ary valueForKey:@"price"]objectAtIndex:d];
                 float prict_int=[pri_str floatValue];
                 Grand_total=Grand_total+prict_int;
                 //[Grand_Total_Dict setObject:pri_str forKey:[NSString stringWithFormat:@"%d",d]];
             }
             
          
             _Grand_lbl.text=[NSString stringWithFormat:@"₹ %.2f",Grand_total];

             user_data=[NSUserDefaults standardUserDefaults];
             [user_data setValue:[NSString stringWithFormat:@"%lu",(unsigned long)Cart_Products_ary.count] forKey:@"cart_count"];
             
              _cart_count.text=[NSString stringWithFormat:@"My Cart (%@)",[user_data valueForKey:@"cart_count"]];
             
             [_cart_table reloadData];
         }
         else
         {
         }
     }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == Cart_Products_ary.count)
    {
        return 332;// coupon height
    }
    else
        return 330;
}

-(void)send_click
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:Cart_Products_ary.count inSection:0];
        Coupan_cell *coupan_cell = (Coupan_cell *)
        [_cart_table cellForRowAtIndexPath:indexpath];
    NSString *coupon_text=coupan_cell.coupon.text;
    
    if ([coupon_text isEqualToString:@""]||[coupon_text isEqual:[NSNull null]]||coupon_text == nil)
    {
        // [self Alert:@"Please enter valid coupon code!"];
        ALERT_DIALOG(@"Alert", @"Please enter valid coupon code!");
    }
    else
    {
        NSString *url_form=[NSString stringWithFormat:@"couponPost?customer_id=%@&&coupon_code=%@&&remove=0",user_id,coupon_text];
        NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Coupon_send showProgress:YES withHandler:^(BOOL success, id data)
         {
             if (success)
             {
                 NSArray *Coupon_dict=data;
                 NSDictionary *coupon_dict=[[Coupon_dict valueForKey:@"response"]objectAtIndex:0];
                 NSString *status=[coupon_dict valueForKey:@"status"];
                 NSString *coupon_status=[coupon_dict valueForKey:@"message"];
                 NSLog(@"Coupon Status %@",coupon_status);
                // [self Alert:coupon_status];
                 ALERT_DIALOG(@"Alert", coupon_status);
                 [self.view endEditing:YES];
             }
             else
             {
//                 UIAlertController * alert=   [UIAlertController
//                                               alertControllerWithTitle:@"Alert"
//                                               message:[NSString stringWithFormat:@"%@",[data valueForKey:@"error_message"]]
//                                               preferredStyle:UIAlertControllerStyleAlert];
//                 
//                 UIAlertAction* ok = [UIAlertAction
//                                      actionWithTitle:@"OK"
//                                      style:UIAlertActionStyleDefault
//                                      handler:^(UIAlertAction * action)
//                                      {
//                                          [alert dismissViewControllerAnimated:YES completion:nil];
//                                      }];
//                 [alert addAction:ok];
//                 [self presentViewController:alert animated:YES completion:nil];
             }
         }];
    }
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the scrollview
    CGRect viewFrame = self.cart_table.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 100);
    if (viewFrame.size.height < tableHeight) {
        viewFrame.size.height = tableHeight;
    }
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.cart_table setFrame:viewFrame];
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
    CGRect viewFrame = self.cart_table.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 100);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.cart_table setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Continue_shopping:(id)sender
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

- (IBAction)PlaceOrder_click:(id)sender
{
    if (Cart_Products_ary.count>0)
    {
        BOOL check = false;
        
        int totalTons =0;
        
        for (int p=0; p<Cart_Products_ary.count; p++)
        {
            NSString *tonnes=[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"quantityInTonnes"]objectAtIndex:p]];
            if ([tonnes isEqual:[NSNull null]]||[tonnes isEqualToString:@""]||[tonnes isEqualToString:@"0"])
            {
                check = YES;
                break;
            }
            
            int currentTons =( int) [tonnes intValue];
            totalTons = totalTons+currentTons;

            
        }
        
        

        if (check) {
            [self Alert:@"Please enter tonnes quantity"];
        }
           // else  if (totalTons <6) {
//           
//            [self Alert:@"Please select min 6 tonnes to continue"];
//
//            }
        else{
            checkSixTonnesArr  = [[NSMutableArray alloc]init];
            for (int p=0; p<Cart_Products_ary.count; p++)
            {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
               
                
                [dict setValue:[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"quantityInTonnes"]objectAtIndex:p]] forKey:@"ton"];
                [dict setValue:[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"childId"]objectAtIndex:p]] forKey:@"child_id"];
                 [dict setValue:[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"id"]objectAtIndex:p]] forKey:@"product_id"];
                  [dict setValue:[NSString stringWithFormat:@"%@",[[Cart_Products_ary valueForKey:@"quantityInPieces"]objectAtIndex:p]] forKey:@"piece"];
                
                    [checkSixTonnesArr addObject:dict];
            
            }
            NSMutableDictionary *detailsDic = [[NSMutableDictionary alloc]init];
           // [detailsDic setValue:checkSixTonnesArr forKey:@"details"];
            [detailsDic setObject:checkSixTonnesArr forKey:@"details"];
            [self service:detailsDic];
            
            
    //            BillingInfoViewController *define = [[BillingInfoViewController alloc]init];
//            [self.navigationController pushViewController:define animated:YES];
        }
        
    }
    else
        [self Alert:@"Add products to the Cart!"];
}

-(void)service:(NSDictionary *)parameters
{
    _HUD.hidden =NO;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.responseSerializer =responseSerializer;
    NSString *urlString;
    urlString= [NSString stringWithFormat:@"%@checkQtyInCart",MAIN_Url];
    NSError *error;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    
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
                                                  
                                                  
                                                  NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                       options:kNilOptions
                                                                                                         error:&error];
                                                  NSLog(@"%@",json);
                                                 
                                                  
                                                  NSString *response=[[[json valueForKey:@"response"] objectAtIndex:0] valueForKey:@"status"];
                                                  NSString *responTovalidate = [NSString stringWithFormat:@"%@",response];
                                                  
                                                 
                                                  
                                                  if ([responTovalidate isEqualToString:@"1"])
                                                  {
                                                      //Background Thread
                                                      // _HUD.hidden =YES;
                                                      dispatch_async(dispatch_get_main_queue(), ^(void){
                                                          //Run UI Updates
                                                          //  [_HUD removeFromSuperview];
                                                          
                                                          //_HUD.hidden =YES;
                                                        [activityView removeFromSuperview];
                                                          
                                                          BillingInfoViewController *define = [[BillingInfoViewController alloc]initWithNibName:@"BillingInfoViewController" bundle:nil];
                                                          [self.navigationController pushViewController:define animated:YES];
                                                          
                                                      });
                                                      
                                                  }
                                                  else
                                                  {
                                                      
                                                      
                                                      
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^(void){
                                                          
                                                          
                                                          [activityView removeFromSuperview];
                                                      });
                                                      
                                                      //   [self Alert:@"Something went wrong"];
                                                      
                                                      NSString *responMessage;
                                                      
                                                      NSString *message=[[[json valueForKey:@"response"] objectAtIndex:0] valueForKey:@"message"];
                                                      NSString *sellers=[[[json valueForKey:@"response"] objectAtIndex:0] valueForKey:@"sellers"];
                                                      
                                                      if ([sellers isEqual:[NSNull null]]||[sellers isEqualToString:@""]||[sellers isEqualToString:@"<nil>"]||[sellers isEqualToString:@"nil"]||sellers == nil)
                                                      {
                                                          responMessage = [NSString stringWithFormat:@"%@",message];
                                                          
                                                          if ([responMessage isEqual:[NSNull null]]||[responMessage isEqualToString:@""]||[responMessage isEqualToString:@"(null)"]||[responMessage isEqualToString:@"nil"]||responMessage == NULL)
                                                          {
                                                              responMessage = @"Something went wrong";
                                                          }
                                                      }
                                                      else
                                                          responMessage = [NSString stringWithFormat:@"%@ For sellers %@",message,sellers];
                                                      
                                                      
                                                      ALERT_DIALOG(@"Alert", responMessage);
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
                                                                         
                                                                         
                                                                        [activityView removeFromSuperview];
                                                                        
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


-(void)Alert:(NSString *)Msg
{
    NSDictionary *options = @{kCRToastNotificationTypeKey:@(CRToastTypeNavigationBar),
                              
                              kCRToastTextKey : Msg,
                              
                              kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                              
                              kCRToastBackgroundColorKey : [UIColor colorWithRed:44.0/255.0 green:52.0/255.0 blue:75.0/255.0 alpha:1],
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

-(void)Back_click
{
    if ([_From_check isEqualToString:@"login"])
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
            
            
        }    }
    else
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)call_tonnes_service
{
    NSString *url_form=[NSString stringWithFormat:@"https://steeloncall.com/b2b/calculate/service/getcalculateqty?ids=%@",product_ids_str];
    
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString: urlEncoded requestNumber:PRODUCT_TONNES showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             NSDictionary *res_data=data;
             for (int p=0; p<res_data.count; p++)
             {
                 [pieces_per_ton_ary addObject:[[res_data valueForKey:@"pieces"]objectAtIndex:p]];
             }
         }
         else
         {
             
            
//             UIAlertController * alert=   [UIAlertController
//                                           alertControllerWithTitle:@"Alert"
//                                           message:[NSString stringWithFormat:@"%@",[data valueForKey:@"error_message"]]
//                                           preferredStyle:UIAlertControllerStyleAlert];
//             
//             UIAlertAction* ok = [UIAlertAction
//                                  actionWithTitle:@"OK"
//                                  style:UIAlertActionStyleDefault
//                                  handler:^(UIAlertAction * action)
//                                  {
//                                      [alert dismissViewControllerAnimated:YES completion:nil];
//                                  }];
//             [alert addAction:ok];
//             [self presentViewController:alert animated:YES completion:nil];
             
         }
     }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"enterd text %@",newString);
    
    NSString *Home_tag_str=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    NSString *TF_check = [NSString stringWithFormat:@"%c", [Home_tag_str characterAtIndex:0]];
    NSString *Tag = [Home_tag_str substringFromIndex:1];
    int row=[Tag intValue];
    NSLog(@"tag %d",row);
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
    MyCart_Cell *tappedCell = (MyCart_Cell *)[_cart_table cellForRowAtIndexPath:indexpath];
    
    if (pieces_per_ton_ary.count>0) {
        
    
    NSString *pieces_per_tonne=[pieces_per_ton_ary objectAtIndex:row];
    int pieces_per_tonne_int=[pieces_per_tonne intValue];
    
    if(((![string isEqualToString:@"0"] || textField.text.length>0 ) && textField.text.length <6) || [string isEqualToString:@""]) {
    
    
    if ([TF_check isEqualToString:@"1"])//tonnes
    {
        int tonnes_int=[newString intValue];
        int total_pieces_int=tonnes_int*pieces_per_tonne_int;
        NSString *total_pieces_str;
        if (total_pieces_int >0) {
            
            total_pieces_str=[NSString stringWithFormat:@"%d",total_pieces_int];
            
            if (total_pieces_str.length>6) {
                NSRange range = NSMakeRange(0,6);
                NSString *trimmedString=[total_pieces_str substringWithRange:range];
                total_pieces_str =trimmedString;
                
            }
            
        }else{
            
            newString = @"";
            total_pieces_str = @"";
            
        }
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        NSDictionary *oldDict = (NSDictionary *)[Cart_Products_ary objectAtIndex:row];
        [newDict addEntriesFromDictionary:oldDict];
        [newDict setObject:newString forKey:@"quantityInTonnes"];
        [newDict setObject:total_pieces_str forKey:@"quantityInPieces"];
        [Cart_Products_ary replaceObjectAtIndex:row withObject:newDict];
      

        
        tappedCell.pieces.text=total_pieces_str;
        [self change_tonnes_service:newString :row];
    }
    else if ([TF_check isEqualToString:@"2"])//pieces
    {
        float pieces_int=[newString floatValue];
        float total_tonnes_int=pieces_int/pieces_per_tonne_int;
        NSString *total_tonnes_str;
        if (total_tonnes_int >0) {
            total_tonnes_str=[NSString stringWithFormat:@"%.2f",total_tonnes_int];
            
            if (total_tonnes_str.length>6) {
                NSRange range = NSMakeRange(0,6);
                NSString *trimmedString=[total_tonnes_str substringWithRange:range];
                total_tonnes_str =trimmedString;
                
            }
        }else{
            newString = @"";
            total_tonnes_str = @"";
        }

        NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
        NSDictionary *oldDict = (NSDictionary *)[Cart_Products_ary objectAtIndex:row];
        [newDict addEntriesFromDictionary:oldDict];
 
      
        [newDict setObject:total_tonnes_str forKey:@"quantityInTonnes"];
        [newDict setObject:newString forKey:@"quantityInPieces"];
        [Cart_Products_ary replaceObjectAtIndex:row withObject:newDict];

        tappedCell.tonnnes.text=total_tonnes_str;
        
        [self change_tonnes_service:tappedCell.tonnnes.text :row];
    }
    }
    //  [_cart_table reloadData];
        
    }else{
        return NO;
    }
    return YES;
}

-(void)change_tonnes_service:(NSString *)tonnes :(int )tag_int
{
    NSString *child_id=[[Cart_Products_ary valueForKey:@"childId"]objectAtIndex:tag_int];
    NSString *prod_id=[[Cart_Products_ary valueForKey:@"id"]objectAtIndex:tag_int];
    
   NSString *url_form=[NSString stringWithFormat:@"changetons?id=%@&child_id=%@&ton=%@&customer_id=%@",prod_id,child_id,tonnes,user_id];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Change_tons showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             
             if ([data count]>0)
             {
            NSDictionary *res_dict=[ data objectAtIndex:0];
             if (res_dict.count>0)
             {
                 NSString *status=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"status"]];
                 if ([status isEqualToString:@"0"])
                 {
                     [self Alert:[res_dict valueForKey:@"message"]];
                 }
                 else
                 {
                     NSIndexPath *indexpath = [NSIndexPath indexPathForRow:tag_int inSection:0];
                     MyCart_Cell *tappedCell = (MyCart_Cell *)[_cart_table cellForRowAtIndexPath:indexpath];
                     discount_str=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"discount"]];
                     price_str=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"price"]];
                     
                     NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
                     NSDictionary *oldDict = (NSDictionary *)[Cart_Products_ary objectAtIndex:tag_int];
                     [newDict addEntriesFromDictionary:oldDict];
                     [newDict setObject:discount_str forKey:@"discount"];
                     [newDict setObject:price_str forKey:@"price"];
                     [Cart_Products_ary replaceObjectAtIndex:tag_int withObject:newDict];
                     
                     tappedCell.Discount_lbl.text=discount_str;
                     tappedCell.total_price.text=price_str;
                     
                     
                     Grand_total =0;
                     for (int d=0; d<Cart_Products_ary.count; d++)
                     {
                         NSString *pri_str=[[Cart_Products_ary valueForKey:@"price"]objectAtIndex:d];
                         float prict_int=[pri_str floatValue];
                         Grand_total=Grand_total+prict_int;
                         //[Grand_Total_Dict setObject:pri_str forKey:[NSString stringWithFormat:@"%d",d]];
                     }
                     
                     
                     _Grand_lbl.text=[NSString stringWithFormat:@"₹ %.2f",Grand_total];
                     
                     
                 }
             }
         }
         }
         else
         {
             
         }
     }];
}

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
@end
