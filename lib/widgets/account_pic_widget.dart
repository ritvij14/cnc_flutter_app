import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPic extends StatelessWidget {
  const AccountPic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Theme.of(context).primaryColor,
            child: CircleAvatar(
              radius: 55.0,
              backgroundImage: AssetImage('assets/images/popcat.jpg'),
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                  side: BorderSide(color: Theme.of(context).highlightColor),
                ),
                color:  Theme.of(context).accentColor,
                onPressed: () {},
                child:
                SvgPicture.asset(
                  "assets/icons/Camera Icon.svg",
                  color: Theme.of(context).highlightColor,
                  width: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}