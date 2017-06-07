//
//  SuccessOrderViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 05/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuccessOrderViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *orderStatusMessageLbl;
- (IBAction)view_yourOrdrsBtnActn:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *orderIdLbl;
@property(nonatomic,strong)NSDictionary *responce;
@property(strong, nonatomic)NSDictionary *CCAvenueResponse;

@property(nonatomic,strong)NSString *From;
@property(nonatomic,strong)NSString *statusFromCCavenue;// only status

@end
