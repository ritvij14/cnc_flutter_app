import 'package:cnc_flutter_app/settings/preferences.dart';
import 'package:flutter/material.dart';
import 'package:cnc_flutter_app/theme/bloc/theme_bloc.dart';
import 'package:cnc_flutter_app/theme/bloc/theme_event.dart';
import 'package:cnc_flutter_app/theme/app_themes.dart';
import 'package:flutter/cupertino.dart';
import '../theme/app_themes.dart';
import '../settings/preferences.dart';
import '../theme/bloc/theme_bloc.dart';
import '../theme/bloc/theme_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PreferenceScreen extends StatelessWidget {
  const PreferenceScreen({Key key}) : super(key: key);



  _setTheme(String selectedTheme, BuildContext context) async {
    AppTheme userTheme;
    if(selectedTheme =="AppTheme.Default") {
      userTheme = AppTheme.Default;
    }else if(selectedTheme =="AppTheme.DarkMode") {
      userTheme = AppTheme.DarkMode;
    }else if(selectedTheme =="AppTheme.PinkLight") {
      userTheme = AppTheme.PinkLight;
    }else if(selectedTheme =="AppTheme.PeriwinkleLight") {
      userTheme = AppTheme.PeriwinkleLight;
    }else if(selectedTheme =="AppTheme.TealLight") {
      userTheme = AppTheme.TealLight;
    }
    context.bloc<ThemeBloc>().add(ThemeEvent(appTheme: userTheme));
    Preferences.saveTheme(userTheme);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Application Preferences'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: AppTheme.values.length,
        itemBuilder: (context, index) {
          // Enums expose their values as a list - perfect for ListView
          // Store the theme for the current ListView item
          final itemAppTheme = AppTheme.values[index];
          return Card(
            // Style the cards with the to-be-selected theme colors
            color: Theme.of(context).primaryColor,
            child: ListTile(
              title: Text(
                itemAppTheme.toString(),
                // To show light text with the dark variants...
                style: Theme.of(context).textTheme.body1,
              ),
              onTap: () {
                // This will make the Bloc output a new ThemeState,
                // which will rebuild the UI because of the BlocBuilder in main.dart
                // BlocProvider.of<ThemeBloc>(context)
                //     .add(ThemeChanged(theme: itemAppTheme));
                // BlocProvider.of<ThemeBloc>(context).dispatch(ThemeChanged(theme: itemAppTheme));
                _setTheme(itemAppTheme.toString(), context);
              },
            ),
          );
        },
      ),
    );
  }
}