//
//  ImageScrollView.h
//  ImageFlowViewer
//
//  Created by KUDO IKUO on 12/05/15.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScrollView : UIScrollView

@property ( nonatomic, strong ) UIImageView* imageView;

- ( void ) setImage: ( UIImage* ) aImage;
@end
