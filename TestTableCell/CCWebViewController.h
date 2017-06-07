//
//  CCPOViewController.h
//  CCIntegrationKit
//
//  Created by test on 5/12/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCWebViewController : UIViewController <UIWebViewDelegate>
    @property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
    @property (strong, nonatomic) NSString *accessCode;//
    @property (strong, nonatomic) NSString *merchantId;//

    @property (strong, nonatomic) NSString *currency;// from
    @property (strong, nonatomic) NSString *redirectUrl;///ccavResponseHandler.php
    @property (strong, nonatomic) NSString *cancelUrl;//ccavResponseHandler.php
    @property (strong, nonatomic) NSString *rsaKeyUrl;//GetRSA.php
@property (strong, nonatomic)NSString *Userid;
@property (strong, nonatomic)NSString *orderId;
@property (strong, nonatomic) NSString *amount;// from
@property(strong, nonatomic)NSMutableArray *shipping;
@property(strong, nonatomic)NSMutableArray *billing;

- (IBAction)backBtnActn:(id)sender;




@end



