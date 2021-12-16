import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/bloc/asistente/asistenteBloc.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/rectangleImageWidget.dart';


class ListaDeAistentesWidget extends StatelessWidget {
  final ParticipanteModel participante;
  const ListaDeAistentesWidget({Key? key, required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AsistenteBloc, AsistenteState>(
      builder: (context, state) {
        if (state.listAsistenteParticipante!=null) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.listAsistenteParticipante!.length,
            itemBuilder: (BuildContext context, int index){
              return _ItemListaAsistente(asistente: state.listAsistenteParticipante![index], participante: participante);
            }
          );
        }
        else if (state.listAsistenteParticipante==null) return Center(child: CircularProgressIndicator());
        return Container();
      }
    );
  }
}

class _ItemListaAsistente extends StatelessWidget {
  final AsistenteModel asistente;
  final ParticipanteModel participante;
  const _ItemListaAsistente({required this.asistente, required this.participante});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyleText = TextFontStyle.of(context);
    final usuario = asistente.asistente!;
    return Container(
      margin: EdgeInsets.all(responsive.ip(1)),
      child: Stack(
        children: [
          Container(
            width: responsive.ip(20),
            height: responsive.ip(20),
            child: RectangleImageWidget(urlImage: usuario.avatar),
          ),
          _buildBotonEliminar(responsive, context),
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
                      Text(
                        '${usuario.firstName} ${usuario.lastName}',
                        style: fontStyleText.normalText2.copyWith(color: Colors.white),
                      ),
                      Divider(color: Colors.white),
                      Text(
                        '${usuario.email}',
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

  Positioned _buildBotonEliminar(Responsive responsive, BuildContext context) {
    return Positioned(
        top: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            showAnimatedDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ClassicGeneralDialogWidget(
                  titleText: '¿Estas seguro de eliminar al asistente?',
                  contentText: 'Eliminar a "${asistente.asistente!.firstName} ${asistente.asistente!.lastName}"',
                  onPositiveClick: () {
                    BlocProvider.of<AsistenteBloc>(context).add(
                        EliminarAsistenteParticipanteEvent(
                            idParticipante: participante.id!,
                            idAsistente: asistente.id!
                        )
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
    );
  }
}

