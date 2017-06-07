//
//  Products_List.m
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "Products_List.h"

@interface Products_List ()

@end

@implementation Products_List

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [del setShouldRotate:NO];
    
    self.navigationController.navigationBar.hidden = NO;
    UIColor *blue_shade=[UIColor colorWithRed:44.0/255.0 green:52.0/255.0 blue:75.0/255.0 alpha:1];
    
    self.navigationController.navigationBar.barTintColor = blue_shade;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 188, 40)];
    navigationImage.image=[UIImage imageNamed:@"logo"];
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
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButton;
    
    self.list_view.userInteractionEnabled=YES;
    table_tag=@"products";
    [self.view endEditing:YES];
    [tonnes_pieces_ary removeAllObjects];
    
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    NSString *C_Count=[user_data valueForKey:@"cart_count"];
    Cart_lbl.text=C_Count;
}
-(void)viewDidAppear:(BOOL)animated{
    tableHeight = _list_view.frame.size.height;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _list_view.dataSource = self;
    _list_view.delegate = self;
    _location_table.dataSource = self;
    _location_table.delegate = self;
    _location_table.hidden=YES;
    self.list_view.userInteractionEnabled=YES;

    _list_view.allowsSelection=NO;
    _location_table.allowsSelection=YES;

    tick_check=[[NSMutableArray alloc]init];
    tones_dict=[[NSMutableDictionary alloc]init];
    pieces_dict=[[NSMutableDictionary alloc]init];
    Product_List_Dict=[[NSDictionary alloc]init];
    pieces_per_ton_ary=[[NSMutableArray alloc]init];
    Selected_ids_ary=[[NSMutableArray alloc]init];
    tonnes_pieces_ary=[[NSMutableArray alloc]init];
    product_names=[[NSMutableArray alloc]init];
    [_pincode_tf setDelegate:self];
    [_city_tf setDelegate:self];

    _popup_view.layer.cornerRadius=8;
    table_tag=@"products";
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
    for (int t=0; t<Product_List_Dict.count; t++)
    {
        [tones_dict setObject:@"" forKey:[NSString stringWithFormat:@"%d",t]];
        [pieces_dict setObject:@"" forKey:[NSString stringWithFormat:@"%d",t]];
    }
    [self Call_Products_List_Service];
    
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
                 NSString *pieces=[[res_data valueForKey:@"pieces"]objectAtIndex:p];
                 if ([pieces isEqual:[NSNull null]]||[pieces isEqualToString:@""])
                 {
                     [pieces_per_ton_ary addObject:@"0"];
                 }
                 else
                 [pieces_per_ton_ary addObject:pieces];
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

-(void)Call_Products_List_Service
{
   
    NSString *url_form;
    if ([_product_type isEqualToString:@"product"]) {
        
        url_form=[NSString stringWithFormat:@"getsearchresults?id=%@&type=%@",_product_id,_product_type];
    }
    
    else{
        
        url_form=[NSString stringWithFormat:@"getcategory/id/%@",_product_id];
    }
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:PRODUCT_LIST showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             Product_List_Dict=data;
             [_list_view reloadData];
             for (int l=0; l<Product_List_Dict.count; l++)
             {
                 if (l==0)
                 {
                     product_ids_str=[[Product_List_Dict valueForKey:@"id"]objectAtIndex:l];
                 }
                 else
                 product_ids_str=[NSString stringWithFormat:@"%@_%@",product_ids_str,[[Product_List_Dict valueForKey:@"id"]objectAtIndex:l]];
             }
             NSLog(@"ids string %@",product_ids_str);
             [self call_tonnes_service];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _list_view)
    {
        return Product_List_Dict.count;
    }
    else
        return locations_array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _list_view)
    {
    static NSString *simpleTableIdentifier = @"Product_list_cell";
    cell = (Product_list_cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Product_list_cell" owner:self options:nil];
        cell = (Product_list_cell *)[nib objectAtIndex:0];
    }
    cell.checkbox.tag = indexPath.row;
        
    NSString *Home_tag=[NSString stringWithFormat:@"1%ld",(long)indexPath.row];
    int Home_tag_int=[Home_tag intValue];
    NSString *Away_tag=[NSString stringWithFormat:@"2%ld",(long)indexPath.row];
    int Away_tag_int=[Away_tag intValue];
    
    cell.tonnes.tag = Home_tag_int;
    cell.pieces.tag = Away_tag_int;
        
    cell.tonnes.delegate = self;
    cell.pieces.delegate = self;
        
        UIToolbar *keyboardDoneButtonView = [[UIToolbar alloc] init];
        [keyboardDoneButtonView sizeToFit];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                       style:UIBarButtonItemStyleBordered target:self
                                                                      action:@selector(doneClicked:)];
        [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:doneButton, nil]];
        cell.tonnes.inputAccessoryView = keyboardDoneButtonView;
        cell.pieces.inputAccessoryView = keyboardDoneButtonView;

    UIColor *color = [UIColor grayColor];
        cell.tonnes.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Quantity in Tonnes"
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:@"Arial" size:11.0]
                                                     }
         ];
        cell.pieces.attributedPlaceholder =
        [[NSAttributedString alloc] initWithString:@"Quantity in Pieces"
                                        attributes:@{
                                                     NSForegroundColorAttributeName: color,
                                                     NSFontAttributeName : [UIFont fontWithName:@"Arial" size:11.0]
                                                     }
         ];

    [cell.checkbox addTarget:self action:@selector(Check_Click:) forControlEvents:UIControlEventTouchUpInside];
    cell.tonnes.text=@"";
    cell.pieces.text=@"";
    
    if ([tick_check containsObject:[NSString stringWithFormat:@"%ld", (long)indexPath.row]])
    {
        [cell.checkbox setImage:[UIImage imageNamed:@"Check_Select"] forState:UIControlStateNormal];
        cell.tonnes.enabled=YES;
        cell.pieces.enabled=YES;
    }
    else
    {
        [cell.checkbox setImage:[UIImage imageNamed:@"Check_Deselect"] forState:UIControlStateNormal];
        cell.tonnes.enabled=NO;
        cell.pieces.enabled=NO;
    }
    cell.tonnes.text=[tones_dict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    cell.pieces.text=[pieces_dict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    
    cell.name.text=[[Product_List_Dict valueForKey:@"name"]objectAtIndex:indexPath.row];
    cell.price.text=[NSString stringWithFormat:@"From ₹ %@", [[Product_List_Dict valueForKey:@"price"]objectAtIndex:indexPath.row]];

        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        NSURL *imageURL = [NSURL URLWithString:[[Product_List_Dict valueForKey:@"img"]objectAtIndex:indexPath.row]];
//        [cell.product_img sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
        [manager downloadImageWithURL: imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
         {
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
             
             if(image)
             {
                    cell.product_img.image = image;
             }
         }];
        
        
   
        
    return cell;
    }
    else
    {
            static NSString *CellIdentifier = @"Cell";
            
            UITableViewCell *cell_loc = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell_loc == nil)
            {
                cell_loc = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                cell_loc.textLabel.font = [UIFont systemFontOfSize:13];
                cell_loc.textLabel.textAlignment = UITextAlignmentCenter;
            }
            cell_loc.textLabel.textColor = [UIColor blackColor];
        NSString *city=[[locations_array objectAtIndex:indexPath.row] valueForKey:@"city"];
        NSString *Dist=[[locations_array objectAtIndex:indexPath.row] valueForKey:@"district"];
        
        
            cell_loc.textLabel.text=[NSString stringWithFormat:@"%@-%@",city,Dist];
            _location_table.hidden=NO;
            [self.view bringSubviewToFront:_location_table];
            return cell_loc;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([table_tag isEqualToString:@"products"])
    {
    return 200;
    }
    else
        return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([table_tag isEqualToString:@"Location"])
    {
Product_list_cell *tappedCell = (Product_list_cell *)[_location_table cellForRowAtIndexPath:indexPath];
        NSLog(@"location clicked");
        _location_table.hidden=YES;
        _city_tf.text=[NSString stringWithFormat:@"%@",tappedCell.textLabel.text];
        _pincode_tf.text=[NSString stringWithFormat:@"%@",[[locations_array objectAtIndex:indexPath.row]valueForKey:@"pincode"]];
        [self.view endEditing:YES];
    }
}

