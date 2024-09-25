import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_project_login/screens/login_screen.dart';

import '../utils/app_strings.dart';


class MainScreen extends StatefulWidget {
  final String userName;

  MainScreen({required this.userName});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Timer? inactivityTimer;
  Timer? warningTimer;
  int countdownSeconds = 30;
  bool showWarning = false;

  @override
  void initState() {
    super.initState();
    _resetInactivityTimer();
  }

  void _resetInactivityTimer() {
    inactivityTimer?.cancel();
    inactivityTimer = Timer(Duration(minutes: 1), _showWarning);
  }

  void _showWarning() {
    setState(() {
      showWarning = true;
      countdownSeconds = 30; // Reset countdown to 30 seconds
    });
    _startCountdown();
  }

  void _logout() {
    inactivityTimer?.cancel();
    warningTimer?.cancel();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _startCountdown() {
    warningTimer?.cancel();
    warningTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdownSeconds > 0) {
          countdownSeconds--;
        } else {
          _logout();
          timer.cancel();
        }
      });
    });
  }

  void _onUserInteraction() {
    _resetInactivityTimer();

    if (showWarning) {
      setState(() {
        showWarning = false; // Hide warning
      });
      warningTimer?.cancel(); // Cancel the countdown timer

      // Restart the warning after 30 seconds
      // Future.delayed(Duration(seconds: 30), () {
      //   if (mounted) {
      //     _showWarning(); // Show warning again after 30 seconds
      //   }
      // });
    }
  }

  @override
  void dispose() {
    inactivityTimer?.cancel();
    warningTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return GestureDetector(
      onTap: _onUserInteraction,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.main_screen),
          backgroundColor: Colors.teal,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome ${widget.userName}',
                  style: TextStyle(
                 color: Colors.black,
                 fontWeight: FontWeight.bold,
                 fontSize: 32
               ),
              ),
              SizedBox(height: height * 0.05,),
              if (showWarning)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'You have been inactive. You will be logged out in $countdownSeconds seconds unless you interact.',
                    textAlign: TextAlign.center,style:TextStyle(color: Colors.black,fontSize: 12,
                     fontWeight: FontWeight.w300,
                     fontStyle: FontStyle.italic),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}






// class MainScreen extends StatefulWidget {
//   final String userName;
//   const MainScreen({ required this.userName, super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//
//   Timer? _inactiveTimer;
//   Timer? _warningTimer;
//   bool _isWarningShown=false;
//   int _warningDuration = 30;
//
//
//   final int _inactivityDuration = 60;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     _startInactivityTimer();
//   }
//
//   void _startInactivityTimer(){
//     _inactiveTimer?.cancel();
//     _inactiveTimer = Timer(Duration(seconds:  _inactivityDuration), _showWarning);
//   }
//
//   void _showWarning(){
//     setState(() {
//       _isWarningShown=true;
//
//
//     });
//     _startWarningTimer();
//   }
//
//   void _startWarningTimer(){
//     _warningTimer?.cancel();
//     _warningDuration =30;
//
//     _warningTimer =Timer.periodic(Duration(seconds: 1), (timer) {
//
//       setState(() {
//         _warningDuration --;
//       });
//       if(_warningDuration <=0){
//         _logout();
//       }
//     });
//
//   }
//
//   void _resetTimers(){
//     _startInactivityTimer();
//     if(_isWarningShown){
//       setState(() {
//         _warningDuration=30;
//       });
//       _warningTimer?.cancel();
//       _startWarningTimer();
//     }
//   }
//
//   void _logout(){
//     _inactiveTimer?.cancel();
//     _warningTimer?.cancel();
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
//   }
//
//   @override
//   void dispose() {
//   _inactiveTimer?.cancel();
//   _warningTimer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height * 1;
//     return GestureDetector(
//       onTap: _resetTimers,
//       onPanUpdate: (_)=> _resetTimers(),
//       child: Scaffold(
//         appBar: AppBar(
//
//           title: Text(AppStrings.main_screen,),
//           backgroundColor: Colors.teal,
//           actions: [
//             IconButton(onPressed: _logout, icon: Icon(Icons.logout))
//           ],
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text('Welcome ${widget.userName}',style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 32
//               ),),
//               SizedBox(height: height * 0.05,),
//               if(_isWarningShown) ...[
//                 Text(AppStrings.inactive_text,style: TextStyle(
//                   color: Colors.black,fontSize: 12,
//                   fontWeight: FontWeight.w300,
//                   fontStyle: FontStyle.italic
//                 ),),
//                 SizedBox(height: height * 0.02,),
//                 Text('You will be logged out in $_warningDuration seconds unless you interact with screen',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 12,
//                     fontWeight: FontWeight.w300,
//                     fontStyle: FontStyle.italic),)
//               ]
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
