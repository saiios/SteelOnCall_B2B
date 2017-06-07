//
//  CCResultViewController.h
//  CCIntegrationKit
//
//  Created by test on 5/16/14.
//  Copyright (c) 2014 Avenues. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCResultViewController : UIViewController
    @property (strong, nonatomic) IBOutlet UILabel *resultLabel;
    @property (strong, nonatomic) NSString *transStatus;
    @property (strong, nonatomic) NSString *payAmount;
    @property (strong, nonatomic) NSString *payOrderId;
    @property (strong, nonatomic) NSString *payUserId;
@property (strong, nonatomic) NSString *fromScreen3;//DetailMyRideVC
@property (strong, nonatomic) NSDictionary *respoDetails;
@end
 