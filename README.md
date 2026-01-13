# 🏠 Krib — Swipe. Match. Move In.

> **The Modern App For Real Estate.** A high-energy, vertical-swipe discovery app designed to eliminate scroll fatigue and help you find your next home in seconds.

---

## 🚀 Key Features
* **Vertical Swipe Feed:** A fast-paced, gesture-based interface. Flick **up** to "Krib it" (save) and **down** to skip.
* **Krib Neon UI:** A high-contrast, dark-mode design system with electric green accents.
* **Real-Time Data:** Direct integration with **RentCast** and **Firebase** for live property listings.
* **Agentic Development:** Built using Google Antigravity’s multi-agent orchestration.

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend** | [Flutter](https://flutter.dev) (Dart) |
| **Backend** | [Firebase](https://firebase.google.com) (Firestore & Auth) |
| **Data API** | [RentCast API](https://www.rentcast.io/api) |
| **Workflow** | Google Antigravity |

---

## 📦 Getting Started

### Prerequisites
* **Flutter SDK**: `v3.30+`
* **Firebase Project**: Firestore & Auth enabled.
* **RentCast API Key**: [Get your key here](https://www.rentcast.io/api).

##🏗️ Project Structure

lib/src/
├── features/
│   ├── feed/          # Swiping logic & TikTok-style UI
│   └── auth/          # User login & onboarding
├── data/              # API services & repositories
└── theme/             # Krib Neon styling & colors


To make a GitHub README look great, you need to use **Markdown syntax** specifically. If you just paste plain text, GitHub won't know how to format it with bold titles, tables, or code boxes.

Here is the "Correct" version. You can copy this entire block and paste it directly into your `README.md` file on GitHub or in Antigravity.

---

```markdown
# 🏠 Krib — Swipe. Match. Move In.

> **The TikTok of Real Estate.** A high-energy, vertical-swipe discovery app designed to eliminate scroll fatigue and help you find your next home in seconds.

---

## 🚀 Key Features
* **Vertical Swipe Feed:** A fast-paced, gesture-based interface. Flick **up** to "Krib it" (save) and **down** to skip.
* **Krib Neon UI:** A high-contrast, dark-mode design system with electric green accents.
* **Real-Time Data:** Direct integration with **RentCast** and **Firebase** for live property listings.
* **Agentic Development:** Built using Google Antigravity’s multi-agent orchestration.

---

## 🛠️ Tech Stack

| Layer | Technology |
| :--- | :--- |
| **Frontend** | [Flutter](https://flutter.dev) (Dart) |
| **Backend** | [Firebase](https://firebase.google.com) (Firestore & Auth) |
| **Data API** | [RentCast API](https://www.rentcast.io/api) |
| **Workflow** | Google Antigravity |

---

## 📦 Getting Started

### Prerequisites
* **Flutter SDK**: `v3.30+`
* **Firebase Project**: Firestore & Auth enabled.
* **RentCast API Key**: [Get your key here](https://www.rentcast.io/api).

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/tychocollins/krib-app.git](https://github.com/tychocollins/krib-app.git)
   cd krib-app

```

2. **Install dependencies:**
```bash
flutter pub get

```


3. **Configure Environment:** Create a file at `lib/src/config/config.dart` and add your keys:
```dart
const RENTCAST_API_KEY = 'your_key_here';

```


4. **Run the app:**
```bash
flutter run -d chrome

```



---

## 🏗️ Project Structure

```text
lib/src/
├── features/
│   ├── feed/          # Swiping logic & TikTok-style UI
│   └── auth/          # User login & onboarding
├── data/              # API services & repositories
└── theme/             # Krib Neon styling & colors

```

---

## 🤝 Contributing

Have ideas for a "Krib Score" or neighborhood "Vibe Checks"?

1. Fork the Project.
2. Create your Feature Branch (`git checkout -b feature/NewVibe`).
3. Commit your Changes (`git commit -m 'Add NewVibe'`).
4. Push to the Branch (`git push origin feature/NewVibe`).
5. Open a Pull Request.

---

## 🛡️ License

Distributed under the **MIT License**. See `LICENSE` for more information.

```
---

### Why this looks better:
1.  **Code Blocks:** Using ` ```bash ` creates those nice dark boxes with the "Copy" button on GitHub.
2.  **Tables:** The `| Layer | Technology |` section creates a clean grid that is easy for recruiters or other developers to scan.
3.  **Visual Hierarchy:** The `#` and `##` create different sized headers, which GitHub uses to automatically generate a Table of Contents for your page.
4.  **Blockquotes:** The `>` at the top adds that stylish "Tagline" look.

**Would you like me to also generate a "LICENSE" file for your repo so it looks even more official?**

```
