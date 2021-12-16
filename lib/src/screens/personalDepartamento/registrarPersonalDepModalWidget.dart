import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/personalInfoWidget.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/circleImageWidget.dart';


class RegistrarPersonalDepModalWidget extends StatelessWidget {
  const RegistrarPersonalDepModalWidget({required this.listadoPersonalDepar, required this.departamento});
  final List<PersonalModel> listadoPersonalDepar;
  final DepartamentoModel departamento;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        height: responsive.ip(50),
        width: responsive.ip(40),
        padding: EdgeInsets.all(responsive.ip(1.5)),
        child: Column(
          children: [
            Text('Listado del personal'),
            Expanded(child: Container(
              color: Colors.grey.withOpacity(0.2),
              padding: EdgeInsets.all(responsive.ip(0.5)),
              child: _ListaBlocDePersonal(
                listadoPersonalDepar: listadoPersonalDepar,
                departamento: departamento,
              ),
              // color: Colors.grey.withOpacity(0.1),
            )),
          ],
        ),
      ),
    );
  }
}


class _ListaBlocDePersonal extends StatelessWidget {
  final List<PersonalModel> listadoPersonalDepar;
  const _ListaBlocDePersonal({required this.listadoPersonalDepar, required this.departamento});
  final DepartamentoModel departamento;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDepartamentoBloc, PersonalDepartamentoState>(
      builder: (context, state) {

        if (state.listPersonalDepDisponible!=null) {
          final valor = state.listPersonalDepDisponible??[];
          return _ListPersonal(
            departamento: departamento,
            listPersonal: valor,
          );
        } else if (state.listPersonalDepDisponible==null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container();
      }
    );
  }
}


class _ListPersonal extends StatelessWidget {
  const _ListPersonal({Key? key, required this.listPersonal, required this.departamento}) : super(key: key);
  final List<PersonalModel> listPersonal;
  final DepartamentoModel departamento;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return ListView.builder(
      itemCount: listPersonal.length,
      itemBuilder: (context, int index) {
        final usuario = listPersonal[index].personal;
        final textFontStyle = TextFontStyle.of(context);
        final responsive = Responsive.of(context);
        print(usuario!.avatar);
        return Slidable(
          key: ValueKey(0),
          startActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  _agregarPersonaDepartamentoEvent(context, listPersonal[index]);
                },
                backgroundColor: Color(0xFF4a32a8),
                foregroundColor: Colors.white,
                icon: FontAwesomeIcons.edit,
                label: 'Agregar personal',
              ),
            ],
          ),
          endActionPane: ActionPane(
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  _mostrarInfoPersonaEvent(usuario);
                },
                backgroundColor: Color(0xFF21B7CA),
                foregroundColor: Colors.white,
                icon: Icons.share,
                label: 'Información',
              ),
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: CircleImageAvatarWidget(
                imageUrl: usuario.avatar,
                radio: responsive.ip(22),
                padding: responsive.ip(0.5),
              ),
            ),
            title: Text(
              '${usuario.email}',
              style: textFontStyle.normalText1,
            ),
          ),
        );
      },
    );
  }



  void _agregarPersonaDepartamentoEvent(BuildContext context, PersonalModel personalDep) {
    SmartDialog.dismiss(tag: 'departamentoPersonal');
    BlocProvider.of<PersonalDepartamentoBloc>(context).add(
        RegistrarPersonalDepartamentoEvent(
          uuidDepartamento: departamento.id!,
          uuidPersonal: personalDep.id!,
        )
    );
  }

  void _mostrarInfoPersonaEvent(UserModel usuario) {
    print(usuario.fechaNacimiento);
    SmartDialog.show(
        tag: 'InformacionPersonaModal',
        alignmentTemp: Alignment.center,
        widget: InfoUsuarioModalWidget(
          usuario: usuario,
        )
    );
  }
}
