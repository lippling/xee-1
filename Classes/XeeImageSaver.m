#import "XeeImageSaver.h"
#import "XeeImage.h"
#import "XeeSimpleLayout.h"

@implementation XeeImageSaver
@synthesize control;

static NSMutableArray *saverclasses = nil;

+ (BOOL)canSaveImage:(XeeImage *)img
{
	return NO;
}

+ (NSArray *)saversForImage:(XeeImage *)img
{
	if (!saverclasses)
		return nil;

	NSMutableArray *savers = [NSMutableArray array];
	NSEnumerator *enumerator = [saverclasses objectEnumerator];
	Class saverclass;
	while (saverclass = [enumerator nextObject]) {
		if ([saverclass canSaveImage:img]) {
			XeeImageSaver *saver = [[saverclass alloc] initWithImage:img];
			if (saver)
				[savers addObject:saver];
			[saver release];
		}
	}

	return savers;
}

+ (void)registerSaverClass:(Class)saverclass
{
	if (!saverclasses)
		saverclasses = [[NSMutableArray alloc] init];
	[saverclasses addObject:saverclass];
}

- (id)initWithImage:(XeeImage *)img
{
	if (self = [super init]) {
		image = [img retain];
		control = nil;
	}
	return self;
}

- (void)dealloc
{
	[image release];
	[control release];
	[super dealloc];
}

- (NSString *)format
{
	return nil;
}

- (NSString *)extension
{
	return nil;
}

- (BOOL)save:(NSString *)filename
{
	return NO;
}

@end
