//
//  TDStickerLibraryCustomization.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/1/22.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDStickerLibraryCustomization.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryCustomization

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryCustomization()

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method declare for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare for Private
@interface TDStickerLibraryCustomization(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;


//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibraryCustomization(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    [self                           setConfigureResource: @"Configure"];
    [self                           setInZippedPrefixPath: @"StickerLibraryTabDefault"];
    [self                           setTabConfigureFilename: @"StickerLibraryTabDefault"];
    
    //  for UIView.
    [self                           setNavigationBarHeight: 36.0f];
    [self                           setBannerHeight: 48.0f];
    [self                           setTabMenuHeight: 50.0f];
    
    [self                           setTabMenuItemSize: CGSizeMake( 48.0f, 48.0f )];
    [self                           setTabMenuItemSizeInset: CGSizeMake( 3.0f, 3.0f )];

    //  for UIBackgroundColor
    [self                           setNavigationBGC: [UIColor purpleColor]];
    [self                           setBannerBGC: [UIColor grayColor]];
    [self                           setTabMenuBGC: [UIColor colorWithRed: 0.5f green: ( 200 / 255.0f ) blue: ( 200 / 255.0f ) alpha: 1.0f ]];
    
    
}


//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryCustomization

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
@synthesize configureResource       = _configureResource;
@synthesize inZippedPrefixPath      = _inZippedPrefixPath;
@synthesize tabConfigureFilename    = _tabConfigureFilename;

//  for UIView.
@synthesize navigationBarHeight     = _navigationBarHeight;
@synthesize bannerHeight            = _bannerHeight;
@synthesize tabMenuHeight           = _tabMenuHeight;

@synthesize tabMenuItemSize         = _tabMenuItemSize;
@synthesize tabMenuItemSizeInset    = _tabMenuItemSizeInset;

//  for UIBackgroundColor
@synthesize navigationBGC           = _navigationBGC;
@synthesize bannerBGC               = _bannerBGC;
@synthesize tabMenuBGC              = _tabMenuBGC;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) init
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    return self;
}

//  ------------------------------------------------------------------------------------------------


@end









