//
//  SuccessOrderViewController.m
//  steelonCallThree
//
//  Created by nagaraj  kumar on 05/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import "SuccessOrderViewController.h"
#import "YourOrdersViewController.h"

@interface SuccessOrderViewController ()

@end

@implementation SuccessOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([_From isEqualToString:@"ccavenue"]) {
        
        _orderStatusMessageLbl.text = _statusFromCCavenue;
        _orderIdLbl.text = [NSString stringWithFormat:@"order_id :#%@",[_CCAvenueResponse valueForKey:@"order_id"]];
        
    }
    else
{
    
    if (_responce.count>0)
    {
        
         _orderIdLbl.text = [NSString stringWithFormat:@"order_id :#%@",[_responce valueForKey:@"order_inc_id"]];
        _orderStatusMessageLbl.text = [_responce valueForKey:@"response"];
    }
}//else
   
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)view_yourOrdrsBtnActn:(id)sender {
    
    YourOrdersViewController *define = [[YourOrdersViewController alloc]initWithNibName:@"YourOrdersViewController" bundle:nil];
    define.From = @"Login";
    [self.navigationController pushViewController:define animated:YES];
}
@end
