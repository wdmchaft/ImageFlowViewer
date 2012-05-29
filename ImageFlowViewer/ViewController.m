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

@property ( nonatomic, strong ) ImageScrollView* imageView0;
@property ( nonatomic, strong ) ImageScrollView* imageView1;
@property ( nonatomic, strong ) ImageScrollView* imageView2;
@property ( nonatomic, assign ) CGSize contentsSize;
@property ( nonatomic, assign ) int page;   // 画像のサイズ
@property ( nonatomic, assign ) int pageMax;
@property ( nonatomic, assign ) CGRect left;
@property ( nonatomic, assign ) CGRect center;
@property ( nonatomic, assign ) CGRect right;


- ( void ) setImage: ( ImageScrollView* ) imageView  index: ( int ) index location: ( CGRect ) frame;
- ( void ) layoutViews;
- ( void ) updateView;

@end

@implementation ViewController
@synthesize scrollView,  container, imageView0, imageView1, imageView2;
@synthesize page, pageMax, contentsSize;
@synthesize left, center, right;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- ( void ) setImage: ( ImageScrollView* ) imageView  index: ( int ) index location: ( CGRect ) frame
{
    NSString* f = [ [ NSString alloc ] initWithFormat: @"image%d.jpg", index ];
    UIImage* image = [ UIImage imageNamed: f ];
    imageView.imageView.image = nil;
    [ imageView setImage: image ];
    [ imageView setFrame: frame ];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    float navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    float toolbarHeight = self.navigationController.toolbar.frame.size.height;
    
    CGSize size = self.view.frame.size;
    contentsSize = CGSizeMake( size.width,size.height - navigationbarHeight - toolbarHeight );    
    NSLog( @"Frame size: %f, %f", size.width, size.height );
    
    CGRect frame = CGRectMake( 0, 0, contentsSize.width * 2, contentsSize.height  );
    scrollView = [ [ UIScrollView alloc ] initWithFrame: frame ];
    scrollView.delegate = self;
    
    left = CGRectMake( 0, 0, contentsSize.width, contentsSize.height );
    center = left;
    center.origin.x += contentsSize.width;
    right = center;
    right.origin.x += contentsSize.width;
    
    container = [ [ UIView alloc ] initWithFrame: frame ];
    imageView0 =  [ [ ImageScrollView alloc ] initWithFrame: left ];
    imageView1 = [ [ ImageScrollView alloc ] initWithFrame: center ];
    imageView2 =  [ [ ImageScrollView alloc ] initWithFrame: CGRectZero ];
    
    [ container addSubview: imageView0 ];
    [ container addSubview: imageView1 ];
    [ container addSubview: imageView2 ];
    
    [ scrollView addSubview: container ];
    scrollView.contentSize = container.frame.size;
    
    self.view = scrollView;
    scrollView.backgroundColor = [ UIColor grayColor ];
    scrollView.pagingEnabled = YES;
    
    page = -1;
    pageMax = 7;
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
/*- (void)scrollViewDidEndDragging:(UIScrollView*)scroll willDecelerate:(BOOL)decelerate
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
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     [ self layoutViews ];
}

- ( void ) moveImageFrom: ( ImageScrollView* ) sourceView to: ( ImageScrollView* ) targetView
{
    targetView.imageView.image = sourceView.imageView.image; 
}



- ( void ) layoutViews
{
    CGRect location;
    
    float offset  =  self.scrollView.contentOffset.x;
    int viewIndex = ( int ) ( offset / contentsSize.width );
    
    int viewCount = 0;
    
    if( viewIndex == 0 ) {
        // 左にフリック
        if( page >= 0 ) page--;
    }
    else if ( viewIndex >= 1 ) {
        // 右にフリック
        if( page < pageMax - 2 )  page++;
    }
    
    
    // 左
    if( page >= 0 ) {
        [ self setImage: imageView0 index: page location: left ];
        viewCount++;
    }
    else {
        imageView0.imageView.image = nil;
        [ imageView0 setFrame: CGRectZero ];
    }
    
    // 中
    if( viewCount == 0 ) location = left; else location = center;
    [ self setImage: imageView1 index: page + 1 location: location ]; 
    viewCount++;

    // 右
    if( viewCount == 1 ) location = center; else location = right;
    if( page < pageMax - 2 ) {
        [ self setImage: imageView2 index: page + 2 location: location ]; 
        viewCount++;
    }
    else {
        imageView2.imageView.image = nil;
        [ imageView2 setFrame: CGRectZero ];
    }

    self.scrollView.contentSize = CGSizeMake( viewCount * contentsSize.width, contentsSize.height );
    self.container.frame = CGRectMake( 0, 0, viewCount * contentsSize.width, contentsSize.height );
  
}

@end
