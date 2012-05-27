//
//  ImageBuffer.h
//  ImageFlowViewer
//
//  Created by KUDO IKUO on 12/05/28.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property ( nonatomic, strong ) UIImage* image;
@property ( nonatomic, assign ) int index;
@end 


@interface ImageBuffer : NSObject

@property ( nonatomic, strong ) NSMutableArray* imageBuffer;

- ( UIImage* ) pickupImageWithIndex: ( int ) index;
- ( void ) deleteImageWithIndex: ( int ) index;
- ( void ) addImage: ( UIImage* ) image index: ( int ) index;
@end
