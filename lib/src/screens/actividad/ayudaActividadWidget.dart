import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:health_and_hope/src/bloc/actividadAyuda/actividadAyudaBloc.dart';
import 'package:health_and_hope/src/models/models/actividadAyudaModel.dart';
import 'package:health_and_hope/src/models/models/actividadModel.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';

class ActividadAyudaWidget extends StatelessWidget {
  final ActividadModel actividad;
  const ActividadAyudaWidget({required this.actividad});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActividadAyudaBloc>(context, listen: false).add(MisActividadesAyudaEvent(uuidActividad: actividad.id!));
    final responsive = Responsive.of(context);

    final swipersImgs =  BlocBuilder<ActividadAyudaBloc, ActividadAyudaState>(
        builder: (context, state) {
          if (state.listActividadesAyuda!=null) {
            return Swiper(
              itemBuilder: (BuildContext context, int index) {
                return _BaseAyudaActividad(actividadAyuda: state.listActividadesAyuda![index]);
              },
              itemCount: state.listActividadesAyuda!.length,
              scale: 0.8,
            );
          } else if (state.listActividadesAyuda ==null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        }
    );

    return Container(
      width: responsive.ip(35),
      height: responsive.ip(50),
      child: swipersImgs,
    );
  }

}


class _BaseAyudaActividad extends StatefulWidget {
  final ActividadAyudaModel actividadAyuda;
  const _BaseAyudaActividad({required this.actividadAyuda});

  @override
  __BaseAyudaActividadState createState() => __BaseAyudaActividadState();
}

class __BaseAyudaActividadState extends State<_BaseAyudaActividad> {
  bool mostrar = false;
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.all(responsive.ip(2)),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          _buildImageBase(responsive),
          _buildContenidoTexto(context),
        ],
      )
    );
  }

  ClipRRect _buildContenidoTexto(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyle = TextFontStyle.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(responsive.ip(2)),
        bottomLeft: Radius.circular(responsive.ip(2))
      ),
      child: FadeInUp(
        child: Container(
          padding: EdgeInsets.all(responsive.ip(2)),
          width: responsive.ip(35),
          color: Colors.black.withOpacity(0.65),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DefaultTextStyle(
                style: fontStyle.title2.copyWith(color: Colors.white),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      widget.actividadAyuda.titulo!,
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 120)
                    ),
                  ],
                  totalRepeatCount: 1,
                  onFinished: (){
                    setState(() {
                      mostrar = true;
                    });
                  },
                ),
              ),
              SizedBox(height: responsive.ip(1)),
              Visibility(
                visible: mostrar,
                child: DefaultTextStyle(
                  style: fontStyle.normalText1.copyWith(color: Colors.white),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        widget.actividadAyuda.descripcion!,
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: 120),
                      ),
                    ],
                    totalRepeatCount: 1,
                  ),
                ),
              ),
              // Text(actividadAyuda.descripcion!, style: fontStyle.normalText1.copyWith(color: Colors.white), textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }

  ClipRRect _buildImageBase(Responsive responsive) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(responsive.ip(2))),
      child: Container(
        color: Colors.black.withOpacity(0.3),
        width: responsive.ip(35),
        height: responsive.ip(50),
        child: FadeInImage(
          image: NetworkImage(
            widget.actividadAyuda.imagen!
            // 'https://mejorconsalud.as.com/wp-content/uploads/2015/03/ormas-para-beber-agua-menos-aburrido-640x640.jpg',
          ),
          placeholder: AssetImage(
            'assets/app/gifs/jar-loading.gif',
          ),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/app/gifs/pato.gif',
              fit: BoxFit.cover,
            );
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
