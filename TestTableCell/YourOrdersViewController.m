//
//  YourOrdersViewController.m
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import "YourOrdersViewController.h"
#import "YourOrderTableViewCell.h"
#import "URLS.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "STParsing.h"
#import "LoginViewController.h"
#import "HomeViewController.h"

@interface YourOrdersViewController ()

@end

@implementation YourOrdersViewController

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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    yourOrdersArray = [[NSMutableArray alloc]init];
    [self loadYourOrders];
    self.yourOrdersTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadYourOrders{
    
    NSString *user_id =[[ NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    //73
    //BOOL isCheck = [[ NSUserDefaults standardUserDefaults]boolForKey:@"ckeckLOGIN"];
   
        NSString *urlString = [NSString stringWithFormat:@"userorders?id=%@",user_id];
        
        
        [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlString requestNumber:WS_LOAD_YOUR_ORDERS showProgress:YES withHandler:^(BOOL success, id data)
         {
             
             if (success)
             {
                 if (data) {
                     
                     
                     if([[data objectAtIndex:0]valueForKey:@"status"]){
                         
                        //   ALERT_DIALOG(@"Alert",[[data objectAtIndex:0] valueForKey:@"message"]);
                         _statusLbl.hidden =NO;
                         
                     }else{
                         _statusLbl.hidden =YES;
                         if ([data isKindOfClass:[NSArray class]]) {
                               yourOrdersArray = data;
                         }else if ([data isKindOfClass:[NSDictionary class]]){
                             
                             yourOrdersArray =[NSMutableArray arrayWithArray:@[data]];
                             
                             
                         }
                       
                         
                       
                         
                     }
                        
                     
                 }else{
                     
                     
                 }
                 [_yourOrdersTableView reloadData];
                 
             }else{
                 _statusLbl.text = @"Something went wrong please try again";
                  _statusLbl.hidden =NO;
                 
             }
             
             
         }];

  
//    userorders?id=" + user_id
//    userorders
//    calculate/userservice/orderdetails/?id="+mainOrderId
    
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([scrollView isKindOfClass:[_yourOrdersTableView class]]) {
        
        
        CGFloat sectionHeaderHeight = 44;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
        return [[[yourOrdersArray objectAtIndex:section] valueForKey:@"product"] count];
    
   
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return yourOrdersArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
        return 30;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //base View
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0,tableView.frame.size.width, 25)];
    
    vi.backgroundColor = [UIColor whiteColor];
    
   
  
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(8,5,[UIScreen mainScreen].bounds.size.width-16, 25)];
    // lbl.backgroundColor = [UIColor blueColor];
    NSString *dates =[[yourOrdersArray objectAtIndex:section]valueForKey:@"Date"];
    NSString *orderId = [[yourOrdersArray objectAtIndex:section]valueForKey:@"order_id"];
    lbl.text = [NSString stringWithFormat:@"%@ #%@",dates,orderId] ;
    lbl.font = [UIFont systemFontOfSize:12];
    
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:lbl.text];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor grayColor] range: [lbl.text rangeOfString:dates]];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:143/255.0f green:0/255.0f blue:9/255.0f alpha:1] range: [lbl.text rangeOfString:orderId]];
    [text addAttribute: NSForegroundColorAttributeName value: [UIColor colorWithRed:143/255.0f green:0/255.0f blue:9/255.0f alpha:1] range: [lbl.text rangeOfString:@"#"]];
     //  [text addAttribute: NSForegroundColorAttributeName value:[UIFont fontWithName:@"Arial" size:16] range: [lbl.text rangeOfString:orderId]];
    
    lbl.attributedText = text;
    [vi addSubview:lbl];
    
    return vi;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
        static NSString *simpleTableIdentifier = @"YourOrderCell";
        YourOrderTableViewCell *cell = (YourOrderTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"YourOrderTableViewCell" owner:self options:nil];
            cell = (YourOrderTableViewCell *)[nib objectAtIndex:0];
        }
  
  
    cell.order_title_lbl.text = [[[[yourOrdersArray objectAtIndex:indexPath.section] valueForKey:@"product"]objectAtIndex:indexPath.row ] valueForKey:@"product_name"];
    
    cell.order_status_lbl.text =[NSString stringWithFormat:@"Order total : %@", [self convertHTML:[[yourOrdersArray objectAtIndex:indexPath.section] valueForKey:@"order_total"]]] ;
    cell.order_service_status.text = [NSString stringWithFormat:@"Status : %@", [[yourOrdersArray objectAtIndex:indexPath.section] valueForKey:@"order_status"]];
    
  
    
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    NSURL *ImageUrl = [NSURL URLWithString:[[[[yourOrdersArray objectAtIndex:indexPath.section] valueForKey:@"product"]objectAtIndex:indexPath.row ] valueForKey:@"image"]];
    
    [manager downloadImageWithURL:ImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
     
     {
         
         
     } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
         
         if(image){
             
             cell.order_imageView.image = image;
             NSLog(@"image=====%@",image);
         }
     }];
    
    

    
    
        return cell;
   }

-(NSString *)convertHTML:(NSString *)html {
    
    NSScanner *myScanner;
    NSString *text = nil;
    myScanner = [NSScanner scannerWithString:html];
    
    while ([myScanner isAtEnd] == NO) {
        
        [myScanner scanUpToString:@"<" intoString:NULL] ;
        
        [myScanner scanUpToString:@">" intoString:&text] ;
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return html;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 121;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    //  NSString *orderid = [[yourOrdersArray objectAtIndex:indexPath.row] valueForKey:@"order_id"];
    NSString *main_orderid = [[yourOrdersArray objectAtIndex:indexPath.section] valueForKey:@"main_order_id"];
    
    // NSString *product_id = [[[[yourOrdersArray objectAtIndex:indexPath.row] valueForKey:@"product"]objectAtIndex:0 ] valueForKey:@"product_id"];
    
    
    Detail_Order_View *define = [[Detail_Order_View alloc]init];
    define.mainProductId = main_orderid;
    [self.navigationController pushViewController:define animated:YES];
    
}




@end
