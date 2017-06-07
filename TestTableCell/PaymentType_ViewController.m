//
//  PaymentType_ViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "PaymentType_ViewController.h"
#import "Payment_ProductDetailsViewController.h"

@interface PaymentType_ViewController ()
{
    NSString *paymentTypeIs;
}

@end

@implementation PaymentType_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.payment_subview.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden =YES;
    // self.automaticallyAdjustsScrollViewInsets = NO;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onlinePayBtnAction:(id)sender
{
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    self.payment_subview.hidden = YES;
    paymentTypeIs = @"1";
}

- (IBAction)cashOnDelivryBtnAction:(id)sender
{
    self.payment_subview.hidden = false;
    paymentTypeIs = @"";
    
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
}

- (IBAction)sub_OnlinePayBtnAction:(id)sender {
    paymentTypeIs = @"21";
    
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    
    [_sub_OnlinePayBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    [_sub_OflinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    
}

- (IBAction)sub_offlinePayBtnAction:(id)sender
{
    paymentTypeIs = @"22";
    
    [_onlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_cashOnDeliveryBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
    
    [_sub_OnlinePayBtn setImage:[UIImage imageNamed:@"Radio_Deselect"] forState:UIControlStateNormal];
    [_sub_OflinePayBtn setImage:[UIImage imageNamed:@"Radio_select"] forState:UIControlStateNormal];
}

- (IBAction)makePaymentBtnActn:(id)sender
{
    if ([paymentTypeIs isEqualToString:@"1"])
    {
        [self payment_service:@"ccavenue"];
    }
    else if ([paymentTypeIs isEqualToString:@"21"])
    {
        [self payment_service:@"cashondelivery&submethod=online"];
    }
    else if ([paymentTypeIs isEqualToString:@"22"])
    {
        [self payment_service:@"cashondelivery&submethod=offline"];
    }
}

-(void)payment_service:(NSString *)Method
{
    user_data=[NSUserDefaults standardUserDefaults];
    user_id=[user_data valueForKey:@"user_id"];
    
    NSString *url_form=[NSString stringWithFormat:@"savePaymentMethod?customer_id=%@&method=%@",user_id,Method];
    NSString* urlEncoded = [url_form stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [[STParsing sharedWebServiceHelper]requesting_GET_ServiceWithString:urlEncoded requestNumber:Save_Payment showProgress:YES withHandler:^(BOOL success, id data)
     {
         if (success)
         {
            Payment_ProductDetailsViewController *payment_ProductDetailsViewController = [[Payment_ProductDetailsViewController alloc] initWithNibName:@"Payment_ProductDetailsViewController" bundle:nil];
            payment_ProductDetailsViewController.payType = paymentTypeIs;//
             payment_ProductDetailsViewController.shippingaddress =_shippingAddress;
                 [self.navigationController pushViewController:payment_ProductDetailsViewController animated:YES];
         }
         else
         {
             
         }
     }];
}

- (IBAction)backBtnActn:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
