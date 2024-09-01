# Memo Todo

Memo Todo is a Flutter application designed to help users manage their tasks and categories efficiently. It leverages modern Flutter features and libraries to provide a seamless user experience.

## Table of Contents

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Dependencies](#dependencies)
- [Features](#features)
- [Setup](#setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

Memo Todo is built using Flutter and follows the Model-View-Controller (MVC) architecture. It utilizes Firebase for backend services, including authentication and data storage. The app allows users to manage categories and tasks with functionalities to add, edit, delete, and read data. Additionally, it includes a profile management feature with user profile picture storage.

## Architecture

### Model-View-Controller (MVC)

- **Model**: Represents the data layer, including data models and services.
- **View**: Represents the UI components that display the data to the user.
- **Controller**: Handles the business logic and updates the view based on user interactions.

### State Management

- **Provider**: Used for managing and accessing state across the application. It provides a way to manage state efficiently and update the UI reactively.

## Dependencies

The following dependencies are used in this project:

- **`flutter`**: The framework for building the app.
- **`provider`**: For state management. (Version: `^6.1.2`)
- **`google_fonts`**: For custom text styles. (Version: `^6.2.1`)
- **`firebase_core`**: Initializes Firebase in the Flutter app. (Version: `^2.24.2`)
- **`firebase_auth`**: Provides authentication services for the app. (Version: `^4.16.0`)
- **`cloud_firestore`**: For Cloud Firestore database operations. (Version: `^4.14.0`)
- **`intl`**: For internationalization and date formatting. (Version: `^0.19.0`)
- **`shimmer`**: Provides shimmer effects for loading states. (Version: `^3.0.0`)
- **`cupertino_icons`**: Contains iOS-style icons. (Version: `^1.0.8`)
- **`efenfty_icons`**: Provides custom icons. (Version: `^1.0.7`)
- **`email_validator`**: For validating email addresses. (Version: `^3.0.0`)

### Firebase Services

- **Firebase Authentication**: For user authentication and management.
- **Firebase Firestore**: For storing and retrieving categories and tasks.
- **Firebase Storage**: For storing user profile pictures.

## Features

- **Category Management**:
  - Add, edit, delete, and read categories.
  - Categories are displayed in a grid view with options to add new ones or view existing ones.

- **Task Management**:
  - Add, edit, delete, and read tasks within each category.
  - Tasks are displayed in a list view with detailed information.

- **User Profile**:
  - User profile management with the ability to upload and display profile pictures.
  - Profile section accessible from the side menu.

- **Shimmer Effect**:
  - Provides a shimmer effect for loading states, enhancing the user experience.

