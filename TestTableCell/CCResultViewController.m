//
//  CCResultViewController.m
//  CCIntegrationKit
//
//  Created by test on 5/16/14.
//  Copyright (c) 2014 Avenues. All rights reserved.

#import "CCResultViewController.h"
//#import "PaymentVC.h"
#import "AppDelegate.h"

@interface CCResultViewController ()

@end

@implementation CCResultViewController
@synthesize transStatus;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.resultLabel.text = transStatus;
    [self.resultLabel reloadInputViews];
    NSLog(@"%@",transStatus);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)OK:(id)sender
{
    if ([_fromScreen3 isEqualToString:@"DetailMyRideVC"])
    {
        if ([transStatus isEqualToString:@"Transaction Cancelled"]||[transStatus isEqualToString:@"Transaction Failed"])
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
        else if ([transStatus isEqualToString:@"Transaction Successful"])
        {
//            AppDelegate*appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//            [appdelegate connectToXmpp];
//            [appdelegate setInitialViewController];
        }
        
        
        
    }
    
    else{
    
    if ([transStatus isEqualToString:@"Transaction Cancelled"]||[transStatus isEqualToString:@"Transaction Failed"]) {
        
//        PaymentVC* paymentVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PaymentVCID"];
//        paymentVC.Amount = _payAmount;
//         paymentVC.RideID = _payOrderId;
//         //paymentVC.Amount = _payAmount;
//    
//       [self.navigationController pushViewController:paymentVC animated:YES];

       
        
    }
    
    else if ([transStatus isEqualToString:@"Transaction Successful"])
    {
//        AppDelegate*appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//        [appdelegate connectToXmpp];
//        [appdelegate setInitialViewController];
        
    }
 }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
