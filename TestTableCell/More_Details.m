//
//  More_Details.m
//  SteelonCall
//
//  Created by Manoyadav on 01/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//
//
#import "More_Details.h"

@interface More_Details ()

@end

@implementation More_Details

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self Getting_Details];
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

-(void)Getting_Details
{
    NSString *url_form=[NSString stringWithFormat:@"getProductDetails?id=%@&&pincode=%@&brand=%@&grade=%@&location=%@&child_id=%@",_ID,_PINCODE,_BRAND,_GRADE,_location,_childId];
    
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:More_Detail showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
             Details_Dict=data;
             NSDictionary *mechanical_properties=[Details_Dict valueForKey:@"mechanical_properties"];
             NSDictionary *chemical_properties=[Details_Dict valueForKey:@"chemical_properties"];
             
             NSLog(@" Grades response %@",data);
             _Name.text=[Details_Dict valueForKey:@"name"];
//             _price.text=[NSString stringWithFormat:@"₹ %@", [Details_Dict valueForKey:@"price"]];
             _price.text=[NSString stringWithFormat:@"₹ %@",_price_str];

             _seller_name.text=[Details_Dict valueForKey:@"seller"];
             _brand_name.text=[Details_Dict valueForKey:@"brand"];
             _grade.text=[Details_Dict valueForKey:@"grade"];
             _Description.text=[Details_Dict valueForKey:@"description"];

              _c.text=[NSString stringWithFormat:@"%@", [chemical_properties valueForKey:@"carbon"]];
              _s.text=[NSString stringWithFormat:@"%@", [chemical_properties valueForKey:@"sulphur"]];
              _p.text=[NSString stringWithFormat:@"%@", [chemical_properties valueForKey:@"phosphorus"]];
              _s_p.text=[NSString stringWithFormat:@"%@", [chemical_properties valueForKey:@"sulphur_phosphorus"]];
              _yield_strength.text=[NSString stringWithFormat:@"%@", [mechanical_properties valueForKey:@"yield_strength"]];
              _uts.text=[NSString stringWithFormat:@"%@", [mechanical_properties valueForKey:@"uts"]];
              _elongation.text=[NSString stringWithFormat:@"%@", [mechanical_properties valueForKey:@"elongation"]];
             NSURL *imageURL = [NSURL URLWithString:[Details_Dict valueForKey:@"img"]];
             [_img sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
             
              [_img.layer setBorderColor: [[UIColor colorWithRed:213.0/255.0 green:216.0/255.0 blue:224.0/255.0 alpha:1] CGColor]];
             [_img.layer setBorderWidth: 2.0];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
