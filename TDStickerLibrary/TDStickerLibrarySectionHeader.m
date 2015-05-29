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
    /**
     *  header's title.
     */
    UILabel                       * titleLabel;
    
    /**
     *  information view.
     */
    UIButton                      * informationView;
    
    /**
     *  download view.
     */
    UIButton                      * downloadView;
    
    /**
     *  information's arrow down view.
     */
    UIButton                      * inforArrowDownView;
    
    /**
     *  information's arrow up view.
     */
    UIButton                      * inforArrowUpView;
    
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
#pragma mark declare for assign object's properties.
//  ------------------------------------------------------------------------------------------------
//  assign properties visible after view is did load.
//  ------------------------------------------------------------------------------------------------
/**
 *  assign to correct properties of download view.
 */
- ( void ) _AssignCorrectPropertiesDownloadView;

//  ------------------------------------------------------------------------------------------------
/**
 *  assign to corrent properties of information view.
 */
- ( void ) _AssignCorrectPropertiesInformationView;

//  ------------------------------------------------------------------------------------------------
/**
 *  assign to corrent properties of information's arrows view.
 */
- ( void ) _AssignCorrectPropertiesInforArrowsView;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
//  these method just create a object and set some properties of basic,
//  must be set properties visible by above methods .
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
/**
 *  @brief create a information arrows view.
 *  create a information arrows view, include arrow down and arrow up.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateInforArrows;

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
    
    inforArrowDownView              = nil;
    inforArrowUpView                = nil;
    
    [self                           setSectionIndex: 0];
    [self                           setSectionTitle: nil];
    
    [self                           setCustomization: nil];
    
    
    [self                           setBackgroundColor: [UIColor grayColor]];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for assign object's properties.
//  ------------------------------------------------------------------------------------------------
- ( void ) _AssignCorrectPropertiesDownloadView
{
    if ( ( [self customization] == nil ) || ( nil == downloadView ) )
    {
        return;
    }
    
    CGPoint                         offset;
    UIImage                       * image;

    image                           = [[self customization] sysStyleDownloadImage];
    if ( nil == image )
    {
        return;
    }
    offset                          = CGPointMake( ( [self bounds].size.width - [image size].width - 8.0f ), 0.0f );
    
    [downloadView                   setFrame: CGRectMake( offset.x, offset.y, [image size].width, [image size].height )];
    [downloadView                   setImage: image forState: UIControlStateNormal];
    [downloadView                   setImage: [[self customization] sysStyleDownloadImageHighlighted] forState: UIControlStateHighlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _AssignCorrectPropertiesInformationView
{
    if ( ( [self customization] == nil ) || ( nil == informationView ) )
    {
        return;
    }
    
    CGPoint                         offset;
    UIImage                       * image;
    UIImage                       * imageHighlighted;
    UIImage                       * imageDisabled;
    
    image                           = [[self customization] sectionHeaderInforImage];
    imageHighlighted                = [[self customization] sectionHeaderInforImageHighlighted];
    imageDisabled                   = [[self customization] sectionHeaderInforImageDisabled];
    if ( nil == image )
    {
        return;
    }
    offset                          = CGPointMake( 8.0f, [informationView frame].origin.y );
    
    [informationView                setFrame: CGRectMake( offset.x, offset.y, [informationView frame].size.width, [informationView frame].size.height )];
    [informationView                setImage: image forState: UIControlStateNormal];
    [informationView                setImage: imageHighlighted forState: UIControlStateHighlighted];
    [informationView                setImage: imageDisabled forState: UIControlStateDisabled];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _AssignCorrectPropertiesInforArrowsView
{
    if ( ( [self customization] == nil ) || ( nil == inforArrowDownView ) || ( nil == inforArrowUpView ) )
    {
        return;
    }
    
    CGRect                          arrowsRect;
    CGPoint                         offset;
    
    UIImage                       * arrowDownImage;
    UIImage                       * arrowDownImageDisabled;
    UIImage                       * arrowUpImage;
    UIImage                       * arrowUpImageDisabled;
    
    arrowDownImage                  = [[self customization] sectionHeaderArrowDownImage];
    arrowDownImageDisabled          = [[self customization] sectionHeaderArrowDownImageDisabled];
    arrowUpImage                    = [[self customization] sectionHeaderArrowUpImage];
    arrowUpImageDisabled            = [[self customization] sectionHeaderArrowUpImageDisabled];
    if ( nil == arrowDownImage )
    {
        return;
    }
    
    offset                          = CGPointMake( 8.0f, [inforArrowDownView frame].origin.y );
    arrowsRect.origin               = offset;
    arrowsRect.size                 = CGSizeMake( ( [arrowDownImage size].width * ( 2.0f / 3.0f ) ) , ( [arrowDownImage size].height / 3.0f ) );
    
    [inforArrowDownView             setFrame: arrowsRect];
    [inforArrowDownView             setImage: arrowDownImage forState: UIControlStateNormal];
    [inforArrowDownView             setImage: arrowDownImageDisabled forState: UIControlStateDisabled];

    [inforArrowUpView               setFrame: arrowsRect];
    [inforArrowUpView               setImage: arrowUpImage forState: UIControlStateNormal];
    [inforArrowUpView               setImage: arrowUpImageDisabled forState: UIControlStateDisabled];
    
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
    informationView                 = [UIButton buttonWithType: UIButtonTypeCustom];
    if ( nil == informationView )
    {
        return NO;
    }
    
    [informationView                setFrame: infoViewRect];
    [informationView                setUserInteractionEnabled: YES];
    [self                           addSubview: informationView];    
    [informationView                addTarget: self action: @selector( _TapInfoViewAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _TapInfoViewAction:(UITapGestureRecognizer *)sender
{
    if ( ( [self superview] == nil ) || ( [[self superview] isKindOfClass: [UICollectionView class]] == NO ) )
    {
        return;
    }
    
    //if ( sender.state != UIGestureRecognizerStateEnded )
    //{
    //    return;
    //}
    
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
    CGRect                          downloadRect;
    CGFloat                         height;
    CGFloat                         left;

    left                            = [self bounds].size.width;
    height                          = [self bounds].size.height;
    left                            -= ( 0.0f + height );
    downloadRect                    = CGRectMake( left, 0.0f, height, height );
    downloadView                    = [UIButton buttonWithType: UIButtonTypeCustom];
    if ( nil == downloadView )
    {
        return NO;
    }
    
    [downloadView                   setFrame: downloadRect];
    [downloadView                   setUserInteractionEnabled: YES];
    [self                           addSubview: downloadView];
    
    [downloadView                   addTarget: self action: @selector( _TapInfoViewAction: ) forControlEvents: UIControlEventTouchUpInside];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateInforArrows
{
    CGRect                          arrowsRect;
    CGFloat                         headerHeight;
    
    headerHeight                    = [self bounds].size.height;
    headerHeight                    *= ( 1.0f / 3.0f );
    arrowsRect                      = CGRectMake( 2.0f, ( ( headerHeight * 2.0f ) + 1.0f ), headerHeight, headerHeight );
    inforArrowDownView              = [UIButton buttonWithType: UIButtonTypeCustom];
    inforArrowUpView                = [UIButton buttonWithType: UIButtonTypeCustom];
    if ( ( nil == inforArrowDownView ) || ( nil == inforArrowUpView ) )
    {
        return NO;
    }
    
    [inforArrowDownView             setFrame: arrowsRect];
    [inforArrowDownView             setUserInteractionEnabled: NO];
    [self                           addSubview: inforArrowDownView];
    
    [inforArrowUpView               setFrame: arrowsRect];
    [inforArrowUpView               setUserInteractionEnabled: NO];
    [self                           addSubview: inforArrowUpView];
    
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
    [self                           _CreateInforArrows];
    
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
    [self                           _CreateInforArrows];
    
    [self                           _CreateTapAction];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != titleLabel )
    {
        SAFE_ARC_RELEASE( titleLabel );
        titleLabel                  = nil;
    }
    
    if ( nil != informationView )
    {
        SAFE_ARC_RELEASE( informationView );
        informationView             = nil;
    }
    
    if ( nil != downloadView )
    {
        SAFE_ARC_RELEASE( downloadView );
        downloadView                = nil;
    }
    
    if ( nil != inforArrowDownView )
    {
        SAFE_ARC_RELEASE( inforArrowDownView );
        inforArrowDownView          = nil;
    }
    if ( nil != inforArrowUpView )
    {
        SAFE_ARC_RELEASE( inforArrowUpView );
        inforArrowUpView            = nil;
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
        [downloadView               setHidden: NO];
    }
    else
    {
        [downloadView               setHidden: YES];
    }
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for assign properties.
//  ------------------------------------------------------------------------------------------------
- ( void ) assignCorrectProperties
{
    [self                           _AssignCorrectPropertiesDownloadView];
    
    [self                           _AssignCorrectPropertiesInformationView];
    [self                           _AssignCorrectPropertiesInforArrowsView];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setInformationState:(BOOL)isEnabled
{
    if ( nil == informationView )
    {
        return;
    }
    [informationView                setEnabled: isEnabled];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setInformationArrowsState:(BOOL)isEnabled
{
    if ( nil != inforArrowDownView )
    {
        [inforArrowDownView         setEnabled: isEnabled];
    }
    if ( nil != inforArrowUpView )
    {
        [inforArrowUpView           setEnabled: isEnabled];
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) setInformationArrow:(BOOL)isArrowDown
{
    //  arrow down enabled.
    if ( YES == isArrowDown )
    {
        [inforArrowDownView         setEnabled: YES];
        [inforArrowDownView         setHidden: NO];
        
        [inforArrowUpView           setEnabled: NO];
        [inforArrowUpView           setHidden: YES];
        return;
    }
    
    //  arrow up enabled.
    [inforArrowDownView             setEnabled: NO];
    [inforArrowDownView             setHidden: YES];
    
    [inforArrowUpView               setEnabled: YES];
    [inforArrowUpView               setHidden: NO];
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------



@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









