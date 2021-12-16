import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/asistenteUsuarioBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/participanteBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/registroTarjetaModifFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/participante/gestionParticipanteScreen.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/personalInfoWidget.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/circleImageWidget.dart';

class ListaParticipantes extends StatelessWidget {
  const ListaParticipantes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: responsive.ip(0.6)),
      child: _ListaPartcipanteLoadBloc(),
      color: Colors.grey.withOpacity(0.3),
    );
  }
}


class _ListaPartcipanteLoadBloc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ParticipanteBloc, ParticipanteState>(
      builder: (context, state) {
        if (state.participantesPaginado!=null) return _ListaParticipante(participantes: state.participantesPaginado!);
        else if (state.participantesPaginado==null) return Center(child: CircularProgressIndicator());
        return Container();
      }
    );
  }
}

class _ListaParticipante extends StatefulWidget {
  final ParticipantePaginadoModel participantes;
  const _ListaParticipante({Key? key, required this.participantes}) : super(key: key);

  @override
  __ListaParticipanteState createState() => __ListaParticipanteState();
}

class __ListaParticipanteState extends State<_ListaParticipante> {
  ScrollController _controller = ScrollController();
  int pagina=1;

  void initState() {
    print('initState $pagina');
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.position.maxScrollExtent == _controller.offset) {
      int count = widget.participantes.count??0;
      int results = widget.participantes.results!.length;
      if (results < count) {
        BlocProvider.of<ParticipanteBloc>(context, listen: false).add(
            AllParticipantesPaginadoEvent(page: ++pagina, email: buscarParticipanteTodosFormController.getEmail, dni: buscarParticipanteTodosFormController.getDni)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(pagina);
    final results = [
      ...widget.participantes.results!,
    ];
    return RefreshIndicator(
      onRefresh: _getDataRefresh,
      child: ListView.separated(
        itemCount: results.length,
        controller: _controller,
        itemBuilder: (context, int index) {
          final participante = results[index];
          return _ItemListParticipante(partcipante: participante);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Future<void> _getDataRefresh() async {
    pagina=1;
    BlocProvider.of<ParticipanteBloc>(context, listen: false).add(
        AllParticipantesEvent(page: pagina, email: buscarParticipanteTodosFormController.getEmail, dni: buscarParticipanteTodosFormController.getDni)
    );
  }
}


class _ItemListParticipante extends StatelessWidget {

  final ParticipanteModel partcipante;

  const _ItemListParticipante({required this.partcipante});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final textFontStyle = TextFontStyle.of(context);
    return Slidable(
      key: ValueKey(0),
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              BlocProvider.of<ParticipanteBloc>(context).add(
                EliminarParticipanteEvent(idParticipante: partcipante.id!)
              );
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.trash,
            label: 'Eliminar',
          ),
          SlidableAction(
            onPressed: (BuildContext context) {},
            backgroundColor: Color(0xFF4a32a8),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.edit,
            label: 'Update',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              _mostrarInfoPersona();
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
            imageUrl: partcipante.participante!.avatar,
            radio: responsive.ip(22),
            padding: responsive.ip(0.5),
          ),
        ),
        trailing: FaIcon(
            FontAwesomeIcons.chevronRight
        ),
        title: Text(
          '${partcipante.participante!.email}',
          style: textFontStyle.normalText1,
        ),
        onTap: (){
          buscarAsistenteFormController.cleanData();
          registroTarjetaModifFormController.cleanData();
          BlocProvider.of<AsistenteBloc>(context, listen: false).add(AsistentesParticipanteEvent(idParticipante: partcipante.id!));
          BlocProvider.of<PromotorBloc>(context, listen: false).add(PromotoresParticipanteEvent(idParticipante: partcipante.id!));
          BlocProvider.of<TarjetaModificacionBloc>(context, listen: false).add(TarjetasDeModificacionParticipanteEvent(idParticipante: partcipante.id!));
          Navigator.pushNamed(
            context,
            GestionParticipanteScreen.routeName,
            arguments: partcipante
          );
        },
      ),
    );
  }

  void _mostrarInfoPersona() {
    SmartDialog.show(
        tag: 'InformacionPersonaModal',
        alignmentTemp: Alignment.center,
        widget: InfoUsuarioModalWidget(
          usuario: partcipante.participante!
        )
    );
  }
}
