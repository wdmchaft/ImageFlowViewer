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

@property ( nonatomic, assign ) int pageIndex;

- ( void ) layoutViews;
- ( void ) updateView;
@end

@implementation ViewController
@synthesize scrollView,  container, leftView, centerView, rightView;
@synthesize pageIndex;
@synthesize pageSize;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    CGRect frame;
    CGSize size = self.view.frame.size;
    pageSize = size;
    
    float navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    float toolbarHeight = self.navigationController.toolbar.frame.size.height;
    
    NSLog( @"Frame size: %f, %f", size.width, size.height );
    
    frame = CGRectMake( 0, 0, size.width * 3, size.height - navigationbarHeight - toolbarHeight );
    scrollView = [ [ UIScrollView alloc ] initWithFrame: frame ];
    scrollView.delegate = self;
    
    container = [ [ UIView alloc ] initWithFrame: frame ];
    
    frame = CGRectMake( 0, 0, size.width, size.height );
    leftView =  [ [ ImageScrollView alloc ] initWithFrame: frame ];
    frame.origin.x = size.width;
    centerView = [ [ ImageScrollView alloc ] initWithFrame: frame ];
    frame.origin.x = size.width * 2.0;
    rightView =  [ [ ImageScrollView alloc ] initWithFrame: frame ];
    
    [ container addSubview: leftView ];
    [ container addSubview: centerView ];
    [ container addSubview: rightView ];
    
    [ scrollView addSubview: container ];
    scrollView.contentSize = container.frame.size;
    
    self.view = scrollView;
    scrollView.backgroundColor = [ UIColor grayColor ];
    
    UIImage* image = [ UIImage imageNamed: @"image1.jpg" ];
    [ leftView setImage:  image ];
    image =[ UIImage imageNamed: @"image2.jpg" ];
    [ centerView setImage: image ];
    image =[ UIImage imageNamed: @"image3.jpg" ];
    [ rightView setImage: image ];

    
    pageIndex = -1;
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




- ( void ) layoutViews
{
    
    int currentIndex = ( int ) ( self.scrollView.contentOffset.x / pageSize.width );
    NSLog( @"current view index: %d", currentIndex );
    
}

@end
