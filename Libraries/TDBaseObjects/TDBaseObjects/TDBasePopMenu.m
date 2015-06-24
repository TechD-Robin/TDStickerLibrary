//
//  TDBasePopMenu.m
//  TDBaseObjects
//
//  Created by Robin Hsu on 2015/6/23.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#import "UIKit+TechD.h"
#import "TDBasePopMenu.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDBasePopMenu

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDBasePopMenu ()
{
    TDBasePopMenuPosition           popMenuPosition;
    CGPoint                         positionOffset;
    
    UIButton                      * popOutButton;
    UIButton                      * unPopOutButton;
    
    UIScrollView                  * actionsMenu;
    
    
    CGPoint                         transformBeforeCenter;
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
@interface TDBasePopMenu (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

- ( void ) _SetFrame;

- ( void ) _SetPopOutFrame;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _CalculateActionsMenuContentSize:(CGSize)newItemSize;

//  ------------------------------------------------------------------------------------------------
- ( CGPoint) _CalculateNewActionItemOrigin;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted;

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateActionsMenu;

//  ------------------------------------------------------------------------------------------------
- ( UIButton * ) _CreateActionItem:(UIImage *)image highlighted:(UIImage *)highlighted;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDBasePopMenu (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( void ) _InitAttributes
{
    positionOffset                  = CGPointZero;
    
    popOutButton                    = nil;
    unPopOutButton                  = nil;

    actionsMenu                     = nil;
    
    transformBeforeCenter           = CGPointZero;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetFrame
{
    CGFloat                         screenWidth;
    CGRect                          frame;
    
    frame                           = CGRectMake( 0.0f, 0.0f, 0.0f, 0.0f );
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    
    frame.origin.x                  = screenWidth;
    if ( nil != popOutButton )
    {
        frame.size                  = [popOutButton bounds].size;
    }

    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            frame.origin.x          = 0;
            if ( nil != actionsMenu )
            {
                frame.origin.x      = -( [actionsMenu bounds].size.width + positionOffset.x );
                frame.size.width    += [actionsMenu bounds].size.width;
                frame.size.width    += positionOffset.x;
            }
            
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            if ( nil != popOutButton )
            {
                frame.origin.x      -= frame.size.width;
            }
            if ( nil != actionsMenu )
            {
                frame.size.width            += [actionsMenu bounds].size.width;
                frame.size.width            -= positionOffset.x;
            }
            
            break;
        }
        default:
            break;
    }
    

    frame.origin.x                  += positionOffset.x;
    frame.origin.y                  += positionOffset.y;
    [self                           setFrame: frame];
    
    [self                           _SetPopOutFrame];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SetPopOutFrame
{
    if ( nil == popOutButton )
    {
        return;
    }
    
    CGPoint                         centerOffset;
    CGRect                          offsetRect;
    
    centerOffset                    = CGPointZero;
    offsetRect                      = [popOutButton frame];
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            if ( ( nil != popOutButton ) && ( nil != actionsMenu ) )
            {
                offsetRect.origin.x = ( [actionsMenu bounds].size.width + positionOffset.x );
                [popOutButton       setFrame: offsetRect];
            }
            if ( nil != unPopOutButton )
            {
                [unPopOutButton     setFrame: offsetRect];
            }
            
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            break;
        }
        default:
            break;
    }
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _CalculateActionsMenuContentSize:(CGSize)newItemSize
{
    if ( CGSizeEqualToSize( newItemSize, CGSizeZero ) == true )
    {
        return CGSizeZero;
    }
    
    if ( ( nil == actionsMenu ) || ( [[actionsMenu subviews] count] == 0 ) )
    {
        return newItemSize;
    }
    
    CGSize                          contentSize;
    
    contentSize                     = [actionsMenu contentSize];
    contentSize.width               += ( newItemSize.width + 2.0f );
    contentSize.height              = MAX( contentSize.height, newItemSize.height );
    return contentSize;
}

//  ------------------------------------------------------------------------------------------------
- ( CGPoint) _CalculateNewActionItemOrigin
{
    if ( ( nil == actionsMenu ) || ( [[actionsMenu subviews] count] == 0 ) )
    {
        return CGPointZero;
    }
    
    CGPoint                         newOrigin;
    id                              idObject;
    
    newOrigin                       = CGPointZero;
    idObject                        = [[actionsMenu subviews] lastObject];
    if ( nil == idObject )
    {
        return CGPointZero;
    }
    
    newOrigin.x                     = ( [idObject frame].origin.x + [idObject frame].size.width + 2.0f );
    return newOrigin;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreatePopOutView:(UIImage *)image highlighted:(UIImage *)highlighted
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    buttonRect                      = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    popOutButton                    = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == popOutButton )
    {
        return NO;
    }
    
    [popOutButton                   setFrame: buttonRect];
    [popOutButton                   addTarget: self action: @selector( _PopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    
    [self                           addSubview: popOutButton];
//    [self                           setBackgroundColor: [UIColor orangeColor]];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _PopOutAction:(id) sender
{
    CGPoint                         transformCenter;

    transformBeforeCenter           = [self center];
    transformCenter                 = transformBeforeCenter;
    
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            transformCenter.x       += ( ( nil != actionsMenu ) ? [actionsMenu bounds].size.width : 0.0f );
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            transformCenter.x       -= ( ( nil != actionsMenu ) ? [actionsMenu bounds].size.width : 0.0f );
            break;
        }
        default:
            break;
    }
    
    [UIView                         animateWithDuration: 0.33f animations: ^
    {
        [self                       setCenter: transformCenter];
        
    } completion: ^ ( BOOL finished )
    {
        if ( nil != unPopOutButton )
        {
            [popOutButton           setHidden: YES];
            [unPopOutButton         setHidden: NO];
        }
    }];
    
    
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateUnPopOutView:(UIImage *)image highlighted:(UIImage *)highlighted
{
    NSParameterAssert( nil != image );
    NSParameterAssert( nil != highlighted );
    
    CGRect                          buttonRect;
    
    if ( nil != popOutButton )
    {
        buttonRect                  = [popOutButton frame];
    }
    else
    {
        buttonRect                  = CGRectMake( 0.0f, 0.0f, [image size].width, [image size].height );
    }
    
    unPopOutButton                  = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == unPopOutButton )
    {
        return NO;
    }
    
    [unPopOutButton                 setFrame: buttonRect];
    [unPopOutButton                 addTarget: self action: @selector( _UnPopOutAction: ) forControlEvents: UIControlEventTouchUpInside];
    [unPopOutButton                 setHidden: YES];
    
    [self                           addSubview: unPopOutButton];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _UnPopOutAction:(id) sender
{
    CGPoint                         transformCenter;
    
    transformCenter                 = transformBeforeCenter;
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            break;
        }
        default:
            break;
    }
    [UIView                         animateWithDuration: 0.33f animations: ^
    {
        [self                       setCenter: transformCenter];
        
    } completion: ^ ( BOOL finished )
    {
        if ( nil != popOutButton )
        {
            [popOutButton           setHidden: NO];
            [unPopOutButton         setHidden: YES];
        }
        transformBeforeCenter       = CGPointZero;
    }];

    
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateActionsMenu
{
    CGRect                          actionsMenuRect;
    CGPoint                         offset;
    CGSize                          baseSize;
    
    offset                          = CGPointZero;
    baseSize                        = CGSizeZero;
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            if ( nil != popOutButton )
            {
                baseSize            = [popOutButton bounds].size;
            }
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            if ( nil != popOutButton )
            {
                offset.x            += [popOutButton bounds].size.width;
                baseSize            = [popOutButton bounds].size;
            }
            
            break;
        }
        default:
            break;
    }
    
    offset.x                        -= positionOffset.x;    //  reset special offset from superview & superview's supverview's.
    actionsMenuRect                 = CGRectMake( offset.x, offset.y, baseSize.width, baseSize.height );
    actionsMenu                     = [[UIScrollView alloc] initWithFrame: actionsMenuRect];
    if ( nil == actionsMenu )
    {
        return NO;
    }
    
//    [actionsMenu                    setBackgroundColor: [UIColor yellowColor]];
    [self                           addSubview: actionsMenu];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( UIButton * ) _CreateActionItem:(UIImage *)image highlighted:(UIImage *)highlighted
{
    if ( ( nil == image ) || ( nil == highlighted ) || ( nil == actionsMenu ) )
    {
        return nil;
    }
    
    CGPoint                         scrollOffset;
    CGRect                          buttonRect;
    CGRect                          menuRect;
    CGSize                          contentSize;
    CGFloat                         screenWidth;
    UIButton                      * actionButton;
    
    scrollOffset                    = CGPointZero;
    buttonRect                      = CGRectZero;
    menuRect                        = [actionsMenu frame];
    contentSize                     = [actionsMenu bounds].size;
    screenWidth                     = [[UIScreen mainScreen] bounds].size.width;
    actionButton                    = [UIButton buttonWithImage: image highlighted: highlighted origin: CGPointZero];
    if ( nil == actionButton )
    {
        return nil;
    }
    
    buttonRect.size                 = [actionButton bounds].size;
    buttonRect.origin               = [self _CalculateNewActionItemOrigin];
    contentSize                     = [self _CalculateActionsMenuContentSize: buttonRect.size];
    
    [actionButton                   setFrame: buttonRect];
    [actionsMenu                    addSubview: actionButton];
    [actionsMenu                    setContentSize: contentSize];
    
    //  reset menu's frame.
    menuRect.size.width             = contentSize.width;
    if ( ( ( screenWidth / 2.0f ) - [popOutButton bounds].size.width ) < contentSize.width )
    {
        menuRect.size.width         = ( ( screenWidth / 2.0f ) - [popOutButton bounds].size.width );
    }
    
    switch ( popMenuPosition )
    {
        case TDBasePopMenuPositionLeftTop:
        {
            menuRect.origin.x       = 0;
            scrollOffset.x          = ( ( contentSize.width > menuRect.size.width ) ? ( contentSize.width - menuRect.size.width ) : 0.0f );
            break;
        }
        case TDBasePopMenuPositionRightTop:
        {
            break;
        }
        default:
            break;
    }
    
    
    [actionsMenu                    setFrame: menuRect];
    [actionsMenu                    setContentOffset: scrollOffset];
    [self                           _SetFrame];
    return actionButton;
}


//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation for public
//  ------------------------------------------------------------------------------------------------
@implementation TDBasePopMenu

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.

////  ------------------------------------------------------------------------------------------------
//- ( void ) dealloc
//{
//}

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create the object.
//  ------------------------------------------------------------------------------------------------
- (instancetype ) initWithPosition:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    
    //  assign variables.
    popMenuPosition                 = menuPosition;
    positionOffset                  = offset;
    
    [self                           _CreatePopOutView: image highlighted: highlighted];
    [self                           _CreateActionsMenu];
    
    [self                           _SetFrame];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) popMenu:(TDBasePopMenuPosition)menuPosition popOut:(UIImage *)image highlighted:(UIImage *)highlighted origin:(CGPoint)offset
{
    return [[[self class] alloc] initWithPosition: menuPosition popOut: image highlighted: highlighted origin: offset];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) setUnPopOut:(UIImage *)image highlighted:(UIImage *)highlighted
{
    return [self _CreateUnPopOutView: image highlighted: highlighted];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) AddAction:(UIImage *)image highlighted:(UIImage *)highlighted
              target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton                      * actionButton;
    
    actionButton                    = [self _CreateActionItem: image highlighted: highlighted];
    if ( nil == actionButton )
    {
        return NO;
    }

    if ( ( nil == target ) || ( nil == action ) )
    {
        return YES;
    }
    [actionButton                   addTarget: target action: action forControlEvents: controlEvents];
    return YES;
}

//  ------------------------------------------------------------------------------------------------



@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
































