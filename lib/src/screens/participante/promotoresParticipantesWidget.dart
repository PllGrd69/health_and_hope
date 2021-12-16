import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/promotorUsuarioBuscarFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/bloc/asistente/asistenteBloc.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/rectangleImageWidget.dart';


class ListaDePromotoresWidget extends StatelessWidget {
  final ParticipanteModel participante;
  const ListaDePromotoresWidget({Key? key, required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotorBloc, PromotorState>(
        builder: (context, state) {
          if (state.listPromotorParticipante!=null) {
            Future.microtask(() =>{
              BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
                  PersonalDisponibleParticipanteNoRefreshEvent(
                    idParticipante: participante.id!,
                    email: buscarPromotorFormController.getEmail,
                    dni: buscarPromotorFormController.getDni,
                  )
              )
            });
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.listPromotorParticipante!.length,
                itemBuilder: (BuildContext context, int index){
                  return _ItemListaPromotores(promotor: state.listPromotorParticipante![index]);
                }
            );
          }
          else if (state.listPromotorParticipante==null) return Center(child: CircularProgressIndicator());

          return Container();
          
        }
    );

  }
}

class _ItemListaPromotores extends StatelessWidget {
  final PromotorParticipanteModel promotor;
  const _ItemListaPromotores({required this.promotor});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyleText = TextFontStyle.of(context);
    final usuario = promotor.promotorParticipante!.personalDepartamento!.personal!;
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
                      Divider(color: Colors.white),
                      Text(
                        '${promotor.promotorParticipante!.departamento!.nombre}',
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
                  titleText: '¿Estas seguro de eliminar al promotor?',
                  contentText: 'Eliminar a "${promotor.promotorParticipante!.personalDepartamento!.personal!.firstName} ${promotor.promotorParticipante!.personalDepartamento!.personal!.lastName}"',
                  onPositiveClick: () {
                    BlocProvider.of<PromotorBloc>(context).add(
                        EliminarPromotorParticipanteEvent(idPromotorParticipante: promotor.id!)
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

