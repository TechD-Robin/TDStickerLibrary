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

#import "TDMath.h"
#import "UIKit+TechD.h"

#import "TDStickerLibraryTabPageView.h"
#import "TDStickerLibrarySectionHeader.h"
#import "TDStickerLibrarySectionPreviewCell.h"
#import "TDStickerLibraryStickerSoloView.h"
#import "TDStickerLibraryStickerIntroDLVC.h"

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
#pragma mark declare private category ()
//  ------------------------------------------------------------------------------------------------
@interface TDStickerLibraryTabPageView ()
<TDSectionHeaderDelegate, TDSectionPreviewCellDelegate>
{
    /**
     *  the pointer for the customization object, reference some properties.
     */
    TDStickerLibraryCustomization * customization;
    
    /**
     *  the pointer for tab page information, i/o the configure from this object.
     */
    TDStickerLibraryTabPageInfo   * pageConfigure;
    
    /**
     *  the pointer for section states, i/o section states of collection view from this object.
     */
    TDStickerLibrarySectionStates * sectionStates;
    
    /**
     *  flags of mode.
     */
    struct {
        unsigned int                a:1;                    //  after set to preview or edit mode.
        unsigned int                isIntroduction:1;       //  introduction or tab page.
        
    } modeFlags;
    
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
@interface TDStickerLibraryTabPageView (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for initial this class.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial the attributes of class.
 *  initial the attributes of class.
 */
- ( void ) _InitAttributes;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief register sub classes for a collection view.
 *  register sub classes  for collection view.
 */
- ( void ) _RegisterClasses;


//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load configure data with page's information for a collection view.
 *  load configure data with page's information for a collection view, use for introduction mode.
 *
 *  @param pageInfo                 the page's information object. (this object isn't it's creator.)
 */
- ( void ) _LoadSwapedSystemConfigure:(TDStickerLibraryTabPageInfo *)pageInfo;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief load configure data for a collection view.
 *  load configure data for a collection view.
 *
 *  @param configure                a configure name for collection view.
 *  @param dataLink                 a data link relation to configure name for update.
 *  @param timestamp                a timestamp relation to configure name for update.
 *  @param aKey                     a key for collection view.
 */
- ( void ) _LoadSystemConfigure:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp forKey:(NSString *)aKey;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief execute the method to sort the configure data.
 *  execute the method to sort the configure data.
 */
- ( void ) _SortSystemConfigureData;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief initial section states of collection view.
 *  initial section states of collection view.
 *
 *  @param aKey                     a key for collection view.
 */
- ( void ) _InitSectionStates:(NSString *)aKey;


//  ------------------------------------------------------------------------------------------------
#pragma mark declare for check configure.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the configure of sticker data is must download to get or not.
 *  check the configure of sticker data is must download to get or not.
 *  * this method always below check effective period.
 *
 *  @param index                    index of the configure.
 *
 *  @return YES|NO                  must download or need not.
 */
- ( BOOL ) _IsMustDownloadStickerAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the sticker data is downloaded to device or not.
 *  check the sticker data is downloaded to device or not.
 *
 *  @param index                    index of the configure.
 *
 *  @return YES|NO                  is downloaded or not.
 */
- ( BOOL ) _IsDownloadedStickerAtIndex:(NSInteger)index;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief check the sticker data can enable(show) intro page view or not.
 *  check the sticker data can enable(show) intro page view or not.
 *
 *  @param section                  section index.
 *
 *  @return YES|NO                  can enabled or not.
 */
- ( BOOL ) _IsEnabledIntroPageForSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
//  is more content for section at index
/**
 *  @brief check the sticker count or contents  can assign into a row or not.
 *  check the sticker count or contents  can assign into a row or not. ( equal mini state )
 *
 *  @param moreContent              pointer of the content state to get result.
 *  @param section                  section index.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _IsMoreContent:(BOOL *)moreContent forSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for create object.
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief create layout of the collection view with customization.
 *  create layout of the collection view with customization.
 *
 *  @param customization            the customization object for the Sticker Library.
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
/**
 *  @brief create a introducton view controller.
 *  create a introducton view controller, that will show sticker's introductioin.
 *
 *  @param section                  section index.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _CreateIntroductionForSection:(NSInteger)section;

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
 *  @brief calculate normal mode image size of proportional of the collection view at index path.
 *  calculate normal mode image size of proportional of the collection view at index path.
 *
 *  @param indexPath                indexPath object of table(collectionView).
 *
 *  @return size|ZeroSize           the result size or ZeroSize.
 */
- ( CGSize ) _CalculateCommonImageProportionalSizeAtIndexPath:(NSIndexPath *)indexPath;

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
 *  tap action for cell in section of collection view, show the sticker image.
 *
 *  @param stickerImage             a sticker image.
 *  @param stickerSize              the sticker image's original size.
 *  @param nowFrame                 the sticker's frame on screen.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _ShowStickerSoloView:(UIImage *)stickerImage original:(CGSize)stickerSize onScreen:(CGRect)nowFrame;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for Sticker Library callback
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the selected image by Sticker Library VC's callback mechanism.
 *  get the selected image by Sticker Library VC's callback mechanism.
 *
 *  @param image                    the selected image.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _StickerLibraryCallbackWithImage:(UIImage *)image;

//  ------------------------------------------------------------------------------------------------
/**
 *  @brief get the selected image by Sticker Library VC's callback mechanism.
 *  get the selected image by Sticker Library VC's callback mechanism; first, get the image by image name.
 *
 *  @param imageName                the image's name (in resource or update).
 *  @param section                  section index.
 *
 *  @return YES|NO                  method success or failure.
 */
- ( BOOL ) _StickerLibraryCallbackWithImageName:(NSString *)imageName forSectionAtIndex:(NSInteger)section;

//  ------------------------------------------------------------------------------------------------
#pragma mark declare for Sticker Library action
//  ------------------------------------------------------------------------------------------------
/**
 *  @brief execute this method when Sticker Library VC's action is completion.
 *  execute this method when Sticker Library VC's action is completion; get a current image by user touch action.
 *  system will close the Sticker Library VC.
 */
- ( void ) _StickerLibraryActionCompletion;

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
@implementation TDStickerLibraryTabPageView (Private)

//  ------------------------------------------------------------------------------------------------
#pragma mark method for initial this class.
//  ------------------------------------------------------------------------------------------------
- ( void ) _InitAttributes
{
    customization                   = nil;
    
    pageConfigure                   = nil;
    sectionStates                   = nil;
    
    //  mode
    modeFlags.isIntroduction        = NO;

    
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
- ( void ) _LoadSwapedSystemConfigure:(TDStickerLibraryTabPageInfo *)pageInfo
{
    if ( nil == pageInfo )
    {
        return;
    }
    
    pageConfigure                   = pageInfo;
    [self                           _InitSectionStates: nil];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _LoadSystemConfigure:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp forKey:(NSString *)aKey
{
    BOOL                            isUpdate;
    
    if ( [TDStickerLibraryUpdate checkConfigureFileExist: configure from: dataLink updateCheckBy: timestamp with: customization extensionResult: &isUpdate] == NO )
    {
        return;
    }
    
    NSString                      * filename;
    NSString                      * subpath;
    NSString                      * passwd;
    TDGetPathDirectory              directory;
    

    //  first, load default.
    filename                        = configure;
    subpath                         = [customization systemConfigureDefaultSubpath];
    passwd                          = nil;
    directory                       = [customization systemConfigureDefaultDirectory];
    pageConfigure                   = [TDStickerLibraryTabPageInfo loadDataFromZip: filename forDirectories: directory inDirectory: subpath
                                                                      inZippedPath: configure  with: passwd configure: aKey];
    if ( nil == pageConfigure )
    {
        //  when the tab configure just create form update.( not configure in default. )
        if ( NO == isUpdate )
        {
            return;
        }
        
        filename                    = [filename stringByAppendingPathExtension: timestamp];
        subpath                     = [customization systemConfigureUpdateSubpath];
        passwd                      = [customization systemConfigureTabPageUpdateZpwiaopsrpsded];
        directory                   = [customization systemConfigureUpdateDirectory];
        pageConfigure               = [TDStickerLibraryTabPageInfo loadDataFromZip: filename forDirectories: directory inDirectory: subpath
                                                                      inZippedPath: configure  with: passwd configure: aKey];
        if ( nil == pageConfigure )
        {
            return;
        }
        
        [self                       _SortSystemConfigureData];
        
        [self                       _InitSectionStates: aKey];
        return;
    }
    
    if ( NO == isUpdate )
    {
        [self                       _SortSystemConfigureData];
        
        [self                       _InitSectionStates: aKey];
        return;
    }
    
    //  second, load update.
    filename                        = [configure stringByAppendingPathExtension: timestamp];
    subpath                         = [customization systemConfigureUpdateSubpath];
    passwd                          = [customization systemConfigureTabPageUpdateZpwiaopsrpsded];
    directory                       = [customization systemConfigureUpdateDirectory];
    [pageConfigure                  updateDataFromZip: filename forDirectories: directory inDirectory: subpath
                                         inZippedPath: configure with: passwd configure: aKey];
    
    //  sort data after data update.
    [self                           _SortSystemConfigureData];
    
    [self                       _InitSectionStates: aKey];
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _SortSystemConfigureData
{
    if ( ( nil == pageConfigure ) || ( nil == customization ) )
    {
        return;
    }

    switch ( [customization tabPageTableSectionSorting] )
    {
        case TDStickerLibraryPageSectionSortingNone:
            return;
        case TDStickerLibraryPageSectionSortingIDAscending:
        {
            [pageConfigure          sortInfoDataByDataID: YES];
            break;
        }
        case TDStickerLibraryPageSectionSortingIDDescending:
        {
            [pageConfigure          sortInfoDataByDataID: NO];
            break;
        }
        case TDStickerLibraryPageSectionSortingTitleAscending:
        {
            [pageConfigure          sortInfoDataByDataTitle: YES];
            break;
        }
        case TDStickerLibraryPageSectionSortingTitleDescending:
        {
            [pageConfigure          sortInfoDataByDataTitle: NO];
            break;
        }
    }
}

//  ------------------------------------------------------------------------------------------------
- ( void ) _InitSectionStates:(NSString *)aKey
{
    if ( ( nil == pageConfigure ) || ( [pageConfigure infoDataCount] == 0 ) )
    {
        return;
    }
    
    
    NSString                      * bundleIdentifier;
    
    bundleIdentifier                = [[NSBundle mainBundle] bundleIdentifier];
    if ( nil != aKey )
    {
        aKey                        = [@"TabPage" stringByAppendingPathExtension: aKey];
        if ( nil != bundleIdentifier )
        {
            aKey                    = [bundleIdentifier stringByAppendingPathExtension: aKey];
        }
    }
    
    sectionStates                   = [TDStickerLibrarySectionStates sectionStates: aKey saveState: [customization isSaveTableSectionMiniStateChange]];
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
    BOOL                            activeData;
    NSMutableArray                * expireData;
    BOOL                            mustDownload;
    BOOL                            isDownloaded;
    
    ID                              = nil;
    imageCount                      = 0;
    imageMiniCount                  = 0;
    perRowCapacity                  = 0;
    sectionMode                     = 0;
    previewSize                     = CGSizeZero;
    previewMiniSize                 = CGSizeZero;
    activeData                      = NO;
    expireData                      = nil;
    perRowCapacity                  = [self _CalculatePerRowCapacityWithCustomization];
    for ( int i = 0; i < [pageConfigure infoDataCount]; ++i )
    {
        //  check data's effective period.
        activeData                  = NO;
        [pageConfigure              isActive: &activeData atIndex: i];
        if ( NO == activeData )
        {
            if ( nil == expireData )
            {
                expireData          = [NSMutableArray new];
            }
            [expireData             addObject: [pageConfigure infoDataAtIndex: i]];
            continue;
        };
        
        
        //  assign data into state container.
        ID                          = [pageConfigure dataIDAtIndex: i];
        if ( nil != ID )
        {
            [sectionStates          insertStateDataForKey: ID];
        }
        
        //  check for download state.
        mustDownload                = [self _IsMustDownloadStickerAtIndex: i];
        isDownloaded                = [self _IsDownloadedStickerAtIndex: i];
        [sectionStates              updateStickerDownloadState: mustDownload with: isDownloaded];
        
        imageCount                  = [pageConfigure countOfImageDataAtIndex: i];
        imageMiniCount              = ( ( imageCount > perRowCapacity ) ? perRowCapacity : imageCount );
        
        if ( NO == modeFlags.isIntroduction )
        {
            [sectionStates          updateImagesCountOfStateData: imageCount with: imageMiniCount];             //  start at mini state.
            //[sectionStates          updateImagesCountOfStateData: imageCount with: imageCount];                 //  start at normal state.
            [sectionStates          updateMiniStateOfStateData: YES];
        }
        else
        {
            [sectionStates          updateImagesCountOfStateData: imageCount with: imageCount];                 //  start at normal state.
            [sectionStates          updateMiniStateOfStateData: NO];
        }
        
        //  when mode not equal normal.
        sectionMode                 = 0;
        if ( ( [pageConfigure dataMode: &sectionMode atIndex: i] == NO ) || ( TDStickerLibraryPageSectionModeNormal == sectionMode ) )
        {
            continue;
        }
        
        previewSize                 = [self _CalculatePreviewImageProportionalSizeForSectionAtIndex: i];
        previewMiniSize             = [self _CalculatePreviewImageMiniSizeForSectionAtIndex: i];
        if ( NO == modeFlags.isIntroduction )
        {
            [sectionStates          updatePreviewImageSizeOfStateData: previewSize with: previewMiniSize];      //  start at mini state.
            //[sectionStates          updatePreviewImageSizeOfStateData: previewSize with: previewSize];          //  start at normal state.
            [sectionStates          updateMiniStateOfStateData: YES];
        }
        else
        {
            [sectionStates          updatePreviewImageSizeOfStateData: previewSize with: previewSize];          //  start at normal state.
            [sectionStates          updateMiniStateOfStateData: NO];
        }
        
    }
    
    //  remove expire information from container.
    if ( ( nil != expireData ) && ( [expireData count] > 0 ) )
    {
        [pageConfigure              removeInfoData: expireData];
    }
    
    //  refresh data.
    [sectionStates                  refreshFromStored];    
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for check configure.
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsMustDownloadStickerAtIndex:(NSInteger)index
{
    NSParameterAssert( [pageConfigure infoDataCount] > index );
    
    NSString                      * configure;
    NSString                      * dataLink;
    NSString                      * timestamp;
    
    configure                       = [pageConfigure configureNameAtIndex: index];
    dataLink                        = [pageConfigure dataLinkAtIndex: index];
    timestamp                       = [pageConfigure timestampAtIndex: index];
    
    //  need not to download
    if ( ( nil == configure ) || ( nil == dataLink ) || ( nil == timestamp ) )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsDownloadedStickerAtIndex:(NSInteger)index
{
    NSParameterAssert( [pageConfigure infoDataCount] > index );

    NSString                      * configure;
    NSString                      * timestamp;
    NSString                      * filePath;
    
    configure                       = [pageConfigure configureNameAtIndex: index];
    timestamp                       = [pageConfigure timestampAtIndex: index];
    if ( ( nil == configure ) || ( nil == timestamp ) )
    {
        return NO;
    }
    
    filePath                        = TDGetPathForDirectoriesWithTimestamp( [customization stickerDownloadDirectory],
                                                                            configure,
                                                                            timestamp,
                                                                            nil,
                                                                            [customization stickerDownloadSubpath], YES );
    if ( nil == filePath )
    {
        return NO;
    }
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsEnabledIntroPageForSectionAtIndex:(NSInteger)section
{
    NSParameterAssert( [pageConfigure infoDataCount] > section );
    
    if ( [self _IsMustDownloadStickerAtIndex: section] == YES )
    {
        return YES;
    }
    
    NSString                      * illustrator;
    NSString                      * email;
    NSString                      * website;
    
    illustrator                     = [pageConfigure illustratorAtIndex: section];
    email                           = [pageConfigure illustratorEMailAtIndex: section];
    website                         = [pageConfigure illustratorWebsiteAtIndex: section];
    if ( ( nil == illustrator ) || ([illustrator length] == 0 ) )
    {
        return NO;
    }
    
    //  illustrator && website.
    if ( ( nil != website ) && ( [website length] > 0 ) )
    {
        return YES;
    }

    //  illustrator && email.
    if ( ( nil != email ) && ( [email length] > 0 ) )
    {
        return YES;
    }
    return NO;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _IsMoreContent:(BOOL *)moreContent forSectionAtIndex:(NSInteger)section
{
    NSParameterAssert( nil != pageConfigure );
    
    if ( NULL == moreContent )
    {
        return NO;
    }
    
    TDStickerLibraryTabPageLayout * layout;
    NSInteger                       rowCapacity;
    NSInteger                       imageTotal;
    NSInteger                       sectionMode;
    
    layout                          = (TDStickerLibraryTabPageLayout *)[self collectionViewLayout];
    if ( nil == layout )
    {
        return NO;
    }
    
    sectionMode                     = 0;
    if ( [pageConfigure dataMode: &sectionMode atIndex: section] == NO )
    {
        return NO;
    }
    
    rowCapacity                     = [layout calculateFirstRowCapacityForSectionAtIndex: section];
    imageTotal                      = [sectionStates numberOfTotalImagesInSection: section];

    //  when image count less then row's capacity, equal no more content.
    if ( TDStickerLibraryPageSectionModeNormal == sectionMode )
    {
        *moreContent                = ( ( imageTotal > rowCapacity ) ? YES : NO );
        return YES;
    }

    *moreContent                    = ( ( imageTotal >= rowCapacity ) ? YES : NO );
    return YES;
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
    
    BOOL                            isEnabled;
    BOOL                            miniState;
    BOOL                            moreContent;
    BOOL                            isDownloaded;
    NSString                      * title;
    TDStickerLibrarySectionHeader * header;
    
    isEnabled                       = NO;
    miniState                       = NO;
    moreContent                     = NO;
    isDownloaded                    = NO;
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
    
    [header                         setCustomization: customization];
    
    //  when mode is tab page, assign current properties.
    if ( YES == modeFlags.isIntroduction )
    {
        return header;
    }
    [header                         assignCorrectProperties];
    
    
    //  find information about this section, then set enabled of status.
    isEnabled                       = [self _IsEnabledIntroPageForSectionAtIndex: indexPath.section];
    [header                         setInformationState: isEnabled];
    
    if ( [self _IsMoreContent: &moreContent forSectionAtIndex: indexPath.section] == YES )
    {
        if ( NO == moreContent )
        {
            [header                 setInformationArrowsState: NO];
        }
        else
        {
            //  set information arrows.
            if ( [sectionStates miniState: &miniState inSection: indexPath.section] == YES )
            {
                [header             setInformationArrow: miniState];
            }
        }
    }
    
    //  check download state.
    if ( [sectionStates downloadState: &isDownloaded inSection: indexPath.section] == YES )
    {
        [header                     setIsDownloadedData: isDownloaded];
    }
    return header;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImageView * ) _CreateCommonSticker:(NSIndexPath *)indexPath
{
    UIImage                       * stickerImage;
    UIImageView                   * stickerView;
    
    stickerImage                    = nil;
    stickerView                     = nil;
    stickerImage                    = [pageConfigure imageAtIndex: indexPath.section inArray: indexPath.row];
    if ( nil == stickerImage )
    {
        return nil;
    }
    
    //stickerView                     = [[UIImageView alloc] initWithImage: stickerImage];
    stickerView                     = [UIImageView proportionalImageView: stickerImage reference: [customization tableCommonItemSize]
                                                              originWith: [customization tableCommonItemSize]];
    if ( nil == stickerView )
    {
        SAFE_ARC_RELEASE( stickerImage );
        return nil;
    }
    
    SAFE_ARC_RELEASE( stickerImage );
    SAFE_ARC_ASSIGN_POINTER_NIL( stickerImage );
    return stickerView;
}

//  ------------------------------------------------------------------------------------------------
- ( UIImageView * ) _CreatePreviewSticker:(NSIndexPath *)indexPath
{
    UIImage                       * stickerImage;
    UIImageView                   * stickerView;
    CGSize                          previewSize;
    
    stickerImage                    = nil;
    stickerView                     = nil;
    previewSize                     = [sectionStates normalSizeOfPreviewImageInSection: indexPath.section];
    stickerImage                    = [pageConfigure imageAtIndex: indexPath.section inArray: indexPath.row];
    if ( nil == stickerImage )
    {
        return nil;
    }
    
    stickerView                     = [[UIImageView alloc] initWithImage: [stickerImage resize: previewSize]];
    if ( nil == stickerView )
    {
        SAFE_ARC_RELEASE( stickerImage );
        return nil;
    }
    
    SAFE_ARC_RELEASE( stickerImage );
    SAFE_ARC_ASSIGN_POINTER_NIL( stickerImage );
    return stickerView;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _CreateIntroductionForSection:(NSInteger)section
{
    NSString                          * ID;
    TDStickerLibraryStickerIntroDLVC  * introVC;
    id                                  viewController;
    NSInteger                           sectionMode;
    BOOL                                miniStateActionBefore;
    
    sectionMode                     = 0;
    if ( [pageConfigure dataMode: &sectionMode atIndex: section] == NO )
    {
        return NO;
    }
    
    miniStateActionBefore           = NO;
    if ( [sectionStates miniState: &miniStateActionBefore inSection: section] == NO )
    {
        return NO;
    }
    
    ID                              = [sectionStates idInSection: section];
    introVC                         = [TDStickerLibraryStickerIntroDLVC introductionDL: customization
                                                                             configure: pageConfigure forSection: section identifier: ID];
    if ( nil == introVC )
    {
        return NO;
    }
    
    //  set callbackup.
    [introVC                        setFinishedIntroDLVCCallbackBlock: ^(NSString * stickerID, NSInteger sectionIndex,BOOL isDownloaded, BOOL actionFinished)
    {
        NSLog( @"finished :%d  sticker ID :%@  index : %d  isDownload : %d", actionFinished, stickerID, sectionIndex, isDownloaded );
        if ( ( NO == actionFinished ) || ( -1 == sectionIndex ) || ( [stickerID isEqualToString: ID] == NO ) )
        {
            return;
        }
        
        //  when action is finish.
        //  call header's delegate to setting UI state.
        if ( ( YES == miniStateActionBefore ) || ( YES == isDownloaded ) )
        {
            [sectionStates          updateDownloadState: isDownloaded inSection: sectionIndex];
            [self                   reloadData];
            return;
        }
        
        if ( TDStickerLibraryPageSectionModeNormal == sectionMode )
        {
            [self                   _CollectionView: self didSelectNormalModeHeaderInSection: section];
        }
        else
        {
            [self                   _CollectionView: self didSelectPreviewModeHeaderInSection: section];
        }
        
        [sectionStates              updateDownloadState: isDownloaded inSection: sectionIndex];
    }];
    
    
    viewController                  = [self viewController];
    if ( nil == viewController )
    {
        return NO;
    }
    
    [viewController                 presentViewController: introVC animated: YES completion: nil];
    return YES;
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for calculate.
//  ------------------------------------------------------------------------------------------------
- ( NSInteger ) _CalculatePerRowCapacityWithCustomization
{
    if ( nil == customization )
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
    sectionInset                    = [customization tableCommonSectionInset];
    itemSize                        = [customization tableCommonItemSize];
    minimumInteritemSpacing         = [customization tableMinimumInteritemSpacing];
    
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
- ( CGSize ) _CalculateCommonImageProportionalSizeAtIndexPath:(NSIndexPath *)indexPath
{
    if ( ( nil == pageConfigure ) || ( nil == customization ) )
    {
        return CGSizeZero;
    }
    
    if ( [customization isTableItemSizeUsingImageOriginalProportion] == NO )
    {
        return [customization tableCommonItemSize];
    }
    
    UIImage                       * stickerImage;
    CGSize                          stickerSize;
    CGFloat                         stickerRatio;
    
    stickerRatio                    = 1.0f;
    stickerImage                    = [pageConfigure imageAtIndex: indexPath.section inArray: indexPath.row];
    if ( nil == stickerImage )
    {
        return [customization tableCommonItemSize];
    }
    
    stickerSize                     = [stickerImage size];
    stickerRatio                    = ( stickerSize.height / stickerSize.width );
    stickerSize                     = calculateProportionalMaxSizeWithLimit( stickerRatio, stickerSize, [customization tableCommonItemSize] );
    return stickerSize;
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) _CalculatePreviewImageProportionalSizeForSectionAtIndex:(NSInteger)section
{
    if ( ( nil == pageConfigure ) || ( nil == customization ) )
    {
        return CGSizeZero;
    }
    
    CGFloat                         ratio;
    CGSize                          newSize;
    UIImage                       * previewImage;
    UIEdgeInsets                    sectionInset;
    
    ratio                           = 1.0f;
    previewImage                    = nil;
    newSize                         = CGSizeZero;
    sectionInset                    = [customization tableCommonSectionInset];
    previewImage                    = [pageConfigure imageAtIndex: section inArray: 0];
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
    if ( nil == customization )
    {
        return CGSizeZero;
    }
    
    CGFloat                         ratio;
    CGSize                          newSize;
    UIEdgeInsets                    sectionInset;
    
    ratio                           = 1.0f;
    newSize                         = CGSizeZero;
    sectionInset                    = [customization tableCommonSectionInset];

    newSize                         = [self bounds].size;
    newSize.width                   -= ( sectionInset.left + sectionInset.right );
    ratio                           = ( [customization tableCommonItemSize].width / newSize.width );
    
//.    newSize.height                  = ( [customization tableCommonItemSize].height + sectionInset.top + [customization tableMinimumLineSpacing] );
    newSize.height                  = ( [customization tableCommonItemSize].height );
    
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
                                                                                  with: [self window] customization: customization];
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
#pragma mark declare for Sticker Library callback
//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _StickerLibraryCallbackWithImage:(UIImage *)image
{
    if ( ( [self superview] == nil ) || ( [[self superview] viewController] == nil ) )
    {
        return NO;
    }
    
    id                                  idViewController;
    FinishedStickerLibraryCallbackBlock callbackBlock;
    
    callbackBlock                   = nil;
    idViewController                = [[self superview] viewController];
    if ( [idViewController isKindOfClass: [TDStickerLibraryViewController class]] == NO )
    {
        return NO;
    }
    
    callbackBlock                 = [idViewController finishedStickerLibraryCallbackBlock];
    if ( nil == callbackBlock )
    {
        return NO;
    }

    callbackBlock( image );
    return YES;
}

//  ------------------------------------------------------------------------------------------------
- ( BOOL ) _StickerLibraryCallbackWithImageName:(NSString *)imageName forSectionAtIndex:(NSInteger)section
{
    NSParameterAssert( nil != pageConfigure );
    NSParameterAssert( [pageConfigure infoDataCount] > section );

    NSString                      * configure;
    NSString                      * timestamp;
    NSString                      * filePath;
    
    configure                       = [pageConfigure configureNameAtIndex: section];
    timestamp                       = [pageConfigure timestampAtIndex: section];
    if ( ( nil == configure ) || ( nil == timestamp ) )
    {
        return NO;
    }
    
    filePath                        = TDGetPathForDirectoriesWithTimestamp( [customization stickerDownloadDirectory],
                                                                           configure,
                                                                           timestamp,
                                                                           nil,
                                                                           [customization stickerDownloadSubpath], YES );
    if ( nil == filePath )
    {
        return NO;
    }
    
    //  get the data frm zipped.
    TDResourceManager             * resourceManager;
    UIImage                       * stickerImage;
    
    stickerImage                    = nil;
    resourceManager                 = [TDResourceManager zippedFileEnvironment: filePath with: [customization stickerDownloadZpwiaopsrpsded]
                                                                   onSingleton: NO];
    if ( nil == resourceManager )
    {
        return NO;
    }
    
    stickerImage                    = [resourceManager image: imageName ofType: nil inDirectory: configure];
    if ( nil == stickerImage )
    {
        resourceManager             = nil;
        return NO;
    }
    
    resourceManager                 = nil;
    return [self _StickerLibraryCallbackWithImage: stickerImage];
}

//  ------------------------------------------------------------------------------------------------
#pragma mark method for Sticker Library action
//  ------------------------------------------------------------------------------------------------
- ( void ) _StickerLibraryActionCompletion
{
    if ( ( [self superview] == nil ) || ( [[self superview] viewController] == nil ) )
    {
        return;
    }
    
    id                                  idViewController;
    
    idViewController                = [[self superview] viewController];
    if ( [idViewController isKindOfClass: [TDStickerLibraryViewController class]] == NO )
    {
        return;
    }

    [idViewController               actionCompletion];
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
@implementation TDStickerLibraryTabPageView

//  ------------------------------------------------------------------------------------------------
//  ------------------------------------------------------------------------------------------------
#pragma mark overwrite implementation of NSObject.
//  ------------------------------------------------------------------------------------------------


//  ------------------------------------------------------------------------------------------------
- ( void ) dealloc
{
    if ( nil != customization )
    {
        //  release by creator.
        customization               = nil;
    }
    
    if ( nil != pageConfigure )
    {
        //  when this object is create at introduction mode, it's not creator.
        if ( NO == modeFlags.isIntroduction )
        {
            SAFE_ARC_RELEASE( pageConfigure );
        }
        pageConfigure               = nil;
    }
    
    if ( nil != sectionStates )
    {
        SAFE_ARC_RELEASE( sectionStates );
        sectionStates               = nil;
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
- ( instancetype ) initWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)custom
{
    TDStickerLibraryTabPageLayout * layout;
    
    layout                          = (TDStickerLibraryTabPageLayout *)[[self class] _CreateLayout: custom];
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
    [self                           setBackgroundColor: [UIColor clearColor]];
    customization                   = custom;
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)custom
                            data:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp forKey:(NSString *)aKey
{
    NSParameterAssert( nil != custom );
    NSParameterAssert( nil != configure );
    NSParameterAssert( nil != aKey );
    
    self                            = [self initWithFrame: frame customization: custom];
    if ( nil == self )
    {
        return nil;
    }
    
    [self                           _LoadSystemConfigure: configure from: dataLink updateCheckBy: timestamp forKey: aKey];
    return self;
}

//  ------------------------------------------------------------------------------------------------
- ( instancetype ) initWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)custom
                       configure:(TDStickerLibraryTabPageInfo *)pageInfo forSection:(NSInteger)index
{
    NSParameterAssert( nil != custom );
    NSParameterAssert( nil != pageInfo );
    
    self                            = [self initWithFrame: frame customization: custom];
    if ( nil == self )
    {
        return nil;
    }
    
    modeFlags.isIntroduction        = YES;
    [self                           _LoadSwapedSystemConfigure: pageInfo];
    return self;
}


//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) tabPageWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)custom
                               data:(NSString *)configure from:(NSString *)dataLink updateCheckBy:(NSString *)timestamp forKey:(NSString *)aKey
{
    return [[[self class] alloc] initWithFrame: frame customization: custom data: configure from: dataLink updateCheckBy: timestamp forKey: aKey];
}

//  ------------------------------------------------------------------------------------------------
+ ( instancetype ) introductionPageWithFrame:(CGRect)frame customization:(TDStickerLibraryCustomization *)custom
                                   configure:(TDStickerLibraryTabPageInfo *)pageInfo forSection:(NSInteger)index
{
    return [[[self class] alloc] initWithFrame: frame customization: custom configure: pageInfo forSection: index];
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
    NSInteger                       sectionMode;
    
    stickerView                     = nil;
    sectionMode                     = 0;
    if ( [pageConfigure dataMode: &sectionMode atIndex: indexPath.section] == NO )
    {
        NSLog( @"cannot get the section mode!" );
        return nil;
    }
    
    if ( TDStickerLibraryPageSectionModeNormal == sectionMode )
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
    BOOL                            miniState;
    
    miniState                       = YES;
    cell                            = [collectionView dequeueReusableCellWithReuseIdentifier: NSStringFromClass( [TDStickerLibrarySectionPreviewCell class] ) forIndexPath: indexPath];
    if ( ( [sectionStates miniState: &miniState inSection: indexPath.section] == NO ) || ( nil == cell ) )
    {
        return cell;
    }
    
    //  init the cell's state.
    [(TDStickerLibrarySectionPreviewCell *)cell setMiniState: miniState];
    
    stickerView                     = [self _CreatePreviewSticker: indexPath];
    if ( nil != stickerView )
    {
        [cell                       setBackgroundView: stickerView];
    }

    
    //  assign the frames data for preview image..
    NSData                        * configureData;
    
    configureData                   = [pageConfigure configureDataAtIndex: indexPath.section];
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
    if ( ( nil == customization ) || ( nil == pageConfigure ) || ( nil == sectionStates ) )
    {
        return CGSizeZero;
    }
    
    NSInteger                       sectionMode;
    
    sectionMode                     = 0;
    if ( ( [pageConfigure dataMode: &sectionMode atIndex: indexPath.section] == NO ) || ( TDStickerLibraryPageSectionModeNormal == sectionMode ) )
    {
        return [self _CalculateCommonImageProportionalSizeAtIndexPath: indexPath];
    }
    return [sectionStates nowSizeOfPreviewImageInSection: indexPath.section];
}

//  ------------------------------------------------------------------------------------------------
- ( UIEdgeInsets ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return [customization tableCommonSectionInset];
}

//  ------------------------------------------------------------------------------------------------
- ( CGSize ) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    //  when introduction mode, don't show header.
    if ( YES == modeFlags.isIntroduction )
    {
        CGFloat                     screenWidth;
        screenWidth                 = [[UIScreen mainScreen] bounds].size.width;
        
        return CGSizeMake( screenWidth, 0 );
    }
    
    if ( [(UICollectionViewFlowLayout *)collectionViewLayout scrollDirection] == UICollectionViewScrollDirectionHorizontal )
    {
        return CGSizeMake( [customization tableCommonHeaderReferenceSize].height, [collectionView frame].size.height );
    }
    return CGSizeMake( [collectionView frame].size.width, [customization tableCommonHeaderReferenceSize].height );
}

//  ------------------------------------------------------------------------------------------------
#pragma mark protocol optional for UICollectionViewDelegate.
//  ------------------------------------------------------------------------------------------------
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  precheck for download state.
    BOOL                            isDownloaded;
    
    isDownloaded                    = NO;
    if ( [sectionStates downloadState: &isDownloaded inSection: indexPath.section] == NO )
    {
        NSLog( @"cannot get the section download state!");
        return;
    }
    if ( NO == isDownloaded )
    {
        //  when introduction mode, don't create introduction again..
        if ( NO == modeFlags.isIntroduction )
        {
            [self                   _CreateIntroductionForSection: indexPath.section];
            return;
        }
    }
    
    
    //  for normal mode.
    CGSize                              stickerSize;
    CGRect                              onScreenFrame;
    UIImage                           * stickerImage;
    UICollectionViewLayoutAttributes  * layoutAttributes;
    
    stickerSize                     = CGSizeZero;
    onScreenFrame                   = CGRectZero;
    stickerImage                    = nil;
    layoutAttributes                = [collectionView layoutAttributesForItemAtIndexPath: indexPath];
    if ( nil == layoutAttributes )
    {
        return;
    }
    
    onScreenFrame.size              = [layoutAttributes size];
    onScreenFrame.origin            = [self convertPoint: [layoutAttributes frame].origin toView: nil];
    stickerImage                    = [pageConfigure imageAtIndex: indexPath.section inArray: indexPath.row];
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
    
    if ( [self _StickerLibraryCallbackWithImage: stickerImage] == YES )
    {
        //  close this object's controller.( superview's )
        [self                       _StickerLibraryActionCompletion];
        return;
    }
    

    if ( [customization isStickerSoloViewEnabled] == NO )
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
    NSParameterAssert( nil != pageConfigure );
    
    //  precheck for download state.
    BOOL                            isDownloaded;
    isDownloaded                    = NO;
    if ( [sectionStates downloadState: &isDownloaded inSection: section] == NO )
    {
        return;
    }
    
    if ( NO == isDownloaded )
    {
        [self                       _CreateIntroductionForSection: section];
        return;
    }
    
    
    NSInteger                       sectionMode;
    
    sectionMode                     = 0;
    if ( ( [pageConfigure dataMode: &sectionMode atIndex: section] == YES ) && ( TDStickerLibraryPageSectionModeNormal != sectionMode ) )
    {
        [self _CollectionView: collectionView didSelectPreviewModeHeaderInSection: section];
        return;
    }
    
    [self _CollectionView: collectionView didSelectNormalModeHeaderInSection: section];
    return;
}

//  ------------------------------------------------------------------------------------------------
- ( void ) collectionView:(UICollectionView *)collectionView didSelectHeaderInformationInSection:(NSInteger)section
{
    NSParameterAssert( nil != pageConfigure );
    NSParameterAssert( nil != sectionStates );
        
    //  check again.
    if ( [self _IsEnabledIntroPageForSectionAtIndex: section] == NO )
    {
        return;
    }
    [self                           _CreateIntroductionForSection: section];
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

    //  precheck for download state.
    NSIndexPath                   * indexPath;
    BOOL                            isDownloaded;
    NSInteger                       sectionMode;
    
    indexPath                       = [collectionView indexPathForCell: cell];
    if ( nil == indexPath )
    {
        return;
    }
    
    isDownloaded                    = NO;
    if ( [sectionStates downloadState: &isDownloaded inSection: indexPath.section] == NO )
    {
        NSLog( @"cannot get the section download state!");
        return;
    }
    if ( NO == isDownloaded )
    {
        //  when introduction mode, don't create introduction again..
        if ( NO == modeFlags.isIntroduction )
        {
            [self                   _CreateIntroductionForSection: indexPath.section];
            return;
        }
    }
    
    sectionMode                     = 0;
    if ( [pageConfigure dataMode: &sectionMode atIndex: indexPath.section] == NO )
    {
        NSLog( @"cannot get the section data mode!");
        return;
    }
    
    
    //  execute callback.
    if ( ( TDStickerLibraryPageSectionModePreviewDownload == sectionMode ) && ( NO == modeFlags.isIntroduction ) )
    {
        if ( [self _StickerLibraryCallbackWithImageName: spriteName forSectionAtIndex: indexPath.section] == YES )
        {
            //  close this object's controller.( superview's )
            [self                   _StickerLibraryActionCompletion];
            return;
        }
    }
    
    
    //  for use preview name.
    UIImage                       * image;
    UIImage                       * stickerImage;
    
    image                           = nil;
    stickerImage                    = nil;
    image                           = [pageConfigure imageAtIndex: indexPath.section forKey: imageName];
    if ( nil == image )
    {
        return;
    }
    
    stickerImage                    = [image clipping: stickerFrame];
    if ( nil == stickerImage )
    {
        return;
    }
    
    //  execute callback.
    if ( TDStickerLibraryPageSectionModePreview == sectionMode )
    {
        if ( [self _StickerLibraryCallbackWithImage: stickerImage] == YES )
        {
            //  close this object's controller.( superview's )
            [self                   _StickerLibraryActionCompletion];
            return;
        }
    }
    
    if ( [customization isStickerSoloViewEnabled] == NO )
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






