-(NSString *)proceed_validation
{
    int totalTons =0;
    for (int c=0; c<tick_check.count; c++)
    {
        int index_int=[[tick_check objectAtIndex:c]intValue];
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index_int inSection:0];
        Product_list_cell *tappedCell = (Product_list_cell *)[_list_view cellForRowAtIndexPath:indexpath];
        

       
        NSString *tonnes_str=[tones_dict valueForKey:[NSString stringWithFormat:@"%ld",(long)c]];
        NSString *pieces_str=tappedCell.pieces.text;
        if ([tonnes_str isEqualToString:@""]||[tonnes_str isEqual:[NSNull null]]||[tonnes_str isEqualToString:@"<nil>"])
        {
            return @"tonnes";
            break;
        }
        else if ([pieces_str isEqualToString:@""]||[pieces_str isEqual:[NSNull null]]||[pieces_str isEqualToString:@"<nil>"])
        {
            return @"pieces";
            break;
        }
        int currentTons =( int) [tonnes_str intValue];
        
        totalTons = totalTons+currentTons;
        
    }
    
    
    
    
    
    if (tick_check.count ==0)
    {
        return @"select";
   }
        //else if(totalTons <6){
//        return @"min6Tons";
//    }
    else
        return @"YES";
}

-(BOOL)Popup_proceed_validation
{
    if (_pincode_tf.text.length !=6 )
    {
        [self Alert:@"Invalid Pincode"];
        return NO;
    }
    else if ([_city_tf.text isEqual:[NSNull null]]||[_city_tf.text isEqualToString:@""]||[_city_tf.text isEqualToString:@"<nil>"])
    {
        return NO;
    }
    return YES;
}

