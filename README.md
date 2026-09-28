# 💬 Flutter Firebase Chat App

A modern, real-time messaging application built with **Flutter**, **Firebase**, and **Clean Architecture**. Designed with an elegant **Glassmorphic UI**, state management using **BLoC/Cubit**, and seamless authentication.

---

##  watch a demo


https://github.com/user-attachments/assets/92935ebb-4202-4089-98c5-f69b93c8b9dc


## ✨ Features

- 🔐 **Google Sign-In Authentication:** Seamless and secure one-click login powered by Firebase Auth and Google Provider.
- 💬 **Real-Time Messaging:** Instant chat capabilities leveraging Cloud Firestore streams.
- 🟢 **Live Online/Offline Status:** Dynamic presence tracking with last seen timestamps formatted smoothly.
- 🎨 **Glassmorphism UI Design:** Stunning translucent UI elements built with `BackdropFilter` and custom gradients.
- 🚀 **Declarative & Named Routing:** Clean navigation setup using `onGenerateRoute` with type-safe argument passing.
- 🏗️ **Clean Architecture & BLoC:** Separation of concerns using `flutter_bloc` (Cubit) for clean, maintainable, and scalable code.

---

## 🛠️ Tech Stack & Architecture

- **Framework:** Flutter (Dart)
- **Backend & Auth:** Firebase Auth, Cloud Firestore
- **State Management:** `flutter_bloc` (Cubit)
- **Architecture Pattern:** Clean Architecture (Data, Domain, Presentation layers)
- **Navigation:** Dynamic Route Management via `AppRouter`

---

## 📂 Project Structure

```text
lib/
├── core/
│   ├── firebase_helper/  # Firebase initialization setup
│   ├── routing/          # AppRouter & AppRoutes management
│   └── theme/            # AppColors, Glassmorphism styles & Theme
├── features/
│   ├── auth/             # Auth feature (Cubit, UI, Google Sign-In button)
│   ├── home/             # Home feature (Users list, CustomUserTile)
│   └── chat/             # Chat feature (ChatCubit, ChatScreen, Messages)
└── main.dart
