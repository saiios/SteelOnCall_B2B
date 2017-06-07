//
//  product_defined.m
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "product_defined.h"


@interface product_defined ()<moreSellers>
{
    NSString *slcdID_Compare;
}

@end

@implementation product_defined
@synthesize activityView;
-(void)viewWillAppear:(BOOL)animated
{
    [activityView removeFromSuperview];

    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del setShouldRotate:NO];
    
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

    //cart
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Cart"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(Cart_click)forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    
    UIView *label_bg=[[UIView alloc]initWithFrame:CGRectMake(20, 0, 30, 30)];
    label_bg.backgroundColor=[UIColor colorWithRed:191.0/255.0 green:36.0/255.0 blue:42.0/255.0 alpha:1];
    label_bg.layer.cornerRadius = 15;
    
    //tap gesture
    UITapGestureRecognizer *cart_tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(Cart_click)];
    [label_bg addGestureRecognizer:cart_tap];

    Cart_lbl = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, 26, 25)];
    [Cart_lbl setFont:[UIFont fontWithName:@"Arial-BoldMT" size:13]];
    [Cart_lbl setText:@"0"];
    Cart_lbl.backgroundColor=[UIColor redColor];
    Cart_lbl.textAlignment = NSTextAlignmentCenter;
    [Cart_lbl setTextColor:[UIColor whiteColor]];
    [Cart_lbl setBackgroundColor:[UIColor clearColor]];
    [label_bg addSubview:Cart_lbl];
    [button addSubview:label_bg];
    
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    Cart_lbl.text=[user_data valueForKey:@"cart_count"];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    if ([_seller_name isEqualToString:@""]||[_seller_name isEqual:[NSNull null]]||_seller_name==NULL)
    {
    }
    else
    {
        More_seller_tag=_tag_str;
        NSMutableDictionary *test=[[NSMutableDictionary alloc]init];
        test=[[_products_ary objectAtIndex:More_seller_tag] mutableCopy];
        
        [test setObject:_price forKey:@"price"];
        [test setObject:_seller_name forKey:@"seller"];
        [test setObject:_S_id forKey:@"child_id"];

        _Pin_code=[_pin mutableCopy];
        _Location=[_Location mutableCopy];
        
        _selected_qty=_s_qty;
        _selected_ids=_s_ids;
        
        _brand_lbl.text=_brand_str;
        _grade_lbl.text=_grade_str;
        
        [_products_ary replaceObjectAtIndex:More_seller_tag withObject:test];
        Products_dict=[_products_ary mutableCopy];
        T_P_Ary=[_TP_ary mutableCopy];
        
        [_list_view reloadData];
    }
    
    

}

-(void)productIds:(NSDictionary *)prod{
   
    
    _price = [prod valueForKey:@"price"];
    _ton_price = [prod valueForKey:@"tonprice"];
      _seller_name = [prod valueForKey:@"seller_name"];
      _S_id = [prod valueForKey:@"S_id"];
      _TP_ary = [prod valueForKey:@"TP_ary"];
      _Location = [prod valueForKey:@"Location"];
      _tag_str = [[prod valueForKey:@"tag_str"] intValue];
      _pin = [prod valueForKey:@"pin"];
      _s_ids = [prod valueForKey:@"s_ids"];
    _s_qty = [prod valueForKey:@"s_qty"];
    discount_str = [prod valueForKey:@"discount"];//added
    _brand_str = [prod valueForKey:@"brand_str"];
    _grade_str = [prod valueForKey:@"grade_str"];
    _products_ary = [prod valueForKey:@"products_ary"];
    
    if ([_seller_name isEqualToString:@""]||[_seller_name isEqual:[NSNull null]]||_seller_name==NULL)
    {
    }
    else
    {
        More_seller_tag=_tag_str;
        NSMutableDictionary *test=[[NSMutableDictionary alloc]init];
        test=[[_products_ary objectAtIndex:More_seller_tag] mutableCopy];
        
        [test setObject:_price forKey:@"price"];
         [test setObject:_ton_price forKey:@"tonprice"];
        [test setObject:_seller_name forKey:@"seller"];
        [test setObject:_S_id forKey:@"child_id"];
        [test setObject:discount_str forKey:@"discount"];
        
        _Pin_code=[_pin mutableCopy];
        _Location=[_Location mutableCopy];
        
        _selected_qty=_s_qty;
        _selected_ids=_s_ids;
        
        _brand_lbl.text=_brand_str;
        _grade_lbl.text=_grade_str;
        
        [_products_ary replaceObjectAtIndex:More_seller_tag withObject:test];
        Products_dict=[_products_ary mutableCopy];
        T_P_Ary=[_TP_ary mutableCopy];
        
       [self shipping_info_service];
    }

    //[self Getting_Define_Products];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _list_view.dataSource = self;
    _list_view.delegate = self;
    _list_view.allowsSelection=NO;
    _company_view.layer.cornerRadius = 5;
    _model_view.layer.cornerRadius = 5;
    pieces_per_ton_ary=[[NSMutableArray alloc]init];

    Products_dict=[[NSMutableArray alloc]init];

    keyboardIsShown=NO;
    //notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //tap gesture
    singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.list_view addGestureRecognizer:singleFingerTap];
    _list_view.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    searchView = [[searchPopupVIew alloc]initWithFrame:CGRectMake(_company_btn.frame.origin.x+10,_company_btn.frame.origin.x+55 ,[UIScreen mainScreen].bounds.size.width/4,200)];
    searchView.delegate =self;
    searchView.hidden =YES;
    Referesh_tag=@"NO";
    [self.view addSubview:searchView];
    
    noDataLabel         = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _list_view.bounds.size.width, _list_view.bounds.size.height)];
    noDataLabel.text             = @"Select Brand and Grade";
    noDataLabel.numberOfLines=2;
    noDataLabel.textColor        = [UIColor blackColor];
    noDataLabel.textAlignment    = NSTextAlignmentCenter;
    _list_view.backgroundView = noDataLabel;
    [self call_tonnes_service];
}

