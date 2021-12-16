import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/asistente/asistenteBloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/asistenteUsuarioBuscarFormController.dart';
import 'package:health_and_hope/src/form_controllers/promotorUsuarioBuscarFormController.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/personalDepartamento/personalInfoWidget.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/circleImageWidget.dart';
import 'package:health_and_hope/src/widgets/roundedInputField.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AgregarPromotoresScreen extends StatelessWidget {
  final ParticipanteModel participante;
  static final String routeName = 'AgregarPromotoresScreen';
  const AgregarPromotoresScreen({required this.participante});
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      body: SafeArea( 
        child: Container(
          padding: EdgeInsets.all(responsive.ip(1)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _busquedaPersonalizadaBtn(context),
              Expanded(child: _ListaParticipantes(participante: participante))
            ],
          ),
        ),
      ),
    );
  }

  Widget _busquedaPersonalizadaBtn(BuildContext context){
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      child: ButtonActionWidget(
          text: 'Busqueda Personalizada',
          // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          onPressed: ()=> _busquedaPersonalizada(context)
      ),
    );
  }

  void _busquedaPersonalizada(BuildContext context) {
    final responsive = Responsive.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context)=> Container(
        padding: EdgeInsets.all(responsive.ip(2)),
        child: _BuscarAsistenteForm(participante: participante)
      ),
    );
  }

}


class _BuscarAsistenteForm extends StatelessWidget {
  final ParticipanteModel participante;

  const _BuscarAsistenteForm({Key? key, required this.participante}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.width,
      child: ReactiveForm(
        formGroup: buscarPromotorFormController.buscarPromotorForm,
        child: Column(
          children: [
            _buildDNI(),
            _buildEmail(),
            _buscar(context),
          ],
        )
      ),
    );
  }

  Widget _buildDNI(){
    return RoundedInputField (
      formControlTextName: "dni",
      textInputType: TextInputType.number,
      icon: FontAwesomeIcons.idCard,
      hintText: "DNI",
      labelText: 'DNI',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.maxLength: 'El DNI debe tener 8 caracteres',
        ValidationMessage.number:"El DNI debe ser numérico",
      },
    );
  }

  Widget _buildEmail(){
    return RoundedInputField (
      formControlTextName: "email",
      textInputType: TextInputType.number,
      icon: FontAwesomeIcons.idCard,
      hintText: "Email",
      labelText: 'Email',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.maxLength: "Esta campo debe tener como maximo 100 caracteres",
      },
    );
  }

  Widget _buscar(BuildContext context){
    return ButtonActionWidget(
        text: 'Buscar',
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        onPressed: ()=> _onPressed(context)
    );
  }

  void _onPressed(BuildContext context) {
    buscarPromotorFormController.buscarPromotorForm.markAllAsTouched();
    FocusScope.of(context).unfocus();
    if (!buscarPromotorFormController.buscarPromotorForm.valid) return;


    BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
      PersonalDisponibleParticipanteEvent(
        idParticipante: participante.id!,
        email: buscarPromotorFormController.getEmail,
        dni: buscarPromotorFormController.getDni,
      )
    );

  }
}


class _ListaParticipantes extends StatelessWidget {
  final ParticipanteModel participante;
  const _ListaParticipantes({required this.participante});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: responsive.ip(0.6)),
      child: _ListaPartcipanteLoadBloc(participante: participante),
      color: Colors.grey.withOpacity(0.2),
    );
  }
}


class _ListaPartcipanteLoadBloc extends StatelessWidget {
  final ParticipanteModel participante;
  const _ListaPartcipanteLoadBloc({Key? key, required this.participante}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalDepartamentoBloc, PersonalDepartamentoState>(
      builder: (context, state) {
        print(state.personalDeparDisponiblePag);
        if (state.personalDeparDisponiblePag!=null) return _ListaParticipante(asistentesPaginago: state.personalDeparDisponiblePag!, participante: participante);
        else if (state.personalDeparDisponiblePag==null) return Center(child: CircularProgressIndicator());
        return Container();
      }
    );
  }
}

class _ListaParticipante extends StatefulWidget {
  final PersonalDepartamentoPaginadoModel asistentesPaginago;
  final ParticipanteModel participante;
  const _ListaParticipante({required this.asistentesPaginago, required this.participante});

  @override
  __ListaParticipanteState createState() => __ListaParticipanteState();
}

class __ListaParticipanteState extends State<_ListaParticipante> {
  ScrollController _controller = ScrollController();
  int pagina=1;

  void initState() {
    print('page $pagina');
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.position.maxScrollExtent == _controller.offset) {
      int count = widget.asistentesPaginago.count??0;
      int results = widget.asistentesPaginago.results!.length;
      if (results < count) {
        BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
          PersonalDisponibleParticipantePagEvent(
            idParticipante: widget.participante.id!,
            email: buscarPromotorFormController.getEmail,
            dni: buscarPromotorFormController.getDni,
            page: ++pagina
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(pagina);
    final results = [
      ...widget.asistentesPaginago.results!,
    ];
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: _getDataRefresh,
      child: ListView.separated(
        itemCount: results.length,
        controller: _controller,
        itemBuilder: (context, int index) {
          final asistente = results[index];
          return _ItemListParticipante(asistente: asistente, participante: widget.participante);
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      ),
    );
  }

  Future<void> _getDataRefresh() async {
    pagina=1;
    BlocProvider.of<PersonalDepartamentoBloc>(context, listen: false).add(
      PersonalDisponibleParticipanteEvent(
        idParticipante: widget.participante.id!,
        email: buscarPromotorFormController.getEmail,
        dni: buscarPromotorFormController.getDni,
      )
    );
  }
}


class _ItemListParticipante extends StatelessWidget {

  final ResultPersonalDepartamentoModel asistente;
  final ParticipanteModel participante;

  const _ItemListParticipante({required this.asistente, required this.participante});

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
              BlocProvider.of<PromotorBloc>(context).add(
                RegistrarPromotoresParticipanteEvent(
                  idParticipante: participante.id!,
                  idPromotorParticipante: asistente.id!
                )
              );
            },
            backgroundColor: Color(0xFF4a32a8),
            foregroundColor: Colors.white,
            icon: FontAwesomeIcons.edit,
            label: 'Agregar promotor',
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
            imageUrl: asistente.personalDepartamento!.personal!.avatar,
            radio: responsive.ip(22),
            padding: responsive.ip(0.5),
          ),
        ),
        title: Text(
          '${asistente.personalDepartamento!.personal!.email} (${asistente.departamento!.nombre})',
          style: textFontStyle.normalText1,
        ),
      ),
    );
  }

  void _mostrarInfoPersona() {
    SmartDialog.show(
        tag: 'InformacionPersonaModal',
        alignmentTemp: Alignment.center,
        widget: InfoUsuarioModalWidget(
            usuario: asistente.personalDepartamento!.personal!
        )
    );
  }
}
