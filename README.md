


# ShowsApp
Check tv series

# The challange

Develop in 5 days a app that consumes tvmaze api: https://www.tvmaze.com/api.
Tvmaze API is free and provides information about tv series.

The app should contain:
  * List of all shows
  * Show details
  * Season selection
  * Episode details
  * Search
  * Passcode

# The structure 

ShowApp uses MVVM-C as a pattern and delegates to bind views with his viewmodels.
To give the user a better navigability in such a large (infinity) list of shows ShowApp uses cache and prefetch data.

Three public available libraries were used to speed up development: 
  * SkeletonView - to animate loading views
  * SwiftKeychainWrapper - simple keychain wrapper to quickly store encrypted private data
  * KAPinField - to quickly desgin a pin text field

# The result

This vídeo demonstrates the final result:
https://user-images.githubusercontent.com/15925863/113040711-7da08000-916f-11eb-8161-daec1dbf591d.MP4

# To run 

This app was built with (requeriments):
  * iOS Deployment Target 14.3
  * Swift 5
  * cocoapods 1.9.3

To run simply open the built project (ShowsApp.xcworkspace) with xcode and run or 
Run pod install in the project root folder and then open ShowsApp.xcworkspace or 
Select one of the distribution .ipa located at ShowsAppIPA folder, install it in your device and run 
