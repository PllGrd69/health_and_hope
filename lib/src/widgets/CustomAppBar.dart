import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/utils/responsive.dart';

class CustomAppBarPage extends StatelessWidget {
  const CustomAppBarPage({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _CustomAppBar(),
        SliverList(
          delegate: SliverChildListDelegate(
              children
          )
        ),
      ],
    );
  }
}



class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final flexibleSpaceBar = FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          padding: EdgeInsets.only(bottom: 15, left: 10, right: 10),
          // color: Colors.black12,
          // child: Text('Salud y Esperanza')
          // child: Container()
        ),
        background: Container(
          padding: EdgeInsets.only(
            top: responsive.ip(4),
            left: responsive.ip(4),
            right: responsive.ip(4),
            bottom: responsive.ip(1),
          ),
          child: Image(
            image: AssetImage('assets/images/handh_logo.png'),
          ),
          decoration: buildBoxDecoration(responsive),
        )

    );

    return SliverAppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      expandedHeight: responsive.ip(25),
      floating: false,
      pinned: false,
      flexibleSpace: flexibleSpaceBar,
    );
  }

  BoxDecoration buildBoxDecoration(Responsive responsive) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          HelpersAppsColors().colorBase,
          HelpersAppsColors().colorBase,
        ]
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(responsive.ip(3.0)),
        bottomRight: Radius.circular(responsive.ip(3.0)),
      )
    );
  }
}