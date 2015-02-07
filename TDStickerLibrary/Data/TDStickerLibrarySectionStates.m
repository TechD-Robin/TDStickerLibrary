//
//  TDStickerLibrarySectionStates.m
//  TDStickerLibrary
//
//  Created by Robin Hsu on 2015/2/5.
//  Copyright (c) 2015年 TechD. All rights reserved.
//
//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

#ifndef __ARCMacros_H__
    #import "ARCMacros.h"
#endif  //  End of __ARCMacros_H__.

#import "TDStickerLibrarySectionStates.h"


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
static  NSString  * const kTDSectionStateKeyID                      = @"ID";
static  NSString  * const kTDSectionStateKeyTotalImagesCount        = @"TotalImagesCount";
static  NSString  * const kTDSectionStateKeyShowImagesCount         = @"ShowImagesCount";
static  NSString  * const kTDSectionStateKeyPreviewImageSize        = @"PreviewImageSize";


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionStates

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
#pragma mark declare property ()
@interface TDStickerLibrarySectionStates()
{
    NSMutableArray                * sectionStates;
    
    NSMutableDictionary           * currentState;
    
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
@interface TDStickerLibrarySectionStates(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetStateInfoAtIndex:(NSInteger)index;

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
@implementation TDStickerLibrarySectionStates(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    sectionStates                   = nil;
    
    currentState                    = nil;
    
    sectionStates                   = [NSMutableArray new];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSDictionary * ) _GetStateInfoAtIndex:(NSInteger)index
{
    if ( ( nil == sectionStates ) || ( [sectionStates count] == 0 ) )
    {
        return nil;
    }
    return [sectionStates objectAtIndex: index];
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
@implementation TDStickerLibrarySectionStates

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  --------------------------------
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
- ( void ) dealloc
{
    if ( nil != sectionStates )
    {
        SAFE_ARC_RELEASE( sectionStates );
        SAFE_ARC_ASSIGN_POINTER_NIL( sectionStates );
    }
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method create the object.
//  ------------------------------------------------------------------------------------------------

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) sectionStates
{
    return [[[self class] alloc] init];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
- ( BOOL ) insertStateDataForKey:(NSString *)aKey
{
    if ( nil == aKey )
    {
        return NO;
    }
    
    currentState                    = nil;
    currentState                    = [NSMutableDictionary new];
    if ( nil == currentState )
    {
        return NO;
    }
    
    [currentState                   setValue: aKey forKey: kTDSectionStateKeyID];
    

    [sectionStates                  addObject: currentState];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateImagesCountOfStateData:(NSInteger)count
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSNumber numberWithInteger: count] forKey: kTDSectionStateKeyTotalImagesCount];
    [currentState                   setValue: [NSNumber numberWithInteger: count] forKey: kTDSectionStateKeyShowImagesCount];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updatePreviewImageSizeOfStateData:(CGSize)size
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSValue valueWithCGSize: size] forKey: kTDSectionStateKeyPreviewImageSize];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfSections
{
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates count];
}

//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfImagesInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return 0;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyShowImagesCount] integerValue];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateNumberOfImages:(NSInteger)count inSection:(NSInteger)section
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    //  system cover old data at the same key.
    //[stateInfo                      removeObjectForKey: kTDSectionStateKeyShowImagesCount];
    [stateInfo                      setValue: [NSNumber numberWithInteger: count] forKey: kTDSectionStateKeyShowImagesCount];
    return YES;
}


//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) numberOfTotalImagesInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return 0;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyTotalImagesCount] integerValue];
}

//  ------------------------------------------------------------------------------------------------
- (CGSize) sizeOfPreviewImageInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return CGSizeZero;
    }
    return [[stateInfo objectForKey: kTDSectionStateKeyPreviewImageSize] CGSizeValue];
}

//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















