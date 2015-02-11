//
//  TDStickerLibraryTabPageView.m
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

#import "TDStickerLibraryTabPageView.h"
#import "TDStickerLibraryTabPageLayout.h"
#import "TDStickerLibrarySectionHeader.h"
#import "TDStickerLibrarySectionPreviewCell.h"
#import "TDStickerLibraryStickerSoloView.h"

#import "TDStickerLibraryTabPageInfo.h"
#import "TDStickerLibrarySectionStates.h"

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark class TDStickerLibraryViewController

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  declare property for private category()
//  ------------------------------------------------------------------------------------------------
#pragma mark declare property ()
@interface TDStickerLibraryTabPageView ()
<TDSectionHeaderDelegate, TDSectionPreviewCellDelegate>
{
    
    TDStickerLibraryCustomization * customizationParam;
    
    
    TDStickerLibraryTabPageInfo   * pageConfigure;
    TDStickerLibrarySectionStates * sectionStates;
    
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
@interface TDStickerLibraryTabPageView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;
- ( void ) _RegisterClasses;

//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure:(NSString *)configure forKey:(NSString *)aKey;

- ( void ) _InitSectionStates;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create layout of the collection view with customization.
 *  create layout of the collection view with customization.
 *
 *  @param customization            customization object for the Sticker Library.
 *
 *  @return layout|nil              the layout object or nil.
 */
+ ( UICollectionViewLayout * ) _CreateLayout:(TDStickerLibraryCustomization *)customization;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create header view of the collection view at index path.
 *  create header view of the collection view at index path.
 *
 *  @param collectionView           the collection view object( header's super view )
 *  @param indexPath                indexPath object of table(collectionView).
 *
 *  @return header|nil              the header object or nil.
 */
- (UICollectionReusableView *) _CreateSectionHeader:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create sticker view(a background view of cell) of the collection view at index path.
 *  create sticker view(a background view of cell) of the collection view at index path.
 *
 *  @param indexPath                indexPath object of table(collectionView).
 *
 *  @return sticker|nil             the sticker object or nil.
 */
- ( UIImageView * ) _CreateCommonSticker:(NSIndexPath *)indexPath;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create a preview's sticker view(a background view of cell) of the collection view at index path.
 *  create a preview's sticker view(a background view of cell) of the collection view at index path.
 *
 *  @param indexPath                indexPath object of table(collectionView).
 *
 *  @return sticker|nil             the sticker object or nil.
 */
- ( UIImageView * ) _CreatePreviewSticker:(NSIndexPath *)indexPath;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for calculate.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate capacity of row
 *  calculate capacity of row, calculate capacity just with customization's properties.
 *
 *  @param section                  section index.
 *
 *  @return value| -1               calculated value for capacity or -1.
 */
- ( NSInteger ) _CalculatePerRowCapacityWithCustomization;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate preview mode image size of proportional for section at index.
 *  calculate preview mode image size of proportional for section at index.
 *
 *  @param section                  section index.
 *
 *  @return size|ZeroSize           the result size or ZeroSize.
 */
- ( CGSize ) _CalculatePreviewImageProportionalSizeForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief calculate preview mode image size of minimum for section at index.
 *  calculate preview mode image size of minimum for section at index.
 *
 *  @param section                  section index.
 *
 *  @return size|ZeroSize           the result size or ZeroSize.
 */
- ( CGSize ) _CalculatePreviewImageMiniSizeForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for touch action(GestureRecognizer).
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief tap action for header in section of collection view that the section is preview mode.
 *  tap action for header in section of collection view that the section is preview mode.
 *
 *  @param collectionView           the collection view.
 *  @param section                  section index.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CollectionView:(UICollectionView *)collectionView didSelectPreviewModeHeaderInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief tap action for header in section of collection view that the section is normal mode.
 *  tap action for header in section of collection view that the section is normal mode.
 *
 *  @param collectionView           the collection view.
 *  @param section                  section index.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CollectionView:(UICollectionView *)collectionView didSelectNormalModeHeaderInSection:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief tap action for cell in section of collection view, show the sticker image.
 *
 *  @param stickerImage             a sticker image.
 *  @param stickerSize              the sticker image's original size.
 *  @param nowFrame                 the sticker's frame on screen.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _ShowStickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame;

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
@implementation TDStickerLibraryTabPageView(Private)

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    customizationParam              = nil;
    
    pageConfigure                   = nil;
    sectionStates                   = nil;
    
    
    [self                           setDataSource: self];
    [self                           setDelegate: self];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _RegisterClasses
{
    [self                           registerClass: [UICollectionViewCell class]
                       forCellWithReuseIdentifier: NSStringFromClass( [UICollectionViewCell class] )];
    
    [self                           registerClass: [TDStickerLibrarySectionPreviewCell class]
                       forCellWithReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionPreviewCell class] )];
    
    [self                           registerClass: [TDStickerLibrarySectionHeader class]
                       forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                              withReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionHeader class] )];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure:(NSString *)configure forKey:(NSString *)aKey
{
    pageConfigure                   = [TDStickerLibraryTabPageInfo loadDataFromZip: configure forDirectories: TDResourcesDirectory inDirectory: [customizationParam configureResource] inZippedPath: configure configure: aKey];
    if ( nil == pageConfigure )
    {
        return;
    }
    
    
    [self                           _InitSectionStates];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitSectionStates
{
    if ( ( nil == pageConfigure ) || ( [pageConfigure infoDataCount] == 0 ) )
    {
        return;
    }
    
    sectionStates                   = [TDStickerLibrarySectionStates sectionStates];
    if ( nil == sectionStates )
    {
        return;
    }
    
    NSString                      * ID;
    NSInteger                       imageCount;
    NSInteger                       imageMiniCount;
    NSInteger                       perRowCapacity;
    NSInteger                       sectionMode;
    CGSize                          previewSize;
    CGSize                          previewMiniSize;
    
    ID                              = nil;
    imageCount                      = 0;
    imageMiniCount                  = 0;
    perRowCapacity                  = 0;
    sectionMode                     = 0;
    previewSize                     = CGSizeZero;
    previewMiniSize                 = CGSizeZero;
    perRowCapacity                  = [self _CalculatePerRowCapacityWithCustomization];
    for ( int i = 0; i < [pageConfigure infoDataCount]; ++i )
    {
        ID                          = [pageConfigure dataIDAtIndex: i];
        if ( nil != ID )
        {
            [sectionStates          insertStateDataForKey: ID];
        }
        
        imageCount                  = [pageConfigure countOfImageDataAtIndex: i];
        imageMiniCount              = ( ( imageCount > perRowCapacity ) ? perRowCapacity : imageCount );
        [sectionStates              updateImagesCountOfStateData: imageCount with: imageMiniCount];             //  start at mini state.
        //[sectionStates              updateImagesCountOfStateData: imageCount with: imageCount];                 //  start at normal state.
        [sectionStates              updateMiniStateOfStateData: YES];
        
        //  when mode not equal normal.
        sectionMode                 = [pageConfigure dataModeAtIndex: i];
        if ( 0 == sectionMode )
        {
            continue;
        }
        
        previewSize                 = [self _CalculatePreviewImageProportionalSizeForSectionAtIndex: i];
        previewMiniSize             = [self _CalculatePreviewImageMiniSizeForSectionAtIndex: i];
        [sectionStates              updatePreviewImageSizeOfStateData: previewSize with: previewMiniSize];      //  start at mini state.
        //[sectionStates              updatePreviewImageSizeOfStateData: previewSize with: previewSize];          //  start at normal state.
        [sectionStates              updateMiniStateOfStateData: YES];
        
        
    }
    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create object.
//  ------------------------------------------------------------------------------------------------
+ ( UICollectionViewLayout * ) _CreateLayout:(TDStickerLibraryCustomization *)customization
{
    TDStickerLibraryTabPageLayout * layout;
    
    layout                          = [TDStickerLibraryTabPageLayout new];
    if ( nil == layout )
    {
        return nil;
    }
    
    [layout                         setScrollDirection: UICollectionViewScrollDirectionVertical];
    //[layout                         setScrollDirection: UICollectionViewScrollDirectionHorizontal];
    
    [layout                         setItemSize: [customization tableCommonItemSize]];
    [layout                         setSectionInset: [customization tableCommonSectionInset]];
    [layout                         setHeaderReferenceSize: [customization tableCommonHeaderReferenceSize]];
    [layout                         setMinimumInteritemSpacing: [customization tableMinimumInteritemSpacing]];
    [layout                         setMinimumLineSpacing: [customization tableMinimumLineSpacing]];
    
    return layout;
}

//  ------------------------------------------------------------------------------------------------
- (UICollectionReusableView *) _CreateSectionHeader:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath
{
    if ( ( nil == collectionView ) || ( nil == indexPath ) )
    {
        return nil;
    }
    
    NSString                      * title;
    TDStickerLibrarySectionHeader * header;
    
    title                           = nil;
    header                          = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader
                                                                         withReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionHeader class] ) forIndexPath: indexPath];
    if ( nil == header )
    {
        return nil;
    }
    
    title                           = [pageConfigure dataTitleAtIndex: indexPath.section];
    if ( nil == title )
    {
        return header;
    }
    
    [header                         setIdDelegate: self];
    [header                         setSectionIndex: indexPath.section];
    [header                         setSectionTitle: title];
    return header;
}


