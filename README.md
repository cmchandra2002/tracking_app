# App Usage Demo

This Flutter app displays the usage statistics of mobile applications on an Android device. It utilizes the `app_usage` package to fetch app usage data.

## Features

- Fetches and displays app usage statistics for a specified time range.
- Shows the app name, usage time and Last used.

## Getting Started

To run the app on your local machine, follow these steps:

1. Ensure that you have Flutter installed. For installation instructions, refer to the [Flutter documentation](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine using Git or download the ZIP file.

3. Open the project in your preferred IDE (e.g., Android Studio, Visual Studio Code).

4. Install the required dependencies by running the following command in the project directory:

5. Connect an Android device or start an Android emulator.

6. Run the app using the following command:


## Permissions

The app requires the `PACKAGE_USAGE_STATS` permission to access app usage statistics. To grant this permission, follow these steps:

1. Open the `android/app/src/main/AndroidManifest.xml` file.

2. Add the following permission inside the `<manifest>` tag:

```xml
<uses-permission android:name="android.permission.PACKAGE_USAGE_STATS" />

3. Save the file.

## Dependencies

This app uses the app_usage package to fetch app usage statistics.

For more information about the package, refer to its documentation on pub.dev.
