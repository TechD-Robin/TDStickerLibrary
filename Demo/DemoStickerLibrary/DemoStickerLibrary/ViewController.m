//
//  ViewController.m
//  DemoStickerLibrary
//
//  Created by Robin Hsu on 2015/1/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "UIKit+TechD.h"
#import "TDStickerLibrary.h"
#import "AFNetworking.h"

#import "ViewController.h"

@interface ViewController ()


- (void) _CreateButton;

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@implementation ViewController

//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- (void) _CreateButton
{
    UIButton                      * button;
    CGRect                          mainRect;
    
    mainRect                        = [[UIScreen mainScreen] bounds];
    //.NSLog( @"%s", [NSStringFromCGRect( mainRect ) UTF8String] );
    button                          = [UIButton buttonWithType: UIButtonTypeInfoDark];
    if ( nil == button )
    {
        return;
    }
    
    [button                         setBackgroundColor: [UIColor darkGrayColor]];
    [button                         setFrame: CGRectMake( 0, 0, 120, 36)];
    [button                         setCenter: CGPointMake( ( mainRect.size.width / 2.0f ), ( mainRect.size.height /2.0f ) )];
    [button                         setTitle: @" Start " forState: UIControlStateNormal];
    [[self                          view] addSubview: button];
    
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapButtonAction: )];
    if ( nil == tap )
    {
        return;
    }
    [button                         addGestureRecognizer: tap];
    
    
    [button                         setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    NSLayoutConstraint            * layoutX;
    NSLayoutConstraint            * layoutY;
    layoutX                         = [NSLayoutConstraint constraintWithItem: button attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual
                                                                      toItem: [self view] attribute:NSLayoutAttributeCenterX  multiplier: 1.0f constant: 0.0f];
    
    layoutY                         = [NSLayoutConstraint constraintWithItem: button attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual
                                                                      toItem: [self view] attribute: NSLayoutAttributeTopMargin multiplier: 1.0f constant: 20.0f];
    
    [[self view] addConstraint: layoutX];
    [[self view] addConstraint: layoutY];
    
    
    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapButtonAction:(id)sender
{
    TDStickerLibraryViewController* controller;
    
    controller                      = [TDStickerLibraryViewController stickerLibaray];
    if ( nil == controller )
    {
        return;
    }
    
    
    
    [self                           presentViewController: controller animated: YES completion: nil];
    
//    NSLog( @"new get status bar height : %f", [[UIScreen mainScreen] getStatusBarHeight] );
}


//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- (void) _CreateDownloadButton
{
    UIButton                      * button;
    CGRect                          mainRect;
    
    mainRect                        = [[UIScreen mainScreen] bounds];
    //.NSLog( @"%s", [NSStringFromCGRect( mainRect ) UTF8String] );
    button                          = [UIButton buttonWithType: UIButtonTypeInfoDark];
    if ( nil == button )
    {
        return;
    }
    
    [button                         setBackgroundColor: [UIColor darkGrayColor]];
    [button                         setFrame: CGRectMake( 0, 0, 240, 36)];
    [button                         setCenter: CGPointMake( ( mainRect.size.width / 2.0f ), ( mainRect.size.height /2.0f ) )];
    [button                         setTitle: @" Download Test " forState: UIControlStateNormal];
    [[self                          view] addSubview: button];
    
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapDownloadAction: )];
    if ( nil == tap )
    {
        return;
    }
    [button                         addGestureRecognizer: tap];
    
    
    [button                         setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    NSLayoutConstraint            * layoutX;
    NSLayoutConstraint            * layoutY;
    layoutX                         = [NSLayoutConstraint constraintWithItem: button attribute: NSLayoutAttributeCenterX relatedBy: NSLayoutRelationEqual
                                                                      toItem: [self view] attribute:NSLayoutAttributeCenterX  multiplier: 1.0f constant: 0.0f];
    
    layoutY                         = [NSLayoutConstraint constraintWithItem: button attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual
                                                                      toItem: [self view] attribute: NSLayoutAttributeTopMargin multiplier: 1.0f constant: 80.0f];
    
    [[self view] addConstraint: layoutX];
    [[self view] addConstraint: layoutY];
    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapDownloadAction:(id)sender
{
    NSLog( @"download test" );
    
    NSString                      * link;
    

    link                            = @"https://docs.google.com/uc?authuser=0&id=0B1yHM9LysIXXdXV4TWVVdkJORkU&export=download";
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString: link];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //.NSProgress *progress = nil;
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress: nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"!!!!!!!!!!!! File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    
    
    

}



//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[self view] setBackgroundColor: [UIColor grayColor]];

    
    [self                           _CreateButton];
    [self                           _CreateDownloadButton];     //  for download update test.
    
//    [[UIApplication sharedApplication] setStatusBarHidden: NO withAnimation:UIStatusBarAnimationFade];
}

//// 這一個一設定, 變成無論如何都 hidden = YES.
//- (BOOL)prefersStatusBarHidden
//{
//    return YES;
//}

//  ------------------------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
