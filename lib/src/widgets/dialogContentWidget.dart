import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_and_hope/src/utils/responsive.dart';

class ModalBaseCustomWidget extends StatelessWidget {
  final List<Widget> children;
  const ModalBaseCustomWidget({required this.children});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final container =  Container(
        height: responsive.ip(45),
        width: responsive.ip(30),
        color: Colors.black.withOpacity(0.15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(responsive.ip(1.2)),
              color: Colors.black.withOpacity(0.5),
              child: Column(
                children: children,
              ),
            )
          ],
        )
    );

    return Stack(
        children: [
          Positioned(
            top: responsive.ip(2),
            right: responsive.ip(2),
            child: Pulse(
              infinite: true,
              child: Roulette(
                infinite: true,
                child: SvgPicture.asset(
                  'assets/app/svg/planeta.svg',
                  height: responsive.ip(10),
                  semanticsLabel: 'Acme Logo',
                  width: responsive.ip(10),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            top: responsive.ip(6),
            left: 0,
            child: SvgPicture.asset(
              'assets/app/svg/cloud.svg',
              height: responsive.ip(21),
              semanticsLabel: 'Acme Logo',
              width: responsive.ip(21),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: responsive.ip(6)*-1,
            bottom: responsive.ip(4)*-1,
            child: SvgPicture.asset(
              'assets/app/svg/calle.svg',
              height: responsive.ip(30),
              semanticsLabel: 'Acme Logo',
              width: responsive.ip(30),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: responsive.ip(10),
            bottom: 0,
            child: FadeInLeft(
              from: 400,
              duration: Duration(seconds: 20),
              child: Swing(
                infinite: true,
                child: SvgPicture.asset(
                  'assets/app/svg/perrito.svg',
                  height: responsive.ip(5),
                  semanticsLabel: 'Acme Logo',
                  width: responsive.ip(5),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Bounce(
              infinite: true,
              child: SvgPicture.asset(
                'assets/app/svg/mujer.svg',
                height: responsive.ip(21),
                semanticsLabel: 'Acme Logo',
                width: responsive.ip(21),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Bounce(
              infinite: true,
              delay: Duration(seconds: 1),
              child: SvgPicture.asset(
                'assets/app/svg/varon.svg',
                height: responsive.ip(21),
                semanticsLabel: 'Acme Logo',
                width: responsive.ip(21),
                fit: BoxFit.contain,
              ),
            ),
          ),
          container
        ]
    );
  }

}

