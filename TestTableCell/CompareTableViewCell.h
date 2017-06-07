//
//  CompareTableViewCell.h
//  steelonCallThree
//
//  Created by nagaraj  kumar on 29/11/16.
//  Copyright © 2016 nagaraj  kumar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareTableViewCell : UITableViewCell
//tata
@property (strong, nonatomic) IBOutlet UILabel *tataPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *tataFinalPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *tataSellerNameLbl;
//vizag
@property (strong, nonatomic) IBOutlet UILabel *vizagPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *vizagFinalPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *VizagSellerNameLbl;

//compare
@property (strong, nonatomic) IBOutlet UILabel *comparePriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *compareFinalPriceLbl;
@property (strong, nonatomic) IBOutlet UILabel *compareCellarNameLbl;
@property (strong, nonatomic) IBOutlet UILabel *tonnes;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UIImageView *img;



@end
