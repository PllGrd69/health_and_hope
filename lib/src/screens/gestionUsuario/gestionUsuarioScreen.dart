import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/asistentesBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/participanteBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/personalBuscarFormController.dart';
import 'package:health_and_hope/src/screens/asistente/gestionAsistentes.dart';
import 'package:health_and_hope/src/screens/departamento/departamentoScreen.dart';
import 'package:health_and_hope/src/screens/participante/participanteScreen.dart';
import 'package:health_and_hope/src/screens/personal/gestionPersonal.dart';
import 'package:health_and_hope/src/utils/helpers.dart';


class GestionUsuariosScreen extends StatelessWidget {

  static final routeName = 'GestionUsuariosScreen';

  @override
  Widget build(BuildContext context) {
    buscarAsistentesTodosFormController.cleanData();
    buscarPersonalTodosFormController.cleanData();
    buscarParticipanteTodosFormController.cleanData();
    BlocProvider.of<ParticipanteBloc>(context).add(AllParticipantesEvent(page: 1, email: buscarParticipanteTodosFormController.getEmail, dni: buscarParticipanteTodosFormController.getDni));
    BlocProvider.of<AsistenteBloc>(context).add(AsistentesEvent(email:  buscarAsistentesTodosFormController.getEmail, dni: buscarAsistentesTodosFormController.getDni));
    BlocProvider.of<PersonalBloc>(context).add(ListaPersonalEvent(dni: buscarPersonalTodosFormController.getDni, email: buscarPersonalTodosFormController.getEmail));


    return Swiper.children(
      pagination: SwiperPagination(
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
        builder: DotSwiperPaginationBuilder(
          color: Colors.grey.withOpacity(0.4),
          activeColor: HelpersAppsColors().colorBase,
          size: 15.0,
          activeSize: 20.0
        )
      ),

      children: <Widget>[
        GestionParticipante(),
        GestionAsistentes(),
        GestionPersonal(),
      ],
    );
  }
}
