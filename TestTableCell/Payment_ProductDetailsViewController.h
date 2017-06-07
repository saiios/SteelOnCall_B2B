//
//  Payment_ProductDetailsViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 03/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STParsing.h"

@interface Payment_ProductDetailsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults *user_data;
    NSString *user_id;
}
@property (strong, nonatomic) IBOutlet UITableView *paymentTableView;
@property (strong, nonatomic) NSString *payType;
@property(strong, nonatomic)NSMutableArray *shippingaddress;

- (IBAction)backBtnActn:(id)sender;

@end
