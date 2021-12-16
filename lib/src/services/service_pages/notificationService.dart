import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/widgets/alertWidget.dart';

class NotificationService {

  static late GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackbar({required String message, int seconds=1, IconData icon = Icons.message_outlined}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: seconds),
      content:  ListTile(
        title: Text(message, style: TextStyle(color: Colors.white, fontSize: 15)),
        leading: Icon(icon, color: Colors.white),
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showMessageNoCredential({required String message, int seconds=1}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: Icons.mobile_off_rounded,
          texto: message,
          color1: Color(0xffc31432),
          color2: Color(0xff240b36),
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageSave({required String message, int seconds=1}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidCheckCircle,
          texto: message,
          color1: Color(0xff2b5876),
          color2: Color(0xff4e4376),
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageNoSave({required String message, int seconds=2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidTimesCircle,
          texto: message,
          color1: Color(0xffc31432),
          color2: Color(0xff240b36),
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }



  /*Actualizacion de muevos toast*/
  static showMessageSadTear({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidSadTear,
          texto: message,
          color1: (color1==null)?Color(0xffc31432) : color1,
          color2: (color2==null)?Color(0xff240b36) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageSurprise({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidSurprise,
          texto: message,
          color1: (color1==null)? Color(0xff30cfd0) : color1,
          color2: (color2==null)? Color(0xff330867) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageSadCry({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidSadCry,
          texto: message,
          color1: (color1==null)? Color(0xffc31432) : color1,
          color2: (color2==null)? Color(0xff240b36) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageGrinBeam({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidGrinBeam,
          texto: message,
          color1: (color1==null)? Color(0xff23074d) : color1,
          color2: (color2==null)? Color(0xffcc5333) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageGrinStars({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidGrinStars,
          texto: message,
          color1: (color1==null)? Color(0xff23074d) : color1,
          color2: (color2==null)? Color(0xffcc5333) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageDizzy({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidDizzy,
          texto: message,
          color1: (color1==null)? Color(0xffc31432) : color1,
          color2: (color2==null)? Color(0xff240b36) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

  static showMessageTired({required String message, int seconds=2, Color? color1, Color? color2}) async {
    await SmartDialog.showToast('',
        widget: _BaseAlert(
          icon: FontAwesomeIcons.solidTired,
          texto: message,
          color1: (color1==null)? Color(0xffc31432) : color1,
          color2: (color2==null)? Color(0xff240b36) : color2,
        ),
        // alignment: Alignment.topCenter,
        time: Duration(seconds: seconds)
    );
  }

}

class _BaseAlert extends StatelessWidget {
  final IconData icon;
  final Color color1;
  final Color color2;
  final String texto;

  const _BaseAlert({required this.icon, required this.color1, required this.color2, required this.texto});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SafeArea(
          child: SlideInDown(
            child: AlertWidget(
              texto: texto,
              color1: color1,
              color2: color2,
              icon: icon/*FontAwesomeIcons.ellipsisV*/,
              onPress: ()=>{}
            ),
            duration: Duration(milliseconds: 800),
          )
        )
      ],
    );
  }
}




class ErrorToast extends StatelessWidget {
  const ErrorToast({Key? key, required this.msg, required this.iconData, required this.color}): super(key: key);
  final String msg;
  final Color color;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    final querySize = MediaQuery.of(context).size;
    final algn = Align(
      // alignment: Alignment.bottomCenter,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              iconData,
              size: 50,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: querySize.width,
            margin: EdgeInsets.only(bottom: 15),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text('$msg', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
          )
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: algn,
    );
  }


}



