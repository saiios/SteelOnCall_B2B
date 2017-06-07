//
//  Detail_Order_View.m
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "Detail_Order_View.h"

@interface Detail_Order_View ()

@end

@implementation Detail_Order_View

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
    self.navigationController.navigationBar.hidden = NO;
    _Orders_table.dataSource = self;
    _Orders_table.delegate = self;
    _Orders_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _Orders_table.allowsSelection=NO;
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
//    user_id=@"73";
    Orders_Dict=[[NSArray alloc]init];
    _Orders_table.hidden =YES;
    [self Order_Details];
    
    
}

-(void)Order_Details
{
    NSString *url_form=[NSString stringWithFormat:@"orderdetails/?id=%@",_mainProductId];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Order_Detail showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             NSLog(@" response %@",data);
             Orders_Dict=data;
            Orders_Dictionary=[[NSArray alloc]init];
             Payment_Dict=[[NSArray alloc]init];
             Shipment_Dict=[[NSArray alloc]init];
             
             Orders_Dictionary=[Orders_Dict objectAtIndex:0];
             
             Ordered_Products=[Orders_Dictionary valueForKey:@"product"];
             Payment_Dict=[[Orders_Dictionary valueForKey:@"payment_method"]objectAtIndex:0];
             Shipment_Dict=[[Orders_Dictionary valueForKey:@"shipping_address"]objectAtIndex:0];
             [_Orders_table reloadData];
              _Orders_table.hidden =NO;
             
//             for (int l=0; l<Product_List_Dict.count; l++)
//             {
//                 if (l==0)
//                 {
//                     product_ids_str=[[Product_List_Dict valueForKey:@"id"]objectAtIndex:l];
//                 }
//                 else
//                     product_ids_str=[NSString stringWithFormat:@"%@_%@",product_ids_str,[[Product_List_Dict valueForKey:@"id"]objectAtIndex:l]];
//             }
//             NSLog(@"ids string %@",product_ids_str);
//             [self call_tonnes_service];
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
    if (section ==0||section ==2)
    {
        return Orders_Dict.count;
    }
    else if (section ==1)
    {
        return Ordered_Products.count;
    }
    else
        return 0;
   
//    if (Cart_Products_ary.count==0)
//    {
       // return 5;
//    }
//    else
//        return Cart_Products_ary.count+1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0 )
    {
        static NSString *simpleTableIdentifier = @"Detail_Order_Cell_0";
        Detail_Order_Cell_0 *cell = (Detail_Order_Cell_0 *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Detail_Order_Cell_0" owner:self options:nil];
            cell = (Detail_Order_Cell_0 *)[nib objectAtIndex:0];
        }
        
        NSString *order_date=[NSString stringWithFormat:@"%@",[Orders_Dictionary valueForKey:@"Date"]];
        cell.date.text=order_date;
        NSString *order_total=[NSString stringWithFormat:@"%@",[Orders_Dictionary valueForKey:@"order_total"]];
        cell.grand_total.text=order_total;
        cell.item_count.text=[NSString stringWithFormat:@"%lu", (unsigned long)Ordered_Products.count];
        return cell;
    }
    else if (indexPath.section ==2 )
    {
        static NSString *simpleTableIdentifier = @"Detail_Order_LastCell";
        Detail_Order_LastCell *cell = (Detail_Order_LastCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Detail_Order_LastCell" owner:self options:nil];
            cell = (Detail_Order_LastCell *)[nib objectAtIndex:0];
        }
        cell.payment.text=[Payment_Dict valueForKey:@"payment_method"];
        
        cell.name.text=[Shipment_Dict valueForKey:@"name"];
        cell.city.text=[Shipment_Dict valueForKey:@"city"];
        cell.region.text=[Shipment_Dict valueForKey:@"region"];
        cell.phone.text=[Shipment_Dict valueForKey:@"phone"];
        cell.zipcode.text=[Shipment_Dict valueForKey:@"zipcode"];

        cell.shipping_address.layer.borderColor=[UIColor grayColor].CGColor;
        cell.shipping_address.layer.borderWidth = 1.0f;
        cell.payment_address.layer.borderColor=[UIColor grayColor].CGColor;
        cell.payment_address.layer.borderWidth = 1.0f;
        return cell;
    }
    else//middle cells
    {
        static NSString *simpleTableIdentifier = @"MyCart_Cell";
        Detail_Order *cell = (Detail_Order *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Detail_Order" owner:self options:nil];
            cell = (Detail_Order *)[nib objectAtIndex:0];
        }
        
        NSString *Name=[NSString stringWithFormat:@"%@",[[Ordered_Products objectAtIndex:indexPath.row]valueForKey:@"product_name"]];
        cell.name.text=Name;
        cell.quantity.text=[NSString stringWithFormat:@"Items-%@",[[Ordered_Products objectAtIndex:indexPath.row]valueForKey:@"qty"]];
        cell.price.text=[NSString stringWithFormat:@"₹ %@",[[Ordered_Products objectAtIndex:indexPath.row]valueForKey:@"price"]];
        NSURL *imageURL = [NSString stringWithFormat:@"%@",[[Ordered_Products objectAtIndex:indexPath.row]valueForKey:@"image"]];
        [cell.img sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        
    cell.border_view.layer.borderColor=[UIColor grayColor].CGColor;
    cell.border_view.layer.borderWidth = 1.0f;
    cell.Buttons_view.layer.borderColor=[UIColor grayColor].CGColor;
    cell.Buttons_view.layer.borderWidth = 1.0f;
        return cell;
    }
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, self.view.frame.size.width, 30)];
        title.text = [NSString stringWithFormat:@" #%@",[Orders_Dictionary valueForKey:@"order_id"]];
        title.textColor = [UIColor colorWithRed:44.0/255.0 green:52.0/255.0 blue:75.0/255.0 alpha:1.0];
        title.backgroundColor=[UIColor whiteColor];
        title.textAlignment=NSTextAlignmentLeft;
        [title setFont:[UIFont fontWithName:@"PTSans-NarrowBold" size:18]];
        return title;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1)
    {
    return 40;
    }
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    else if (indexPath.section == 2)
    {
        return 250;
    }
    else
        return 230;
}

-(void)Back_click
{
    [self.navigationController popViewControllerAnimated:YES];
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
