# Plant Disease Detection
A Flutter-based mobile application developed as a Final Year Project for detecting plant diseases from leaf images using a Deep Learning Convolutional Neural Network (CNN) and a TensorFlow Lite model.
The application allows users to capture a plant leaf image using the camera or select an image from the gallery. The image is then processed by an on-device TensorFlow Lite model to predict the plant disease and display the prediction confidence.

## Features
- Plant disease detection from leaf images
- Capture images using the device camera
- Select images from the gallery
- TensorFlow Lite model integration
- 38 plant disease and healthy plant classes
- Prediction confidence display
- User registration and login using Firebase Authentication
- Prediction history stored in Cloud Firestore
- Guest detection mode without login

## Technologies Used
- Python
- Flutter
- Dart
- TensorFlow
- TensorFlow Lite
- Keras
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Google Colab

## Machine Learning Model
The machine learning model was trained in Google Colab using TensorFlow and Keras.
The training notebook is included in:
`notebooks/Plant_Diseases_Detection.ipynb`
The dataset contains:
- 43,444 training images
- 10,861 validation images
- 38 classes

Data augmentation is applied during training.
The model was trained for 10 epochs. The recorded validation accuracy reached approximately 94.24% during training.
After training, the model was converted to TensorFlow Lite format:
`assets/plant_disease_model.tflite`

The Flutter application uses this model for on-device plant disease classification.

## Application Flow
1. Launch the application
2. Register, log in, or continue as a guest
3. Capture a leaf image or choose one from the gallery
4. Run the image through the TensorFlow Lite model
5. Display the predicted disease and confidence
6. Save prediction history for authenticated users

## Project Structur
```text
android/      Android application files
assets/       TensorFlow Lite model, class labels, and application images
ios/          iOS application files
lib/          Flutter application source code
notebooks/    Machine learning training notebook
test/         Flutter tests
web/          Flutter web files
```
Important project assets include:
```text
assets/plant_disease_model.tflite
assets/plant_labels.txt
assets/pdback.png
```

## Flutter Dependencies
The project uses packages for image selection, camera access, TensorFlow Lite inference, Firebase authentication, Firebase storage, Cloud Firestore, state management, and UI loading indicators.

## Running the Project
1. Install Flutter.
2. Clone this repository.
3. Open the project directory.
4. Install the required dependencies:

```bash
flutter pub get
```

5. Configure Firebase for the target platform if required.
6. Connect a device or start an emulator.
7. Run the application:

```bash
flutter run
```

## Final Year Project
This repository contains the Flutter mobile application, trained TensorFlow Lite model, class labels, and the original machine learning training notebook used for the Plant Disease Detection Final Year Project.