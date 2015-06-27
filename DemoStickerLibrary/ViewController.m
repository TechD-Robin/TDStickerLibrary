//
//  ViewController.m
//  DemoStickerLibrary
//
//  Created by Robin Hsu on 2015/1/15.
//  Copyright (c) 2015年 TechD. All rights reserved.
//

#import "UIKit+TechD.h"
#import "TDStickerLibrary.h"
#import "TDResourceManager.h"
#import "TDPreUpdateProcedure.h"
#import "TDSystemCustomization.h"

#import "ViewController.h"

@interface ViewController ()


- (void) _CreateButton;

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
@implementation ViewController

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _ImageWithoutTintColor:(NSString *)imageName from:(TDResourceManager *)manager
{
    NSParameterAssert( nil != imageName );
    NSParameterAssert( nil != manager );
    
    UIImage                       * image;
    
    image                           = [manager image: imageName ofType: @"png" inDirectory: @"Images"];
    NSParameterAssert( nil != image );
    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImage * ) _Image:(NSString *)imageName from:(TDResourceManager *)manager
{
    NSParameterAssert( nil != imageName );
    NSParameterAssert( nil != manager );
    
    UIImage                       * image;
    TDSystemCustomization         * sysCustomization;
    
    sysCustomization                = [TDSystemCustomization customization];
    NSParameterAssert( nil != sysCustomization );
    
    image                           = [manager image: imageName ofType: @"png" inDirectory: @"Images"];
    NSParameterAssert( nil != image );
    
    image                           = [image imageWithTintedColor: sysCustomization->styleTintedColor
                                                       colorAlpha: sysCustomization->styleTintedColorAlpha];
    NSParameterAssert( nil != image );
    return image;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitSystemCustomization
{
//    TDResourceManager             * manager;
    TDSystemCustomization         * sysCustomization;
    
    sysCustomization                = [TDSystemCustomization customization];
    
    sysCustomization->styleBackgroundColor              = [UIColor blackColor];
    sysCustomization->styleTintedColor                  = [UIColor cyanColor];
    sysCustomization->styleTintedColorAlpha             = 0.32f;
    
    sysCustomization->styleHighlightedTintedColor       = [UIColor cyanColor];
    sysCustomization->styleHighlightedTintedColorAlpha  = 0.32f;
    
    sysCustomization->styleDisabledTintedColor          = [UIColor lightGrayColor];
    sysCustomization->styleDisabledTintedColorAlpha     = 0.0f;
    
    sysCustomization->styleAlertTintedColor                 = [UIColor redColor];
    sysCustomization->styleAlertTintedColorAlpha            = 0.0f;
    
    sysCustomization->styleHighlightedAlertTintedColor      = [UIColor redColor];
    sysCustomization->styleHighlightedAlertTintedColorAlpha = 0.32f;
    
    
    sysCustomization->styleTitleTextColor               = [UIColor lightGrayColor];
    
    
    //  for UIimage.
    sysCustomization->styleBackToMenuImageName              = @"ic_menu_black_36dp";
    sysCustomization->styleBackToMenuHighlightedImageName   = @"ic_menu_white_36dp";
    sysCustomization->styleBackToMenuDisabledImageName      = nil;

    sysCustomization->styleBackImageName                    = @"ic_chevron_left_black_36dp";
    sysCustomization->styleBackHighlightedImageName         = @"ic_chevron_left_white_36dp";
    sysCustomization->styleBackDisabledImageName            = @"ic_chevron_left_white_36dp";

    sysCustomization->styleDownloadImageName                = @"ic_get_app_black_36dp";
    sysCustomization->styleDownloadHighlightedImageName     = @"ic_get_app_white_36dp";
    sysCustomization->styleDownloadDisabledImageName        = @"ic_get_app_white_36dp";
        
    sysCustomization->styleDeleteImageName                  = @"ic_delete_black_36dp";
    sysCustomization->styleDeleteHighlightedImageName       = @"ic_delete_white_36dp";
    sysCustomization->styleDeleteDisabledImageName          = @"ic_delete_white_36dp";

    
//    manager                         = [TDResourceManager assetsBundleEnvironment: @"SystemCustomization.bundle"
//                                                                            with: [self class] onSingleton: YES];
//    NSParameterAssert( nil != manager );
//    
//    
//    //  image menu.
//    sysCustomization->backToMenuImage               = [self _Image: @"ic_menu_grey600_36dp" from: manager];
//    sysCustomization->backToMenuImageHighlighted    = [self _Image: @"ic_menu_white_36dp" from: manager];
//        
//    //  image download.
//    sysCustomization->downloadImage                 = [self _Image: @"ic_get_app_grey600_36dp" from: manager];
//    sysCustomization->downloadImageHighlighted      = [self _Image: @"ic_get_app_white_36dp" from: manager];
    
    
    
    
    
//    UIImage                       * image;
//    
//    image                           = [resourceManager image: @"ic_menu_grey600_36dp" ofType: @"png" inDirectory: @"Images"];
//    NSParameterAssert( nil != image );
//    imageView                       = [self _CreateTestImageView: image position: CGPointMake( 160 , 160)];
//    NSParameterAssert( nil != imageView );
//    
//
//    image                           = [resourceManager image: @"ic_menu_white_36dp" ofType: nil inDirectory: @"Images"];
//    NSParameterAssert( nil != image );
//    image                           = [image imageWithTintedColor: [UIColor cyanColor]];
//    NSParameterAssert( nil != image );
//    imageView                       = [self _CreateTestImageView: image position: CGPointMake( 160 , 200)];
//    NSParameterAssert( nil != imageView );
//    
//    
//    image                           = [resourceManager image: @"star-test-image" ofType: @"png" inDirectory: @"Images"];
////    image                           = [resourceManager image: @"ic_perm_device_info_other_36dp" ofType: @"png" inDirectory: @"Images"];
//    
//    NSParameterAssert( nil != image );
//    image                           = [image imageWithTintedColor: [UIColor orangeColor] colorAlpha: 0.8f];
//    
//    
//    
//    NSParameterAssert( nil != image );
//    
//    imageView                       = [self _CreateTestImageView: image position: CGPointMake( 160 , 240)];
//    NSParameterAssert( nil != imageView );
////    [imageView                      setImageTintColor: [UIColor cyanColor]];
    
}

- ( UIImageView * ) _CreateTestImageView:(UIImage *)image position:(CGPoint)center;
{
    if ( nil == image )
    {
        return nil;
    }
    
    UIImageView                   * imageView;
    
    imageView                       = [[UIImageView alloc] initWithImage: image];
    if ( nil == imageView )
    {
        return nil;
    }
    
    [[self                          view] addSubview: imageView];
    [imageView                      setCenter: center];
    return imageView;
}


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
    
    [button                         setTintColor: [UIColor blueColor]];
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
    TDStickerLibraryCustomization * customization;
    TDSystemCustomization         * sysCustomization;
    
    
    
    sysCustomization                = [TDSystemCustomization customization];
    customization                   = [TDStickerLibraryCustomization new];
    NSParameterAssert( nil != sysCustomization );
    NSParameterAssert( nil != customization );
    
    //  init customization.
    [customization                  setSystemConfigureUpdateDirectory: TDDocumentDirectory];
    
    //  system style.
    [customization                  setSysStyleBundleName: @"SystemCustomization.bundle"];
    [customization                  setSysStyleImageSubpathInBundle: @"Images"];
    
    
    [customization                  setSysStyleBackToMenuImageName:             sysCustomization->styleBackToMenuImageName];
    [customization                  setSysStyleBackToMenuHighlightedImageName:  sysCustomization->styleBackToMenuHighlightedImageName];
    
    [customization                  setSysStyleBackImageName:                   sysCustomization->styleBackImageName];
    [customization                  setSysStyleBackHighlightedImageName:        sysCustomization->styleBackHighlightedImageName];
    [customization                  setSysStyleBackDisabledImageName:           sysCustomization->styleBackDisabledImageName];
    
    [customization                  setSysStyleDownloadImageName:               sysCustomization->styleDownloadImageName];
    [customization                  setSysStyleDownloadHighlightedImageName:    sysCustomization->styleDownloadHighlightedImageName];
    [customization                  setSysStyleDownloadDisabledImageName:       sysCustomization->styleDownloadDisabledImageName];

    [customization                  setSysStyleDeleteImageName:                 sysCustomization->styleDeleteImageName];
    [customization                  setSysStyleDeleteHighlightedImageName:      sysCustomization->styleDeleteHighlightedImageName];
    [customization                  setSysStyleDeleteDisabledImageName:         sysCustomization->styleDeleteDisabledImageName];
    
    
    [customization                  setSysStyleTintedColor:                     sysCustomization->styleTintedColor];
    [customization                  setSysStyleTintedColorAlpha:                sysCustomization->styleTintedColorAlpha];
    
    [customization                  setSysStyleHighlightedITintedColor:         sysCustomization->styleHighlightedTintedColor];
    [customization                  setSysStyleHighlightedITintedColorAlpha:    sysCustomization->styleHighlightedTintedColorAlpha];
    
    [customization                  setSysStyleDisabledTintedColor:             sysCustomization->styleDisabledTintedColor];
    [customization                  setSysStyleDisabledTintedColorAlpha:        sysCustomization->styleDisabledTintedColorAlpha];
    
    [customization                  setSysStyleAlertTintedColor:                    sysCustomization->styleAlertTintedColor];
    [customization                  setSysStyleAlertTintedColorAlpha:               sysCustomization->styleAlertTintedColorAlpha];

    [customization                  setSysStyleHighlightedAlertTintedColor:         sysCustomization->styleHighlightedAlertTintedColor];
    [customization                  setSysStyleHighlightedAlertTintedColorAlpha:    sysCustomization->styleHighlightedAlertTintedColorAlpha];
    
    
    [customization                  setSysStyleTitleTextColor:                  sysCustomization->styleTitleTextColor];
    
    
    //controller                      = [TDStickerLibraryViewController stickerLibaray];
    controller                      = [TDStickerLibraryViewController stickerLibarayWithCustomization: customization];
    if ( nil == controller )
    {
        return;
    }
    
    
    
    [self                           presentViewController: controller animated: YES completion: nil];
    
//    NSLog( @"new get status bar height : %f", [[UIScreen mainScreen] getStatusBarHeight] );
}

