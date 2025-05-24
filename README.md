# Unit Trust Dividend Calculator

A mobile application built with Flutter to calculate dividends from unit trust investments. This project is designed to be simple, user-friendly, and provide clear calculation breakdowns.

## Current Features

*   **Dividend Calculation:**
    *   Accepts Invested Fund Amount, Annual Dividend Rate (%), and Number of Months Invested (Max 12 months).
    *   Calculates Monthly Dividend using the formula: `(Annual Rate / 12) × Invested Fund`.
    *   Calculates Total Dividend using the formula: `Monthly Dividend × Number of Months`.
*   **Clear Results Display:**
    *   Presents the calculated Monthly Dividend and Total Dividend, formatted to two decimal places with "RM" currency symbol.
*   **Detailed Calculation Breakdown (Optional):**
    *   Users can tap "Show Details" to view:
        *   The inputs used for the calculation.
        *   Step-by-step display of the formulas with the entered values.
    *   This section can be hidden by tapping "Hide Details."
*   **User Interface:**
    *   Clean and intuitive input form.
    *   Responsive design for mobile devices.
    *   Navigation Drawer with "Home" and "About" sections.
    *   **Theme Customization:** Supports both Light and Dark mode, with a toggle switch in the navigation drawer. The current theme is based on a Seafoam Green color palette.
*   **About Page:**
    *   Includes application icon and title.
    *   Displays author information (Name, Matric No, Course).
    *   Contains a copyright notice.
    *   Provides a clickable link to this GitHub repository.
    *   Includes links to author's social media profiles (Instagram, LinkedIn, GitHub).

## Screenshots

*(It's highly recommended to add screenshots here to showcase your app's UI)*

*   **Home Screen (Input):**
*   
    ![image](https://github.com/user-attachments/assets/29bbd10c-1a8c-4efc-aafd-b937e75fe9d1)

*   **Home Screen (Results Summary):**
*   
    ![image](https://github.com/user-attachments/assets/c8ef2342-3037-462f-a5d0-ba228bb2b33d)

*   **Home Screen (Detailed Breakdown Shown):**
*   
    ![image](https://github.com/user-attachments/assets/ef7f26ed-2473-414c-a1b8-6924632ce2d4)

*   **Navigation Drawer (with Theme Toggle):**
*   
    ![image](https://github.com/user-attachments/assets/c3729771-ca74-40a6-8054-ab02c1489890)

*   **About Page:**
*   
    ![image](https://github.com/user-attachments/assets/649e5cbd-1497-48aa-a755-4a23fd8ecc81)


*(Create a `screenshots` folder in your project root and add your images there, then update the paths above or use direct image embedding if your Markdown supports it well.)*

## Technical Details

*   **Framework:** Flutter
*   **Language:** Dart
*   **State Management:** Provider (for theme management)
*   **Key Packages Used:**
    *   `intl`: For number and currency formatting.
    *   `url_launcher`: For opening external links (GitHub, social media).
    *   `provider`: For managing app-wide theme state.
    *   `shared_preferences`: For persisting the chosen theme.
    *   `font_awesome_flutter`: For social media icons on the About page.
*   **Development Environment:** Android Studio / VS Code

## Getting Started

### Prerequisites

*   Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install) (Ensure your version matches the `environment: sdk:` constraint in `pubspec.yaml`)
*   An Android Emulator or a physical Android device.
*   IDE: Android Studio or Visual Studio Code (with Flutter and Dart extensions).

### Installation & Running

1.  **Clone the repository:**
    ```bash
    git clone (https://github.com/jerungpyro/Dividend-Calc-App)
    cd unit_trust_calculator 
    ```

2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the app:**
    Ensure an emulator is running or a device is connected.
    ```bash
    flutter run
    ```

## Future Enhancements (Potential)

*   Saving calculation history.
*   User accounts for personalized data.
*   Advanced charting for dividend progression.
*   *(This section can be updated if/when you add Firebase or other features)*

## Author Information

*   **Name:** [Your Full Name]
*   **Matric No:** [Your Matric No]
*   **Course:** [Your Course Name]

*(Make sure these details are consistent with your `AppConstants` file and About page.)*

## License

This project is licensed under the [Your Chosen License - e.g., MIT License]. See the `LICENSE` file for details.
*(If you haven't chosen a license, MIT is a common and permissive one. Create a `LICENSE` file in your root directory with the license text.)*
