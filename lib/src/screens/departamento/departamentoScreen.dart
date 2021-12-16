import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/departamento/formDepartamentoModal.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/personalDepartamentoScreen.dart';
// import 'package:health_and_hope/src/screens/register_screen.dart';
import 'package:health_and_hope/src/screens/registrarUsuarioScreen.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/userRole.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';


class DepartamentosScreen extends StatelessWidget {
  const DepartamentosScreen({Key? key}) : super(key: key);
  static final routeName = 'DepartamentosScreen';
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final textFontStyle = TextFontStyle.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(responsive.ip(3)),
          height: responsive.height,
          width: responsive.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Departamentos',style: textFontStyle.title2, textAlign: TextAlign.center),
              SizedBox(height: responsive.ip(4)),
              Expanded(child: SingleChildScrollView(child: _DepartamentoButtons())),
              SizedBox(height: responsive.ip(2)),
            ]
          )
        ),
      ),
      floatingActionButton: _FloatingsActionButtons(),
    );
  }
}


class _FloatingsActionButtons extends StatefulWidget {
  const _FloatingsActionButtons({Key? key}) : super(key: key);
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
        child: Text(texto)
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildText('Registrar personal', responsive),
                SizedBox(width: responsive.ip(1)),
                FloatingActionButton(
                  heroTag: "RegisterUserScreen",
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrarUsuarioScreen.routeName, arguments: RoleUser.personal);
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
                _buildText('Registrar departamento', responsive),
                SizedBox(width: responsive.ip(1)),
                FloatingActionButton(
                  heroTag: 'RegistrarDepartamento',
                  onPressed: ()=>_registrarDepartamento(),
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
    SmartDialog.show(
        tag: 'RegistrarDepartamento',
        alignmentTemp: Alignment.center,
        widget: RegistrarDepartamentoWidget()
    );
  }
}


class _DepartamentoButtons extends StatelessWidget {
  Widget _buttonModel(BuildContext context, Responsive responsive, DepartamentoModel departamento) {
    return Container(
      padding: EdgeInsets.only(bottom: responsive.ip(1)),
      width: responsive.width,
      child: ButtonActionWidget(
        padding: EdgeInsets.symmetric(horizontal: responsive.ip(1.5), vertical: responsive.ip(1.5)),
        text: '${departamento.nombre}',
        onPressed: () => onPressed(context, departamento),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return BlocBuilder<DepartamentoBloc, DepartamentoState>(
      builder: (context, state) {
        if (state.listDepartamento!=null) {
          final listaBotonesDepart = state.listDepartamento!.map((e) {
            return _buttonModel(context, responsive, e);
          }).toList();
          return Column(
            children: listaBotonesDepart
          );
        }
        return Container();
      }
    );

  }

  void onPressed (BuildContext context, DepartamentoModel departamento) {

    Navigator.pushNamed(context, PersonalDepartamentoScreen.routeName, arguments: departamento);

  }
}