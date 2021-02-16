import 'package:cnc_flutter_app/models/fitness_activity_model.dart';
import 'file:///C:/Workspace/Capstone/cnc_flutter_app/lib/widgets/fitness_tracking_widgets/fitness_tracking_body_widget.dart';
import 'file:///C:/Workspace/Capstone/cnc_flutter_app/lib/widgets/fitness_tracking_widgets/fitness_tracking_popup_modify_activity_widget.dart';
import 'package:flutter/material.dart';


class FitnessTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracking'),
      ),
      body: FitnessTrackingBody(fitnessActivityModelList),//ToDo: swap with db connection

      // MOVED TO FITNESS TRACKING BODY WIDGET
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).accentColor,
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           content: FitnessTrackingPopupInputWidget(new FitnessActivity.emptyConstructor()),
      //         );
      //       }
      //     );
      //   },
      // ),
    );
  }
}