- (void)viewDidUnload
{
    _company_btn = nil;
    [searchItemsArray removeAllObjects];
    [super viewDidUnload];
}

-(void)call_tonnes_service
{
    NSString *url_form=[NSString stringWithFormat:@"https://steeloncall.com/b2b/calculate/service/getcalculateqty?ids=%@",_selected_ids];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString: urlEncoded requestNumber:PRODUCT_TONNES showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             [pieces_per_ton_ary removeAllObjects];
             
             NSDictionary *res_data=data;
             for (int p=0; p<res_data.count; p++)
             {
                [pieces_per_ton_ary addObject:[[res_data valueForKey:@"pieces"]objectAtIndex:p]];
             }
             
             [_list_view reloadData];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        
        return Products_dict.count;
    }
    else
    {
        if (Dict.count>0)
        {
            return Dict.count+1;
        }
        return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        
        
        static NSString *simpleTableIdentifier = @"Product_defined_cell";
        Product_defined_cell *cell = (Product_defined_cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Product_defined_cell" owner:self options:nil];
            cell = (Product_defined_cell *)[nib objectAtIndex:0];
        }
        
        cell.defined_cell_view.layer.cornerRadius = 5;
        
        cell.remove.tag = indexPath.row;
        cell.save.tag = indexPath.row;
        cell.more_sellers.tag = indexPath.row;
        cell.detail_view.tag = indexPath.row;
        cell.tonnes_tf.delegate = self;
        cell.pieces_tf.delegate = self;
        
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleBordered target:self
                                                                      action:@selector(doneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        cell.tonnes_tf.inputAccessoryView = keyboardDoneButtonView;
        cell.pieces_tf.inputAccessoryView = keyboardDoneButtonView;
        
        int size = 0;
        if ([UIScreen mainScreen].bounds.size.width <= 320) {
            
            size = 11;
            
        }else{
            
            size = 12;
        }
        UIColor *color = [UIColor grayColor];
        cell.tonnes_tf.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Quantity in Tonnes"
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:@"Arial" size:size]
                                                     }
         ];
        cell.pieces_tf.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Quantity in Pieces"
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:@"Arial" size:size]
                                                     }
         ];
        
        cell.tonnes_tf.minimumFontSize = 10;
        cell.pieces_tf.minimumFontSize = 10;
        NSString *Home_tag=[NSString stringWithFormat:@"1%ld",(long)indexPath.row];
        int Home_tag_int=[Home_tag intValue];
        NSString *Away_tag=[NSString stringWithFormat:@"2%ld",(long)indexPath.row];
        int Away_tag_int=[Away_tag intValue];
        
        cell.tonnes_tf.tag = Home_tag_int;
        cell.pieces_tf.tag = Away_tag_int;
        cell.Refresh_Btn.tag = (long)indexPath.row;
        
        [cell.Refresh_Btn addTarget:self action:@selector(Refresh_click:) forControlEvents:UIControlEventTouchUpInside];
        
        [[cell.Refresh_Btn layer] setBorderWidth:1.0f];
        [[cell.Refresh_Btn layer] setBorderColor:[UIColor whiteColor].CGColor];
        
        [cell.remove addTarget:self action:@selector(remove_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.save addTarget:self action:@selector(save_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.more_sellers addTarget:self action:@selector(More_click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detail_view addTarget:self action:@selector(Details_Click:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.seller_name.text=[[Products_dict valueForKey:@"seller"]objectAtIndex:indexPath.row];
        if ([cell.seller_name.text isEqualToString:@""])
        {
            cell.Refresh_view.hidden=NO;
        }
        else
            cell.Refresh_view.hidden=YES;
        
        NSString *ton_price_str=[NSString stringWithFormat:@"₹%@",[[Products_dict valueForKey:@"tonprice"]objectAtIndex:indexPath.row]];
        NSString *Discount_str=[NSString stringWithFormat:@"%@",[[Products_dict valueForKey:@"discount"]objectAtIndex:indexPath.row]];
        NSString *tonnes;
        if (T_P_Ary.count>indexPath.row)
            tonnes=[[T_P_Ary valueForKey:@"tonnes"]objectAtIndex:indexPath.row];
        cell.price_ton.text=ton_price_str;
        cell.tonnes_tf.text=tonnes;
        if (T_P_Ary.count>indexPath.row)
            cell.pieces_tf.text=[NSString stringWithFormat:@"%@",[[T_P_Ary valueForKey:@"pieces"]objectAtIndex:indexPath.row]];
        cell.Discount.text=Discount_str;
        
        float ton_price_int=[ton_price_str floatValue];
        float tons_int=[tonnes floatValue];
        float total_ton_price=ton_price_int*tons_int;
        //    cell.total_price.text=[NSString stringWithFormat:@"₹%.2f",total_ton_price];
        cell.total_price.text=[NSString stringWithFormat:@"%@",[[Products_dict valueForKey:@"price"]objectAtIndex:indexPath.row]];
        
        if (T_P_Ary.count>indexPath.row)
            cell.name.text=[[T_P_Ary valueForKey:@"name"]objectAtIndex:indexPath.row];
        
        NSURL *imageURL = [NSURL URLWithString:[[T_P_Ary valueForKey:@"img"]objectAtIndex:indexPath.row]];
        [cell.image sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [cell.image.layer setBorderColor: [[UIColor colorWithRed:213.0/255.0 green:216.0/255.0 blue:224.0/255.0 alpha:1] CGColor]];
        [cell.image.layer setBorderWidth: 2.0];
        
        return cell;
    }
    
    else
    {
        if (indexPath.row==Dict.count)
        {
            static NSString *simpleTableIdentifier = @"Shipping_lastCell";
            Shipping_lastCell *cell = (Shipping_lastCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Shipping_lastCell" owner:self options:nil];
                cell = (Shipping_lastCell *)[nib objectAtIndex:0];
            }
            if ([S_H_Price isEqual:[NSNull null]]||[S_H_Price isEqualToString:@""]||S_H_Price==nil)
            {
                cell.S_H_Price.text=@"";
            }
            else
                cell.S_H_Price.text=S_H_Price;
            return cell;
        }
        else
        {
            static NSString *simpleTableIdentifier = @"Shipping_info_cell";
            Shipping_info_cell *cell = (Shipping_info_cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Shipping_info_cell" owner:self options:nil];
                cell = (Shipping_info_cell *)[nib objectAtIndex:0];
            }
            NSString *seller_name=[[Dict valueForKey:@"seller_name"]objectAtIndex:indexPath.row];
            NSString *total_tons=[NSString stringWithFormat:@"%@",[[Dict valueForKey:@"total_tons"]objectAtIndex:indexPath.row]];
            NSString *shipping_price=[NSString stringWithFormat:@"%@",[[Dict valueForKey:@"shipping_price"]objectAtIndex:indexPath.row]];
            NSString *shipping_and_handling_price=[NSString stringWithFormat:@"%@",[[Dict valueForKey:@"shipping_and_handling_price"]objectAtIndex:indexPath.row]];
            NSString *handling_price=[NSString stringWithFormat:@"%@",[[Dict valueForKey:@"handling_price"]objectAtIndex:indexPath.row]];
            NSString *distance=[NSString stringWithFormat:@"%@",[[Dict valueForKey:@"distance"]objectAtIndex:indexPath.row]];
            
            cell.total_lbl.layer.borderColor=[[UIColor blackColor]CGColor];
            cell.total_lbl.layer.borderWidth=0.6;
            
            if ([seller_name isEqual:[NSNull null]]||[seller_name isEqualToString:@""]||seller_name==nil)
            {
                cell.sellername.text=@"";
            }
            else
                cell.sellername.text=seller_name;
            
            if ([total_tons isEqual:[NSNull null]]||[total_tons isEqualToString:@""]||total_tons==nil)
            {
                cell.tons.text=@"";
            }
            else
                cell.tons.text=total_tons;
            
            if ([shipping_price isEqual:[NSNull null]]||[shipping_price isEqualToString:@""]||shipping_price==nil)
            {
                cell.shipping.text=@"";
            }
            else
                cell.shipping.text=shipping_price;
            
            if ([handling_price isEqual:[NSNull null]]||[handling_price isEqualToString:@""]||handling_price==nil)
            {
                cell.handling.text=@"";
            }
            else
                cell.handling.text=handling_price;
            
            if ([distance isEqual:[NSNull null]]||[distance isEqualToString:@""]||distance==nil)
            {
                cell.distance.text=@"";
            }
            else
                cell.distance.text=distance;
            
            if ([shipping_and_handling_price isEqual:[NSNull null]]||[shipping_and_handling_price isEqualToString:@""]||shipping_and_handling_price==nil)
            {
                cell.subtotal.text=@"";
            }
            else
                cell.subtotal.text=shipping_and_handling_price;
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 300;
    }
    
    else{
        
        if (indexPath.row==Dict.count)
        {
            return 50;
        }
        else
            return 213;
        
    }
}

- (IBAction)Model_click:(id)sender
{
    NSLog(@"model clicked");
    [self Getting_Grades:(id)0];
}

- (IBAction)Refresh_click:(id)sender
{
    int tag=[sender tag];
    NSLog(@"Refresh click");
    Referesh_tag=@"YES";
    Refreshing_id=[NSString stringWithFormat:@"%@",[[Products_dict valueForKey:@"id"]objectAtIndex:tag]];
    _brand_lbl.text=@"--select--";
    _grade_lbl.text=@"--select--";
    Refreshing_Indexpath = [NSIndexPath indexPathForRow:tag inSection:0];
    [self Alert:@"Re-Select the Brand & Grade."];
}

- (IBAction)Company_click:(id)sender
{
    NSLog(@"Company clicked");
    [self Getting_Brands:(id)0];
}

-(void)Getting_Brands:(id)sender
{
//    if (searchItemsArray.count==0)
//    {
    NSString *url_form;
    if ([Referesh_tag isEqualToString:@"YES"])
    {
        url_form=[NSString stringWithFormat:@"getBrandsBasedOnLocation?ids=%@&pincode=%@&location=%@",Refreshing_id,_Pin_code,_Location];
    }
    else
    {
        url_form=[NSString stringWithFormat:@"getBrandsBasedOnLocation?ids=%@&pincode=%@&location=%@",_selected_ids,_Pin_code,_Location];
    }
     NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Getting_Brands showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSArray *Brands_ary=data;
             
             int tab_height=Brands_ary.count*60;;
             if (tab_height>self.view.frame.size.height-200)
             {
                 tab_height=self.view.frame.size.height-200;
             }
             
             searchView.frame = CGRectMake(_company_btn.frame.origin.x,_company_btn.frame.origin.y+55 ,_company_btn.frame.size.width,tab_height+10);
             [searchView updateInstaceFrame:CGRectMake(0, 0,searchView.frame.size.width , searchView.frame.size.height)];
             
             searchItemsArray = [[NSMutableArray alloc]init];
             [searchItemsArray  addObjectsFromArray:Brands_ary];
             searchView.hidden =NO;
             popup_tag=@"Brand";
             [searchView relaodSearchTable];
             
             NSLog(@" Brands response %@",Brands_ary);
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

-(void)Getting_Grades:(id)sender
{
    if (searchItemsArray.count!=0)
    {
        NSString *url_form;
        if ([Referesh_tag isEqualToString:@"YES"])
        {
            url_form=[NSString stringWithFormat:@"getGradesBasedOnBrand?ids=%@&pincode=%@&location=%@&brand=%@",Refreshing_id,_Pin_code,_Location,_brand_lbl.text];
        }
        else
        {
            url_form=[NSString stringWithFormat:@"getGradesBasedOnBrand?ids=%@&pincode=%@&location=%@&brand=%@",_selected_ids,_Pin_code,_Location,_brand_lbl.text];
        }
     NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Getting_Grades showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSArray *Grades_ary=data;
             int tab_height=Grades_ary.count*60;
             if (tab_height>self.view.frame.size.height-200)
             {
                 tab_height=self.view.frame.size.height-200;
             }
             searchView.frame = CGRectMake(_Grade_view.frame.origin.x+30,_company_btn.frame.origin.y+55 ,_Grade_view.frame.size.width-60,tab_height+10);
               [searchView updateInstaceFrame:CGRectMake(0, 0,searchView.frame.size.width , searchView.frame.size.height)];
             searchItemsArray = [[NSMutableArray alloc]init];
             [searchItemsArray  addObjectsFromArray:Grades_ary];
             searchView.hidden =NO;
             popup_tag=@"Grade";
              noDataLabel.text =@"";
             [searchView relaodSearchTable];
             NSLog(@" Grades response %@",Grades_ary);
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
}

-(void)Getting_Define_Products
{
    NSString *url_form;
    if ([Referesh_tag isEqualToString:@"YES"])
    {
        url_form=[NSString stringWithFormat:@"getDefineProductPrices?ids=%@&pincode=%@&qty=%@&location=%@&brand=%@&grade=%@",Refreshing_id,_Pin_code,_selected_qty,_Location,_brand_lbl.text,_grade_lbl.text];
    }
    else
    {
        url_form=[NSString stringWithFormat:@"getDefineProductPrices?ids=%@&pincode=%@&qty=%@&location=%@&brand=%@&grade=%@",_selected_ids,_Pin_code,_selected_qty,_Location,_brand_lbl.text,_grade_lbl.text];
    }
    
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Getting_Def_Product showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
           NSArray *Products_ary=data;
             
             NSLog(@" Grades response %@",Products_dict);
             
             if ([Referesh_tag isEqualToString:@"YES"])
             {
                 [Products_dict replaceObjectAtIndex:Refreshing_Indexpath.row withObject:[Products_ary objectAtIndex:0]];
                 
                 [_list_view beginUpdates];
                 [_list_view reloadRowsAtIndexPaths:[NSArray arrayWithObjects:Refreshing_Indexpath, nil] withRowAnimation:UITableViewRowAnimationNone];
                 [_list_view endUpdates];
                 [self shipping_info_service];
             }
             else
             {
                 [Products_dict removeAllObjects];
                 for (int d=0; d<Products_ary.count; d++)
                 {
                     [Products_dict addObject:[Products_ary objectAtIndex:d]];
                 }
                 T_P_Ary=[_tonne_piece_ary mutableCopy];
                 [self shipping_info_service];
                 [_list_view reloadData];
             }
             Referesh_tag=@"NO";
         }
         else
         {

         }
     }];
}

- (IBAction)Compare_click:(id)sender
{
    if ([_brand_lbl.text isEqualToString:@"--select--"]||[_grade_lbl.text isEqualToString:@"--select--"])
    {
        [self Alert:@"Select Brand and Grade"];
    }
    else
    {
    
    NSLog(@"Compare clicked");
    CompareViewController *newView = [[CompareViewController alloc]init];
    if ([slcdID_Compare isEqual:[NSNull null]]||[slcdID_Compare isEqualToString:@"<nil>"]||slcdID_Compare == nil||[slcdID_Compare isEqualToString:@""]){
        
         newView.selected_ids=_selected_ids;
    }
    else
    {
    newView.selected_ids=slcdID_Compare;//_selected_ids;
    }
    newView.T_P_Ary=T_P_Ary;
    newView.Location=_Location;
    
    [self.navigationController pushViewController:newView animated:YES];
    }
}

- (IBAction)Details_Click:(id)sender
{
    NSLog(@"details clicked %ld",(long)[sender tag]);
    int tag=[sender tag];
    More_Details *newView = [[More_Details alloc]init];
    newView.PINCODE=_Pin_code;
    newView.GRADE=_grade_lbl.text;
    newView.BRAND=_brand_lbl.text;
    newView.location=_Location;
    newView.ID=[[Products_dict valueForKey:@"id"]objectAtIndex:tag];
    newView.price_str=[[Products_dict valueForKey:@"price"]objectAtIndex:tag];
     newView.childId = [[Products_dict valueForKey:@"child_id"]objectAtIndex:tag];

    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction)More_click:(id)sender
{
    NSLog(@"more clicked%ld",(long)[sender tag]);
    More_seller_tag=[sender tag];

    More_Sellers *newView = [[More_Sellers alloc]init];
    newView.delegate =self;
    newView.name=[[T_P_Ary valueForKey:@"name"]objectAtIndex:More_seller_tag];
    newView.grade=_grade_lbl.text;
    newView.brand=_brand_lbl.text;
    newView.Location=_Location;
    newView.Pin_code=_Pin_code;
    newView.tag_int=More_seller_tag;
    newView.selected_ids=_selected_ids;
    newView.selected_qty=_selected_qty;
    newView.products_ary=Products_dict;
    newView.price=[[Products_dict valueForKey:@"tonprice"]objectAtIndex:More_seller_tag];
    newView.tonne_piece_ary=T_P_Ary;
    newView.img_url=[[T_P_Ary valueForKey:@"img"]objectAtIndex:More_seller_tag];
    newView.ID=[[Products_dict valueForKey:@"id"]objectAtIndex:More_seller_tag];
    [self.navigationController pushViewController:newView animated:YES];
}

- (IBAction)save_click:(id)sender
{
    /*
    NSLog(@"save clicked%ld",(long)[sender tag]);
    int tag=[sender tag];
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:tag inSection:0];
    Product_defined_cell *tappedCell = (Product_defined_cell *)[_list_view cellForRowAtIndexPath:indexpath];
    NSString *pieces=tappedCell.pieces_tf.text;
    NSString *tonnes=tappedCell.tonnes_tf.text;

    [[T_P_Ary objectAtIndex:tag] setValue:pieces forKey:@"pieces"];
    [[T_P_Ary objectAtIndex:tag] setValue:tonnes forKey:@"tonnes"];
     */
}

- (IBAction)remove_click:(id)sender
{
    NSLog(@"remove clicked%ld",(long)[sender tag]);
    int tag=[sender tag];
    
    NSString *idTodelete = [NSString stringWithFormat:@"%@",[[Products_dict objectAtIndex:tag] valueForKey:@"id"]];
    NSString *remove_ = [NSString stringWithFormat:@"_%@",idTodelete];
    
    [Products_dict removeObjectAtIndex:tag];
    [T_P_Ary removeObjectAtIndex:tag];
    [_list_view reloadData];
    
    
    slcdID_Compare = _selected_ids;
    
    
    if ([slcdID_Compare containsString:remove_]) {
        
        slcdID_Compare = [slcdID_Compare stringByReplacingOccurrencesOfString:remove_
                                                                   withString:@""];
        
    }
    
    else if ([slcdID_Compare containsString:idTodelete]) {
        
        slcdID_Compare = [slcdID_Compare stringByReplacingOccurrencesOfString:idTodelete
                                                                   withString:@""];
        
    }
    
    if(slcdID_Compare.length>1)
    {
       
        NSString *Str = [slcdID_Compare substringWithRange:NSMakeRange(0, 1)];
        if ([Str isEqualToString:@"_"]) {
            slcdID_Compare = [slcdID_Compare stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        }

    }
    

}

-(void)Add_To_Cart
{
    [Cart_Details_ary removeAllObjects];
    Cart_Details_ary=[[NSMutableArray alloc]init];
    BOOL isCheck =NO;
    for (int p=0; p<T_P_Ary.count; p++)
    {
        NSMutableDictionary *post_dict=[[NSMutableDictionary alloc]init];
        
        NSString  *Tonnes_id=[[T_P_Ary valueForKey:@"tonnes"]objectAtIndex:p];
        NSString  *Pieces_id=[[T_P_Ary valueForKey:@"pieces"]objectAtIndex:p];
        NSString  *Product_id=[[Products_dict valueForKey:@"id"]objectAtIndex:p];
        NSString  *Child_id=[[Products_dict valueForKey:@"child_id"]objectAtIndex:p];
        
        [post_dict setObject:Product_id forKey:@"product_id"];
        [post_dict setObject:Child_id forKey:@"child_id"];
        [post_dict setObject:Tonnes_id forKey:@"ton"];
        [post_dict setObject:Pieces_id forKey:@"piece"];
        [Cart_Details_ary addObject:post_dict];
        
        if (Tonnes_id.length>0 || Pieces_id.length>0) {
            isCheck =YES;
        }
    }
    
    NSMutableDictionary *Add_To_Cart_Dict=[[NSMutableDictionary alloc]init];
    [Add_To_Cart_Dict setObject:Cart_Details_ary forKey:@"details"];
    
    if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
    {
        [Add_To_Cart_Dict setObject:@"0" forKey:@"customer_id"];
    }
    else
    [Add_To_Cart_Dict setObject:user_id forKey:@"customer_id"];
    [Add_To_Cart_Dict setObject:_Pin_code forKey:@"pincode"];
    [Add_To_Cart_Dict setObject:_Location forKey:@"location"];
    NSLog(@"Add to cart Dict %@",Add_To_Cart_Dict);
    if (isCheck)
    {
        if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
            myNewVC.cart_dict=Add_To_Cart_Dict;
           myNewVC.From = @"define";
            [self.navigationController pushViewController:myNewVC animated:YES];
        }
        else
        {
        [self service:Add_To_Cart_Dict];
        activityView.frame = [UIScreen mainScreen].bounds;
        [self.view addSubview:activityView];
        }
    }else{
        ALERT_DIALOG(@"Alert", @"Please enter tonns or pieces to continue");
    }
  
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
    
 //   NSData *jsonData22 = [NSJSONSerialization  JSONObjectWithData:parameters options:NSJSONReadingAllowFragments error:&error];
        NSString *jsonSt = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
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
            NSLog(@"%@",jsonString);
           // NSString *response=[NSString stringWithFormat:@"%@",[json valueForKey:@"response"]];
            
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

                My_Cart *define = [[My_Cart alloc]initWithNibName:@"My_Cart" bundle:nil];
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
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

-(void)viewWillDisappear:(BOOL)animated
{
    _HUD.hidden =YES;
}

- (IBAction)continue_click:(id)sender
{
    if ([_brand_lbl.text isEqualToString:@"--select--"]||[_grade_lbl.text isEqualToString:@"--select--"])
    {
        [self Alert:@"Select Brand and Grade"];
    }
    else
    {
    //[self shipping_info_service];
    
    if (Products_dict.count>0)
    {
        [self Add_To_Cart];
    }
else
    [self Alert:@"Cart should not be empty!"];
    }
}

-(void)shipping_info_service
{
    [Cart_Details_ary removeAllObjects];
    Cart_Details_ary=[[NSMutableArray alloc]init];
    
    for (int p=0; p<T_P_Ary.count; p++)
    {
        NSMutableDictionary *post_dict=[[NSMutableDictionary alloc]init];
        
        NSString  *Tonnes_id=[[T_P_Ary valueForKey:@"tonnes"]objectAtIndex:p];
        NSString  *Pieces_id=[[T_P_Ary valueForKey:@"pieces"]objectAtIndex:p];
        NSString  *Product_id=[[Products_dict valueForKey:@"id"]objectAtIndex:p];
        NSString  *Child_id=[[Products_dict valueForKey:@"child_id"]objectAtIndex:p];
        
        [post_dict setObject:Product_id forKey:@"product_id"];
        [post_dict setObject:Child_id forKey:@"child_id"];
        [post_dict setObject:Tonnes_id forKey:@"ton"];
        [post_dict setObject:Pieces_id forKey:@"piece"];
        [Cart_Details_ary addObject:post_dict];
    }
    
    NSMutableDictionary *Add_To_Cart_Dict=[[NSMutableDictionary alloc]init];
    [Add_To_Cart_Dict setObject:Cart_Details_ary forKey:@"details"];
    //[Add_To_Cart_Dict setObject:user_id forKey:@"customer_id"];
    [Add_To_Cart_Dict setObject:_Pin_code forKey:@"pincode"];
    [Add_To_Cart_Dict setObject:_Location forKey:@"location"];
    NSLog(@"Add to cart Dict %@",Add_To_Cart_Dict);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.responseSerializer =responseSerializer;
    NSString *urlString;
    urlString= [NSString stringWithFormat:@"%@getshippig",MAIN_Url];
    NSError *error;
    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:Add_To_Cart_Dict options:0 error:&error];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
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
                                                  _HUD.hidden =YES;
                                                 // NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                  
                                                  NSDictionary* json_dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                       options:kNilOptions
                                                                                                         error:&error];
                                                  NSLog(@"%@",json_dict);
                                                  
                                                  
            if (json_dict.count>0)
            {
                if ([user_id isEqualToString:@""]||[user_id isEqual:[NSNull null]]||[user_id isEqualToString:@"<nil>"]||user_id == nil||[user_id isEqualToString:@"0"])
                {
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    LoginViewController *myNewVC = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewControllerID"];
                    [self.navigationController pushViewController:myNewVC animated:YES];
                   
                }
                else
                {
                    
                    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
                                   {
                                       //Background Thread
                                       _HUD.hidden =YES;
                                       dispatch_async(dispatch_get_main_queue(), ^(void){
                                           //Run UI Updates
                                           [_HUD removeFromSuperview];
                                           
                                           _HUD.hidden =YES;
//                                           Shipping_Info *define = [[Shipping_Info alloc]initWithNibName:@"Shipping_Info" bundle:nil];
//                                           define.json_dict=json_dict;
                                        //   [self.navigationController pushViewController:define animated:YES];
                                           
                                           Dict=[[NSMutableDictionary alloc]init];
                                           Dict=[[json_dict valueForKey:@"seller_info"]mutableCopy];
                                           NSLog(@"local dictionary %@",Dict);
                                           
                                           S_H_Price=[NSString stringWithFormat:@"%@",[[json_dict valueForKey:@"total_shipping_and_handling_price"]mutableCopy]];
                                           
                                           [_list_view reloadData];
                                       });
                                   });
                    
                }
                   
                
            }
            else
            {
                   // [self Alert:@"Something went wrong"];
                ALERT_DIALOG(@"Alert", @"Something went wrong");
            }
                                              }
                                              else
                                              {
                                                  _HUD.hidden =YES;
                                                  [self Alert:[NSString stringWithFormat:@"%@",error]];
                                              }
  }];
    
    [postDataTask resume];

}

