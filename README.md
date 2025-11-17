# 🧠✨ Student Mental Wellness & Peer Support

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.8.1-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![AI](https://img.shields.io/badge/AI_Powered-4285F4?style=for-the-badge&logo=google&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

*A comprehensive mental wellness platform designed specifically for students, combining AI-powered insights, peer support, and mindfulness practices in a beautiful, modern interface.*

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Demo](#-demo-video) • [Download APK](#-download-apk)

</div>

---

## 🌟 Overview

Student Mental Wellness is a cutting-edge Flutter application that revolutionizes how students approach mental health and well-being. Built with modern design principles and powered by advanced AI technology, the app provides a safe, supportive environment for students to track their emotional journey, connect with mentors, and access professional wellness resources.

### 🎯 Mission
To create an accessible, stigma-free platform where students can prioritize their mental health, build resilience, and foster meaningful connections with their peers and mentors.

---

## ✨ Features

### 🤖 AI-Powered Mental Health Analytics
- **Intelligent Mood Tracking**: Advanced 5-point mood logging with contextual insights
- **AI Journal Analysis**: TensorFlow Lite sentiment analysis for journal entries  
- **Personalized Recommendations**: Smart suggestions based on mood patterns and behavior
- **Predictive Insights**: Early warning systems for mental health trends

### 📱 Comprehensive Wellness Dashboard
- **Real-time Mood Visualization**: Beautiful charts and analytics powered by FL Chart
- **Streak Tracking**: Gamified wellness journey with achievement systems
- **Progress Monitoring**: Detailed analytics for mood trends, journal insights, and meditation streaks
- **Motivational Quotes**: Daily inspiration tailored to current emotional state

### 🧘 Mindfulness & Meditation
- **Guided Meditation Sessions**: Sleep meditation, stress relief, focus enhancement
- **Breathing Exercises**: Interactive breathing guides with visual feedback
- **Mindfulness Timer**: Customizable meditation timer with ambient sounds
- **Progress Tracking**: Meditation streak monitoring and habit formation

### 💬 Peer Support Network
- **Real-time Messaging**: Instant chat with typing indicators and read receipts
- **Mentor Connection**: Direct access to trained student mentors and counselors
- **Group Support**: Create and join support groups based on shared experiences
- **Anonymous Chat**: Safe spaces for sensitive conversations

### 📝 Intelligent Journaling
- **AI-Powered Prompts**: Contextual writing prompts based on mood and activities
- **Sentiment Analysis**: Real-time emotional analysis of journal entries
- **Word Cloud Visualization**: Visual representation of emotional themes
- **Export Capabilities**: PDF export for therapy sessions or personal records

### 🎨 Premium User Experience
- **Dark/Light Theme**: Adaptive theming that responds to user mood
- **Glassmorphism Design**: Modern, premium interface with backdrop blur effects
- **Smooth Animations**: Lottie animations and custom transitions throughout
- **Accessibility First**: Full screen reader support and accessibility features

---

## 🏗️ Technology Stack

### Frontend Framework
- **Flutter 3.8.1+** - Cross-platform mobile development
- **Dart** - Primary programming language
- **Material Design 3** - Modern UI components and theming

### State Management & Architecture
- **Riverpod** - Reactive state management solution
- **MVVM Pattern** - Clean architecture with separation of concerns
- **Provider Pattern** - Dependency injection and service locator

### Backend & Cloud Services
- **Firebase Authentication** - Secure user authentication and authorization
- **Cloud Firestore** - Real-time NoSQL database for messaging and user data
- **Firebase ML** - Cloud-based machine learning model deployment
- **Firebase Storage** - Secure file storage for user uploads

### Local Storage & Caching
- **Hive** - High-performance local database for offline functionality
- **Shared Preferences** - Simple key-value storage for user settings
- **Path Provider** - Cross-platform path finding for file operations

### AI & Machine Learning
- **TensorFlow Lite** - On-device sentiment analysis for journal entries
- **Firebase ML Model Downloader** - Dynamic model updates and deployment
- **Custom Sentiment Analysis** - Proprietary algorithms for emotional insights

### UI/UX Libraries
- **Google Fonts** - Beautiful typography with Poppins and Inter fonts
- **FL Chart** - Advanced charting and data visualization
- **Lottie Animations** - Smooth, vector-based animations
- **Staggered Animations** - Elegant list and grid animations

### Notifications & Permissions
- **Flutter Local Notifications** - Cross-platform notification system
- **Permission Handler** - Runtime permission management
- **Timezone** - Accurate time handling for scheduling features

---

## 🎨 UI/UX Design Philosophy

### Design Language
Our design system is built on the principles of **Digital Wellness** and **Emotional Clarity**, featuring:

- **Calming Color Palette**: Carefully selected colors that promote tranquility
  - Primary: Indigo 500 (#6366F1) - Trust and stability
  - Secondary: Purple 500 (#8B5CF6) - Creativity and insight
  - Accent: Cyan 500 (#06B6D4) - Clarity and focus

- **Typography Hierarchy**: 
  - **Poppins**: Headers and titles for modern elegance
  - **Inter**: Body text for exceptional readability

- **Glassmorphism Effects**: Premium backdrop blur and translucent surfaces
- **Micro-interactions**: Subtle animations that provide meaningful feedback
- **Adaptive Theming**: Dynamic color schemes that respond to user mood

### Visual Identity
- **Mood-Responsive Interface**: UI adapts colors and themes based on user's emotional state
- **Breathing Animations**: Subtle, calming animations inspired by mindfulness practices
- **Progressive Disclosure**: Information architecture that prevents cognitive overload
- **Accessibility-First**: WCAG 2.1 compliant with full screen reader support

---

## 🏛️ Architecture Overview

### Project Structure
```
lib/
├── 📁 core/              # Core application logic
│   └── app_router.dart    # Navigation and routing
├── 📁 models/             # Data models and entities
│   ├── user_profile.dart  # User and mentor profiles
│   ├── chat_models.dart   # Messaging system models
│   ├── mood_entry.dart    # Mood tracking models
│   └── journal_entry.dart # Journaling models
├── 📁 services/           # Business logic and data access
│   ├── auth_service.dart  # Authentication management
│   ├── messaging_service.dart  # Real-time messaging
│   ├── ml_service.dart    # AI/ML integrations
│   ├── hive_service.dart  # Local database operations
│   └── journal_analysis_service.dart  # AI journal analysis
├── 📁 providers/          # State management
│   ├── app_providers.dart # Global app state
│   └── mood_theme_provider.dart  # Mood-based theming
├── 📁 pages/              # Screen components
│   ├── 📁 onboarding/     # Welcome and setup flows
│   ├── 📁 auth/           # Login and registration
│   ├── 📁 dashboard/      # Main wellness dashboard
│   ├── 📁 mood/           # Mood tracking features
│   ├── 📁 journal/        # AI-powered journaling
│   ├── 📁 messaging/      # Chat and support system
│   ├── 📁 meditation/     # Mindfulness features
│   ├── 📁 analytics/      # Progress visualization
│   └── 📁 resources/      # Wellness content library
├── 📁 widgets/            # Reusable UI components
├── 📁 theme/              # Design system and theming
└── 📁 main.dart           # Application entry point
```

### Data Flow Architecture
1. **Presentation Layer**: Flutter widgets and pages
2. **State Management**: Riverpod providers for reactive updates
3. **Business Logic**: Service classes handling core functionality
4. **Data Layer**: Firebase Cloud Firestore + Hive local storage
5. **AI Layer**: TensorFlow Lite models for on-device analysis

---

## 🎭 Theme System

### Adaptive Color Schemes
Our advanced theming system responds to user emotions and preferences:

```dart
// Light Theme - Promotes focus and energy
- Background: Slate 50 (#F8FAFC)
- Surface: Pure white with subtle shadows
- Primary: Indigo gradient with premium glass effects

// Dark Theme - Enhances relaxation and reduces eye strain  
- Background: Slate 900 (#0F172A)
- Surface: Slate 800 with backdrop blur
- Primary: Purple gradient with ambient lighting

// Mood-Responsive Themes
- Happy: Warm yellows and oranges
- Calm: Cool blues and teals  
- Energetic: Vibrant greens and lime
- Thoughtful: Deep purples and indigos
```

### Design Tokens
- **Spacing**: 4px base unit system (8, 12, 16, 20, 24px)
- **Border Radius**: Modern rounded corners (12-24px)
- **Shadows**: Layered elevation system with colored shadows
- **Typography**: Fluid type scale with perfect line heights

---

## 📱 Screenshots

*[Screenshots will be inserted here - Beautiful interface showcasing mood tracking, AI journal analysis, meditation timers, and peer messaging]*

### Key Interface Highlights:
- 🏠 **Dashboard**: Mood overview with AI insights and daily inspiration
- 📊 **Analytics**: Comprehensive charts showing emotional patterns  
- 🧘 **Meditation**: Interactive breathing guides with ambient animations
- 💬 **Messaging**: Real-time chat with mentors and peer groups
- 📝 **Journal**: AI-powered writing prompts and sentiment analysis
- 🎯 **Resources**: Curated wellness content and mindfulness exercises

---

## 🚀 Installation & Setup

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart SDK 3.0+
- Android Studio / VS Code with Flutter extensions
- Firebase project configuration

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/student-mental-wellness.git
   cd student-mental-wellness
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   ```bash
   # Install Firebase CLI
   npm install -g firebase-tools
   
   # Login to Firebase
   firebase login
   
   # Configure Flutter for Firebase
   flutterfire configure --project=your-project-id
   ```

4. **Configure AI Models** (Optional)
   ```bash
   # Deploy sentiment analysis model to Firebase ML
   firebase deploy --only ml
   
   # Or place local fallback model in assets/models/
   # and update pubspec.yaml assets section
   ```

5. **Run the application**
   ```bash
   flutter run
   ```

### Environment Setup

Create a `.env` file in the root directory:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
ENABLE_ML_FEATURES=true
DEBUG_MODE=false
```

### Platform-Specific Setup

#### Android
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Permissions: Internet, notifications, camera (optional)

#### iOS  
- Minimum iOS: 12.0
- Required: Camera and notification permissions
- Firebase configuration in `ios/Runner/GoogleService-Info.plist`

---

## Firebase ML Model Setup

1. Install Firebase CLI and configure your Firebase project.
2. Ensure `lib/firebase_options.dart` is generated via FlutterFire and app builds against the project you intend to use.
3. Deploy the sentiment TFLite model using Firebase ML:
   - In Firebase Console → ML → Custom models → Add model
   - Model name: `sentiment_analysis_model`
   - Upload your `sentiment.tflite`
   - Publish the model
4. Optionally bundle a local fallback at `assets/models/sentiment.tflite` and add it to `pubspec.yaml` under `assets:`.
5. On app start, the app attempts Firebase ML first. If Firebase is configured but no model is available, it will throw; otherwise it falls back to a heuristic when Firebase isn't configured.

## Messaging Features Notes

- Unread badges are computed from per-user read state stored in `chat_rooms/{roomId}/read_states/{userId}`.
- Typing indicators are published under `chat_rooms/{roomId}/typing/{userId}` with `isTyping` and `updatedAt`.
- Pagination: messages are streamed with a limit (default 50) and older messages fetched in batches.

---

## 🎥 Demo Video

*[Demo video will be embedded here showcasing the complete app workflow from onboarding through daily usage, highlighting AI features, messaging capabilities, and wellness tracking]*

**Demo Highlights:**
- 🚀 Smooth onboarding experience with mood selection
- 📊 Real-time mood tracking with AI insights
- 🤖 Intelligent journal analysis with sentiment detection
- 💬 Seamless mentor connection and group messaging
- 🧘 Interactive meditation sessions with progress tracking
- 📈 Comprehensive analytics dashboard with beautiful visualizations

---

## 📦 Download APK

### Latest Release (v1.0.0)
*[Download link will be inserted here]*

### System Requirements
- **Android**: 5.0+ (API level 21)
- **Storage**: 100MB available space
- **RAM**: 2GB minimum, 4GB recommended
- **Network**: Internet connection required for real-time features

### Installation Instructions
1. Download the APK file from the link above
2. Enable "Install from Unknown Sources" in Android settings
3. Open the downloaded APK file to begin installation
4. Follow the on-screen instructions
5. Grant necessary permissions when prompted

---

## 🧪 Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run specific test suites
flutter test test/services/          # Service layer tests
flutter test test/widgets/           # UI component tests
flutter test test/models/            # Data model tests

# Run tests with coverage
flutter test --coverage
```

### Test Coverage
- **Services**: Messaging, Authentication, ML Analysis, Local Storage
- **UI Components**: Mood tracking, Journal interface, Analytics charts  
- **Models**: Data validation and serialization
- **Integration**: End-to-end user workflows

### Tests included:
- `test/ml_service_test.dart`: heuristic sentiment checks
- `test/mood_theme_provider_test.dart`: mood-based theme updates
- `test/messaging_hub_widget_test.dart`: tabs/discover UI smoke test

---

## 🔐 Privacy & Security

### Data Protection
- **End-to-End Encryption**: All personal conversations and journal entries
- **Local Storage**: Sensitive data encrypted with Hive secure storage
- **GDPR Compliant**: Full user data control and deletion capabilities
- **Anonymized Analytics**: No personally identifiable information in analytics

### Permissions
- **Camera**: Optional, for profile photos and mood selfies
- **Notifications**: Mental health reminders and peer messages (Android 13+ notifications permission is requested at runtime)
- **Storage**: Local caching of wellness content and offline functionality
- **Internet**: Real-time messaging and cloud synchronization

---

## 🤝 Contributing

We welcome contributions from the community! See our [Contributing Guidelines](CONTRIBUTING.md) for details on:

- 🐛 Bug reports and feature requests
- 🔧 Code contributions and pull requests  
- 📖 Documentation improvements
- 🎨 Design and UX enhancements
- 🧪 Testing and quality assurance

### Development Workflow
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team & Acknowledgments

### Core Development Team
- **Lead Developer**: [Your Name] - Full-stack development and AI integration
- **UI/UX Designer**: [Designer Name] - Design system and user experience
- **Mental Health Consultant**: [Consultant Name] - Clinical guidance and content validation

### Special Thanks
- Mental health professionals who provided clinical guidance
- Student beta testers who shaped the user experience
- Open source contributors and the Flutter community

---

## 📞 Support & Contact

### Get Help
- 📧 **Email**: support@studentwellness.app
- 💬 **Discord**: [Join our community](https://discord.gg/studentwellness)
- 📱 **In-App Support**: Available 24/7 through the help section
- 🌐 **Website**: [studentwellness.app](https://studentwellness.app)

### Crisis Resources
If you're experiencing a mental health crisis, please reach out immediately:
- **National Suicide Prevention Lifeline**: 988
- **Crisis Text Line**: Text HOME to 741741
- **Emergency Services**: 911

---

## 🔮 Roadmap

### Upcoming Features
- 🎯 **AI Mood Prediction**: Proactive mental health insights
- 🏥 **Therapist Integration**: Direct connection with licensed professionals
- 📱 **Apple Watch Support**: Wrist-based mood tracking and breathing reminders
- 🌍 **Multilingual Support**: Expanding accessibility to global student communities
- 🎮 **Gamification**: Wellness challenges and achievement systems
- 📊 **Advanced Analytics**: Machine learning insights for personalized recommendations

### Version History
- **v1.0.0** (Current) - Initial release with core features
- **v1.1.0** (Planned) - Enhanced AI capabilities and group features
- **v2.0.0** (Future) - Professional integration and advanced analytics

---

<div align="center">

**Made with ❤️ for student mental health and well-being**

*Empowering students to prioritize their mental health, one day at a time.*

[![Flutter](https://img.shields.io/badge/Built_with-Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Firebase](https://img.shields.io/badge/Powered_by-Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)](https://firebase.google.com)

</div>
