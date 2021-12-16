import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AlertWidget extends StatelessWidget {

  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function onPress;

  const AlertWidget({
    this.icon = FontAwesomeIcons.circle,
    required this.texto,
    this.color1 = Colors.grey,
    this.color2 = Colors.blueGrey,
    required this.onPress
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Opacity(opacity: 0.9,child: _BotonGordoBackground(color1: color1, color2: color2, icon: icon)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140, width: 40),
              FaIcon(/*FontAwesomeIcons.carCrash*/icon, color: Colors.white, size: 40),
              SizedBox(width: 20),
              Expanded(child: Text(texto, style: TextStyle(color: Colors.white))),
              // FaIcon(FontAwesomeIcons.chevronRight, color: Colors.white),
              SizedBox(width: 40),
            ],
          )
        ],
    );
  }
}

class _BotonGordoBackground extends StatelessWidget {

  final IconData icon;
  final Color color1;
  final Color color2;

  const _BotonGordoBackground({
    required this.icon,
    required this.color1,
    required this.color2
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
                right: -20,
                top: -20,
                child: ZoomIn(
                  delay: Duration(milliseconds: 200),
                  child: Roulette(
                    child: FaIcon(
                      icon,
                      size: 150,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
      width: double.infinity,
      margin: EdgeInsets.all(20),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: Offset(4,6),
                blurRadius: 10
            )
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
          )
      ),
    );
  }
}
