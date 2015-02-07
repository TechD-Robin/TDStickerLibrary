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

#import "TDStickerLibrarySectionHeader.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionHeader

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibrarySectionHeader ()
{
    UILabel                       * titleLabel;
    
}
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
@interface TDStickerLibrarySectionHeader(Private)

//  ------------------------------------------------------------------------------------------------
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
 *  @brief create tap gesture recognizer and assign the action method for owner object.
 *
 *  @param ownerObject              owner object.
 *  @param action                   a selector method of action.
 *
 *  @return YES|NO                  method success or failure
 */
- ( BOOL ) _CreateTapGestureRecognizer:(id)ownerObject action:(SEL)action;

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

@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  method implementation for Private of category
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for Private method
@implementation TDStickerLibrarySectionHeader(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    titleLabel                      = nil;
    
    
    [self                           setSectionIndex: 0];
    [self                           setSectionTitle: nil];
    
    
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
- ( BOOL ) _CreateTapGestureRecognizer:(id)ownerObject action:(SEL)action
{
    if ( nil == ownerObject )
    {
        return NO;
    }
    
    UITapGestureRecognizer        * tap;
    
    tap                             = [[UITapGestureRecognizer alloc] initWithTarget: self action: action];
    if ( nil == tap )
    {
        return NO;
    }
    
    [ownerObject                    addGestureRecognizer: tap];
    SAFE_ARC_RELEASE( tap );
    SAFE_ARC_ASSIGN_POINTER_NIL( tap );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateTapAction
{
    return [self _CreateTapGestureRecognizer: self action: @selector( _TapAction: )];
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
@implementation TDStickerLibrarySectionHeader

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.
@synthesize sectionIndex            = _sectionIndex;
@synthesize sectionTitle            = _sectionTitle;

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
    
    
}

//  ------------------------------------------------------------------------------------------------
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


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------









