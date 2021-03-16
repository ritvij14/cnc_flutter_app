import 'package:cnc_flutter_app/screens/home/activity_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/home/ask_screen.dart';
import 'package:cnc_flutter_app/screens/home/diet_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/home/goal_calendar_screen.dart';
import 'package:cnc_flutter_app/screens/home/home_screen.dart';
import 'package:cnc_flutter_app/screens/home/symptom_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/home/metric_tracking_screen.dart';
import 'package:cnc_flutter_app/screens/login_screen.dart';
import 'package:cnc_flutter_app/screens/navigator_screen.dart';
import 'package:cnc_flutter_app/screens/profile_screen.dart';
import 'package:cnc_flutter_app/screens/summary_screen.dart';
import 'package:cnc_flutter_app/screens/user_questions_screen.dart';
import 'package:cnc_flutter_app/screens/welcome_screen_stepper.dart';
import 'package:cnc_flutter_app/theme/bloc/theme_bloc.dart';
import 'package:cnc_flutter_app/theme/bloc/theme_state.dart';
import 'package:cnc_flutter_app/widgets/activity_tracking_screen_widgets/activity_tracking_input_activity_widget.dart';
import 'package:cnc_flutter_app/widgets/metric_tracking_widgets/metric_tracking_input_metric_widget.dart';
import 'package:cnc_flutter_app/widgets/symptom_tracking_widgets/symptom_tracking_input_symptoms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NutritionApp extends StatelessWidget {
  final String initialRoute;

  const NutritionApp({Key key, this.initialRoute}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (context, projectSnap) {
      return BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState themeState) {
            return MaterialApp(
                initialRoute: initialRoute,
                debugShowCheckedModeBanner: false,
                theme: themeState.themeData,
                routes: {
                  // '/': (context) => NavigatorScreen(),
                  '/login': (context) => LoginScreen(),
                  '/home': (context) => NavigatorScreen(),
                  '/summary': (context) => SummaryScreen(),
                  '/dietTracking': (context) => DietTrackingScreen(),
                  '/fitnessTracking': (context) => ActivityTrackingScreen(),
                  '/symptomTracking': (context) => SymptomTrackingScreen(),
                  '/metricTracking': (context) => MetricTrackingScreen(),
                  '/goals': (context) => CalendarPage(),
                  '/welcome': (context) => WelcomeScreen(),
                  '/inputActivity': (context) => ActivityTrackingInputScreen(),
                  '/inputSymptom' : (context) => SymptomTrackingInputScreen(),
                  '/inputMetric' : (context) => MetricTrackingInputScreen(),
                  '/questions' : (context) => UserQuestionsScreen(),
                  '/profile' : (context) => ProfileScreen(),
                });
          },
        ),
      );
    });
  }
}
