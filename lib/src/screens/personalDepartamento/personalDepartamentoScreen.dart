import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/listadoPersonalWidget.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/personalDepartFormScreen.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/registrarPersonalDepModalWidget.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';

class PersonalDepartamentoScreen extends StatelessWidget {
  static final routeName = 'PersonalDepartamentoScreen';
  final DepartamentoModel departamento;
  const PersonalDepartamentoScreen({required this.departamento});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PersonalDepartamentoBloc>(context).add(AllPersonalDepDisponibleEvent(idDepartamento: departamento.id!));
    final responsive = Responsive.of(context);
    final textFontStyle = TextFontStyle.of(context);
    BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(AllPersonalDepartamentoEvent(page: 1, uuidDepartamento: departamento.id!));
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: responsive.width,
          height: responsive.height,
          child: Column(
            children: [
              Text('${departamento.nombre}', style: textFontStyle.title1, textAlign: TextAlign.center),
              Expanded(child: ListadoPersonal())
            ],
          ),
          // color: Colors.orange,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'FormRegistroPersonalDepartScreend',
        onPressed: ()=> _registrarPersonalDepar(context),
        child: FaIcon(
          FontAwesomeIcons.plus
        ),
      ),
    );
  }
  void _registrarPersonalDepar(BuildContext context) {
    final listaPersonal = BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).state.
    personalDepartamentoPaginado!.results??[];
    final otraLista = listaPersonal.map((e) => e.personalDepartamento!).toList();
    SmartDialog.show(
        tag: 'registrarPersonalDep',
        alignmentTemp: Alignment.center,
        widget: RegistrarPersonalDepModalWidget(
          listadoPersonalDepar: otraLista,
          departamento: departamento,
        )
    );
  }
}