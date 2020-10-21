#import "ZpostCliv2Plugin.h"
#if __has_include(<ZpostCliv2/ZpostCliv2-Swift.h>)
#import <ZpostCliv2/ZpostCliv2-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ZpostCliv2-Swift.h"
#endif

@implementation ZpostCliv2Plugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZpostCliv2Plugin registerWithRegistrar:registrar];
}
@end
