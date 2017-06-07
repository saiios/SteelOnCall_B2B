//
//  Pat_AmountOnline_TableViewCell.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 05/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pat_AmountOnline_TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *Online_OrderPlaceBtnOutlet;

@property (strong, nonatomic) IBOutlet UILabel *sub_total;
@property (strong, nonatomic) IBOutlet UILabel *shipping_handling;
@property (strong, nonatomic) IBOutlet UILabel *Grand_total;
@property (strong, nonatomic) IBOutlet UILabel *Shipping_Handling_Charges;


@end
