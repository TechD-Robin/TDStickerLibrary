//
//  TDSystemCustomization.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/5/25.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "TDSystemCustomization.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDSystemCustomization

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
@interface TDSystemCustomization ()

//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDSystemCustomization (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;


//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDSystemCustomization (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{

    styleBackgroundColor            = nil;
    styleTintedColor                = nil;
    styleTintedColorAlpha           = 0.0f;
    
    styleHighlightedTintedColor     = nil;
    styleHighlightedTintedColorAlpha= 0.0f;
    
    styleDisabledTintedColor        = nil;
    styleDisabledTintedColorAlpha   = 0.0f;
    
    styleAlertTintedColor                   = nil;
    styleAlertTintedColorAlpha              = 0.0f;
    
    styleHighlightedAlertTintedColor        = nil;
    styleHighlightedAlertTintedColorAlpha   = 0.0f;
    
    styleTitleTextColor             = nil;
    
    //  for UIimage.
    
    styleBackToMenuImageName                = nil;
    styleBackToMenuHighlightedImageName     = nil;
    styleBackToMenuDisabledImageName        = nil;
    
    styleBackImageName                      = nil;
    styleBackHighlightedImageName           = nil;
    styleBackDisabledImageName              = nil;
    
    styleDownloadImageName                  = nil;
    styleDownloadHighlightedImageName       = nil;
    styleDownloadDisabledImageName          = nil;
    
    styleDeleteImageName                    = nil;
    styleDeleteHighlightedImageName         = nil;
    styleDeleteDisabledImageName            = nil;
    
    backToMenuImage                 = nil;
    backToMenuImageHighlighted      = nil;
    
    downloadImage                   = nil;
    downloadImageHighlighted        = nil;
    downloadImageDisabled           = nil;
    
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDSystemCustomization

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

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

//  --------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
static TDSystemCustomization              * _customization = nil;

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) customization
{
    static dispatch_once_t          oneToken;
    
    dispatch_once( &oneToken, ^
    {
        _customization              = [[self alloc] init];
    });
    return _customization;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------