- (IBAction)popup_proceed_click:(id)sender
{
    if ([self Popup_proceed_validation] == YES)
    {
        _popup_view.hidden=YES;
        self.list_view.userInteractionEnabled=YES;
        NSArray *selected_keys=[tones_dict allKeys];
        
        for (int c=0; c<Product_List_Dict.count; c++)
        {
            NSString *key=[NSString stringWithFormat:@"%d",c];
            
            if ([selected_keys containsObject:key])
            {
                    NSMutableDictionary  *Tonnes_Pieces_Dict=[[NSMutableDictionary alloc]init];
                    [Tonnes_Pieces_Dict setObject:[tones_dict valueForKey:key] forKey:@"tonnes"];
                    [Tonnes_Pieces_Dict setObject:[pieces_dict valueForKey:key] forKey:@"pieces"];
                    [Tonnes_Pieces_Dict setObject:[[Product_List_Dict valueForKey:@"name"]objectAtIndex:c] forKey:@"name"] ;
                    [Tonnes_Pieces_Dict setObject:[[Product_List_Dict valueForKey:@"img"]objectAtIndex:c] forKey:@"img"] ;
                    [tonnes_pieces_ary addObject:Tonnes_Pieces_Dict];
            }
        }
        NSMutableArray *selected_tonnes=[[NSMutableArray alloc]init];
        
        for (int t=0; t<tonnes_pieces_ary.count; t++)
        {
            [selected_tonnes addObject:[[tonnes_pieces_ary valueForKey:@"tonnes"]objectAtIndex:t]];
        }
        NSString *ids_str = [Selected_ids_ary componentsJoinedByString:@"_"];
        NSString *tonnes_str = [selected_tonnes componentsJoinedByString:@"_"];

        product_defined *myControllerHastag = [[product_defined alloc]init];
        myControllerHastag.Pin_code =_pincode_tf.text;
        myControllerHastag.Location =_city_tf.text;
        myControllerHastag.selected_ids =ids_str;
        myControllerHastag.selected_qty =tonnes_str;
        myControllerHastag.tonne_piece_ary=tonnes_pieces_ary;
        _pincode_tf.text=@"";
        _city_tf.text=@"";
        [self.navigationController pushViewController:myControllerHastag animated:YES];
    }
}

