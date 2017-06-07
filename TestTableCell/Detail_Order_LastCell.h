//
//  Detail_Order_LastCell.h
//  SteelonCall
//
//  Created by Manoyadav on 06/12/16.
//  Copyright © 2016 com.way2online. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Detail_Order_LastCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *payment;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *region;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *zipcode;

@property (strong, nonatomic) IBOutlet UIView *shipping_address;

@property (strong, nonatomic) IBOutlet UIView *payment_address;

@end
