// final List<Map<String, dynamic>> _packages = [
//   {
//     'title': 'table_calendar',
//     'description':
//     'The table_calendar package is one of the most popular Flutter packages used to display and manage calendar UIs — it lets you show monthly or weekly calendars, select single or multiple dates, and react to user selections easily.',
//     'screen': const CalenderScreen(),
//   },
//   {
//     'title': 'shimmer',
//     'description':
//     'A package to create shimmer loading animations for placeholders.',
//     'screen': ShimmerScreen(),
//   },
//   {
//     'title': 'carousel_slider',
//     'description':
//     'The package carousel_slider: ^5.1.1 in Flutter is used to create image or widget carousels (sliders) easily. It’s one of the most popular Flutter packages for this purpose because it provides flexible, ready-to-use carousel functionality without writing complex custom code.',
//     'screen': CarouselExample(),
//   },
//   {
//     'title': 'Signature',
//     'description':
//     '''The flutter_signature_pad package is a Flutter plugin that allows you to capture handwritten signatures directly from the user’s touch input — ideal for apps requiring digital authorization, e-signatures, or user consent.
//       ''',
//     'screen': const SignatureScreen(),
//   },
// ];
//
// final List<Map<String, dynamic>> _apiRelated = [
//   {
//     'title': 'http',
//     'description':
//     'Performs network requests (GET, POST, PUT, DELETE) easily in Flutter.',
//     'screen': const PackageDetailScreen(title: 'HTTP'),
//   },
//   {
//     'title': 'shared_preferences',
//     'description':
//     'Stores small persistent data (like user info or theme preferences).',
//     'screen': const PackageDetailScreen(title: 'Shared Preferences'),
//   },
//   {
//     'title': 'flutter_svg',
//     'description':
//     'Renders SVG (Scalable Vector Graphics) easily within Flutter widgets.',
//     'screen': const PackageDetailScreen(title: 'Flutter SVG'),
//   },
// ];
//
// final List<Map<String, dynamic>> _functions = [
//   {
//     'title': 'Selected Star',
//     'description':
//     '💡 Core Concept\nThe star rating system works by: \n Keeping track of how many stars the user selected (_selectedStars).\n Using that number to color the stars (yellow for selected, grey for unselected).\n  Updating the state (setState) every time the user taps a star — this rebuilds the widget to reflect the new selection.\n\nfinal isSelected = index < _selectedStars;\nThat means — for every star before the selected number, color it yellow.',
//     'screen': SelectedStar(),
//   },
//   {
//     'title': 'Dialog',
//     'description':
//     'The resizeToAvoidBottomInset property in a Scaffold controls whether the body of the Scaffold should resize when the on-screen keyboard appears (or when any system inset appears, like a bottom navigation bar or the keyboard).',
//     'screen': const DialogScreen(),
//   },
//   {
//     'title': '+X” container',
//     'description': 'It updates the UI when you tap the “+X” container — ',
//     'screen': const XContainer(),
//   },
//   {
//     'title': 'Keyboard appear size fix',
//     'description':
//     'resizeToAvoidBottomInset : false,\n\nThe resizeToAvoidBottomInset property in a Scaffold controls whether the body of the Scaffold should resize when the on-screen keyboard appears (or when any system inset appears, like a bottom navigation bar or the keyboard).',
//     'screen': const PackageDetailScreen(title: 'resizeToAvoidBottomInset'),
//   },
//   {
//     'title': 'PDF run in WEB View',
//     'description':
//     '''Error:\nAssertion failed:\n"pdf.js not added in web/index.html.\nRun «flutter pub run pdfx:install_web» or add script manually
//       \n\nWhen running on Chrome (Flutter Web), pdfx requires pdf.js to be added to your web project.
//       \nCodes: \n  flutter pub run pdfx:install_web\n  flutter clean\n  flutter pub get\n  flutter run -d chrome''',
//     'screen': const PackageDetailScreen(title: 'resizeToAvoidBottomInset'),
//   },
//   {
//     'title': 'Build APK',
//     'description':
//     '''An APK is the file format used to install apps on Android devices.\n
//       It’s similar to:\n.exe on Windows\n.dmg on macOS\n.ipa on iOS (iPhone apps)
//       \nCodes:  flutter build apk --release --split-per-abi (For frequently use purpose)\nflutter build apk --debug --split-per-abi (Same purpose but quite heavy and slow)\n\n
//       Example: app-arm64-v8a-debug.apk\n And the path to find it ->Project File -> build -> app -> outputs -> flutter-apk -> app-arm64-v8a-debug.apk\n''',
//     'screen': const PackageDetailScreen(title: 'resizeToAvoidBottomInset'),
//   },
//   {
//     'title':
//     'Fetch Project from another Repository or\nChange Project git path ',
//     'description': ''' Check current:\n  git remote -v\n\n
//       Remove old one:\ngit remote remove origin ...(http/ssh link)\n\n
//
//       To change the git repo of Android project:\n  git remote set-url origin ...(http/ssh link)\n\n
//       git pull origin main\ngit pull --rebase origin main\ngit push -u origin main\n\n
//
//       Here Sometimes cause error if there are different commit and files to swap Repo link:\n
//       Problem:\n
//       Argument for @NotNull parameter 'app' of \nio/flutter/run/daemon/FlutterApp.addToEnvironment must not be null\n\n
//       Solved Code: \n git pull origin main --allow-unrelated-histories     (in Terminal)
// ''',
//     'screen': const PackageDetailScreen(title: 'resizeToAvoidBottomInset'),
//   },
//   {
//     'title': 'Off Default Splash Screen',
//     'description':'''Go...\nProject-> android-> app-> src-> main-> res-> values-> </>styles.xml\n\n
//       Write this:  <item name="android:windowDisablePreview">true</item>\n
//          Under <resources> then <style> -> write this code.''',
//     'screen': const PackageDetailScreen(title: 'resizeToAvoidBottomInset'),
//   },
// ];