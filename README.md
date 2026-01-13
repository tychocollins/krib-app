🏠 Krib — Swipe. Match. Move In.
Krib is a modern, high-energy property discovery app designed to eliminate scroll fatigue. Instead of endless lists, Krib uses a fast-paced, vertical-swipe interface (TikTok-style) to help you find your next home.

🚀 Key Features
Vertical Swipe Feed: A fast, gesture-based way to browse listings. Flick up to "Krib it" (save), flick down to skip.

Krib Neon UI: A high-contrast, dark-mode design system built for 2026 aesthetics.

Real-Time Data: Powered by RentCast & Firebase to ensure you're seeing available homes, not "zombies."

Cross-Platform: Built with Flutter for a seamless experience on Web and Mobile.

🛠️ Tech Stack
Frontend: Flutter (Dart)

Backend: Firebase (Firestore & Auth)

Data API: RentCast

Orchestration: Built using Google Antigravity multi-agent systems.

📦 Getting Started
Prerequisites
Flutter SDK (v3.30 or higher recommended)

A Firebase project setup

RentCast API Key

Installation
Clone the repo:

Bash

git clone https://github.com/tychocollins/krib-app.git
cd krib-app
Install dependencies:

Bash

flutter pub get
Configure Environment: Create a .env or config.dart file in lib/src/config/ and add your API keys:

Dart

const RENTCAST_API_KEY = 'your_key_here';
Run the app:

Bash

flutter run -d chrome
🏗️ Project Structure
This project follows a Feature-First architecture to stay organized:

lib/src/features/feed: The core swiping logic and UI.

lib/src/features/auth: User login and onboarding.

lib/src/data: Repositories and API service wrappers.

lib/src/theme: The "Krib Neon" design system tokens.

🛡️ License
Distributed under the MIT License. See LICENSE for more information.

🤝 Contributing
Krib is currently in active development. If you have ideas for the "Krib Score" or neighborhood "Vibe Checks," feel free to open an issue or submit a PR!