//  ------------------------------------------------------------------------------------------------
- ( UIImageView * ) _CreateCommonSticker:(NSIndexPath *)indexPath
{
    
    NSData                        * imageData;
    UIImage                       * stickerImage;
    UIImageView                   * stickerView;
    
    stickerImage                    = nil;
    stickerView                     = nil;
    imageData                       = [pageConfigure imageDataAtIndex: indexPath.section inArray: indexPath.row];
    if ( nil == imageData )
    {
        return nil;
    }
    
    stickerImage                    = [UIImage imageWithData: imageData];
    if ( nil == stickerImage )
    {
        return nil;
    }
    
    //stickerView                     = [[UIImageView alloc] initWithImage: stickerImage];
    stickerView                     = [UIImageView proportionalImageView: stickerImage reference: [customizationParam tableCommonItemSize] originWith: [customizationParam tableCommonItemSize]];
    if ( nil == stickerView )
    {
        SAFE_ARC_RELEASE( image );
        return nil;
    }
    
    SAFE_ARC_RELEASE( image );
    SAFE_ARC_ASSIGN_POINTER_NIL( image );
    return stickerView;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImageView * ) _CreatePreviewSticker:(NSIndexPath *)indexPath
{
    NSData                        * imageData;
    UIImage                       * stickerImage;
    UIImageView                   * stickerView;
    CGSize                          previewSize;
    
    stickerImage                    = nil;
    stickerView                     = nil;
    previewSize                     = [sectionStates normalSizeOfPreviewImageInSection: indexPath.section];
    imageData                       = [pageConfigure imageDataAtIndex: indexPath.section inArray: indexPath.row];
    if ( nil == imageData )
    {
        return nil;
    }
    
    stickerImage                    = [UIImage imageWithData: imageData];
    if ( nil == stickerImage )
    {
        return nil;
    }
    
    stickerView                     = [[UIImageView alloc] initWithImage: [stickerImage resize: previewSize]];
    if ( nil == stickerView )
    {
        SAFE_ARC_RELEASE( image );
        return nil;
    }
    
    SAFE_ARC_RELEASE( image );
    SAFE_ARC_ASSIGN_POINTER_NIL( image );
    return stickerView;
}