//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _CreatePreUpdateButton
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
    [button                         setTitle: @" PreUpload " forState: UIControlStateNormal];
    [[self                          view] addSubview: button];
    
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector( _TapPreUpdateAction: )];
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
- ( void ) _TapPreUpdateAction:(id)sender
{
    NSArray                       * searchKeys;
    NSString                      * urlString;
    TDStickerLibraryCustomization * customization;
    TDStickerLibraryUpdate        * updateProcedure;
    
    customization                   = [TDStickerLibraryCustomization new];
    NSParameterAssert( nil != customization );
    
    [customization                  setSystemConfigureUpdateFilename: @"SystemConfigureUpdate.json"];
    [customization                  setSystemConfigureUpdateDirectory: TDDocumentDirectory];
    updateProcedure                 = [TDStickerLibraryUpdate stickerLibraryUpdateWithCustomization: customization];
    NSParameterAssert( nil != updateProcedure );
    
    searchKeys                      = [NSArray arrayWithObjects: @"UpdateTab", nil];
    urlString                       = @"https://docs.google.com/uc?authuser=0&id=0B1yHM9LysIXXMnJWUzhvS3ZuN1k&export=download";
    [updateProcedure                startUpdateSystemConfigure: urlString forSearch: searchKeys];
    
    __weak __typeof(updateProcedure)    weakUpdateProcedure;
    weakUpdateProcedure                 = updateProcedure;
    [updateProcedure                    setUpdateCompletionBlock: ^(NSDictionary * updateResponses, NSError * error, BOOL finished)
    {
        NSLog( @"resopnses : %@", updateResponses );
        NSLog( @"error : %@", error );
        NSLog( @"finished : %d", finished );
        
        [weakUpdateProcedure            stopProcedure];
    }];
    
    
    //  finish.
    customization                   = nil;
    
}

//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[self view] setBackgroundColor: [UIColor grayColor]];
    [[self                           view] setBackgroundColor: [UIColor clearColor]];

    
    [self                           _InitSystemCustomization];
    
    [self                           _CreateButton];
    [self                           _CreatePreUpdateButton];
    
    
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
