//
//  CompareViewController.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 29/11/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.

#import <UIKit/UIKit.h>
#import "NIDropDown.h"
#import "UIImageView+WebCache.h"

@interface CompareViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
        IBOutlet UIButton *btnSelect;
        NIDropDown *dropDown;
    NSMutableArray *tonnes_names_ary;
    NSUserDefaults *user_data;
    NSString *user_id;
}
@property (strong, nonatomic) IBOutlet UITableView *compareListview;

@property (retain, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)selectClicked:(id)sender;
- (IBAction)backButtonClicked:(id)sender;
- (IBAction)Cart_click:(id)sender;

//@property (strong, nonatomic) IBOutlet UIButton *selectBtnOutlet;
@property (weak, nonatomic) IBOutlet UILabel *Cart_count;
@property (strong, nonatomic) NSString *Location;
@property (strong, nonatomic) NSString *selected_ids;
@property (strong, nonatomic) NSMutableArray *T_P_Ary;
@property (weak, nonatomic) IBOutlet UIButton *cart_view;
@property (weak, nonatomic) IBOutlet UIView *Cart_BackgrndView;

-(void)rel;

@end
