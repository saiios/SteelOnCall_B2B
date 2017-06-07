//
//  Shipping_Info.m
//  SteelonCall
//
//  Created by Manoyadav on 13/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.

#import "Shipping_Info.h"
@interface Shipping_Info ()
@end

@implementation Shipping_Info

-(void)Back_click
{
    [self.navigationController popViewControllerAnimated:YES];
}

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
    NSLog(@"dictionary %@",_json_dict);
    Dict=[[NSMutableDictionary alloc]init];
    Dict=[[_json_dict valueForKey:@"seller_info"]mutableCopy];
    NSLog(@"local dictionary %@",Dict);
    S_H_Price=[NSString stringWithFormat:@"%@",[[_json_dict valueForKey:@"total_shipping_and_handling_price"]mutableCopy]];
    NSLog(@"s h str %@",S_H_Price);
    _shipping_table.delegate=self;
    _shipping_table.dataSource=self;
    _shipping_table.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (Dict.count>0)
    {
        return Dict.count+1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==Dict.count)
    {
        return 50;
    }
    else
        return 213;
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
