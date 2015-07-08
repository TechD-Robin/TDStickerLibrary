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
static  NSString  * const kTDSectionStateKeyMiniState               = @"MiniState";
static  NSString  * const kTDSectionStateKeyTotalImagesCount        = @"TotalImagesCount";
static  NSString  * const kTDSectionStateKeyShowImagesCount         = @"ShowImagesCount";
static  NSString  * const kTDSectionStateKeyPreviewImageSize        = @"PreviewImageSize";
static  NSString  * const kTDSectionStateKeyNowPreviewImageSize     = @"NowPreviewImagesize";

static  NSString  * const kTDSectionStateKeyMustDownload            = @"MustDownload";
static  NSString  * const kTDSectionStateKeyIsDownloaded            = @"IsDownloaded";

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibrarySectionStates

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibrarySectionStates ()
{
    /**
     *  a key of this states object.
     */
    NSString                      * statesName;
    
    /**
     *  the container of section's states.
     */
    NSMutableArray                * sectionStates;
    
    /**
     *  the current data of section's state for new a record.
     */
    NSMutableDictionary           * currentState;
    
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
@interface TDStickerLibrarySectionStates (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for state information.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get a state information at index.
 *  get a state information at index.
 *
 *  @param index                    index of state information.
 *
 *  @return data|nil                the state data or nil.
 */
- ( NSDictionary * ) _GetStateInfoAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief save container of section's states into NSUserDefaults object.
 *  save container of section's states into NSUserDefaults object.
 */
- ( void ) _SaveStates;

//  ------------------------------------------------------------------------------------------------


@end


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark implementation private category (Private)
//  ------------------------------------------------------------------------------------------------
@implementation TDStickerLibrarySectionStates (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    statesName                      = nil;
    
    sectionStates                   = nil;
    
    currentState                    = nil;
    
    sectionStates                   = [NSMutableArray new];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for state information.
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
//  ------------------------------------------------------------------------------------------------
- ( void ) _SaveStates
{
    if ( ( nil == statesName ) || ( nil == sectionStates ) || ( [sectionStates count] == 0 ) )
    {
        return;
    }
    
    NSUserDefaults                * userDefaults;
    
    userDefaults                    = [NSUserDefaults standardUserDefaults];
    if ( nil == userDefaults )
    {
        return;
    }
    
    [userDefaults                   setObject: sectionStates forKey: statesName];
    [userDefaults                   synchronize];
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
@implementation TDStickerLibrarySectionStates

//  ------------------------------------------------------------------------------------------------
#pragma mark synthesize variable.

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject
////  ------------------------------------------------------------------------------------------------
//- ( instancetype ) init
//{
//    self                            = [super init];
//    if ( nil == self )
//    {
//        return nil;
//    }
//    [self                           _InitAttributes];
//    return self;
//}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithName:(NSString *)name
{
    self                            = [super init];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _InitAttributes];
    statesName                      = name;
    return self;    
}

//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != statesName )
    {
        //SAFE_ARC_RELEASE( statesName );
        statesName                  = nil;
    }
    
    if ( nil != sectionStates )
    {
        for ( id idObject in sectionStates )
        {
            if ( nil == idObject )
            {
                continue;
            }
            if ( [idObject isKindOfClass: [NSMutableDictionary class]] == YES )
            {
                [idObject           removeAllObjects];
            }
            SAFE_ARC_RELEASE( idObject );
            SAFE_ARC_ASSIGN_POINTER_NIL( idObject );
        }
        [sectionStates              removeAllObjects];
        SAFE_ARC_RELEASE( sectionStates );
        SAFE_ARC_ASSIGN_POINTER_NIL( sectionStates );
    }
    
    if ( nil != currentState )
    {
        currentState                = nil;
    }
    
    
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) sectionStates:(NSString *)name
{
    return [[[self class] alloc] initWithName: name];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for i/o a state data.
//  ------------------------------------------------------------------------------------------------
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
- ( BOOL ) updateImagesCountOfStateData:(NSInteger)count with:(NSInteger)miniCount
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSNumber numberWithInteger: count] forKey: kTDSectionStateKeyTotalImagesCount];
    [currentState                   setValue: [NSNumber numberWithInteger: miniCount] forKey: kTDSectionStateKeyShowImagesCount];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updatePreviewImageSizeOfStateData:(CGSize)size with:(CGSize)miniSize
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: NSStringFromCGSize( size ) forKey: kTDSectionStateKeyPreviewImageSize];
    [currentState                   setValue: NSStringFromCGSize( miniSize ) forKey: kTDSectionStateKeyNowPreviewImageSize];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateMiniStateOfStateData:(BOOL)miniState
{
    if ( nil == currentState )
    {
        return NO;
    }
    [currentState                   setValue: [NSNumber numberWithBool: miniState] forKey: kTDSectionStateKeyMiniState];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateStickerDownloadState:(BOOL)mustDownload with:(BOOL)isDownloaded
{
    if ( nil == currentState )
    {
        return NO;
    }
    
    [currentState                   setValue: [NSNumber numberWithBool: mustDownload] forKey: kTDSectionStateKeyMustDownload];
    [currentState                   setValue: [NSNumber numberWithBool: isDownloaded] forKey: kTDSectionStateKeyIsDownloaded];
    return YES;
}

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
#pragma mark method for i/o the state data in section.
//  ------------------------------------------------------------------------------------------------
//  mini state.
//  ------------------------------------------------------------------------------------------------
- ( NSString * ) idInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return nil;
    }
    return [stateInfo objectForKey: kTDSectionStateKeyID];
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) miniState:(BOOL *)miniState inSection:(NSInteger)section;
{
    NSDictionary                  * stateInfo;
    BOOL                            state;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    state                           = [[stateInfo objectForKey: kTDSectionStateKeyMiniState] boolValue];
    if ( NULL != miniState )
    {
        *miniState                  = state;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateMiniState:(BOOL)miniState inSection:(NSInteger)section
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    [stateInfo                      setValue: [NSNumber numberWithBool: miniState] forKey: kTDSectionStateKeyMiniState];
    [self                           _SaveStates];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  image's count.
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
//  preview image's size.
- (CGSize) normalSizeOfPreviewImageInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return CGSizeZero;
    }
    return CGSizeFromString( [stateInfo objectForKey: kTDSectionStateKeyPreviewImageSize] );
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateNowSizeOfPreviewImage:(CGSize)size inSection:(NSInteger)section;
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    [stateInfo                      setValue: NSStringFromCGSize( size ) forKey: kTDSectionStateKeyNowPreviewImageSize];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) nowSizeOfPreviewImageInSection:(NSInteger)section
{
    NSDictionary                  * stateInfo;
    
    stateInfo                       = [self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return CGSizeZero;
    }
    return CGSizeFromString( [stateInfo objectForKey: kTDSectionStateKeyNowPreviewImageSize] );
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) downloadState:(BOOL *)downloadState inSection:(NSInteger)section
{
    if ( NULL == downloadState )
    {
        return NO;
    }
    
    NSMutableDictionary           * stateInfo;
    BOOL                            mustDownload;
    BOOL                            isDownloaded;
    
    mustDownload                    = NO;
    isDownloaded                    = NO;
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        *downloadState              = NO;
        return NO;
    }
    
    mustDownload                    = [[stateInfo objectForKey: kTDSectionStateKeyMustDownload] boolValue];
    isDownloaded                    = [[stateInfo objectForKey: kTDSectionStateKeyIsDownloaded] boolValue];
    //  when need not to download, that's mean isDownloaded's flag always is true.
    if ( NO == mustDownload )
    {
        *downloadState              = YES;
        return YES;
    }
    
    *downloadState                  = isDownloaded;
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) updateDownloadState:(BOOL)downloadState  inSection:(NSInteger)section
{
    NSMutableDictionary           * stateInfo;
    
    stateInfo                       = (NSMutableDictionary *)[self _GetStateInfoAtIndex: section];
    if ( nil == stateInfo )
    {
        return NO;
    }
    
    [stateInfo                      setValue: [NSNumber numberWithBool: downloadState] forKey: kTDSectionStateKeyIsDownloaded];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) refreshFromStored
{
    if ( ( nil == statesName ) || ( nil == sectionStates ) || ( [sectionStates count] == 0 ) )
    {
        return NO;
    }
    
    NSUserDefaults                * userDefaults;
    NSArray                       * saveStates;
    
    saveStates                      = nil;
    userDefaults                    = [NSUserDefaults standardUserDefaults];
    if ( nil == userDefaults )
    {
        return NO;
    }
    
    saveStates                      = [userDefaults objectForKey: statesName];
    if ( nil == saveStates )
    {
        return NO;
    }
    
    if ( [saveStates count] != [sectionStates count] )
    {
//        if ( [saveStates count] > [sectionStates count] )
//        {
//            return NO;
//        }
        
        
        return NO;
    }
    

    NSDictionary                  * sectionInfo;
    NSDictionary                  * saveInfo;
    
    NSString                      * sectionInfoID;
    NSString                      * sectionInfoTotalImagesCount;
    NSString                      * sectionInfoPreviewImageSize;
    
    NSString                      * saveInfoID;
    NSString                      * saveInfoMiniState;
    NSString                      * saveInfoTotalImagesCount;
    NSString                      * saveInfoShowImagesCount;
    NSString                      * saveInfoPreviewImageSize;
    
    
    sectionInfo                     = nil;
    saveInfo                        = nil;
    
    sectionInfoID                   = nil;
    sectionInfoTotalImagesCount     = nil;
    sectionInfoPreviewImageSize     = nil;
    
    saveInfoID                      = nil;
    saveInfoMiniState               = nil;
    saveInfoTotalImagesCount        = nil;
    saveInfoShowImagesCount         = nil;
    saveInfoPreviewImageSize        = nil;
    for ( int i = 0; i < [sectionStates count]; ++i )
    {
        sectionInfo                 = [sectionStates objectAtIndex: i];
        if ( nil == sectionInfo )
        {
            continue;
        }
        
        sectionInfoID               = [sectionInfo objectForKey: kTDSectionStateKeyID];
        if ( nil == sectionInfoID )
        {
            continue;
        }
        
        sectionInfoTotalImagesCount = [sectionInfo objectForKey: kTDSectionStateKeyTotalImagesCount];
        sectionInfoPreviewImageSize = [sectionInfo objectForKey: kTDSectionStateKeyPreviewImageSize];
        for ( int j = 0; j < [saveStates count]; ++j )
        {
            saveInfo                = [saveStates objectAtIndex: j];
            if ( nil == saveInfo )
            {
                continue;
            }
            
            saveInfoID              = [saveInfo objectForKey: kTDSectionStateKeyID];
            
            if ( ( nil == saveInfoID ) || ( [sectionInfoID isEqualToString: saveInfoID] == NO ) )
            {
                continue;
            }
            
            //  when save mini state is mini, skip.
            saveInfoMiniState       = [saveInfo objectForKey: kTDSectionStateKeyMiniState];
            if ( ( nil == saveInfoMiniState ) || ( YES == [saveInfoMiniState boolValue] ) )
            {
                continue;
            }
            
            //  sub check for preview mode.
            saveInfoPreviewImageSize= [saveInfo objectForKey: kTDSectionStateKeyPreviewImageSize];
            if ( ( nil != sectionInfoPreviewImageSize ) && ( nil != saveInfoPreviewImageSize ) )
            {
                if ( [sectionInfoPreviewImageSize isEqualToString: saveInfoPreviewImageSize] == NO )
                {
                    continue;
                }
                
                //  update save data to current section state.
                [sectionInfo        setValue: [NSNumber numberWithBool: [saveInfoMiniState boolValue]] forKey: kTDSectionStateKeyMiniState];
                
                //  assign current preview size to now preview size.
                [sectionInfo        setValue: sectionInfoPreviewImageSize forKey: kTDSectionStateKeyNowPreviewImageSize];
                continue;
            }
            

            //  sub check for normal mode.
            saveInfoTotalImagesCount= [saveInfo objectForKey: kTDSectionStateKeyTotalImagesCount];
            saveInfoShowImagesCount = [saveInfo objectForKey: kTDSectionStateKeyShowImagesCount];
            if ( ( nil == sectionInfoTotalImagesCount ) || ( nil == saveInfoTotalImagesCount ) )
            {
                continue;
            }
            if ( [sectionInfoTotalImagesCount integerValue] != [saveInfoTotalImagesCount integerValue] )
            {
                continue;
            }
            
            //  update save data to current section state.
            [sectionInfo            setValue: [NSNumber numberWithBool: [saveInfoMiniState boolValue]] forKey: kTDSectionStateKeyMiniState];
            if ( nil != saveInfoShowImagesCount )
            {
                [sectionInfo        setValue: [NSNumber numberWithInteger: [saveInfoShowImagesCount integerValue]]
                                      forKey: kTDSectionStateKeyShowImagesCount];
            }
        }   //  End of for ( int j = 0; j < [saveStates count]; ++j ).
    }
    
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------















