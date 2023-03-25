# studentapp

A student attendance mobile application using flutter. It makes use of state of the art deep learning and facial recognition models.

# Setting up the project

## 1. Download jnilibs directory from the following link

url: https://github.com/YashMakan/face_auth_flutter/tree/master/android/app/src/main/jniLibs

You may use this website to download a github directory. https://download-directory.github.io/

Once the jnilibs folder is downloaded, place it in the android/app/src/main/ folder of your project

## 2. Set the minimum sdk version in the app/build.gradle to 21
defaultConfig {

    ...
    
    minSdkVersion 21
    
    ...
    
}

## 3. Download the assets folder from the link: https://github.com/YashMakan/face_auth_flutter/tree/master/assets
Once the assets folder has been downloaded, place it in the project root directory.

Note: the assets folder should contain 

1. the model named: mobilefacenet.tflite

2. loading file: loading.json





