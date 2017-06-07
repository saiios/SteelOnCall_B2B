//
//  More_Sellers.m
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "More_Sellers.h"

@interface More_Sellers ()

@end

@implementation More_Sellers

-(void)viewWillAppear:(BOOL)animated
{
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
    _list_view.dataSource = self;
    _list_view.delegate = self;
    _list_view.separatorStyle = UITableViewCellSeparatorStyleNone;
    _list_view.allowsSelection=NO;
    selected_tag=0;
    Sellers_Ary = [[NSArray alloc]init];

    _name_lbl.text=_name;
    _brand_lbl.text=_brand;
    _grade_lbl.text=_grade;
    _price_lbl.text=[NSString stringWithFormat:@"%@", _price];
    
    NSURL *image_url = [NSURL URLWithString:_img_url];
    [_img sd_setImageWithURL:image_url placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [_img.layer setBorderColor: [[UIColor colorWithRed:213.0/255.0 green:216.0/255.0 blue:224.0/255.0 alpha:1] CGColor]];
    [_img.layer setBorderWidth: 2.0];
    [self Getting_Sellers];
}

-(void)Getting_Sellers
{
    NSString *url_form=[NSString stringWithFormat:@"moreSellers?ids=%@&location=%@&brand=%@&grade=%@&ton=%@",_ID,_Location,_brand,_grade,_selected_qty];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:More_Seller showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             Sellers_Ary = [[NSArray alloc]init];
             if (data) {
                 
                 if([data isKindOfClass:[NSArray class]]){
             Sellers_Ary= [NSArray arrayWithArray:data];
                 }else{
                     
                 }
            NSLog(@" Grades response %@",Sellers_Ary);
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Sellers_Ary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"Seller_cell";
    Seller_cell *cell = (Seller_cell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Seller_cell" owner:self options:nil];
        cell = (Seller_cell *)[nib objectAtIndex:0];
    }
    [cell.select_btn addTarget:self action:@selector(Select_click:) forControlEvents:UIControlEventTouchUpInside];
    cell.select_btn.tag=indexPath.row;
    if (indexPath.row == selected_tag)
    {
        [cell.select_btn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    }
    else
       [cell.select_btn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    
    cell.company_lbl.text=[[Sellers_Ary objectAtIndex:indexPath.row]valueForKey:@"seller"];
    cell.price_lbl.text=[NSString stringWithFormat:@"₹ %d",[[[Sellers_Ary objectAtIndex:indexPath.row]valueForKey:@"price"] intValue] ];
    cell.Delivery_lbl.text=[[Sellers_Ary objectAtIndex:indexPath.row]valueForKey:@"delivery"];
   // [[Sellers_Ary objectAtIndex:indexPath.row]valueForKey:@"seller"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 144;
}

- (IBAction)Select_click:(id)sender
{
    NSLog(@"model clicked");
    UIButton *button=(UIButton *) sender;
    selected_tag=button.tag;
    
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    Seller_cell *tappedCell = (Seller_cell *)[_list_view cellForRowAtIndexPath:indexpath];
    [tappedCell.select_btn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    
   // product_defined *newView = [[product_defined alloc]init];
//    newView.price=[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"price"];
//    newView.seller_name=[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"seller"];
//    newView.S_id=[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"id"];
//    [_list_view reloadData];
//    newView.TP_ary=_tonne_piece_ary;
//    newView.Location=_Location;
//    newView.tag_str=_tag_int;
//    newView.pin=_Pin_code;
//    newView.s_ids=_selected_ids;
//    newView.s_qty=_selected_qty;
//    newView.brand_str=_brand;
//    newView.grade_str=_grade;
//    newView.products_ary=_products_ary;
   // [self.navigationController pushViewController:newView animated:YES];
    
    NSDictionary *dic = @{@"price":[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"price"]
                          , @"tonprice":[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"tonprice"]
                          ,@"seller_name":[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"seller"]
                          ,@"discount":[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"discount"]
                          ,@"S_id" :[[Sellers_Ary objectAtIndex:selected_tag]valueForKey:@"child_id"]
                          ,@"TP_ary":_tonne_piece_ary
                          ,@"Location":_Location
                          ,@"tag_str":[NSString stringWithFormat:@"%d",_tag_int]
                          ,@"pin": _Pin_code
                          ,@"s_ids": _selected_ids
                          ,@"s_qty":_selected_qty
                          ,@"brand_str":_brand
                          ,@"grade_str":_grade
                          ,@"products_ary":_products_ary};
    
                          
    [_delegate productIds:dic];
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}

-(void)Back_click
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
