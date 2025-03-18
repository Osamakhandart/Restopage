# Restopage: Restaurant Order Management App

## Overview
Welcome to Restopage, the ultimate restaurant order management app designed to simplify how restaurant owners receive and handle customer orders placed through their website. This one-stop solution enables efficient order processing, helps manage workflow, and keeps customers informed every step of the way.

## Key Features

- **Seamless Order Reception**: Instantly receive orders through your website, view incoming orders in real-time, and manage customer preferences seamlessly.

- **Time-Sensitive Order Management**: Accept or decline orders within a 20-minute window to ensure that your kitchen can handle the demand without any miscommunication or delays.

- **Set Preparation Time**: Specify the preparation time for each order, allowing for better kitchen scheduling and customer communication.

- **Automated Email Notifications**: Keep your customers updated with automated emails at each stage of their order — from placement to readiness.

- **Order Management**: View, manage, and cancel orders directly from the app, providing full control over your order flow and preventing service bottlenecks.

- **User-Friendly Interface**: Designed for ease of use, ensuring even those not tech-savvy can navigate and manage the app without hassle.

## Project Structure
Below is the directory structure of the Restopage project:

Restopage/
├── assets
│   └── images
│       └── restologo.jpeg
├── lib
│   ├── api
│   │   ├── api_exception.dart
│   │   ├── api_extension.dart
│   │   ├── api_helpers.dart
│   │   └── repo
│   │       ├── auth_repo.dart
│   │       ├── change_status_repo.dart
│   │       ├── order_repo.dart
│   │       ├── others_repo.dart
│   │       └── status_repo.dart
│   ├── constant
│   │   ├── app_assets.dart
│   │   ├── app_color.dart
│   │   ├── app_string.dart
│   │   └── request_constant.dart
│   ├── controllers
│   │   ├── home_screen_controller.dart
│   │   ├── login_controller.dart
│   │   └── new_test_order_controller.dart
│   ├── firebase_options.dart
│   ├── main.dart
│   ├── models
│   │   ├── about_model.dart
│   │   ├── home_tab_model.dart
│   │   ├── order_model.dart
│   │   ├── reservation_model.dart
│   │   ├── response_item.dart
│   │   ├── resto_open_model.dart
│   │   ├── resturant_timing_model.dart
│   │   ├── term_model.dart
│   │   ├── user_model.dart
│   │   ├── view_all_model.dart
│   │   └── view_order_model.dart
│   ├── theme
│   │   └── app_layout.dart
│   ├── utils
│   │   ├── app_routes.dart
│   │   ├── app_translations.dart
│   │   ├── extension.dart
│   │   ├── printer_class.dart
│   │   ├── push_notification_utils.dart
│   │   └── shared_prefs.dart
│   ├── view
│   │   ├── main
│   │   │   ├── drawer_pages
│   │   │   │   ├── about_pages
│   │   │   │   │   └── about_screen.dart
│   │   │   │   ├── feed_back_pages
│   │   │   │   │   └── feed_back_screen.dart
│   │   │   │   ├── info_pages
│   │   │   │   │   └── info_screen.dart
│   │   │   │   ├── language_pages
│   │   │   │   │   └── language_screen.dart
│   │   │   │   ├── my_account_pages.dart
│   │   │   │   ├── new_test_order_pages
│   │   │   │   │   └── new_test_order_screen.dart
│   │   │   │   └── term_pages
│   │   │   │       └── term_screen.dart
│   │   │   └── home_pages
│   │   │       ├── home_screen.dart
│   │   │       └── home_tabs
│   │   │           ├── accepted_tab
│   │   │           │   ├── accepted_tab.dart
│   │   │           │   ├── accepted_view_screen.dart
│   │   │           │   └── pick_up_time_screen.dart
│   │   │           ├── pending_tab
│   │   │           │   ├── pending_tab.dart
│   │   │           │   └── pending_view_screen.dart
│   │   │           ├── rejected_tab
│   │   │           │   ├── reject_order_screen.dart
│   │   │           │   ├── rejected_tab.dart
│   │   │           │   └── rejected_view_screen.dart
│   │   │           ├── reservation_screen
│   │   │           │   ├── accepted_reservation_screen.dart
│   │   │           │   ├── pending_reservation_screen.dart
│   │   │           │   └── rejected_reservation_screen.dart
│   │   │           ├── status_tab_controller.dart
│   │   │           └── view_all_tab
│   │   │               └── view_all_tab.dart
│   │   ├── splash_screen.dart
│   │   └── startup
│   │       ├── forget_password_pages
│   │       │   └── forget_password_screen.dart
│   │       └── login_pages
│   │           └── login_screen.dart
│   └── widgets
│       ├── app_app_bar.dart
│       ├── app_button.dart
│       ├── app_card.dart
│       ├── app_dropdown_widget.dart
│       ├── app_popup_menu.dart
│       ├── app_progress.dart
│       ├── app_textfield.dart
│       ├── display.dart
│       └── reverse_timer.dart
├── pubspec.lock
├── pubspec.yaml
└── README.md