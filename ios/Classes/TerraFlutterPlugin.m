#import "TerraFlutterPlugin.h"
#if __has_include(<terra_flutter/terra_flutter-Swift.h>)
#import <terra_flutter/terra_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "terra_flutter-Swift.h"
#endif

@implementation TerraFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTerraFlutterPlugin registerWithRegistrar:registrar];
}
@end
