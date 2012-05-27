//
//  ImageBuffer.m
//  ImageFlowViewer
//
//  Created by KUDO IKUO on 12/05/28.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import "ImageBuffer.h"

@implementation Image
    @synthesize image, index;
@end


@interface ImageBuffer ()
- ( int ) searchLocatonWithIndex: ( int ) index;
@end


@implementation ImageBuffer

@synthesize imageBuffer;


- ( id ) init
{
    self = [ super init ];
    if( self ) {
        imageBuffer = [ [ NSMutableArray alloc ] init ];
    }
    
    return self;
}

- ( int ) searchLocatonWithIndex: ( int ) index
{
    int location = -1;
    if( !imageBuffer  ) return nil;
    for ( int i = 0; i < [ imageBuffer count ]; i++ ) {
        Image* obj = [ imageBuffer objectAtIndex: i ];
        if ( obj.index == index ) {
            location = i;
            break;
        }
    }
    
    return location;
}

- ( UIImage* ) pickupImageWithIndex: ( int ) index
{
    int location = [ self searchLocatonWithIndex: index ];
    if( location < 0 ) return nil;
    
    Image* img = [ imageBuffer objectAtIndex: location ];
    return img.image;
}

- ( void ) deleteImageWithIndex: ( int ) index
{
    int location = [ self searchLocatonWithIndex: index ];
    if( location < 0 ) return;
    
    [ imageBuffer removeObjectAtIndex: location ];
}

- ( void ) addImage: ( UIImage* ) image index: ( int ) index
{
    Image* img = [ [ Image alloc ] init ];
    img.image = image;
    img.index = index;
    
    [ imageBuffer addObject: img ];
}

@end
