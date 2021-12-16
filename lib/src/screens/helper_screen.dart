import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/access/accessScreen.dart';
import 'package:health_and_hope/src/widgets/CustomPage.dart';
import 'package:health_and_hope/src/widgets/slideshow_widget.dart';

class HelpScreen extends StatelessWidget {
  static final routeName = 'helpScreen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    BlocProvider.of<ScreenCustomHelperBloc>(context, listen: false).add(AllScreensHelperEvent());
    final stack = Stack(
      children: [
        Container(
          height: size.height,
          width: size.width,
          child: BlocBuilder<ScreenCustomHelperBloc, ScreenCustomHelperState>(
            builder: (context, state) {
              if (state.listScreenHelper!=null) {
                final listaScreen = state.listScreenHelper!.map((e) => _FormatHelpPage(screenHelperModel: e)).toList();
                return Slideshow(
                  slides: listaScreen,
                  bulletPrimario: 20,
                  colorPrimario: HelpersAppsColors().colorBase,
                );
              } else {
                return Container();
              }
            }
          )
        ),
        Positioned(
          child: _buildButtonsFinish(context),
          top: -3,
          right: 0,
        ),

      ],
    );
    return Scaffold(
      body: SafeArea(
        child: stack,
      )
    );
  }

  Widget _buildButtonsFinish(BuildContext context){
    // final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        child: Text(
          'Continuar',
          style: Theme.of(context).textTheme.button?.copyWith(
            color: HelpersAppsColors().colorBase,
            fontSize: 18,
            decoration: TextDecoration.underline,
          )
        ),
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
          context,
          AccessScreen.routeName,
          (Route<dynamic> route) => false
        )
      )
    );
  }

}



class _FormatHelpPage extends StatelessWidget {
  final ScreenHelperModel screenHelperModel;

  const _FormatHelpPage({Key? key, required this.screenHelperModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPageBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          _buildTitulo(context),
          SizedBox(height: 25),
          _buildImage(),
          SizedBox(height: 25),
          _buildContent(context),
          SizedBox(height: 60),
          // _buildButtonsFinish(context),
        ],
      )
    );
  }
  
  Widget _buildTitulo(BuildContext context){
    final column = Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bienvenido al Programa', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25)),
        Text('Health&Hope', style: Theme.of(context).textTheme.headline5!.copyWith(fontSize: 25, fontWeight: FontWeight.bold)),
      ],
    );
    return Container (
      child: SafeArea(child: column),
    );
  }

  Widget _buildImage(){
    return Container(
      // color: Colors.orange,
      width: double.infinity,
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        child: FadeInImage(
          image: NetworkImage(screenHelperModel.imagen!),
          placeholder: AssetImage('assets/app/gifs/jar-loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context){
    return Container(
      width: double.infinity,
      // color: Colors.orange,
      child: Column (
        children: [
          Text('${screenHelperModel.titulo}', style: Theme.of(context).textTheme.headline4),
          Text(
              '${screenHelperModel.descripcion}',
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyText2
          )
        ],
      )
    );
  }


}