//  ------------------------------------------------------------------------------------------------
#pragma mark method for calculate.
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) _CalculatePerRowCapacityWithCustomization
{
    if ( nil == customizationParam )
    {
        return -1;
    }
    
    CGFloat                         baseWidth;
    NSInteger                       perRowItem;
    UIEdgeInsets                    sectionInset;
    CGSize                          itemSize;
    CGFloat                         minimumInteritemSpacing;
    
    perRowItem                      = 0;
    baseWidth                       = [self bounds].size.width;
    sectionInset                    = [customizationParam tableCommonSectionInset];
    itemSize                        = [customizationParam tableCommonItemSize];
    minimumInteritemSpacing         = [customizationParam tableMinimumInteritemSpacing];
    
    //  1st, calculate for without edgeInset.
    baseWidth                       -= ( sectionInset.left + sectionInset.right );
    
    //  2nd, calculate for without first item.
    baseWidth                       -= itemSize.width;
    
    //  3th. use others to calculate for amount.
    perRowItem                      = ceilf( baseWidth / ( itemSize.width + minimumInteritemSpacing ) );
    if ( 0 >= perRowItem )
    {
        perRowItem                  = 1;
    }
    
    return perRowItem;
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _CalculatePreviewImageProportionalSizeForSectionAtIndex:(NSInteger)section
{
    if ( ( nil == pageConfigure ) || ( nil == customizationParam ) )
    {
        return CGSizeZero;
    }
    
    CGFloat                         ratio;
    CGSize                          newSize;
    NSData                        * imageData;
    UIImage                       * previewImage;
    UIEdgeInsets                    sectionInset;
    
    ratio                           = 1.0f;
    previewImage                    = nil;
    newSize                         = CGSizeZero;
    imageData                       = [pageConfigure imageDataAtIndex: section inArray: 0];
    sectionInset                    = [customizationParam tableCommonSectionInset];
    if ( nil == imageData )
    {
        return CGSizeZero;
    }
    
    previewImage                    = [UIImage imageWithData: imageData];
    if ( nil == previewImage )
    {
        return CGSizeZero;
    }

    newSize                         = [self bounds].size;
    newSize.width                   -= ( sectionInset.left + sectionInset.right );
    ratio                           = ( [previewImage size].width / newSize.width );
    newSize.height                  = ( [previewImage size].height / ratio );
    
    SAFE_ARC_RELEASE( previewImage );
    SAFE_ARC_ASSIGN_POINTER_NIL( previewImage );
    return newSize;
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _CalculatePreviewImageMiniSizeForSectionAtIndex:(NSInteger)section
{
    if ( nil == customizationParam )
    {
        return CGSizeZero;
    }
    
    CGFloat                         ratio;
    CGSize                          newSize;
    UIEdgeInsets                    sectionInset;
    
    ratio                           = 1.0f;
    newSize                         = CGSizeZero;
    sectionInset                    = [customizationParam tableCommonSectionInset];

    newSize                         = [self bounds].size;
    newSize.width                   -= ( sectionInset.left + sectionInset.right );
    ratio                           = ( [customizationParam tableCommonItemSize].width / newSize.width );
    
//.    newSize.height                  = ( [customizationParam tableCommonItemSize].height + sectionInset.top + [customizationParam tableMinimumLineSpacing] );
    newSize.height                  = ( [customizationParam tableCommonItemSize].height );
    
    return newSize;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for touch action(GestureRecognizer).
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CollectionView:(UICollectionView *)collectionView didSelectPreviewModeHeaderInSection:(NSInteger)section
{
    if  ( ( nil == sectionStates ) || ( [sectionStates numberOfSections] < section )
         || ( nil == collectionView ) || ( [collectionView collectionViewLayout] == nil ) )
    {
        return NO;
    }
    
    
    NSIndexPath                           * indexPath;
    TDStickerLibrarySectionPreviewCell    * cell;
    TDStickerLibraryTabPageLayout         * layout;
    
    indexPath                       = [NSIndexPath indexPathForItem: 0 inSection: section];
    cell                            = (TDStickerLibrarySectionPreviewCell *)[self cellForItemAtIndexPath: indexPath];
    layout                          = (TDStickerLibraryTabPageLayout *)[collectionView collectionViewLayout];
    
    BOOL                            miniState;
    CGSize                          miniSize;
    CGSize                          nowSize;
    CGSize                          previewSize;
    
    miniState                       = NO;
    miniSize                        = [self _CalculatePreviewImageMiniSizeForSectionAtIndex: section];
    nowSize                         = [sectionStates nowSizeOfPreviewImageInSection: section];
    previewSize                     = [sectionStates normalSizeOfPreviewImageInSection: section];
    if ( ( [sectionStates miniState: &miniState inSection: section] == YES ) && ( nil != cell ) )
    {
        if ( YES == miniState )
        {
            //  section content to max.
            [sectionStates          updateNowSizeOfPreviewImage: previewSize inSection: section];
            [cell                   setMiniState: NO];
            
            [sectionStates          updateMiniState: NO inSection: section];
        }
        else
        {
            //  section content to mini.
            [sectionStates          updateNowSizeOfPreviewImage: miniSize inSection: section];
            [cell                   setMiniState: YES];
            
            [sectionStates          updateMiniState: YES inSection: section];
        }
    }
    
    [layout                         needUpdateLayoutAttributes: NO];
    [self                           reloadData];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CollectionView:(UICollectionView *)collectionView didSelectNormalModeHeaderInSection:(NSInteger)section
{
    if  ( ( nil == sectionStates ) || ( [sectionStates numberOfSections] < section )
         || ( nil == collectionView ) || ( [collectionView collectionViewLayout] == nil ) )
    {
        return NO;
    }
    
    BOOL                            miniState;
    NSInteger                       rowCapacity;
    NSInteger                       imageNowCount;
    NSInteger                       imageTotal;
    TDStickerLibraryTabPageLayout * layout;
    
    miniState                       = NO;
    layout                          = (TDStickerLibraryTabPageLayout *)[collectionView collectionViewLayout];
    rowCapacity                     = [layout calculateFirstRowCapacityForSectionAtIndex: section];
    imageTotal                      = [sectionStates numberOfTotalImagesInSection: section];
    imageNowCount                   = [sectionStates numberOfImagesInSection: section];
    //  when image count less then row's capacity, skip change.
    if ( imageTotal <= rowCapacity )
    {
        return NO;
    }

    if ( [sectionStates miniState: &miniState inSection: section] == NO )
    {
        return NO;
    }
    
    if ( YES == miniState )
    {
        //  section content to max.
        [sectionStates              updateNumberOfImages: imageTotal inSection: section];
        [sectionStates              updateMiniState: NO inSection: section];
    }
    else
    {
        //  section content to mini.
        [sectionStates              updateNumberOfImages: rowCapacity inSection: section];
        [sectionStates              updateMiniState: YES inSection: section];
    }
    
    
    
    [layout                         needUpdateLayoutAttributes: YES];
    [self                           reloadData];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _ShowStickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame
{
    TDStickerLibraryStickerSoloView   * soloView;
    
    soloView                        = [TDStickerLibraryStickerSoloView stickerSoloView: stickerImage original: stickerSize onScreen: nowFrame
                                                                                  with: [self window] customization: customizationParam];
    if ( nil == soloView )
    {
        return NO;
    }
    
    __weak id                       blockSuperview;
    
    blockSuperview                  = [self superview];
    [soloView                       showSoloView: ^ ()
    {
        [blockSuperview             setUserInteractionEnabled: NO];
    }
    completion: ^( BOOL finished )
    {
        [blockSuperview             setUserInteractionEnabled: YES];
    }];
    return YES;
}


//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
//  public method implementation.
//  ------------------------------------------------------------------------------------------------
//  --------------------------------
#pragma mark -
#pragma mark implementation for public method
@implementation TDStickerLibraryTabPageView

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != customizationParam )
    {
        //  release by creator.
        SAFE_ARC_ASSIGN_POINTER_NIL( customizationParam );
    }
    
    if ( nil != pageConfigure )
    {
        SAFE_ARC_RELEASE( pageConfigure );
        SAFE_ARC_ASSIGN_POINTER_NIL( pageConfigure );
    }
    SAFE_ARC_SUPER_DEALLOC();
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//  ------------------------------------------------------------------------------------------------
#pragma mark method for create the object.
//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)customization
                            data:(NSString *)configure forKey:(NSString *)aKey
{
    if ( nil == customization )
    {
        NSLog( @"customization parameter cannot nil." );
        return nil;
    }
    if ( ( nil == configure ) || ( nil == aKey ) )
    {
        NSLog( @"data parameter cannot nil." );
        return nil;
    }
    
    TDStickerLibraryTabPageLayout * layout;
    
    layout                          = (TDStickerLibraryTabPageLayout *)[[self class] _CreateLayout: customization];
    if ( nil == layout )
    {
        NSLog( @"create table layout fail." );
        return nil;
    }
    [layout                         setIdDelegate: self];
    
    self                            = [super initWithFrame: frame collectionViewLayout: layout];
    if ( nil == self )
    {
        return nil;
    }
    [self                           _InitAttributes];
    [self                           _RegisterClasses];
    customizationParam              = customization;
    
    [self                           _LoadSystemConfigure: configure forKey: aKey];
    return self;
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabPageWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)customization
                               data:(NSString *)configure forKey:(NSString *)aKey
{
    return [[[self class] alloc] initWithFrame: frame customization: customization data: configure forKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol required for UICollectionViewDataSource.
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates numberOfImagesInSection: section];
}

//  ------------------------------------------------------------------------------------------------
- ( UICollectionViewCell * ) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell          * cell;
    UIImageView                   * stickerView;
    
    stickerView                     = nil;
    if ( [pageConfigure dataModeAtIndex: indexPath.section] == 0 )
    {
        cell                        = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass( [UICollectionViewCell class] ) forIndexPath: indexPath];
        stickerView                 = [self _CreateCommonSticker: indexPath];
        if ( nil != stickerView )
        {
            [cell                   setBackgroundView: stickerView];
        }
        return cell;
    }
    

    //  preview mode.
    BOOL                        miniState;
    
    miniState                   = YES;
    cell                        = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionPreviewCell class] ) forIndexPath: indexPath];
    if ( ( [sectionStates miniState: &miniState inSection: indexPath.section] == NO ) || ( nil == cell ) )
    {
        return cell;
    }
    
    //  init the cell's state.
    [(TDStickerLibrarySectionPreviewCell *)cell setMiniState: miniState];
    
    stickerView                 = [self _CreatePreviewSticker: indexPath];
    if ( nil != stickerView )
    {
        [cell                   setBackgroundView: stickerView];
    }

    
    //  assign the frames data for preview image..
    NSData                    * configureData;
    
    configureData               = [pageConfigure configureDataAtIndex: indexPath.section];
    if ( nil != configureData )
    {
        [(TDStickerLibrarySectionPreviewCell *)cell loadFrames: configureData];
        [(TDStickerLibrarySectionPreviewCell *)cell setIdDelegate: self];
    }

    return cell;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDataSource.
