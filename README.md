# GeminiMultimodal-iOS

# Multimodal iOS App with Gemini AI

This project is an iOS application integrating Gemini AI, utilizing both Gemini-Pro (text-based input/output) and Gemini-Pro-Vision (text and image-based input/output). The app features a user-friendly interface developed with SwiftUI.

## Features

- **Text-Based Input/Output**: Interact with Gemini-Pro for text-based input and responses.
- **Image-Based Input/Output**: Utilize Gemini-Pro-Vision for processing images and receiving appropriate responses.
- **SwiftUI Interface**: A sleek and responsive user interface built with SwiftUI.
- **Full Integration**: Seamless integration with Gemini AI's official SDKs and APIs.

## Installation

1. **Clone the repository**:
   
2. **Install dependencies**:
    Open the project in Xcode. It should automatically resolve the dependencies via Swift Package Manager (SPM).
   
4. **Set up Gemini AI SDK**:
    - Follow the official Gemini AI Docs to obtain your API keys and set up the SDK.
    - Add your API keys and any necessary configuration to the project settings.

5. **Build and run**:
    - Select your target device or simulator in Xcode.
    - Press `Cmd+R` or click the Run button to build and run the app.

## Usage

1. **Text Input/Output**:
    - Navigate to the text interaction screen.
    - Enter your query in the text field and submit.
    - View the response from Gemini-Pro.

2. **Image Input/Output**:
    - Navigate to the image interaction screen.
    - Capture or select an image from your device.
    - Submit the image to receive a response from Gemini-Pro-Vision.

## Project Structure

- `GeminiAIIntegration`: Contains the logic for integrating with Gemini AI's SDKs.
- `Views`: SwiftUI views for the app's user interface.
- `Models`: Data models used in the app.
- `ViewModels`: View models for managing the data flow between models and views.
- `Resources`: Assets and other resources used in the app.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes. Make sure to follow the coding standards and add relevant tests for any new features.

