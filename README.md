# 🏃‍♂️ RunMatch
### Real-Time Running Match & Pace Battle App (iOS)

> 🌍 **Global-ready prototype for real-time competitive running**  
> Match instantly with runners worldwide and race in a live 5km pace challenge.

---

## 📱 Screenshots
- Home  
- Matching  
- Live Race  
- Results  
- Leaderboard  
- Rival Discovery  
- Real-time Progress Tracking  
- Global Rankings  

---

## ✨ Key Features

### 🎯 Real-Time Matching
- **Auto Matching** – Pairs runners with similar performance levels  
- **Live Match Rooms** – Instantly join ongoing challenges  
- **Matching Progress Indicator** – Visual feedback during matchmaking  

---

### 🏁 Interactive Racing Experience
- **Live Distance Comparison** – Real-time progress between runners  
- **Animated Race Track** – Visual representation of the race  
- **Live Stats** – Pace, elapsed time, and reward pool updates  
- **Race Controls** – Pause or exit the race at any time  

---

### 🏆 Leaderboard System
- **Global Rankings** – View worldwide runner standings  
- **Top 3 Medals** – Gold, Silver, Bronze highlights  
- **Personal Stats** – Win rate, points, and rank overview  
- **User Highlighting** – Your position emphasized in rankings  

---

### 💰 Points & Rewards
- **Victory Rewards** – Earn points by winning races  
- **Instant Claim** – Claim rewards directly after a race  
- **Real-Time Balance** – Track points from the home screen  

---

### 📊 User Statistics
- **Active Runners Online**  
- **Personal Win Rate**  
- **Recent Match History**  

---

## 🛠 Tech Stack

### Frameworks & Language
- **SwiftUI** – 100% declarative UI  
- **Swift 5.9** – Modern Swift language features  
- **Combine** – Reactive state management  

### Architecture
- **MVVM** – Clear separation of view and business logic  
- **ObservableObject** for state-driven UI updates  
- **Timer-based race simulation** (prototype logic)  

### Design
- Custom color system with HEX support  
- Animated UI interactions (ScaleButtonStyle, race track animation)  
- Neon-inspired dark theme  

---

## 📦 Installation

### Requirements
- Xcode 14.0 or later  
- iOS 15.0 or later  
- macOS Monterey or later  

### Setup

```bash
git clone https://github.com/yourusername/RunMatch.git
cd RunMatch
open RunMatch.xcodeproj
```

---

### 🎮 How It Works

### 1. Home
- Start a new match  
- Join live match rooms  
- Access global leaderboards  

### 2. Matching
- Automatically finds an optimal rival  
- Displays matching progress  
- Cancel at any time  

### 3. Racing
- Elapsed time displayed at the top  
- Real-time distance comparison  
- Interactive track visualization  
- Pause / Resume / Exit controls  

### 4. Results
- Victory message and earned points  
- Total time and average pace  
- Claim reward button  

### 5. Leaderboard
- Global ranking list  
- Highlighted personal position  
- Return to home screen  

---

## 🏗 Project Structure

```text
RunMatch/
├── ContentView.swift
├── ViewModels/
│   └── RunMatchViewModel.swift
├── Views/
│   ├── HomeScreen.swift
│   ├── MatchingScreen.swift
│   ├── RacingScreen.swift
│   ├── ResultScreen.swift
│   └── LeaderboardScreen.swift
├── Components/
│   ├── StatCard.swift
│   ├── MatchRoomCard.swift
│   └── RankingCard.swift
└── Utilities/
    ├── Color+Hex.swift
    └── ButtonStyles.swift