//  ------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ( nil == sectionStates )
    {
        return 0;
    }
    return [sectionStates numberOfSections];
}

//  ------------------------------------------------------------------------------------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ( [kind isEqualToString: UICollectionElementKindSectionHeader] == NO )
    {
        return nil;
    }
    
    TDStickerLibrarySectionHeader * header;
    
    header                          = (TDStickerLibrarySectionHeader *)[self _CreateSectionHeader: collectionView atIndexPath: indexPath];
    if ( nil == header )
    {
        return nil;
    }
    
    
    return header;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDelegateFlowLayout.
//  ------------------------------------------------------------------------------------------------
- ( CGSize ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ( ( nil == customizationParam ) || ( nil == pageConfigure ) || ( nil == sectionStates ) )
    {
        return CGSizeZero;
    }
    
    if ( [pageConfigure dataModeAtIndex: indexPath.section] == 0 )
    {
        return [customizationParam tableCommonItemSize];
    }
    return [sectionStates nowSizeOfPreviewImageInSection: indexPath.section];
}

//  ------------------------------------------------------------------------------------------------
- ( UIEdgeInsets ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return [customizationParam tableCommonSectionInset];
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if ( [(UICollectionViewFlowLayout *)collectionViewLayout scrollDirection] == UICollectionViewScrollDirectionHorizontal )
    {
        return CGSizeMake( [customizationParam tableCommonHeaderReferenceSize].height, [collectionView frame].size.height );
    }
    return CGSizeMake( [collectionView frame].size.width, [customizationParam tableCommonHeaderReferenceSize].height );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDelegate.
//  ------------------------------------------------------------------------------------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //  for normal mode.
    CGSize                              stickerSize;
    CGRect                              onScreenFrame;
    NSData                            * imageData;
    UIImage                           * stickerImage;
    UICollectionViewLayoutAttributes  * layoutAttributes;
    
    stickerSize                     = CGSizeZero;
    onScreenFrame                   = CGRectZero;
    stickerImage                    = nil;
    imageData                       = [pageConfigure imageDataAtIndex: indexPath.section inArray: indexPath.row];
    layoutAttributes                = [collectionView layoutAttributesForItemAtIndexPath: indexPath];
    if ( ( nil == imageData ) || ( nil == layoutAttributes ) )
    {
        return;
    }
    
    onScreenFrame.size              = [layoutAttributes size];
    onScreenFrame.origin            = [self convertPoint: [layoutAttributes frame].origin toView: nil];
    stickerImage                    = [UIImage imageWithData: imageData];
    if ( nil == stickerImage )
    {
        return;
    }
    
    stickerSize                     = [stickerImage size];
    if ( [stickerImage scale] != 1.0f )
    {
        stickerImage                = [stickerImage resize: CGSizeMake( ( stickerSize.width * [stickerImage scale] ), ( stickerSize.height * [stickerImage scale] ) )];
    }
    if ( nil == stickerImage )
    {
        return;
    }

    if ( [customizationParam isStickerSoloViewEnabled] == NO )
    {
        return;
    }
    
    stickerSize                     = [stickerImage size];
    [self                           _ShowStickerSoloView: stickerImage original: stickerSize onScreen: onScreenFrame];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol required for TDSectionHeaderDelegate.
//  ------------------------------------------------------------------------------------------------
- ( void ) collectionView:(UICollectionView *)collectionView didSelectHeaderInSection:(NSInteger)section
{
    if ( nil == pageConfigure )
    {
        return;
    }
    
    if ( [pageConfigure dataModeAtIndex: section] != 0 )
    {
        [self _CollectionView: collectionView didSelectPreviewModeHeaderInSection: section];
        return;
    }
    
    [self _CollectionView: collectionView didSelectNormalModeHeaderInSection: section];
    return;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol required for TDSectionPreviewCellDelegate.
//  ------------------------------------------------------------------------------------------------
- ( void ) collectionView:(UICollectionView *)collectionView didSelectCell:(UICollectionViewCell *)cell preview:(NSString *)imageName
                  sticker:(NSString *)spriteName original:(CGRect)stickerFrame onScreen:(CGRect)nowFrame
{
    NSLog( @"collection %@", collectionView );
    NSLog( @"cell %@", cell );
    NSLog( @"preview name %s ", [imageName UTF8String] );
    NSLog( @"sticker info : %s,  %s, %s", [spriteName UTF8String], [NSStringFromCGRect( stickerFrame ) UTF8String], [NSStringFromCGRect( nowFrame ) UTF8String] );

    
    
    
    
    
    //  for use preview name.
    NSIndexPath                   * indexPath;
    NSData                        * imageData;
    UIImage                       * image;
    UIImage                       * stickerImage;
    
    imageData                       = nil;
    
    image                           = nil;
    stickerImage                    = nil;
    indexPath                       = [collectionView indexPathForCell: cell];
    if ( nil == indexPath )
    {
        return;
    }
    
    imageData                       = [pageConfigure imageDataAtIndex: indexPath.section forKey: imageName];
    if ( nil == imageName )
    {
        return;
    }
    
    image                           = [UIImage imageWithData: imageData];
    if ( nil == image )
    {
        return;
    }
    
    stickerImage                    = [image clipping: stickerFrame];
    if ( nil == stickerImage )
    {
        return;
    }
    
    if ( [customizationParam isStickerSoloViewEnabled] == NO )
    {
        return;
    }
    
    
    [self                           _ShowStickerSoloView: stickerImage original: stickerFrame.size onScreen: nowFrame];
}

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------


@end

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------






























