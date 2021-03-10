import 'package:cnc_flutter_app/connections/weekly_goals_db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// void main() => runApp(GoalCalendar());

//void main() => runApp(ChooseWeeklyGoals());

class ChooseWeeklyGoals extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChooseGoalsPage(title: 'Choose Weekly Goals'),
    );
  }
}

class ChooseGoalsPage extends StatefulWidget {
  ChooseGoalsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ChooseGoalsPageState createState() => _ChooseGoalsPageState();
}

class _ChooseGoalsPageState extends State<ChooseGoalsPage> {
  var db = new WeeklyDBHelper();

  List<String> goals;

  SlidableController slidableController;
  List<_GoalItem> items = List.generate(
    10,
        (i) => _GoalItem(
      i,
      _getTitle(i),
      _getSubtitle(i),
      _getAvatarColor(i),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) => _buildList(
              context,
              orientation == Orientation.portrait
                  ? Axis.vertical
                  : Axis.horizontal),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection =
        direction == Axis.horizontal ? Axis.vertical : Axis.horizontal;

        return _getSlidableWithLists(context, index, slidableDirection);

      },
      itemCount: items.length,
    );
  }

  Widget _getSlidableWithLists(
      BuildContext context, int index, Axis direction) {
    final _GoalItem item = items[index];
    //final int t = index;
    return Slidable(
      key: Key(item.title),
      controller: slidableController,
      direction: direction,
      actionPane: _getActionPane(item.index),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(items[index])
          : HorizontalListItem(items[index]),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Add',
          color: Colors.green,
          icon: Icons.add,
          onTap: () {
            _addGoal(items[index].subtitle);
            print(goals);
            _showSnackBar(context, 'Added Goal to Weekly Goals');
          }
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Add',
          color: Colors.green,
          icon: Icons.add,
          onTap: () {
            _addGoal(items[index].subtitle);
            print(goals);
            _showSnackBar(context, 'Added Goal to Weekly Goals');
          }
        ),
      ],
    );
  }

  _addGoal(String goal) {
    if (goals == null) {
      goals = [];
      goals.add(goal);
    }
    else {
      goals.add(goal);
    }
  }

  static Widget _getActionPane(int index) {
    switch (index % 4) {
      case 0:
        return SlidableBehindActionPane();
      case 1:
        return SlidableStrechActionPane();
      case 2:
        return SlidableScrollActionPane();
      case 3:
        return SlidableDrawerActionPane();
      default:
        return null;
    }
  }

  static Color _getAvatarColor(int index) {
    if(_getTitle(index) == "Fruits") {
      return Colors.orange;
    }
    else if(_getTitle(index) == "Vegetables") {
      return Colors.green;
    }
    else if(_getTitle(index) == "Grains") {
      return Colors.brown;
    }
    else if(_getTitle(index) == "Protein") {
      return Colors.red;
    }
    else if(_getTitle(index) == "Dairy") {
      return Colors.yellow;
    }
    else if(_getTitle(index) == "Snacks") {
      return Colors.purple;
    }
    else if(_getTitle(index) == "Beverages") {
      return Colors.blue;
    }
    else if(_getTitle(index) == "Physical Activity") {
      return Colors.grey;
    }
    else {
      return Colors.black;
    }
  }

  static String _getTitle(int index) {
    if(index < 3) {
      return 'Fruits';
    }
    if(index > 4 && index < 8) {
      return 'Grains';
    }
    else {
      return 'Vegetables';
    }
  }

  static String _getSubtitle(int index) {
    switch (index % 10) {
      case 0:
        return 'Incorporate 3 fruits into a fruit smoothie into your day (1 day)';
      case 1:
        return 'Have 1 serving of fresh fruit in the middle of the day (2 days)';
      case 2:
        return 'Add 2 servings of fresh fruit during your day (2 days)';
      case 3:
        return 'Add 1 serving of berries into your day (3 days) ';
      case 4:
        return 'Eat 1 serving of fresh fruit (5 days)';
      case 5:
        return 'Have 2 servings of non-starchy vegetables into your meals (2 days)';
      case 6:
        return 'Make and eat a salad that you’ve never made before (such as kale, arugula, cabbage) (2 days)';
      case 7:
        return 'Include 2 dark green vegetables for 2 meals (2 days)';
      case 8:
        return 'Eat an orange or yellow vegetable at least once daily (2 days)';
      case 9:
        return 'Prepare two different non-starchy vegetables for 2 meals (5 days)';
      default:
        return null;
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  final _GoalItem item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: item.color,
              child: Text('${item.index+1}'),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.subtitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);
  final _GoalItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
      Slidable.of(context)?.renderingMode == SlidableRenderingMode.none
          ? Slidable.of(context)?.open()
          : Slidable.of(context)?.close(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: item.color,
            foregroundColor: Colors.white,
          ),
          title: Text(item.title),
          subtitle: Text(item.subtitle),
        ),
      ),
    );
  }
}

class _GoalItem {
  _GoalItem(
      this.index,
      this.title,
      this.subtitle,
      this.color,
      );

  int index;
  String title;
  String subtitle;
  Color color;
}