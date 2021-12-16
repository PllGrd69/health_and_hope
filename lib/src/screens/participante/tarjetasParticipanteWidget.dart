import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/registroTarjetaModifFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/bloc/asistente/asistenteBloc.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/screens/participante/editarTarjetaModificacionScreen.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/rectangleImageWidget.dart';
import 'package:intl/intl.dart';


class ListaDeTarjetasParticipanteWidget extends StatelessWidget {
  final ParticipanteModel participante;
  const ListaDeTarjetasParticipanteWidget({Key? key, required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TarjetaModificacionBloc, TarjetaModificacionState>(
        builder: (context, state) {
          if (state.listTarjetaModificacionParticipante!=null) {
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.listTarjetaModificacionParticipante!.length,
                itemBuilder: (BuildContext context, int index){
                  return _ItemListaPromotores(promotor: state.listTarjetaModificacionParticipante![index]);
                }
            );
          }
          else if (state.listTarjetaModificacionParticipante==null) return Center(child: CircularProgressIndicator());

          return Container();
          
        }
    );

  }
}

class _ItemListaPromotores extends StatelessWidget {
  final TarjetaModificacionModel promotor;
  const _ItemListaPromotores({required this.promotor});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyleText = TextFontStyle.of(context);
    // final usuario = promotor.promotorParticipante!.personalDepartamento!.personal!;
    return Container(
      margin: EdgeInsets.all(responsive.ip(1)),
      child: Stack(
        children: [
          Container(
            width: responsive.ip(20),
            height: responsive.ip(20),
            child: RectangleImageWidget(urlImage: 'assets/app/gifs/ista.gif'),
          ),
          _buildBotonEditYEliminar(responsive, context),
          Container(
            width: responsive.ip(20),
            height: responsive.ip(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.black.withOpacity(0.3),
                  padding: EdgeInsets.all(responsive.ip(0.5)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: responsive.width),
                      Text(
                        '${promotor.titulo}',
                        style: fontStyleText.normalText2.copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Positioned _buildBotonEditYEliminar(Responsive responsive, BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                registroTarjetaModifFormController.cleanData();
                registroTarjetaModifFormController.setTitulo = '${promotor.titulo}';
                registroTarjetaModifFormController.setFechaInicio = DateTime.parse('${promotor.fechaInicio}');
                registroTarjetaModifFormController.setFechaFin = DateTime.parse('${promotor.fechaFin}');
                registroTarjetaModifFormController.setHoraActividadEntrega = TimeOfDay.fromDateTime(DateTime.parse('2012-12-12 ${promotor.horaActividadEntrega}'));
                registroTarjetaModifFormController.setHoraActividadEntregaFin = TimeOfDay.fromDateTime(DateTime.parse('2012-12-12 ${promotor.horaActividadEntregaFin}'));
                Navigator.pushNamed(context, TarjetaModificacionEditarScreen.routeName, arguments: promotor);
              },
              child: Container(
                color: Colors.black.withOpacity(0.3),
                width: responsive.ip(4),
                height: responsive.ip(4),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.edit,
                    size: responsive.ip(3),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: responsive.ip(0.3)),
            GestureDetector(
              onTap: () {
                showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ClassicGeneralDialogWidget(
                      titleText: '¿Estas seguro de eliminar la tarjeta modicacion?',
                      contentText: 'Eliminar ${promotor.titulo}',
                      onPositiveClick: () {
                        BlocProvider.of<TarjetaModificacionBloc>(context).add(
                            EliminarTarjetaParticipanteEvent(idTarjetaModif: promotor.id!)
                        );
                        Navigator.of(context).pop();
                      },
                      positiveText: 'Eliminar',
                      negativeText: 'Cancelar',
                      onNegativeClick: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
              child: Container(
                color: Colors.black.withOpacity(0.3),
                width: responsive.ip(4),
                height: responsive.ip(4),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.times,
                    size: responsive.ip(3),
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}

