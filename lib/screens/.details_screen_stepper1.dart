import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/activity_dropdownButtonFormField_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/birthDate_textFormField_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/cancer_history_forms_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/cancer_treatment_forms_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/dropdown_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/ethnicity_dropdownButtonFormField_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/gIIssues_checkbox_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/height_textFormFiled_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/race_dropdownButtonFormField_widget.dart';
import 'package:cnc_flutter_app/widgets/welcome_screen_widgets/weight_textFormField_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailsScreen1 extends StatefulWidget {
  @override
  _DetailsScreenState1 createState() => _DetailsScreenState1();
}

class _DetailsScreenState1 extends State<DetailsScreen1> {
  List<Step> steps;

  final List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  int currentStep = 0;
  bool complete = false;

  next() {
    if (formKeys[currentStep].currentState.validate()) {
      currentStep + 1 != steps.length
          ? goTo(currentStep + 1)
          : setState(() => complete = true);
      if (complete) {
        // for (int i = 0; i < formKeys.length; i++) {
        //   if (!formKeys[i].currentState.validate()){
        //
        //
        //   }

        submit();
      }
    }
    formKeys[currentStep].currentState.save();
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    // for (int i = 0; i < formKeys.length; i++) {
    //   if (!formKeys[i].currentState.validate()) {
    //     StepState.error;
    //   }
    // }
    setState(() => currentStep = step);
  }

  submit() {
    print("is submitting!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }

  StepState _getState(int i) {
    if (currentStep >= i) {
      return StepState.complete;
    } else {
      // if (formKeys[currentStep].currentState != null && !formKeys[currentStep].currentState.validate()) {
      //   return StepState.error;
      // }
      return StepState.indexed;
    }
  }

  final TextEditingController _ageMonthController = new TextEditingController();
  int userAgeMonth;
  final TextEditingController _ageDayController = new TextEditingController();
  int userAgeDay;
  final TextEditingController _ageYearController = new TextEditingController();
  int userYearMonth;
  final TextEditingController _heightInchesController = new TextEditingController();
  int userInchesHeight;
  final TextEditingController _heightFeetController = new TextEditingController();
  int userFeetHeight;
  final TextEditingController _weightController = new TextEditingController();
  int userWeight;
  final TextEditingController _diagYearController =
  new TextEditingController();
  int userDiagYear;
  final TextEditingController _diagMonthController =
  new TextEditingController();
  int userDiagMonth;

  @override
  void initState() {
    _ageMonthController.text = userAgeMonth.toString();
    _ageDayController.text = userAgeDay.toString();
    _ageYearController.text = userYearMonth.toString();
    _heightFeetController.text = userFeetHeight.toString();
    _heightInchesController.text = userInchesHeight.toString();
    _weightController.text = userWeight.toString();
    _diagYearController.text = userDiagYear.toString();
    _diagMonthController.text = userDiagMonth.toString();
    return super.initState();
  }


  int _ageMonth;
  int _ageDay;
  int _ageYear;
  int _heightFeet;
  int _heightInches;
  int _weight;
  int _yearLastDiag;
  int _monthLastDiag;
  int _counter = 0;

  String dropDownActivity = "Lightly Active";
  String dropDownColon = "Stage 0";
  String dropDownRectum;

  // String dropDownSurgery =" ";

  bool _colon = true;
  bool _rectum = false;
  bool _surgery = true;
  bool _chemo = false;
  bool _radiation = false;


  List<String> _activity = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Vigorously Active',
  ];

  Map<String, bool> surgeryType = {
    'Colectomy': false,
    'Ileostomy': false,
    'Polypectomy': false,
    'Other': false,
  };

  List<String> _cancerStages = [
    'Stage 0',
    'Stage 1',
    'Stage 2',
    'Stage 3',
    'Stage 4',
  ];

  Map<String, bool> frequentIssues = {
    'Abdominal Pain': true,
    'Appetite Loss': true,
    'Bloating': false,
    'Constipation': false,
    "Diarrhea": false,
    'Nausea/Vomiting': false,
    'Stoma Problems': false,
  };


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Create an account'),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stepper(
            steps: steps = <Step>[
              Step(
                state: _getState(1),
                isActive: currentStep >= 0,
                title: const Text('Health and Fitness'),
                content: Container(
                  child: Form(
                    key: formKeys[1],
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("Please enter your weight:",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        WeightFormWidget(controller: _weightController),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                                "What is your usual physical activity level?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        DropdownWidget(list: _activity,
                            dropDownSelect: dropDownActivity,
                            labelText: 'Activity Level',
                            hintText: 'Activity Level'),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(3),
                isActive: currentStep >= 2,
                title: const Text('Gastrointestinal Issues'),
                content: Container(
                  child: Form(
                    key: formKeys[2],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        GIIssuesCheckboxWidget(frequentIssues: frequentIssues),
                      ],
                    ),
                  ),
                ),
              ), Step(
                state: _getState(5),
                isActive: currentStep >= 4,
                title: const Text('Cancer Treatment'),
                content: Container(
                  child: Form(
                    key: formKeys[4],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        CancerTreatmentWidget(surgery: _surgery, chemo: _chemo , radiation: _radiation, surgeryType: surgeryType),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: _getState(4),
                isActive: currentStep >= 3,
                title: const Text('Cancer History'),
                content: Container(
                  child: Form(
                    key: formKeys[3],
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 5),
                        CancerHistoryWidget(yearLastDiag: _yearLastDiag, monthLastDiag: _monthLastDiag, cancerStages: _cancerStages, dropDownColon: dropDownColon,dropDownRectum: dropDownRectum,colon: _colon, rectum: _rectum, monthController: _diagMonthController, yearController: _diagYearController),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                title: const Text('Personal Data'),
                state: _getState(1),
                isActive: currentStep >= 0,
                content: Container(
                  child: Form(
                    key: formKeys[0],
                    child: Column(
                      children: <Widget>[
                        BirthdayFormWidget(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What race are you?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        RaceDropdownWidget(),
                        SizedBox(height: 15),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text("What is your ethnicity?",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        SizedBox(height: 5),
                        // ethnicity,
                        EthnicityDropdownWidget(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            currentStep: currentStep,
            onStepContinue: next,
            onStepTapped: (step) => goTo(step),
            onStepCancel: cancel,
          ),
        ),
      ]),
    );
  }
}
