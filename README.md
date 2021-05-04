# cnc_flutter_app

CNC user application

## Getting Started
Authorization is handled in the "cnc_flutter_app\lib\authorization.dart" file.
Navigation and routing is located primarily in the "cnc_flutter_app\lib\nutrition_app.dart" file.
Target Android SDK is 29
Flutter sdk ">=2.12.0 <3.0.0"
Dart sdk ">=1.24.0-10.1.pre"

##Installation
Use Android Studio powered by Intellij to run locally. Use AVD manager to build a local emulated device for testing.
APIs are handled in the "cnc_flutter_app\lib\connections\..." folder. Located there is a "db_helper_base.dart" file that is extended by other helper classes. This means that most, if not all networking connection changes only need to be made in this file

##Usage
Run from: "cnc_flutter_app\lib\main.dart main()".



