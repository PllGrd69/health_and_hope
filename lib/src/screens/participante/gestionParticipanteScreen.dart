import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/asistente/asistenteBloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/asistenteUsuarioBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/promotorUsuarioBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/registroTarjetaModifFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/participante/agregarAsistentesScreen.dart';
import 'package:health_and_hope/src/screens/participante/agregarPromotorScreen.dart';
import 'package:health_and_hope/src/screens/participante/asistentesParticipantesWidget.dart';
import 'package:health_and_hope/src/screens/participante/promotoresParticipantesWidget.dart';
import 'package:health_and_hope/src/screens/participante/registrarTarjetaModificacionScreen.dart';
import 'package:health_and_hope/src/screens/participante/tarjetasParticipanteWidget.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';

import 'package:health_and_hope/src/widgets/rectangleImageWidget.dart';


class GestionParticipanteScreen extends StatelessWidget {
  final ParticipanteModel participante;
  static final String routeName = 'GestionParticipanteScreen';

  const GestionParticipanteScreen({required this.participante});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: responsive.ip(2), left: responsive.ip(2), right: responsive.ip(2)),
        child: ListView(
          children: [
            _InformacionUsuario(participante: participante),
            SizedBox(height: responsive.ip(1)),
            _AsistentesParticipante(participante: participante),
            SizedBox(height: responsive.ip(1)),
            _PromotoresParticipante(participante: participante),
            SizedBox(height: responsive.ip(1)),
            _TarjetasParticipante(participante: participante),
            SizedBox(height: responsive.ip(3)),
          ],
        ),
      ),
      floatingActionButton: _FloatingsActionButtons(participante: participante),
    );
  }
}


class _AsistentesParticipante extends StatelessWidget {
  final ParticipanteModel participante;

  const _AsistentesParticipante({Key? key, required this.participante}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      height: responsive.ip(25),
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(responsive.ip(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Asistentes'),
          Expanded(
            child: ListaDeAistentesWidget(participante: participante)
          )
        ],
      ),
    );
  }
}

class _TarjetasParticipante extends StatelessWidget {
  final ParticipanteModel participante;
  const _TarjetasParticipante({Key? key, required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      height: responsive.ip(25),
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(responsive.ip(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tarjetas de modificación'),
          Expanded(
              child: ListaDeTarjetasParticipanteWidget(participante: participante)
          )
        ],
      ),
    );
  }
}

class _PromotoresParticipante extends StatelessWidget {
  final ParticipanteModel participante;
  const _PromotoresParticipante({Key? key, required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      height: responsive.ip(25),
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(responsive.ip(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Promotores'),
          Expanded(
              child: ListaDePromotoresWidget(participante: participante)
          )
        ],
      ),
    );
  }
}


class _FloatingsActionButtons extends StatefulWidget {
  final ParticipanteModel participante;
  const _FloatingsActionButtons({required this.participante});
  @override
  __FloatingsActionButtonsState createState() => __FloatingsActionButtonsState();
}

class __FloatingsActionButtonsState extends State<_FloatingsActionButtons> {
  bool _visibleButton = false;