#pragma mark PopUp Menu
-(float)setHeighForSearchTable:(UITableView *)tableView
{
    return 40;
}

-(NSInteger )numberOffRowsInSearchTableView:(UITableView *)tableView
{
    return searchItemsArray.count;
}

- (JMOTableViewCell *)cellforRowAtSearchINdex:(UITableView*)tableVIew viewAtIndex:(NSIndexPath *)index
{
    JMOTableViewCell *cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    if (cell==nil)
    {
        [tableVIew registerNib:[UINib nibWithNibName:@"JMOTableViewCell" bundle:nil] forCellReuseIdentifier:@"searchCell"];
        cell = [tableVIew dequeueReusableCellWithIdentifier:@"searchCell"];
    }
    cell.labelName.text =[searchItemsArray objectAtIndex:index.row];
    [cell.labelName setFont:[UIFont systemFontOfSize:13]];
    cell.labelName.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(void)searchTableViewSelected:(UITableView *)table IndexPath:(NSIndexPath * )indexPath
{
    selected_item =[searchItemsArray objectAtIndex:indexPath.row];
    if ([popup_tag isEqualToString:@"Brand"])
    {
        _brand_lbl.text=selected_item;
        _grade_lbl.text=@"--select--";
    }
    else if ([popup_tag isEqualToString:@"Grade"])
    {
        _grade_lbl.text=selected_item;
        [self Getting_Define_Products];
    }
    searchView.hidden =YES;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    [self.view endEditing:YES];
    searchView.hidden =YES;
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
        Product_defined_cell *tappedCell = (Product_defined_cell *)[_list_view cellForRowAtIndexPath:indexpath];
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
            tappedCell.pieces_tf.text=total_pieces_str;
            
            [[T_P_Ary objectAtIndex:row] setValue:total_pieces_str forKey:@"pieces"];
            [[T_P_Ary objectAtIndex:row] setValue:newString forKey:@"tonnes"];
            
            if ([tappedCell.pieces_tf.text isEqualToString:@""]) {
                
            }
            else
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

            tappedCell.tonnes_tf.text=total_tonnes_str;
            
            [[T_P_Ary objectAtIndex:row] setValue:newString forKey:@"pieces"];
            [[T_P_Ary objectAtIndex:row] setValue:total_tonnes_str forKey:@"tonnes"];
            
            [self change_tonnes_service:tappedCell.tonnes_tf.text :row];
        }
      }else{
          return NO;

      }
    }else{
        [self call_tonnes_service];
        return NO;
    }
    return YES;
}

