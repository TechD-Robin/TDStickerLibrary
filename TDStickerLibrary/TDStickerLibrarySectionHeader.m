//
//  TDStickerLibrarySectionHeader.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/4.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "UIKit+TechD.h"
#import "TDStickerLibraryCustomization.h"
#import "TDStickerLibrarySectionHeader.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionHeader

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibrarySectionHeader ()
{
    UILabel                       * titleLabel;
    
    UIImageView                   * informationView;
    
//    UIButton                      * downloadView;
    UIImageView                   * downloadView;
    
}
//  ------------------------------------------------------------------------------------------------

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark declare private category (Private)
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibrarySectionHeader (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create tap gesture recognizer.
 *  create tap gesture recognizer for self (header object).
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateTapAction;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a title lable.
 *  create a title lable for header.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateTitle;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a information view.
 *  create a information view.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateInformationView;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a download view.
 *  create a download view.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateDownloadView;

//  ------------------------------------------------------------------------------------------------



@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibrarySectionHeader (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    titleLabel                      = nil;
    informationView                 = nil;
    downloadView                    = nil;
    
    
    [self                           setSectionIndex: 0];
    [self                           setSectionTitle: nil];
    
    [self                           setCustomization: nil];
    
    
    [self                           setBackgroundColor: [UIColor grayColor]];
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTitle
{
    
    titleLabel                      = [[UILabel alloc] initWithFrame: CGRectMake( 0.0f, 0.0f, [self frame].size.width, [self frame].size.height )];
    if ( nil == titleLabel )
    {
        return NO;
    }
    
    if ( [self sectionTitle] != nil )
    {
        [titleLabel                 setText: [self sectionTitle]];
    }

    [titleLabel                     setTextAlignment: NSTextAlignmentCenter];
    [self                           addSubview: titleLabel];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTapAction
{
    return [UIGestureRecognizer tapGestureRecognizer: self withTarget: self action: @selector( _TapAction: )];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapAction:(UITapGestureRecognizer *) sender
{
    if ( ( [self superview] == nil ) || ( [[self superview] isKindOfClass: [UICollectionView class]] == NO ) )
    {
        return;
    }
    
    if ( sender.state != UIGestureRecognizerStateEnded )
    {
        return;
    }
    
    if ( [self idDelegate] == nil )
    {
        NSLog( @"!!!!Warning!!!! maybe lose to assign delegate of the class: %s ", [NSStringFromClass( [self class] ) UTF8String] );
        NSParameterAssert( [self idDelegate] );
    }
    
    if ( [[self idDelegate] respondsToSelector: @selector( collectionView: didSelectHeaderInSection: )] == NO )
    {
        return;
    }
    
    [[self                          idDelegate] collectionView: (UICollectionView *)[self superview] didSelectHeaderInSection: [self sectionIndex]];
    
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateInformationView
{
    CGRect                          infoViewRect;
    CGFloat                         headerHeight;
    
    headerHeight                    = [self bounds].size.height;
    headerHeight                    *= ( 2.0f / 3.0f );
    infoViewRect                    = CGRectMake( 2.0f, 1.0f, headerHeight, headerHeight );
    informationView                 = [[UIImageView alloc] initWithFrame: infoViewRect];
    if ( nil == informationView )
    {
        return NO;
    }
    
    [self                           addSubview: informationView];
    
    [informationView                setUserInteractionEnabled: YES];
    [UIGestureRecognizer            tapGestureRecognizer: informationView withTarget: self action: @selector( _TapInfoViewAction: )];
    
    
    
    //  test.
    [informationView                setBackgroundColor: [UIColor darkGrayColor]];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapInfoViewAction:(UITapGestureRecognizer *)sender
{
    if ( ( [self superview] == nil ) || ( [[self superview] isKindOfClass: [UICollectionView class]] == NO ) )
    {
        return;
    }
    
    if ( sender.state != UIGestureRecognizerStateEnded )
    {
        return;
    }
    
    if ( [self idDelegate] == nil )
    {
        NSLog( @"!!!!Warning!!!! maybe lose to assign delegate of the class: %@ ", NSStringFromClass( [self class] ));
        NSParameterAssert( [self idDelegate] );
    }
    
    if ( [[self idDelegate] respondsToSelector: @selector( collectionView: didSelectHeaderInformationInSection: )] == NO )
    {
        return;
    }
    
    [[self                          idDelegate] collectionView: (UICollectionView *)[self superview] didSelectHeaderInformationInSection: [self sectionIndex]];
    
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateDownloadView
{
//    if ( ( [self customization] == nil ) || ( [[self customization] downloadImage] == nil ) )
//    {
//        return NO;
//    }
//    
//    if ( nil != downloadView )
//    {
//        [downloadView               setHidden: ( ( [self isDownloadedData] == NO ) ? NO : YES )];        
//        return YES;
//    }
//    
//    CGPoint                         offset;
//    UIButton                      * download;
//    UIImage                       * image;
//    
//    image                           = [[self customization] downloadImage];
//    offset                          = CGPointMake( ( [self bounds].size.width - [image size].width - 2.0f ) , 0.0f );
//    
//    download                        = [UIButton buttonWithImage: image highlighted: [[self customization] downloadImageHighlighted] origin: offset];
//    if ( nil == download )
//    {
//        return NO;
//    }
//    
//    [self                           addSubview: download];
//    downloadView                    = download;
    
    
    CGRect                          dlViewRect;
    CGFloat                         height;
    CGFloat                         left;
    
    left                            = [self bounds].size.width;
    height                          = [self bounds].size.height;
    height                          -= ( 2 * 2 );
    left                            -= ( 2 + height );
    dlViewRect                      = CGRectMake( left, 2.0f, height, height );
    downloadView                    = [[UIImageView alloc] initWithFrame: dlViewRect];
    if ( nil == downloadView )
    {
        return NO;
    }
    
    [self                           addSubview: downloadView];
    
    
    //  test.
    [downloadView                   setBackgroundColor: [UIColor darkGrayColor]];
    return YES;
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
@implementation TDStickerLibrarySectionHeader

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
@synthesize sectionIndex            = _sectionIndex;
@synthesize isDownloadedData        = _isDownloadedData;
@synthesize sectionTitle            = _sectionTitle;

@synthesize customization           = _customization;
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame
{
    self                            = [super initWithFrame: frame];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    [self                           _CreateTitle];
    [self                           _CreateInformationView];
    [self                           _CreateDownloadView];
    
    [self                           _CreateTapAction];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithCoder:(NSCoder *)aDecoder
{
    self                            = [super initWithCoder: aDecoder];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    
    [self                           _CreateTitle];
    [self                           _CreateInformationView];
    [self                           _CreateDownloadView];
    
    [self                           _CreateTapAction];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != titleLabel )
    {
        SAFE_ARC_RELEASE( titleLabel );
        SAFE_ARC_ASSIGN_POINTER_NIL( titleLabel );
    }
    
    if ( nil != informationView )
    {
        SAFE_ARC_RELEASE( informationView );
        SAFE_ARC_ASSIGN_POINTER_NIL( informationView );
    }
    
    if ( nil != downloadView )
    {
        SAFE_ARC_RELEASE( downloadView );
        SAFE_ARC_ASSIGN_POINTER_NIL( downloadView );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite properties of the class
//  ------------------------------------------------------------------------------------------------
- ( void ) setSectionTitle:(NSString *)sectionTitle
{
    if ( nil == sectionTitle )
    {
        sectionTitle                = @"";
    }
    _sectionTitle                   = sectionTitle;

    if ( nil == titleLabel )
    {
        return;
    }
    [titleLabel                     setText: [self sectionTitle]];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setIsDownloadedData:(BOOL)isDownloaded
{
    _isDownloadedData               = isDownloaded;
    
    //  test.
    if ( [self isDownloadedData] == NO )
    {
        [informationView            setBackgroundColor: [UIColor blackColor]];
        
        [downloadView               setHidden: NO];
    }
    else
    {
        [informationView            setBackgroundColor: [UIColor darkGrayColor]];
        
        [downloadView               setHidden: YES];
    }
    
//    if ( [self isDownloadedData] == NO )
//    {
//        [self                       _CreateDownloadView];
//    }
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