  BoxDecoration _boxDecoration(){
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 5, // soften the shadow
          // spreadRadius: 1, //extend the shadow
          offset: Offset(
            0, // Move to right 10  horizontally
            2, // Move to bottom 10 Vertically
          ),
        )
      ],
    );
  }

  Widget _buildText(String texto, Responsive responsive) {
    return Container(
      decoration: _boxDecoration(),
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(responsive.ip(1)),
          child: Text(texto, style: TextStyle(color: Colors.black))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Visibility(
          visible: _visibleButton,
          child: SlideInUp(
            from: 150,
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildText('Agregar tarjeta de modificación', responsive),
                  SizedBox(width: responsive.ip(1)),
                  FloatingActionButton(
                    heroTag: "AgregarTarjetaModifScreen",
                    onPressed: () {
                      registroTarjetaModifFormController.cleanData();
                      Navigator.pushNamed(context, TarjetaModificacionRegistroScreen.routeName, arguments: widget.participante);
                    },
                    child: FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              )
          ),
        ),
        SizedBox(height: responsive.ip(1)),
        Visibility(
          visible: _visibleButton,
          child: SlideInUp(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildText('Agregar asistentes', responsive),
                  SizedBox(width: responsive.ip(1)),
                  FloatingActionButton(
                    heroTag: "AgregarAsistentesScreen",
                    onPressed: () {
                      BlocProvider.of<AsistenteBloc>(context, listen: false).add(
                          AsistentesDisponiParticipanteEvent(
                              idParticipante: widget.participante.id!,
                              email: buscarAsistenteFormController.getEmail,
                              dni: buscarAsistenteFormController.getDni
                          )
                      );
                      Navigator.pushNamed(context, AgregarAsistentesScreen.routeName, arguments: widget.participante);
                    },
                    child: FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              )
          ),
        ),
        SizedBox(height: responsive.ip(1)),
        Visibility(
          visible: _visibleButton,
          child: FlipInX(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildText('Agregar promotores', responsive),
                  SizedBox(width: responsive.ip(1)),
                  FloatingActionButton(
                    heroTag: 'AgregarPromotores',
                    onPressed: (){
                      BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
                          PersonalDisponibleParticipanteEvent(
                              idParticipante: widget.participante.id!,
                              email: buscarPromotorFormController.getEmail,
                              dni: buscarPromotorFormController.getDni,
                          )
                      );
                      Navigator.pushNamed(context, AgregarPromotoresScreen.routeName, arguments: widget.participante);
                      // AgregarPromotoresScreen
                    },
                    child: FaIcon(FontAwesomeIcons.plus),
                  ),
                ],
              )
          ),
        ),
        SizedBox(height: responsive.ip(1)),
        FloatingActionButton(
            onPressed: (){
              this._visibleButton = !this._visibleButton;
              setState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: _visibleButton,
                  child: FadeIn(
                    child: FaIcon(
                        FontAwesomeIcons.chevronDown
                    ),
                  ),
                ),
                Visibility(
                  visible: !_visibleButton,
                  child: FadeIn(
                    child: FaIcon(
                        FontAwesomeIcons.chevronUp
                    ),
                  ),
                )
              ],
            )
        )
      ],
    );
  }

  void _registrarDepartamento(){
    // SmartDialog.show(
    //     tag: 'RegistrarDepartamento',
    //     alignmentTemp: Alignment.center,
    //     widget: RegistrarDepartamentoWidget()
    // );
  }
}


class _InformacionUsuario extends StatelessWidget {

  final ParticipanteModel participante;

  const _InformacionUsuario({required this.participante});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInformacionPersonal(context),
        SizedBox(height: responsive.ip(1)),
        _buildInformacionUsuario(context),
        Divider(),
      ],
    );
  }
  
  Widget _buildInformacionPersonal(BuildContext context){
    final responsive = Responsive.of(context);
    return Container(
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(responsive.ip(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: responsive.width),
          Text('Datos personales'),
          Row(
            children: [
              SizedBox(width: responsive.ip(2)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Text('Nombres: ${participante.participante!.firstName}'),
                    Divider(),
                    Text('Apellidos: ${participante.participante!.lastName}'),
                    Divider(),
                    Text('Género: ${participante.participante!.genero}'),
                    Divider(),
                    Text('Fecha de nacimiento: ${participante.participante!.fechaNacimiento}'),
                    Divider(),
                    Text('Dirección actual: ${participante.participante!.direccionActual}'),
                    Divider(),
                    Text('DNI: ${participante.participante!.dni}'),
                    Divider(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildInformacionUsuario(BuildContext context){
    final responsive = Responsive.of(context);
    return Container(
      color: Colors.grey.withOpacity(0.2),
      padding: EdgeInsets.all(responsive.ip(0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: responsive.width),
          Text('Datos de usuario'),
          Row(
            children: [
              SizedBox(width: responsive.ip(2)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Text('Creado: ${participante.participante!.getCreated}'),
                    Divider(),
                    Text('Modificado: ${participante.participante!.getModified}'),
                    Divider(),
                    Text('Email: ${participante.participante!.email}'),
                    Divider(),
                    Text('Nombre de usuario: ${participante.participante!.username}'),
                    Divider(),
                    Text('Información: ${participante.participante!.informacion}'),
                    Divider(),
                    ButtonActionWidget(text: 'Imagen de perfil', onPressed: ()=>_verImageUsuario(context)),
                    Divider(),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _verImageUsuario(BuildContext context) async {
    final responsive = Responsive.of(context);
    await SmartDialog.show(
      tag: 'fondoImagenUsuario',
      alignmentTemp: Alignment.center,
      widget: Container(
        width: responsive.ip(40),
        height: responsive.ip(40),
        color: Colors.indigo,
        child: RectangleImageWidget(urlImage: participante.participante!.avatar,),
      )
    );
  }

}

