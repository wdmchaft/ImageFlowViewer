//
//  ViewController.m
//  ImageFlowedViewer
//
//  Created by KUDO IKUO on 12/05/13.
//  Copyright (c) 2012年 n/a. All rights reserved.
//

#import "ViewController.h"
#import "ImageScrollView.h"

@interface ViewController ()

@property ( nonatomic, assign ) int beginPageIndex;
@property ( nonatomic, assign ) int pageMax;
@property ( nonatomic, assign ) CGSize pageSize;
@property ( nonatomic, assign ) CGRect left;
@property ( nonatomic, assign ) CGRect center;
@property ( nonatomic, assign ) CGRect right;

- ( void ) setImage: ( ImageScrollView* ) imageView  index: ( int ) index;
- ( void ) layoutViews;
- ( void ) updateView;
- ( void ) slideToRight;
- ( void ) slideToLeft;

@end

@implementation ViewController
@synthesize scrollView,  container, imageView0, imageView1, imageView2;
@synthesize pageSize, beginPageIndex, pageMax;
@synthesize left, center, right;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- ( void ) setImage: ( ImageScrollView* ) imageView  index: ( int ) index
{
    NSString* f = [ [ NSString alloc ] initWithFormat: @"image%d.jpg", index ];
    UIImage* image = [ UIImage imageNamed: f ];
    [ imageView setImage: image ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGSize size = self.view.frame.size;
    pageSize = size;
    
    float navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    float toolbarHeight = self.navigationController.toolbar.frame.size.height;
    
    NSLog( @"Frame size: %f, %f", size.width, size.height );
    
    CGRect frame = CGRectMake( 0, 0, size.width * 3, size.height - navigationbarHeight - toolbarHeight );
    scrollView = [ [ UIScrollView alloc ] initWithFrame: frame ];
    scrollView.delegate = self;
    
    container = [ [ UIView alloc ] initWithFrame: frame ];
    
    left = CGRectMake( 0, 0, size.width, size.height );
    imageView0 =  [ [ ImageScrollView alloc ] initWithFrame: left ];

    center = left;
    center.origin.x = size.width;
    imageView1 = [ [ ImageScrollView alloc ] initWithFrame: center ];
    
    right = left;
    right.origin.x = size.width * 2.0;
    imageView2 =  [ [ ImageScrollView alloc ] initWithFrame: right ];
    
    [ container addSubview: imageView0 ];
    [ container addSubview: imageView1 ];
    [ container addSubview: imageView2 ];
    
    [ scrollView addSubview: container ];
    scrollView.contentSize = container.frame.size;
    
    self.view = scrollView;
    scrollView.backgroundColor = [ UIColor grayColor ];
    
    [ self setImage: self.imageView0 index: 0 ];
    [ self setImage: self.imageView1 index: 1 ];
    [ self setImage: self.imageView2 index: 2 ];
    
    pageMax = 5;
    beginPageIndex = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-( void ) updateView
{
    
}

// ドラッグ終了
- (void)scrollViewDidEndDragging:(UIScrollView*)scroll willDecelerate:(BOOL)decelerate
{
    if ( scroll == self.scrollView ) {
        
        // 加速無し
        if ( !decelerate ) [ self layoutViews ];
    }
}

// フリック操作によるスクロール終了
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    [ self layoutViews ];
}


- ( void ) slideToRight
{
    if( beginPageIndex >= pageMax - 3 ) return;
    beginPageIndex++;
    [ self.imageView1 setFrame: left ];
    [ self.imageView2 setFrame: center ];
    [ self.imageView0 setFrame: right ];
    self.scrollView.contentOffset = left.origin; 
    
    [ self setImage: self.imageView0 index: beginPageIndex + 2 ];
    
}

- ( void ) slideToLeft
{
    if( beginPageIndex == 0 ) return;
    beginPageIndex--;
    [ self.imageView0 setFrame: center ];
    [ self.imageView1 setFrame: right ];
    [ self.imageView2 setFrame: left ];
    self.scrollView.contentOffset = center.origin; 
    [ self setImage: self.imageView2 index: beginPageIndex ]; 
}

- ( void ) layoutViews
{
    
    int currentIndex = ( int ) ( self.scrollView.contentOffset.x / pageSize.width );
    NSLog( @"current view index: %d", currentIndex );
    
    if( currentIndex >= 1 ) [ self slideToRight ];
    else if ( currentIndex <= 0 ) [ self slideToLeft ];
}

@end
