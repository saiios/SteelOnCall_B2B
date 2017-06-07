//
//  OrderReview_AddressTableViewCell.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 02/12/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderReview_AddressTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *seller_NameLbl;
@property (strong, nonatomic) IBOutlet UILabel *shipping_NameLbl;

@property (strong, nonatomic) IBOutlet UITextView *sellar_AddressTXtView;
@property (strong, nonatomic) IBOutlet UITextView *Shipping_AddressTxtView;
@property (strong, nonatomic) IBOutlet UILabel *distanceLbl;
@property (strong, nonatomic) IBOutlet UILabel *shipping_AmontLbl;

@end
