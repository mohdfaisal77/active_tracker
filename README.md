# active_tracker
An action Tracker app is a Flutter application that demonstrates user authentication and inactivity tracking. Users can log in with given dummy credentials, view a welcomed message and receive inactivity warnings.

Feature- 

1. Login/LogOut: Users log in using a username and password which is dummy credentials for testing.
2.Main Screen: Displays a welcome message and a manual logout option.
3. Inactivity Tracker: If the user is inactive for one minute, a warning appears with a 30 second countdwon.
4. Automatic Logout: If there's no interaction during the countdown, the user is automatically logged out.



How to Run- 

-> Clone the repository: 
  git clone https://github.com/mohdfaisal77/active_tracker
  
-> Navigate to the project directory:
   cd active_tracker
   
-> Run the App(as no dependencies were added):
   flutter run



Code Structure- 
->main.dart: Contains the app logic,theme.
->LoginScreen: Contains two textfield and a button for login.
->MainScreen: Conatins a Text and a appBar with logOut Icon and functionality.
