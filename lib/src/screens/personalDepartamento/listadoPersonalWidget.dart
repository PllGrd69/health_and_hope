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
import 'package:health_and_hope/src/widgets/circleImageWidget.dart';

class ListadoPersonal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDepartamentoBloc, PersonalDepartamentoState>(
        builder: (context, state) {
          if (state.personalDepartamentoPaginado!=null) {
            final valor = state.personalDepartamentoPaginado;
            return _ListBuilderItems(personalDepartamento: valor!);
          } else if (state.personalDepartamentoPaginado==null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        }
    );
  }
}

class _ListBuilderItems extends StatefulWidget {
  final PersonalDepartamentoPaginadoModel personalDepartamento;

  const _ListBuilderItems({required this.personalDepartamento});

  @override
  __ListBuilderItemsState createState() => __ListBuilderItemsState();
}

class __ListBuilderItemsState extends State<_ListBuilderItems> {
  ScrollController _controller = ScrollController();
  int pagina=1;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }
  _scrollListener() {
    if (_controller.position.maxScrollExtent == _controller.offset) {

      int count = widget.personalDepartamento.count??0;
      int results = widget.personalDepartamento.results!.length;
      final modulo = count%results;
      int paginas = (count-modulo)~/results;
      if (modulo!=0) paginas++;

      if (pagina < paginas) {
        pagina++;
        print('$pagina - $paginas');
        print("Traer datos");
        BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
            AllPersonalPaginadoEvent(page: pagina)
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final valoresNew = widget.personalDepartamento.results??[];
    return RefreshIndicator(
      onRefresh: _getDataRefresh,
      child: ListView.builder(
        controller: _controller,
        itemCount: valoresNew.length,
        itemBuilder: (context, int index) {
          return _ItemListPersonal(
              resultatoPersonal: valoresNew[index]
          );
        },
      ),
    );
  }
  Future<void> _getDataRefresh() async {
    pagina=1; // Est por gusto
    BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
      AllPersonalDepartamentoEvent(
        uuidDepartamento: widget.personalDepartamento.results![0].departamento!.id!,
        page: 1
      )
    );
  }
}




class _ItemListPersonal extends StatelessWidget {
  final ResultPersonalDepartamentoModel resultatoPersonal;

  const _ItemListPersonal({required this.resultatoPersonal});

  @override
  Widget build(BuildContext context) {
    final textFontStyle = TextFontStyle.of(context);
    final responsive = Responsive.of(context);
    final usuario = resultatoPersonal.personalDepartamento!.personal!;
    return Slidable(
      key: ValueKey(0),
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
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              BlocProvider.of<PersonalDepartamentoBloc>(context).add(
                EliminarPersonalDepEvent(
                  uuidPersonalDep: resultatoPersonal.id!
                )
              );
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.trash,
            label: 'Delete',
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
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight
        ),
        title: Text(
          '${usuario.email}',
          style: textFontStyle.normalText1,
        ),
        onTap: ()=>{},
      ),
    );
  }

  void _mostrarInfoPersona() {
    SmartDialog.show(
        tag: 'InformacionPersonaModal',
        alignmentTemp: Alignment.center,
        widget: InfoUsuarioModalWidget(
          usuario: resultatoPersonal.personalDepartamento!.personal!,
        )
    );
  }
}
