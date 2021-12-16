import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/actividadModel.dart';
import 'package:health_and_hope/src/screens/actividad/ayudaActividadWidget.dart';
import 'package:health_and_hope/src/screens/actividad/estadoActividadWidget.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/responsive.dart';


class ContenedorListadoActividades extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.all(responsive.ip(2)),
      padding: EdgeInsets.all(responsive.ip(1)),
      width: responsive.width,
      height: responsive.ip(50),
      child: _ListadoActividades(),
      color: Colors.grey.withOpacity(0.1),
    );
  }
}


class _ListadoActividades extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActividadBloc, ActividadState>(
        builder: (context, state) {
          if (state.listActividadesHoy != null) {
            List<ActividadUsuarioModel> valor = state.listActividadesHoy!;
            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: valor.length,
              itemBuilder: (context, int index){
                final actividad = valor[index];
                return (index%2==0)?
                _CajaActividad(color: Color(0xff2CCFE9), actividad: actividad):
                _CajaActividad(color: Color(0xff2CE92C), actividad: actividad);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          } else if (state.listActividadesHoy==null) {
            return Center(
                child: CircularProgressIndicator()
            );
          } else {
            return Container();
          }
        }
    );
  }
}


class _CajaActividad extends StatelessWidget {
  final Color color;
  final ActividadUsuarioModel actividad;

  _CajaActividad({required this.color, required this.actividad});

  BoxDecoration _boxDecorationBase(BuildContext context) {
    final responsive = Responsive.of(context);
    return BoxDecoration(
      border: Border.all(
          width: responsive.ip(0.2),
          color: color
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(responsive.ip(1.5)) //                 <--- border radius here
      ),
    );
  }

  BoxDecoration _boxDecorationContent(BuildContext context) {
    final responsive = Responsive.of(context);
    return BoxDecoration(
      border: Border.all(
          width: responsive.ip(0.2),
          color: color
      ),
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(responsive.ip(1.5)),
        topRight: Radius.circular(responsive.ip(1.5)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyle = TextFontStyle.of(context);
    return Container(
      decoration: _boxDecorationBase(context).copyWith(color: color),
      padding: EdgeInsets.only(left: responsive.ip(2.0)),
      child: Container(
        height: responsive.ip(8),
        padding: EdgeInsets.symmetric(horizontal: responsive.ip(1)),
        decoration: _boxDecorationContent(context).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
        child: Center(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            trailing: GestureDetector(
              onTap: ()=>_onPressedEstadoActividad(context),
              child: _buildIconEstado(context),
            ),
            title: Text(
              '${actividad.actividad!.horaEjecucion!} ${actividad.actividad!.titulo!}',
              style: fontStyle.normalText2,
            ),
            leading: GestureDetector(
              onTap: ()=>_onPressedAyudaActividad(context),
              child: FaIcon(
                FontAwesomeIcons.infoCircle,
                color: Theme.of(context).accentColor,
                size: responsive.ip(4.5),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconEstado(BuildContext context){
    final responsive = Responsive.of(context);

    if(actividad.estadoActividad==null) {
      return BounceInRight(
        child: FaIcon(
          FontAwesomeIcons.solidCircle,
          color: Colors.orange,
          size: responsive.ip(4.5),
        ),
      );
    }

    if (actividad.estadoActividad == ActividadModel.completado){
      return BounceInRight(
        child: FaIcon(
          FontAwesomeIcons.solidGrinBeam,
          color: Colors.orange,
          size: responsive.ip(4.5),
        ),
      );
    }
    else if (actividad.estadoActividad == ActividadModel.enProceso){
      return BounceInRight(
        child: FaIcon(
          FontAwesomeIcons.solidMeh,
          color: Colors.orange,
          size: responsive.ip(4.5),
        ),
      );
    }
    else if (actividad.estadoActividad == ActividadModel.noCompletado){
      return BounceInRight(
        child: FaIcon(
          FontAwesomeIcons.solidSadCry,
          color: Colors.orange,
          size: responsive.ip(4.5),

        ),
      );
    }
    return BounceInRight(
      child: FaIcon(
        FontAwesomeIcons.solidCircle,
        color: Colors.orange,
        size: responsive.ip(4.5),
      ),
    );
  }

  void _onPressedEstadoActividad(BuildContext context) async{
    await SmartDialog.show(
        tag: 'EstadoActividad',
        alignmentTemp: Alignment.center,
        widget: EstadosActividad(actividad: actividad)
    );
  }

  void _onPressedAyudaActividad(BuildContext context) async{
    await SmartDialog.show(
        tag: 'AyudaActividadDialog',
        alignmentTemp: Alignment.center,
        widget: ActividadAyudaWidget(actividad: actividad.actividad!)
    );
  }

}
