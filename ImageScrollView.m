//
//  ImageScrollView.m
//  ImageFlowViewer
//
//  Created by KUDO IKUO on 12/05/15.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView
@synthesize imageView;


- ( id ) initWithFrame:(CGRect)frame
{
   self = [ super initWithFrame: frame ];
    
    self.imageView = [ [ UIImageView alloc ] initWithFrame: frame ];
    [ self addSubview: imageView ];
   return self;
}


- ( void ) setImage: ( UIImage* ) aImage
{
    self.imageView.image = aImage;
    
    CGRect rect = CGRectMake( 0, 0, self.frame.size.width, self.frame.size.height );
    [ self.imageView setFrame: rect ];
}

- ( void ) setFrame:(CGRect)frame
{
    [ super setFrame: frame ];
    [ self.imageView setFrame: CGRectMake( 0, 0, frame.size.width, frame.size.height ) ];
}

@end
