//
//  CustomTableViewCell.m
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "CustomCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"
#import "AppDelegate.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
     //   [self setBackgroundColor:[UIColor colorWithRed:244/255.0f green:119/255.0f blue:125/255.0f alpha:1.0f]];
        //  [self setTitle:@"lol" forState:UIControlStateNormal];
     
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
  //  [self.flowCollectionView registerClass:[CustomCollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
      appDel = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    UINib *cellNib = [UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil];
    [self.flowCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"MyCell"];
     [self.flowCollectionView registerNib:[UINib nibWithNibName:@"HeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
    // [self.flowCollectionView registerClass:[HeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell"];
    
  //[_flowCollectionView reloadData];
 //   [_flowCollectionView reloadData];

}

-(void)cellConstruction{
    
    //    _flowCollectionView.scrollEnabled =NO;
     [_flowCollectionView reloadData];
    
      
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

   // [_delegate relaodTable];
//    return [[appDel.userArray objectAtIndex: self.flowCollectionView.tag ] count] ;
    return [_secCount intValue];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if ([_secCount intValue] >1) {
        return [[[_userArray objectAtIndex:section]valueForKey:@"secObjects"] count];

    }else{
        return _userArray.count ;

    }
    
    
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(10,5, 10, 30);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:  (UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize retval;
     if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
         retval =  CGSizeMake(150, 150);

         
     }else{
         
    if ([UIScreen mainScreen].bounds.size.width==320) {
        retval =  CGSizeMake(90, 90);
        
    }else{
        retval =  CGSizeMake(100, 100);
    }
   
     }
    return retval;
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 5.0;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 5.0;
//}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // return UIEdgeInsetsMake(0,8,0,8);  // top, left, bottom, right
      // top, left, bottom, right
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
        return UIEdgeInsetsMake(15,15,15,15);

    }else{
    if ([UIScreen mainScreen].bounds.size.width==320) {
        return UIEdgeInsetsMake(5,5,5,5);
    }else{
        return UIEdgeInsetsMake(15,15,15,15);
    }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    //_collectionViewHeight.constant = (30/3)*100;
    
    if ([_secCount intValue]>1) {
        
        cell.item_name.text = [[[[_userArray objectAtIndex:indexPath.section]valueForKey:@"secObjects"] objectAtIndex:indexPath.row] valueForKey:@"name"];
        if ([[[[[_userArray objectAtIndex:indexPath.section]valueForKey:@"secObjects"] objectAtIndex:indexPath.row] valueForKey:@"img"]  isKindOfClass:[NSString class]]) {
            
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        NSURL *ImageUrl = [NSURL URLWithString:[[[[_userArray objectAtIndex:indexPath.section]valueForKey:@"secObjects"] objectAtIndex:indexPath.row] valueForKey:@"img"]];

        [manager downloadImageWithURL:ImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
         
        {
            
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if(image){
                
                cell.item_imageVIew.image = [self imageWithImage:image scaledToFillSize:cell.item_imageVIew.frame.size];;
                NSLog(@"image=====%@",image);
            }
        }];
        }
        
    }else{
        
         cell.item_name.text = [[_userArray objectAtIndex:indexPath.row]valueForKey:@"name"]  ;
        
        
        if ([[[_userArray objectAtIndex:indexPath.row]valueForKey:@"img"]  isKindOfClass:[NSString class]]) {
            
            
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            
            NSURL *ImageUrl = [NSURL URLWithString:[[_userArray objectAtIndex:indexPath.row]valueForKey:@"img"]];
            
            [manager downloadImageWithURL:ImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
             
             {
                 
                 
             } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                 
                 if(image){
                     
                     cell.item_imageVIew.image = [self imageWithImage:image scaledToFillSize:cell.item_imageVIew.frame.size];
                     NSLog(@"image=====%@",image);
                 }
             }];
        }

    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        
        HeaderCollectionReusableView *reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
        
//        if (indexPath.section == 0) {
//            reusableview.frame =CGRectMake(0, 0, 320, 0);
//        }
        if ([_secCount intValue]>1) {

            reusableview.sectionName_lbl.text = [[_userArray objectAtIndex:indexPath.section] valueForKey:@"name"];
        }else{
            
            reusableview.sectionName_lbl.text =@"";
            
        }
        
        if (reusableview==nil) {
            
            reusableview=[[HeaderCollectionReusableView alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 30)];
        }
        return reusableview;
        
    }
    
    
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    if ([_secCount intValue]>1) {
       
        [_delegate collectionViewSelected:(int)indexPath.row sectionInd:(int)indexPath.section object:[[[_userArray objectAtIndex:indexPath.section]valueForKey:@"secObjects"] objectAtIndex:indexPath.row]];
    }else{

        
          [_delegate collectionViewSelected:(int)indexPath.row sectionInd:(int)indexPath.section object:[_userArray objectAtIndex:indexPath.row]];
 
    }

    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if ([_secCount intValue]>1) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,40);
    }else{
        return CGSizeMake([UIScreen mainScreen].bounds.size.width,0);
    }
    
    
}
- (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}





@end
