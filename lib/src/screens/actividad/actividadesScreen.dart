import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/screens/actividad/listaActividadesWidget.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:intl/intl.dart';



// var date = DateTime.now();
// // print(DateFormat('EEEE').format(date)); // prints Tuesday
// // print(DateFormat('EEEE, d MMM, yyyy').format(date)); // prints Tuesday, 10 Dec, 2019
// // print(DateFormat('h:mm a').format(date)); // prints 10:02 AM
// // print(DateFormat('h:mm a').format(date)); // prints 10:02 AM
// // print(DateFormat('d').format(date)); // prints 10:02 AM
//
// String dia = DateFormat.EEEE('es_ES').format(date);
// dia = dia[0].toUpperCase()+dia.substring(1, dia.length);
// String fecha = DateFormat.yMMMMd('es_ES').format(date);

class ActividadesUsuarioScreen extends StatelessWidget {
  final TarjetaModificacionModel tarjetaModif;
  static final routeName = 'ActividadesUsuarioScreen';
  const ActividadesUsuarioScreen({required this.tarjetaModif});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActividadBloc>(context, listen: false).add(MisActividadesEvent(
        uidTarjetaModif: tarjetaModif.id??''
    ));

    final responsive = Responsive.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(responsive.ip(2)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: responsive.width, height: responsive.ip(1)),
                _buildDia(context),
                SizedBox(height: responsive.ip(1)),
                _buildDateTimeTitle(context),
                SizedBox(height: responsive.ip(1)),
                ImagenEstadoSemanal(),
                SizedBox(height: responsive.ip(1)),
                ContenedorListadoActividades(),
                SizedBox(height: responsive.ip(2)),
                _ContactarCoachButton(),
                SizedBox(height: responsive.ip(1)),
                _retroceder(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _retroceder(BuildContext context) {
    return ButtonActionWidget(
      // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      text: "Retroceder",
      onPressed: (){
        BlocProvider.of<ProgresoActividadBloc>(context, listen: false).add(MiProgresoActividadEvent());
        Navigator.pop(context);
      },
    );
  }

  Container _buildDia(BuildContext context) {
    final fontStyle = TextFontStyle.of(context);
    final responsive = Responsive.of(context);
    String dia = DateFormat.EEEE('es_ES').format(DateTime.now());
    dia = dia[0].toUpperCase()+dia.substring(1, dia.length);
    // return Container(
    //     width: responsive.width,
    //     child: Text(
    //       'Hoy, $dia',
    //       style: fontStyle.title1,
    //       textAlign: TextAlign.start
    //     )
    // );


    return Container(
      width: responsive.width,
      child: BlocBuilder<ActividadBloc, ActividadState>(
          builder: (context, state) {
            if (state.listActividadesHoy!=null && state.listActividadesHoy!.isNotEmpty) {
              final fechaActividad = DateTime.parse(state.listActividadesHoy![0].actividadFecha!.actividadFecha!);
              String dia = DateFormat.EEEE('es_ES').format(fechaActividad);
              dia = dia[0].toUpperCase()+dia.substring(1, dia.length);
              return Text(
                  'Hoy, $dia',
                  style: fontStyle.title1,
                  textAlign: TextAlign.start
              );
              return Container();
            } else {
              return Container();
            }
          }
      ),
    );
  }

  Container _buildDateTimeTitle(BuildContext context) {
    final fontStyle = TextFontStyle.of(context);
    final responsive = Responsive.of(context);


    return Container(
      width: responsive.width,
      child: BlocBuilder<ActividadBloc, ActividadState>(
        builder: (context, state) {
          if (state.listActividadesHoy!=null) {

            if (state.listActividadesHoy!.isEmpty)
              return Text(
                  'Sin actividades',
                  style: fontStyle.subtitle2,
                  textAlign: TextAlign.center
              );;

            final fechaActividad = DateTime.parse(state.listActividadesHoy![0].actividadFecha!.actividadFecha!);
            String fecha = DateFormat.yMMMMd('es_ES').format(fechaActividad);
            return Text(
                '$fecha',
                style: fontStyle.subtitle2,
                textAlign: TextAlign.center
            );
          } else {
            return Container();
          }
        }
      ),
    );

  }
}


class _ContactarCoachButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ButtonActionWidget(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        text: "Contactar coach",
        onPressed: () => onPressed(context),
    );



  }

  void onPressed (BuildContext context) {
  }
}

class ImagenEstadoSemanal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      height: responsive.ip(5),
      // color: Colors.orange,
    );
  }
}


