#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#import "ZipArchive.h"
#import "TarArchive.h"
//#import "GnuZipArchive.h"

/* -----------------------------------------------------------------------------
   Generate a preview for file

   This function's job is to create preview for designated file
   ----------------------------------------------------------------------------- */

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
    @autoreleasepool {
	
	// Before proceeding make sure the user didn't cancel the request
		if (QLPreviewRequestIsCancelled(preview)) {
			return noErr;
		}
		
		NSURL *theUrl = (__bridge NSURL *)url;
		NSString *theUti = (__bridge NSString *)contentTypeUTI;
		NSMutableString *zipHtml = [[NSMutableString alloc] init];
    
		if ([theUti localizedCompare:@"public.zip-archive"] == NSOrderedSame) {		
			ZipArchive *zipFile = [[ZipArchive alloc] init];
			[zipHtml setString:[zipFile dump:theUrl]];
		}
		else if ([theUti localizedCompare:@"public.tar-archive"] == NSOrderedSame) {
			TarArchive *tarFile = [[TarArchive alloc] init];
			[zipHtml setString:[tarFile dump:theUrl]];
		}
		else if ([theUti localizedCompare:@"org.gnu.gnu-zip-tar-archive"] == NSOrderedSame) {
			TarArchive *gnuZipFile = [[TarArchive alloc] init];
			[zipHtml setString:[gnuZipFile dump:theUrl]];
		}
		else if ([theUti localizedCompare:@"org.gnu.gnu-zip-archive"] == NSOrderedSame) {
			TarArchive *gnuZipFile = [[TarArchive alloc] init];
			[zipHtml setString:[gnuZipFile dump:theUrl]];
		}
		else if ([theUti localizedCompare:@"public.iso-image"] == NSOrderedSame) {
			TarArchive *isoFile = [[TarArchive alloc] init];
			[zipHtml setString:[isoFile dump:theUrl]];
		}
		else {
			NSLog(@"UNKNOWN FORMAT: %@", theUti);
			return kUnknownType;
		}
    
		QLPreviewRequestSetDataRepresentation(preview,(__bridge CFDataRef)[zipHtml dataUsingEncoding:NSUTF8StringEncoding],kUTTypeHTML,(CFDictionaryRef)nil);
    
    
    return noErr;
    }
}

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}
