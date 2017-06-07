//
//  PaymentType_ViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"

@interface PaymentType_ViewController : UIViewController
{
    NSUserDefaults *user_data;
    NSString *user_id;
}
@property (strong, nonatomic) IBOutlet UIView *payment_subview;
@property (strong, nonatomic) IBOutlet UIButton *onlinePayBtn;
@property (strong, nonatomic) IBOutlet UIButton *cashOnDeliveryBtn;
@property (strong, nonatomic) IBOutlet UIButton *sub_OnlinePayBtn;
@property (strong, nonatomic) IBOutlet UIButton *sub_OflinePayBtn;
@property (strong, nonatomic)NSMutableArray *shippingAddress;



- (IBAction)onlinePayBtnAction:(id)sender;
- (IBAction)cashOnDelivryBtnAction:(id)sender;

- (IBAction)sub_OnlinePayBtnAction:(id)sender;
- (IBAction)sub_offlinePayBtnAction:(id)sender;
- (IBAction)makePaymentBtnActn:(id)sender;
- (IBAction)backBtnActn:(id)sender;


@end
