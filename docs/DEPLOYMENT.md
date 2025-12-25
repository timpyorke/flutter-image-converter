# 🚀 Production Deployment Guide

Complete guide for publishing Flutter Image Converter to production on Google Play Store and Apple App Store.

## 📋 Table of Contents

1. [Pre-Deployment Checklist](#pre-deployment-checklist)
2. [Version Management](#version-management)
3. [Android Deployment](#android-deployment-google-play)
4. [iOS Deployment](#ios-deployment-app-store)
5. [Post-Deployment](#post-deployment)
6. [CI/CD Integration](#cicd-integration)
7. [Troubleshooting](#troubleshooting)

---

## 🔍 Pre-Deployment Checklist

### Code Quality

- [ ] All tests pass: `flutter test`
- [ ] No analyzer issues: `flutter analyze --no-fatal-infos`
- [ ] Code formatted: `dart format .`
- [ ] No console.log or debug prints in production code
- [ ] Performance tested on low-end devices

### App Configuration

- [ ] App icons configured for all platforms (1024x1024 for iOS, various for Android)
- [ ] Splash screens configured
- [ ] App name finalized in all locales
- [ ] Bundle ID/Package name is correct
- [ ] Version number incremented
- [ ] Build number incremented

### Legal & Compliance

- [ ] Privacy Policy prepared and linked
- [ ] Terms of Service prepared (if applicable)
- [ ] Required permissions justified in descriptions
- [ ] Data handling complies with GDPR/CCPA
- [ ] Third-party licenses acknowledged

### Content

- [ ] App description written in all supported languages
- [ ] Screenshots prepared (required sizes for each platform)
- [ ] Feature graphic prepared (Android)
- [ ] Promotional materials ready
- [ ] Keywords researched for ASO (App Store Optimization)

### Testing

- [ ] Tested on physical devices (iOS and Android)
- [ ] Tested all user flows
- [ ] Tested image processing with various formats
- [ ] Tested error scenarios
- [ ] Tested on different screen sizes
- [ ] Beta testing completed (TestFlight/Internal Testing)

---

## 📊 Version Management

### Semantic Versioning

Follow semantic versioning: `MAJOR.MINOR.PATCH` (e.g., 1.2.3)

- **MAJOR**: Breaking changes or major feature overhauls
- **MINOR**: New features, backwards compatible
- **PATCH**: Bug fixes, small improvements

### Update pubspec.yaml

```yaml
# pubspec.yaml
version: 1.2.3+10 # version+buildNumber
```

**Example progression:**

```
1.0.0+1  → Initial release
1.0.1+2  → Bug fix
1.1.0+3  → New feature (Convert format support)
2.0.0+4  → Major update (UI redesign)
```

### Version Changelog

Create `CHANGELOG.md` in root:

```markdown
# Changelog

## [1.2.3] - 2025-12-25

### Added

- Multi-select image conversion
- WEBP format support
- Localization for 10 languages

### Fixed

- File permission issues on Android 14
- Memory leak in image processing

### Changed

- Improved image quality algorithm
- Updated UI with Material 3 design
```

---

## 🤖 Android Deployment (Google Play)

### 1. Configure App Signing

#### Generate Upload Key

```bash
# Navigate to android folder
cd android

# Generate keystore
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload

# Follow prompts to set password and info
```

#### Configure key.properties

Create `android/key.properties`:

```properties
storePassword=YOUR_STORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=upload
storeFile=/Users/yourname/upload-keystore.jks
```

**⚠️ IMPORTANT**: Add `key.properties` to `.gitignore`!

#### Update build.gradle

Ensure `android/app/build.gradle` has signing config:

```gradle
// Load keystore properties
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    // ... other config

    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }

    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

### 2. Build Release APK/Bundle

#### Build App Bundle (Recommended)

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Build app bundle
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

#### Build APK (Alternative)

```bash
flutter build apk --release --split-per-abi

# Generates multiple APKs for different architectures:
# - app-armeabi-v7a-release.apk
# - app-arm64-v8a-release.apk
# - app-x86_64-release.apk
```

### 3. Prepare Store Listing

#### App Details

**Title**: Flutter Image Converter (50 chars max)

**Short Description** (80 chars):

> Resize, convert & compress images instantly. JPEG, PNG, WEBP support.

**Full Description** (4000 chars):

```
🎨 Flutter Image Converter - Professional Image Processing

Transform your images with ease! Resize, convert, and compress images in seconds.

✨ KEY FEATURES

📏 Smart Resize
• Preset dimensions (Instagram, Facebook, Twitter, Custom)
• Maintain aspect ratio automatically
• Batch process multiple images
• High-quality scaling algorithms

🔄 Format Conversion
• Convert between JPEG, PNG, WEBP
• Preserve or adjust quality
• Optimize file sizes
• Support for transparency (PNG)

⚡ Lightning Fast
• Process images in milliseconds
• Isolate-based processing (no UI freeze)
• LRU cache for instant previews
• Optimized memory usage

📁 Easy Saving
• Save to gallery/photos
• Custom save locations
• Batch save support
• Original file preservation

🌍 Multi-Language Support
• English, Thai, Chinese, Japanese, Korean
• Spanish, German, French, Portuguese, Russian
• Auto-detects system language

💾 Efficient Storage
• Compress without quality loss
• Reduce file sizes up to 80%
• Smart quality adjustment
• Format optimization

🎯 Perfect For:
• Social media content creators
• Photographers & designers
• E-commerce sellers
• Bloggers & marketers
• Anyone needing quick image edits

🔒 Privacy First
• All processing done locally
• No internet required
• No data collection
• Your images stay on your device

📱 Clean, Modern Interface
• Material 3 design
• Intuitive workflow
• Dark mode support
• Smooth animations

Download now and transform your images with professional quality!

---
Keywords: image resize, photo converter, image compressor, JPEG converter, PNG converter, WEBP, batch resize, photo editor, image optimization
```

#### Graphics Requirements

**Screenshots** (Phone - Required):

- Minimum 2, Maximum 8
- JPEG or 24-bit PNG (no alpha)
- Minimum dimension: 320px
- Maximum dimension: 3840px
- Recommended: 1080x1920 (portrait) or 1920x1080 (landscape)

**Feature Graphic** (Required):

- 1024 x 500 pixels
- JPEG or 24-bit PNG (no alpha)

**App Icon** (Uploaded automatically from app):

- 512 x 512 pixels
- 32-bit PNG with alpha

#### Content Rating

Complete questionnaire for proper age rating:

- **Violence**: None
- **User Interaction**: No user-generated content
- **Data Sharing**: No data collection
- **Expected Rating**: Everyone

#### Store Listing Assets Checklist

```
screenshots/
├── en/
│   ├── 1-home-screen.png (1080x1920)
│   ├── 2-resize-feature.png (1080x1920)
│   ├── 3-convert-feature.png (1080x1920)
│   ├── 4-results.png (1080x1920)
│   └── 5-settings.png (1080x1920)
├── feature-graphic.png (1024x500)
└── promo-video.mp4 (optional, 30sec max, 30MB max)
```

### 4. Google Play Console Steps

1. **Create Application**

   - Go to [Google Play Console](https://play.google.com/console)
   - Create new app
   - Select default language and app name

2. **Upload Bundle**

   - Production → Create new release
   - Upload `app-release.aab`
   - Add release notes

3. **Complete Store Listing**

   - App details → Fill all required fields
   - Graphics → Upload all screenshots and graphics
   - Categorization → Select "Photography" or "Tools"

4. **Content Rating**

   - Complete questionnaire
   - Apply rating

5. **Pricing & Distribution**

   - Set pricing (Free/Paid)
   - Select countries
   - Accept content guidelines

6. **Privacy Policy**

   - Add privacy policy URL
   - Complete data safety form

7. **Submit for Review**
   - Review all sections (must be green checkmarks)
   - Submit app for review
   - Wait 1-3 days for approval

### 5. Android Release Notes Template

```
Version 1.2.3 - What's New

✨ New Features
• Multi-select images for batch processing
• Added WEBP format support
• 10 languages now supported

🐛 Bug Fixes
• Fixed storage permission issue on Android 14
• Improved memory management
• Fixed crash on large images

⚡ Improvements
• 30% faster image processing
• Better compression algorithm
• Smoother UI animations

Thank you for using Flutter Image Converter!
Rate us 5 stars if you love the app! ⭐
```

---

## 🍎 iOS Deployment (App Store)

### 1. Configure Xcode Project

#### Update Bundle Identifier

Open `ios/Runner.xcworkspace` in Xcode:

1. Select Runner project
2. Select Runner target
3. General tab → Update Bundle Identifier: `com.yourcompany.imageconverter`

#### Configure Signing

1. Signing & Capabilities tab
2. Team: Select your Apple Developer team
3. Enable "Automatically manage signing"
4. Provisioning Profile: Xcode Managed Profile

#### App Icons

Icons should be in `ios/Runner/Assets.xcassets/AppIcon.appiconset/`:

```
Required sizes:
- 20pt (1x, 2x, 3x)
- 29pt (1x, 2x, 3x)
- 40pt (1x, 2x, 3x)
- 60pt (2x, 3x)
- 76pt (1x, 2x)
- 83.5pt (2x)
- 1024pt (1x) - App Store icon
```

**Tip**: Use [appicon.co](https://appicon.co) to generate all sizes from 1024x1024 source.

### 2. Update Info.plist Permissions

Ensure `ios/Runner/Info.plist` has proper descriptions:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to save converted images to your photo library.</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>We need permission to save your converted images.</string>

<key>NSCameraUsageDescription</key>
<string>We need camera access to take photos for conversion.</string>
```

### 3. Build Release IPA

#### Archive Build

```bash
# Clean build
flutter clean

# Get dependencies
flutter pub get

# Build iOS release
flutter build ipa --release

# Output: build/ios/ipa/flutter_image_converters.ipa
```

#### Manual Archive (Alternative)

```bash
# Build for iOS
flutter build ios --release

# Then in Xcode:
# Product → Archive
# Window → Organizer → Distribute App
```

### 4. App Store Connect Setup

#### Create App Record

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. My Apps → + → New App
3. Fill in:
   - Platform: iOS
   - Name: Flutter Image Converter
   - Primary Language: English
   - Bundle ID: Select from dropdown
   - SKU: Unique identifier (e.g., IMG_CONV_001)
   - User Access: Full Access

#### App Information

**Name**: Flutter Image Converter (30 chars max)

**Subtitle** (30 chars):

> Resize & Convert Images Fast

**Privacy Policy URL**:
`https://yourwebsite.com/privacy-policy`

**Category**:

- Primary: Photo & Video
- Secondary: Utilities

**Content Rights**: Check if contains third-party content

#### Pricing & Availability

- Price: Free (or select pricing)
- Availability: All countries (or select specific)
- Pre-order: Available if needed

### 5. Version Information

#### Screenshots Requirements

**iPhone**:

- 6.7" Display (iPhone 14 Pro Max): 1290 x 2796
- 6.5" Display (iPhone 11 Pro Max): 1242 x 2688
- 5.5" Display (iPhone 8 Plus): 1242 x 2208

**iPad** (if supported):

- 12.9" Display: 2048 x 2732
- 11" Display: 1668 x 2388

Minimum: 3 screenshots per device type
Maximum: 10 screenshots per device type

#### App Preview Video (Optional)

- 15-30 seconds
- Portrait orientation recommended
- Dimensions match screenshot sizes
- MP4 format

#### Description Template

**App Description** (4000 chars):

```
🎨 PROFESSIONAL IMAGE PROCESSING IN YOUR POCKET

Flutter Image Converter is the ultimate tool for resizing, converting, and compressing images on your iPhone and iPad. Whether you're a content creator, photographer, or just need to quickly edit images, we've got you covered.

✨ POWERFUL FEATURES

📏 SMART RESIZE
• Preset dimensions for Instagram, Facebook, Twitter
• Custom width and height with aspect ratio lock
• Batch resize multiple images at once
• Professional-grade scaling algorithms
• No quality loss

🔄 FORMAT CONVERSION
• Convert between JPEG, PNG, and WEBP
• Preserve transparency in PNG images
• Adjustable quality settings
• Optimize for web or print
• Support for large files

⚡ LIGHTNING FAST
• Process images in milliseconds
• No lag or freezing
• Advanced caching system
• Optimized for latest iOS devices
• Works offline

📁 FLEXIBLE SAVING
• Save directly to Photos
• Organize in custom albums
• Preserve original files
• Quick share options
• Batch save support

🌍 SPEAKS YOUR LANGUAGE
Available in 10 languages:
• English, 中文, 日本語, 한국어
• ไทย, Español, Deutsch, Français
• Português, Русский

💾 SMART COMPRESSION
• Reduce file sizes up to 80%
• Maintain visual quality
• Perfect for email attachments
• Optimize for social media
• Web-friendly output

🎯 PERFECT FOR:
• Social media managers
• Professional photographers
• E-commerce sellers
• Bloggers and writers
• Real estate agents
• Anyone who works with images

🔒 PRIVACY FOCUSED
• 100% offline processing
• No server uploads
• No data collection
• No ads or tracking
• Your images stay private

📱 BEAUTIFUL DESIGN
• Native iOS design language
• Clean, intuitive interface
• Dark mode support
• Smooth animations
• Accessible for all users

🏆 WHY CHOOSE US?
✓ No watermarks
✓ No subscriptions
✓ No image limits
✓ No hidden fees
✓ Professional results

Download Flutter Image Converter now and experience the fastest, most powerful image processing app on iOS!

---

Need help? Contact us at support@yourcompany.com
Follow us on Twitter @yourcompany

Privacy Policy: https://yourcompany.com/privacy
Terms of Use: https://yourcompany.com/terms
```

#### Keywords (100 chars max)

```
image,resize,photo,convert,compress,editor,jpeg,png,webp,batch
```

**Tips for ASO**:

- Use comma-separated keywords
- No spaces after commas
- Most important keywords first
- Research competitors' keywords
- Include variations (photo/image, resize/scale)

#### What's New (4000 chars)

```
🎉 NEW IN VERSION 1.2.3

✨ NEW FEATURES
• Multi-Select: Process multiple images simultaneously
• WEBP Support: Convert to modern WEBP format
• 10 Languages: Full localization for global users
• Batch Actions: Apply same settings to all images

🐛 BUG FIXES
• Fixed crash when processing very large images
• Improved memory management for better stability
• Fixed save dialog on iOS 17
• Better error messages and recovery

⚡ PERFORMANCE IMPROVEMENTS
• 30% faster image processing
• Reduced memory usage by 40%
• Smoother animations and transitions
• Better battery efficiency

🎨 UI ENHANCEMENTS
• Updated to iOS 17 design guidelines
• New modern icons
• Improved accessibility
• Better dark mode colors

Thank you for your continued support!
Please rate us 5 stars ⭐⭐⭐⭐⭐ if you love the app!

Having issues? Contact: support@yourcompany.com
```

#### Support URL

```
https://yourcompany.com/support
```

#### Marketing URL (Optional)

```
https://yourcompany.com/image-converter
```

### 6. App Review Information

**Sign-In Required**: No (or provide demo account)

**Contact Information**:

- First Name: Your Name
- Last Name: Last Name
- Phone: +1-234-567-8900
- Email: review@yourcompany.com

**Notes**:

```
Thank you for reviewing Flutter Image Converter!

Key features to test:
1. Resize image: Tap "Resize" → Select image → Choose preset → Resize
2. Convert format: Tap "Convert" → Select image → Choose format → Convert
3. Save image: After processing → Tap Save button
4. Multi-language: Works in English, Chinese, Japanese, and 7 other languages

No special configuration needed. All features work offline.
The app requests photo library access for saving converted images.

Contact for any questions: review@yourcompany.com
```

### 7. Upload Build

#### Using Transporter App

1. Download Transporter from Mac App Store
2. Sign in with Apple Developer account
3. Add IPA file from `build/ios/ipa/`
4. Deliver to App Store Connect

#### Using Xcode

1. Open Organizer (Window → Organizer)
2. Select archive
3. Distribute App → App Store Connect
4. Upload

### 8. Submit for Review

1. Select uploaded build in App Store Connect
2. Complete all required fields (should be green checkmarks)
3. Save
4. Submit for Review
5. Wait 24-48 hours for review

### 9. Release Options

**Manual Release**:

- Review approval → You manually release

**Automatic Release**:

- Review approval → Automatically available

**Scheduled Release**:

- Review approval → Release on specific date

---

## 🎯 Post-Deployment

### Monitor Performance

#### Android (Google Play Console)

Track metrics:

- **Installs**: Daily active installs
- **Crashes**: ANR (App Not Responding) and crash rates
- **Ratings**: User reviews and average rating
- **Vitals**: App startup time, battery usage

Target KPIs:

- Crash-free rate: >99.5%
- ANR rate: <0.5%
- Rating: >4.0 stars

#### iOS (App Store Connect)

Monitor:

- **App Analytics**: Downloads, sessions, engagement
- **Crashes**: Crash reports and diagnostics
- **Reviews**: User feedback and ratings
- **TestFlight**: Beta testing feedback

### Respond to Reviews

**Positive Reviews** (4-5 stars):

```
Thank you so much for the 5-star review! 🌟
We're thrilled you're enjoying Flutter Image Converter!
If you have any suggestions, we'd love to hear them.
```

**Constructive Reviews** (2-3 stars):

```
Thank you for your feedback. We're sorry to hear about [specific issue].
We're actively working on improvements and would love to understand
your concerns better. Please email us at support@yourcompany.com
so we can help resolve this.
```

**Negative Reviews** (1 star):

```
We're very sorry for your experience. This isn't the quality we aim for.
Please contact us at support@yourcompany.com with more details,
and we'll do our best to resolve this issue immediately.
```

### Update Cycle

**Recommended Schedule**:

- **Critical bugs**: Hotfix within 24-48 hours
- **Minor bugs**: Patch release within 1-2 weeks
- **Features**: Minor release every 2-4 weeks
- **Major updates**: Major release every 2-3 months

### User Support

Set up support channels:

- Email: support@yourcompany.com
- FAQ page on website
- In-app help section
- Social media (Twitter, Instagram)

---

## 🔄 CI/CD Integration

### GitHub Actions

Create `.github/workflows/release.yml`:

```yaml
name: Release to Stores

on:
  push:
    tags:
      - "v*"

jobs:
  build-android:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Java
        uses: actions/setup-java@v3
        with:
          distribution: "zulu"
          java-version: "17"

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.19.0"
          channel: "stable"

      - name: Get dependencies
        run: flutter pub get

      - name: Run tests
        run: flutter test

      - name: Build Android App Bundle
        run: flutter build appbundle --release
        env:
          KEY_STORE_PASSWORD: ${{ secrets.KEY_STORE_PASSWORD }}
          KEY_PASSWORD: ${{ secrets.KEY_PASSWORD }}
          KEY_ALIAS: ${{ secrets.KEY_ALIAS }}
          KEY_PATH: ${{ secrets.KEY_PATH }}

      - name: Upload to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.PLAY_STORE_SERVICE_ACCOUNT }}
          packageName: com.yourcompany.imageconverter
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production
          status: completed

  build-ios:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.19.0"
          channel: "stable"

      - name: Get dependencies
        run: flutter pub get

      - name: Run tests
        run: flutter test

      - name: Build iOS
        run: flutter build ios --release --no-codesign

      - name: Archive and Upload to TestFlight
        uses: apple-actions/upload-testflight-build@v1
        with:
          app-path: build/ios/ipa/flutter_image_converters.ipa
          issuer-id: ${{ secrets.APPSTORE_ISSUER_ID }}
          api-key-id: ${{ secrets.APPSTORE_API_KEY_ID }}
          api-private-key: ${{ secrets.APPSTORE_API_PRIVATE_KEY }}
```

### Fastlane Setup

Install Fastlane:

```bash
sudo gem install fastlane
```

#### Android Fastlane

Create `android/fastlane/Fastfile`:

```ruby
platform :android do
  desc "Deploy to Google Play"
  lane :deploy do
    gradle(task: "clean")
    gradle(
      task: "bundle",
      build_type: 'Release'
    )
    upload_to_play_store(
      track: 'production',
      aab: '../build/app/outputs/bundle/release/app-release.aab',
      skip_upload_metadata: false,
      skip_upload_images: false,
      skip_upload_screenshots: false
    )
  end

  desc "Deploy to Internal Testing"
  lane :internal do
    gradle(task: "clean")
    gradle(
      task: "bundle",
      build_type: 'Release'
    )
    upload_to_play_store(
      track: 'internal',
      aab: '../build/app/outputs/bundle/release/app-release.aab'
    )
  end
end
```

#### iOS Fastlane

Create `ios/fastlane/Fastfile`:

```ruby
platform :ios do
  desc "Push to TestFlight"
  lane :beta do
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_testflight(
      skip_waiting_for_build_processing: true
    )
  end

  desc "Deploy to App Store"
  lane :release do
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: "Runner",
      export_method: "app-store"
    )
    upload_to_app_store(
      force: true,
      submit_for_review: true,
      automatic_release: true
    )
  end
end
```

Run deployment:

```bash
# Android
cd android && fastlane deploy

# iOS
cd ios && fastlane release
```

---

## 🔧 Troubleshooting

### Common Android Issues

#### Build Fails - Signing Config

**Error**: `No signature found in archive`

**Solution**:

```bash
# Verify keystore exists
ls -l ~/upload-keystore.jks

# Check key.properties is configured
cat android/key.properties

# Rebuild
flutter clean
flutter pub get
flutter build appbundle --release
```

#### Gradle Build Failed

**Error**: `Could not resolve all dependencies`

**Solution**:

```bash
cd android
./gradlew clean
./gradlew --stop
cd ..
flutter clean
flutter pub get
flutter build appbundle --release
```

#### Play Store Rejection - Privacy Policy

**Error**: `App requires valid privacy policy URL`

**Solution**:

- Host privacy policy on your website
- Update in Play Console → Store presence → Privacy policy
- Include data collection disclosure

### Common iOS Issues

#### Code Signing Failed

**Error**: `No signing certificate "iOS Distribution" found`

**Solution**:

1. Open Xcode → Preferences → Accounts
2. Download Manual Profiles
3. Select correct team in Runner target
4. Clean and rebuild

#### Archive Not Appearing

**Error**: Archive created but not shown in Organizer

**Solution**:

```bash
# Check Generic iOS Device is selected (not simulator)
# Clean build folder
flutter clean
rm -rf ios/Pods
rm ios/Podfile.lock
cd ios && pod install --repo-update
cd ..
flutter build ios --release
```

#### App Store Rejection - Missing Purpose Strings

**Error**: `Missing purpose string for photo library access`

**Solution**:
Add to `ios/Runner/Info.plist`:

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>We need access to save your converted images.</string>
```

### Version Conflicts

**Issue**: Build number already exists

**Solution**:

```yaml
# Increment build number in pubspec.yaml
version: 1.0.1+2  # Change +1 to +2

# Or set manually during build
flutter build appbundle --build-number=2
```

---

## 📝 Deployment Checklist Summary

### Pre-Release

- [ ] Tests passing
- [ ] Version incremented
- [ ] Changelog updated
- [ ] Privacy policy ready
- [ ] Screenshots prepared
- [ ] Descriptions translated

### Android

- [ ] Keystore configured
- [ ] Bundle built successfully
- [ ] Store listing complete
- [ ] Content rating complete
- [ ] Submitted for review

### iOS

- [ ] Signing configured
- [ ] IPA built successfully
- [ ] App Store Connect complete
- [ ] Screenshots uploaded
- [ ] Submitted for review

### Post-Release

- [ ] Monitor crash reports
- [ ] Respond to reviews
- [ ] Track analytics
- [ ] Plan next release

---

## 📚 Additional Resources

### Official Documentation

- [Flutter Deployment](https://docs.flutter.dev/deployment)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect)

### Tools

- [App Icon Generator](https://appicon.co)
- [Screenshot Generator](https://www.shotbot.io)
- [ASO Tools](https://www.apptweak.com)
- [Fastlane](https://fastlane.tools)

### Marketing

- [App Store Optimization Guide](https://developer.apple.com/app-store/product-page/)
- [Google Play Best Practices](https://developer.android.com/distribute/best-practices)
- [Mobile App Marketing](https://www.apptamin.com/blog)

---

**Need Help?**

If you encounter issues during deployment:

1. Check this guide's troubleshooting section
2. Search [Stack Overflow](https://stackoverflow.com) with error message
3. Check Flutter GitHub issues
4. Contact platform support (Google/Apple)

**Good luck with your launch! 🚀**
