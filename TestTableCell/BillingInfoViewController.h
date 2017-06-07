//
//  BillingInfoViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 01/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillingInfoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSUserDefaults *user_data;
    NSString *user_id;
    int tableHeight;
      BOOL keyboardIsShown;
}
@property (strong, nonatomic) IBOutlet UITableView *billingInfoTableView;

- (IBAction)continueBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *continueBtnOutlet;
- (IBAction)backBtnActn:(id)sender;
- (IBAction)cart_Click_Actn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cart_CountLbl;
@property (weak, nonatomic) IBOutlet UIView *cart_BackgroundView;

@end
