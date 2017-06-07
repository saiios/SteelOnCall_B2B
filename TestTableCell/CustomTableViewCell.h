//
//  CustomTableViewCell.h
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
// ... other methods here
@protocol cellSelectDelegate <NSObject>

@optional
-(void)collectionViewSelected:(int )rowIndex sectionInd:(int)sec object:(NSDictionary *)selectedObj;

-(void)relaodTable;

@end


@interface CustomTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    AppDelegate *appDel ;
    
}
@property (strong,nonatomic)NSArray *userArray ;
@property (strong,nonatomic)NSString *secCount ;
@property (strong, nonatomic) IBOutlet UICollectionView *flowCollectionView;

@property (nonatomic, weak) id <cellSelectDelegate> delegate;
-(void)cellConstruction;

@end
