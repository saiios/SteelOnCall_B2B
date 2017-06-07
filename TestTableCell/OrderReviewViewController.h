//
//  OrderReviewViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 02/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReviewViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSUserDefaults *user_data;
    NSString *user_id,*Cart_Count;
}
@property(strong, nonatomic)NSArray *productArr;
@property (strong, nonatomic) IBOutlet UITableView *orderRecordTableview;
- (IBAction)backBtnActn:(id)sender;
- (IBAction)cart_Click_Actn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *cart_CountLbl;
@property (weak, nonatomic) IBOutlet UIView *cart_BackgrndView;


@end
