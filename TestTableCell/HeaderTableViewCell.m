//
//  HeaderTableViewCell.m
//  TestTableCell
//
//  Created by administrator on 29/11/16.
//  Copyright © 2016 com.SteelonCall. All rights reserved.
//

#import "HeaderTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HeaderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   pageControl =  [[UIPageControl alloc] init];
    
    _scrollHeightConstrain.constant = 150;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad){
     
        _scrollHeightConstrain.constant =250;
    }
    
    NSData *dataResultStore = [[NSUserDefaults standardUserDefaults] objectForKey:@"Banners"];
    NSArray *banners;
    banners = [NSKeyedUnarchiver unarchiveObjectWithData:dataResultStore];
    if (banners.count==0 || banners == nil) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"banners" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        banners = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }
    
    for (int i=0; i<banners.count; i++) {
      
        // create imageView
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i,0, [UIScreen mainScreen].bounds.size.width, _scrollHeightConstrain.constant)];
        // set scale to fill
        imgV.contentMode=UIViewContentModeScaleToFill;
      
     
        // apply tag to access in future
        imgV.tag=i+1;
        
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        
        NSURL *ImageUrl = [NSURL URLWithString:[[banners objectAtIndex:i] valueForKey:@"image"]];
        
        [manager downloadImageWithURL:ImageUrl options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize)
         
         {
             
             
         } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
             
             if(image){
                   // set image
                 imgV.image = [self imageWithImage:image scaledToFillSize:imgV.frame.size];
                 NSLog(@"image=====%@",image);
             }
         }];
        // add to scrollView
        [_imageScrollView addSubview:imgV];
    }
    // set the content size to 10 image width
    [_imageScrollView setContentSize:CGSizeMake( [UIScreen mainScreen].bounds.size.width*banners.count, _scrollHeightConstrain.constant)];
    // enable timer after each 2 seconds for scrolling.
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
    _imageScrollView.alwaysBounceHorizontal =YES;
    _imageScrollView.alwaysBounceVertical =NO;
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0,_scrollHeightConstrain.constant-20 ,[UIScreen mainScreen].bounds.size.width, 20)];
    vi.backgroundColor = [UIColor colorWithRed:44/255.0f green:52/255.0f blue:75/255.0f alpha:0.5];
    pageControl.frame = CGRectMake(0,0 ,[UIScreen mainScreen].bounds.size.width, 20);
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.numberOfPages = banners.count;
    pageControl.currentPage = 0;
    _imageScrollView.pagingEnabled =YES;
    [self addSubview:vi];
     [vi addSubview:pageControl];
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
- (void)scrollingTimer {
    // access the scroll view with the tag

    CGFloat contentOffset = _imageScrollView.contentOffset.x;
    // calculate next page to display
    int nextPage = (int)(contentOffset/_imageScrollView.frame.size.width) + 1 ;
    // if page is not 10, display it
    if( nextPage!=pageControl.numberOfPages)  {
        
        
        [_imageScrollView scrollRectToVisible:CGRectMake(nextPage*_imageScrollView.frame.size.width,0 , _imageScrollView.frame.size.width, _imageScrollView.frame.size.height) animated:YES];
        pageControl.currentPage=nextPage;
        // else start sliding form 1 :)
        
        
    } else {
        
        [_imageScrollView scrollRectToVisible:CGRectMake(0, 0, _imageScrollView.frame.size.width, _imageScrollView.frame.size.height) animated:YES];
        pageControl.currentPage=0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
