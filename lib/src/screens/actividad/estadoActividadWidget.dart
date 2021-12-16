import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/actividad/actividadBloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/models/actividadModel.dart';
import 'package:health_and_hope/src/models/models/actividadUsuario.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/iconGradientWidget.dart';


class EstadosActividad extends StatelessWidget {
  final ActividadUsuarioModel actividad;
  const EstadosActividad({required this.actividad});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyle = TextFontStyle.of(context);

    return Container(
      width: responsive.width,
      height: responsive.height,
      color: Colors.black.withOpacity(0.5),
      child: Center(
        child: Container(
            width: responsive.ip(35),
            height: responsive.ip(20),
            decoration: _boxDecorationBase(context),
            padding: EdgeInsets.all(responsive.ip(2)),
            child: Column(
              children: [
                SizedBox(width: responsive.width),
                Text('¿Que tal te fue?', style: fontStyle.subtitle2),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          child: _buildImageGradient(responsive.ip(8), FontAwesomeIcons.solidSadCry),
                          onTap: () => cambiarEstadoActividad(context, ActividadModel.noCompletado),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: _buildImageGradient(responsive.ip(8), FontAwesomeIcons.solidMeh),
                          onTap: () => cambiarEstadoActividad(context, ActividadModel.enProceso),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          child: _buildImageGradient(responsive.ip(8), FontAwesomeIcons.solidGrinBeam),
                          onTap: () => cambiarEstadoActividad(context, ActividadModel.completado),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

  void cambiarEstadoActividad(BuildContext context, String uidEstado) async {
    print("-------------------------event------------");
    print(actividad.id);
    final actividadBloc = BlocProvider.of<ActividadBloc>(context, listen: false);
    actividadBloc.add(
        CambiarMiEstadoActividadEvent(
          uuidEstado: uidEstado,
          uuidActividad: actividad.id!
        )
    );
    await SmartDialog.dismiss(tag: 'EstadoActividad');
  }

  Widget _buildImageGradient(double size, IconData icon) {
    return GradientIconWidget(
      icon,
      size,
      LinearGradient(
        colors: [
          Color(0xffff9e03),
          Color(0xffffb300),
          Color(0xfffcc603),
          Color(0xffff9e03),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomRight,
      ),
    );
  }

  BoxDecoration _boxDecorationBase(BuildContext context) {
    final responsive = Responsive.of(context);
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      border: Border.all(
          width: responsive.ip(0.2),
          color: Colors.black
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(responsive.ip(1.5)) //                 <--- border radius here
      ),
    );
  }

}