-(void)Pincode_To_City
{
    NSString *url_form=[NSString stringWithFormat:@"getLocationsBasedOnPincode?pincode=%@",newString];
     NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Get_Country showProgress:YES withHandler:^(BOOL success, id data)
         {
             if (success)
             {
                 if (data) {
                     
                     locations_array = [[NSArray alloc]init];
                     NSLog(@" response %@",data);
                     locations_array =[data valueForKey:@"Locations"];
                     NSLog(@"countries list %@",Countries_dict);
                     table_tag=@"Location";
                     
                     int tab_height=locations_array.count*50;
                     if (tab_height<300)
                     {
                         CGRect frame = _location_table.frame;
                         frame.size.height = tab_height;
                         _location_table.frame = frame;
                     }
                     [_location_table reloadData];
                 }
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

-(void)City_To_Pincode
{
    NSString *url_form=[NSString stringWithFormat:@"getLocations?loc=%@",newString];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Get_Country showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             if (data)
             {
                 locations_array = [[NSArray alloc]init];
                 NSLog(@" response %@",data);
                 locations_array =[data valueForKey:@"Locations"];
                 NSLog(@"countries list %@",Countries_dict);
                 table_tag=@"Location";
                 
                 int tab_height=locations_array.count*50;
                 if (tab_height<300)
                 {
                     CGRect frame = _location_table.frame;
                     frame.size.height = tab_height;
                     _location_table.frame = frame;
                 }
                 
                 [_location_table reloadData];
             }
         }
         else
         {
//             UIAlertController * alert=   [UIAlertController
//                                           alertControllerWithTitle:@"Alert"
//                                           message:[NSString stringWithFormat:@"%@",[data valueForKey:@"error_message"]]
//                                           preferredStyle:UIAlertControllerStyleAlert];
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

- (IBAction)popup_decline_click:(id)sender
{
    _popup_view.hidden=YES;
    _location_table.hidden=YES;
    self.list_view.userInteractionEnabled=YES;
    _pincode_tf.text=@"";
    _city_tf.text=@"";

    table_tag=@"products";
}

- (IBAction)Proceed_click:(id)sender
{
    if ([[self proceed_validation] isEqualToString:@"YES"])
    {
    //_popup_top.constant = self.view.frame.size.height/2-177;
        _popup_top.constant = 20;

    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    _popup_view.hidden=NO;
    _location_table.hidden=YES;
    self.list_view.userInteractionEnabled=NO;

    table_tag=@"products";
    _popup_view.alpha = 1.5;
    [self.view addSubview:_popup_view];
    singleFingerTap.enabled=YES;
    [UIView commitAnimations];
    }
    
    else if ([[self proceed_validation] isEqualToString:@"tonnes"])
    {
        NSLog(@"enter tonnes");
        [self Alert:@"Please Enter Tonnes"];
    }
    else if ([[self proceed_validation] isEqualToString:@"pieces"])
    {
        NSLog(@"enter pieces");
        [self Alert:@"Please Enter Pieces"];

    }
    else if ([[self proceed_validation] isEqualToString:@"select"])
    {
        NSLog(@"Select atleast single product");
        [self Alert:@"Please Select Product"];
    }
    //else if ([[self proceed_validation] isEqualToString:@"min6Tons"])
//    {
//        NSLog(@"Select atleast single product");
//        [self Alert:@"Please Select min 6 tonnes to Proceed"];
//    }
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

- (IBAction)Check_Click:(id)sender
{
    NSLog(@"details clicked %ld",(long)[sender tag]);
    
    UIButton *button=(UIButton *) sender;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    Product_list_cell *tappedCell = (Product_list_cell *)[_list_view cellForRowAtIndexPath:indexpath];
    
    if ([tappedCell.checkbox.imageView.image isEqual:[UIImage imageNamed:@"Check_Select"]])
    {
        [tappedCell.checkbox setImage:[UIImage imageNamed:@"Check_Deselect"] forState:UIControlStateNormal];
        [tick_check removeObject:[NSString stringWithFormat:@"%ld", (long)button.tag]];
        [Selected_ids_ary removeObject:[[Product_List_Dict valueForKey:@"id"] objectAtIndex:(long)button.tag]];
        [tones_dict setObject:@"" forKey:[NSString stringWithFormat:@"%d",indexpath.row]];
        [pieces_dict setObject:@"" forKey:[NSString stringWithFormat:@"%d",indexpath.row]];
        tappedCell.tonnes.text =@"";
        tappedCell.pieces.text =@"";
        tappedCell.tonnes.layer.borderColor=[[UIColor grayColor]CGColor];
        tappedCell.tonnes.layer.borderWidth=0.6;
        
        tappedCell.pieces.layer.borderColor=[[UIColor grayColor]CGColor];
        tappedCell.pieces.layer.borderWidth=0.6;
        
        tappedCell.tonnes.enabled=NO;
        tappedCell.pieces.enabled=NO;
    }
    else
    {
        [tappedCell.checkbox setImage:[UIImage imageNamed:@"Check_Select"] forState:UIControlStateNormal];
        [tick_check addObject:[NSString stringWithFormat:@"%ld", (long)button.tag]];
        [Selected_ids_ary addObject:[[Product_List_Dict valueForKey:@"id"] objectAtIndex:(long)button.tag]];
        
        tappedCell.tonnes.layer.borderColor=[[UIColor blackColor]CGColor];
        tappedCell.tonnes.layer.borderWidth=0.6;
        
        tappedCell.pieces.layer.borderColor=[[UIColor blackColor]CGColor];
        tappedCell.pieces.layer.borderWidth=0.6;
        
        tappedCell.tonnes.enabled=YES;
        tappedCell.pieces.enabled=YES;
        
        tappedCell.tonnes.delegate=self;
        [tappedCell.tonnes becomeFirstResponder];
        
       
    }
}

- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    [self.view endEditing:YES];
    _popup_view.hidden=YES;
    _popup_top.constant = 400;
    _location_table.hidden=YES;
    self.list_view.userInteractionEnabled=YES;

    table_tag=@"products";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    
    newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSLog(@"enterd text %@",newString);
    
    NSString *Home_tag_str=[NSString stringWithFormat:@"%ld",(long)textField.tag];
    
    if ([Home_tag_str isEqualToString:@"88888"])//pin
    {
        if (newString.length == 6)
        {
            [self Pincode_To_City];
        }
    }
    else if ([Home_tag_str isEqualToString:@"99999"])//city
    {
        if ([newString isEqualToString:@""]||[newString isEqual:[NSNull null]])
        {
        }
        else
         [self City_To_Pincode];
    }
else
{
    
    if(((![string isEqualToString:@"0"] || textField.text.length>0 ) && textField.text.length <6) || [string isEqualToString:@""]){
        
        NSString *TF_check = [NSString stringWithFormat:@"%c", [Home_tag_str characterAtIndex:0]];
        NSString *Tag = [Home_tag_str substringFromIndex:1];
        int row=[Tag intValue];
        NSLog(@"tag %d",row);
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:row inSection:0];
        Product_list_cell *tappedCell = (Product_list_cell *)[_list_view cellForRowAtIndexPath:indexpath];
        
        if (pieces_per_ton_ary.count>0) {//httpss
            
            
            
            NSString *pieces_per_tonne=[pieces_per_ton_ary objectAtIndex:row];
            int pieces_per_tonne_int=[pieces_per_tonne intValue];
            
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
                tappedCell.pieces.text=total_pieces_str;
                
                [tones_dict setObject:newString forKey:[NSString stringWithFormat:@"%d",row]];
                [pieces_dict setObject:total_pieces_str forKey:[NSString stringWithFormat:@"%d",row]];
                
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
                
                tappedCell.tonnes.text=total_tonnes_str;
                [pieces_dict setObject:newString forKey:[NSString stringWithFormat:@"%d",row]];
                [tones_dict setObject:total_tonnes_str forKey:[NSString stringWithFormat:@"%d",row]];
                
            }
            NSLog(@"tonnes dictionay %@",tones_dict);
            NSLog(@"pieces dictionay %@",pieces_dict);
        }else{
            newString =@"";
            return NO;
        }
    }else{
        newString =@"";
        return NO;
    }
}
    return YES;
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
    if (viewFrame.size.height < tableHeight) {
        viewFrame.size.height = tableHeight;
    }
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

-(void)Back_click
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

- (IBAction)doneClicked:(id)sender
{
    NSLog(@"Done Clicked.");
    [self.view endEditing:YES];
}
@end
