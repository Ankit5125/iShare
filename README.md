# 📲 iShare – Fast & Seamless File Sharing ⚡

Welcome to **iShare**, a Flutter app that makes **sharing any type of file** between devices fast, reliable, and simple. From images, videos, PDFs, and music to apps and documents — iShare gives you intuitive UI and smooth performance.

| Home Screen | Send Screen | Receiver Screen | QR Screen |
|-------------|-------------|-----------------|-----------|
| <img src="assets/images/home.png" alt="Home Screen" width="200"/> | <img src="assets/images/send.png" alt="Send Screen" width="200"/> | <img src="assets/images/cat.png" alt="Receiver Screen" width="200"/> | <img src="assets/images/QR.png" alt="QR Screen" width="200"/> |

<img src="assets/images/computer.png" alt="Computer Screen" width="1000"/> 

---

## 📥 Download the App

Try out iShare now!  
Click below to download the latest release:

[![Download iShare](https://img.shields.io/badge/Download%20App-Click%20Here-blue?style=for-the-badge&logo=google-drive)](https://drive.google.com/file/d/1gYu3bLGlLzKXSwzEm8ym-3I3HN7LDkN-/view?usp=sharing)

---

## 🚀 Features

- 📤 **Send Any File Quickly**  
  Share images, videos, documents, audio files, PDFs, apps, and **almost every file format** with just a few taps.

- 📥 **Receive Files Smoothly**  
  Device-to-device transfers with minimal waiting time and clear progress feedback.

- 🎨 **Clean & Minimal UI**  
  Focused on usability; easy to navigate even for first-time users.

- 🔒 **Secure Local Transfers**  
  Files are shared locally (no cloud upload unless you choose); you always control the destination.

*(Future enhancements could include: multiple files at once, transfer history, notifications, dark mode, etc.)*

---

## 🛠️ Tech Stack

| Component | Detail |
|-----------|--------|
| **UI** | Flutter, Dart |
| **State Management** | *(Provider / Riverpod / Bloc – update with what you used)* |
| **File Transfer Logic** | *(Sockets / local Wi-Fi / share_plus / platform channels – update accordingly)* |
| **Asset Management** | Launcher icons, image assets in `assets/` folder |
| **Platforms Supported** | Android, iOS *(Web/Desktop if applicable)* |

---

## 🧑‍💻 Getting Started

To run this project locally:

```bash
# Clone the repository
git clone https://github.com/Ankit5125/iShare.git
cd iShare

# Install dependencies
flutter pub get

# Run the app
flutter run