-(void)change_tonnes_service:(NSString *)tonnes :(int )tag_int
{
    NSString *child_id=[[Products_dict valueForKey:@"child_id"]objectAtIndex:tag_int];
    NSString *prod_id=[[Products_dict valueForKey:@"id"]objectAtIndex:tag_int];

   NSString *url_form=[NSString stringWithFormat:@"changetons?id=%@&child_id=%@&ton=%@&customer_id=%@",prod_id,child_id,tonnes,user_id];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Change_tons showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             if ([data count]>0) {
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
                 Product_defined_cell *tappedCell = (Product_defined_cell *)[_list_view cellForRowAtIndexPath:indexpath];
                 discount_str=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"discount"]];
                 price_str=[NSString stringWithFormat:@"%@",[res_dict valueForKey:@"price"]];
                 tappedCell.Discount.text=discount_str;
                 tappedCell.total_price.text=price_str;
                     [self shipping_info_service];
                }
             }
         }
         else
         {
            
         }
             
         }
     }];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.list_view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height - 50);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.list_view setFrame:viewFrame];
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
    CGRect viewFrame = self.list_view.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height - 50);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.list_view setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
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
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)Cart_click
{
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
- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}

- (IBAction)Shipping_info_click:(id)sender
{
    if ([_brand_lbl.text isEqualToString:@"--select--"]||[_grade_lbl.text isEqualToString:@"--select--"])
    {
        [self Alert:@"Select Brand and Grade"];
    }
    else
    {
      //  [self shipping_info_service];
    }
}
@end
