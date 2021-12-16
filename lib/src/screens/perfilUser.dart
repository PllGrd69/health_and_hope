import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/form_controllers/userInformationController.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:health_and_hope/src/widgets/headerPageWidget.dart';
import 'package:health_and_hope/src/widgets/roundedInputField.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:image_picker/image_picker.dart';

class PerfilUsuarioApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final stateUserAccess = BlocProvider.of<UserAppBloc>(context, listen: true).state.userAccess;
    final String rolNombre = (stateUserAccess!=null && stateUserAccess.rol !=null)? stateUserAccess.rol!:'Sin rol de Usuario';

    final stack = Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        Positioned(
          left: responsive.ip(1),
          top: responsive.ip(1),
          child: SafeArea(child: Text(rolNombre, style: TextStyle(
            color: Colors.white,
            fontSize: responsive.ip(2)
          )))
        ),
        Column(
          children: [
            SizedBox(height: responsive.ip(10), width: responsive.width),
            _AvatarCircle()
          ]
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: responsive.ip(32), width: responsive.width),
              FormContent(),
              _ButtonSaveInformation(),
              ButtonActionWidget(
                onPressed: () {
                  BlocProvider.of<UserAppBloc>(context, listen: false).add(SignOff());
                },
                text: 'Cerrar Sesión',
              ),
              SizedBox(height: responsive.ip(2))
            ],
          )
        ),
        Positioned(
          right: responsive.ip(1),
          top: responsive.ip(1),
          child: SafeArea(
            child: _ImagePickerIcon(),
          )
        )
      ]
    );
    return Scaffold(
      body: HeaderPageWidget(
        color: HelpersAppsColors().colorBase,
        child: stack,
      ),
    );
  }
}

class _ImagePickerIcon extends StatelessWidget {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final userAppBloc = BlocProvider.of<UserAppBloc>(context, listen: true);
    return Row(
      children: [
        if(userAppBloc.state.imagePicker != null) _ClearImagePickerSelect(),
        SizedBox(width: 10),
        GestureDetector(
          onTap: ()=> _onTap(context),
          child: FaIcon(
            FontAwesomeIcons.camera,
            size: responsive.ip(5),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  _onTap(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    try{
      if(pickedFile!=null){
        BlocProvider.of<UserAppBloc>(context, listen: false).add(
            ImagePickerUserAppEvent(imagePicker: pickedFile.path)
        );
      }
    } on Exception catch (_) {}
  }



}

class _ClearImagePickerSelect extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final userAppBloc = BlocProvider.of<UserAppBloc>(context, listen: false);
    return GestureDetector(
      onTap: ()=> userAppBloc.add(ImagePickerUserAppEvent()),
      child: FaIcon(
        FontAwesomeIcons.trash,
        size: 35,
        color: Colors.grey,
      ),
    );
  }
}

class _ButtonSaveInformation extends StatelessWidget {
  _loadDataMsgServerBackendState(BuildContext context){
    final stateUserAccessError = BlocProvider.of<UserAppBloc>(context).state.errorsUpdate;
    userInformationController.errorFormsMapFromApi(stateUserAccessError);
  }

  @override
  Widget build(BuildContext context) {
    _loadDataMsgServerBackendState(context);
    return ButtonActionWidget(
      onPressed: () => _onPressed(context),
      text: 'Aplicar Cambios',
    );
  }

  void _onPressed(BuildContext context) {
    userInformationController.userInformationForm.markAllAsTouched();
    FocusScope.of(context).unfocus();
    if (!userInformationController.userInformationForm.valid) return;

    final userAppBloc = BlocProvider.of<UserAppBloc>(context, listen: false);
    final userModelUpdate = UserModel(
        username: userInformationController.getUsername,
        email: userInformationController.getEmail,
        firstName: userInformationController.getFirstName,
        lastName: userInformationController.getLastName,
        informacion: userInformationController.getInformacion
    );
    userAppBloc.add(
        UpdateCurrentUserAppEvent(userModelUpdate: userModelUpdate)
    );
  }
}

class FormContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      margin: EdgeInsets.all(responsive.ip(1)),
      padding: EdgeInsets.all(responsive.ip(2)),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _InformationUserForm()
    );
  }
}



class _InformationUserForm extends StatelessWidget {

  void _loadDataApiServer(BuildContext context){
    final currentUser = BlocProvider.of<UserAppBloc>(context, listen: true).state.userAccess;
    if (currentUser!=null) {
      userInformationController.setUsername = currentUser.username!;
      userInformationController.setInformacion = currentUser.informacion!;
      userInformationController.setEmail = currentUser.email!;
      userInformationController.setFirstName = currentUser.firstName!;
      userInformationController.setLastName = currentUser.lastName!;
    }
  }

  @override
  Widget build(BuildContext context) {
    _loadDataApiServer(context);
    return ReactiveForm(
      formGroup: userInformationController.userInformationForm,
      child: Column(
        children: [
          _buildNombres(),
          _buildApellidos(),
          _buildUsername(),
          _buildEmail(),
          _buildInformation(),
        ],
      ),
    );
  }

  Widget _buildUsername(){
    return RoundedInputField (
      formControlTextName: "username",
      textInputType: TextInputType.text,
      hintText: 'Nombre de usuario',
      icon: FontAwesomeIcons.solidUser,
      labelText: 'Nombre de usuario',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required: 'El nombre de usuario es requerido',
        ValidationMessage.minLength: 'El nombre de usuario debe tener como minimo 5 caracteres',
        ValidationMessage.maxLength: 'El nombre de usuario debe tener como maximo 20 caracteres',
      },
    );
  }

  Widget _buildInformation(){
    return RoundedInputField (
      formControlTextName: "informacion",
      textInputType: TextInputType.multiline,
      hintText: 'Información del usuario',
      // icon: FontAwesomeIcons.solidEnvelope,
      labelText: 'Información del usuario',
      minLines: 5,
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.maxLength: 'El nombre de usuario debe tener como maximo 250 caracteres',
      },
    );
  }

  Widget _buildEmail(){
    return RoundedInputField (
      formControlTextName: "email",
      textInputType: TextInputType.emailAddress,
      hintText: 'Email',
      icon: FontAwesomeIcons.solidEnvelope,
      labelText: 'Email',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required: 'El email es importante',
        ValidationMessage.email: 'El email es incorrecto',
        ValidationMessage.maxLength: 'El email debe tener como maximo 60 caracteres',
      },
    );
  }

  Widget _buildNombres(){
    return RoundedInputField (
      formControlTextName: "first_name",
      textInputType: TextInputType.text,
      hintText: 'Nombres',
      icon: FontAwesomeIcons.solidUser,
      labelText: 'Nombres',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required: 'El nombre es importante',
        ValidationMessage.maxLength: 'El nombre debe tener como maximo 50 caracteres',
      },
    );
  }

  Widget _buildApellidos(){
    return RoundedInputField (
      formControlTextName: "last_name",
      textInputType: TextInputType.text,
      hintText: 'Apellidos',
      icon: FontAwesomeIcons.solidUser,
      labelText: 'Apellidos',
      onSubmitted: () {},
      validationMessages: {
        ValidationMessage.required: 'Los apellidos son importante',
        ValidationMessage.maxLength: 'Los apellidos deben tener como maximo 50 caracteres',
      },
    );
  }



}


class _AvatarCircle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return BlocBuilder<UserAppBloc, UserAppState>(
      builder: (context, state) {

        String image = (state.userAccess!= null && state.userAccess!.avatar!=null)?state.userAccess!.avatar!:'';
        if (state.imagePicker!=null) {
          image = state.imagePicker!;
        }
        print("cdscsd");
        return _buildCircleAvatar(image, responsive.ip(23), context);
      }
    );
  }

  Widget _buildCircleAvatar(String? image, double size, BuildContext context) {
    final responsive = Responsive.of(context);
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(responsive.ip(0.5)),
        decoration: BoxDecoration (
          shape: BoxShape.circle,
          color: Colors.white
        ),
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration (
                shape: BoxShape.circle,
                color: Colors.grey
            ),
            child:  (image==null || image.isEmpty)?
            _buldNoImage('assets/app/img/no-image.png')
                :
            _buldFadeInImage(
                imageUrl: image,
                placeholder: 'assets/app/gifs/pato.gif'
            ),
          ),
        ),
      ),
    );
  }

  Widget _buldFadeInImage({required String placeholder, required String imageUrl}) {
    // final base64Img = await Io.File(imageUrl).readAsBytesSync().toString();
    // Uint8List bytesList = base64Decode(base64Img);
    if (imageUrl.contains("http://") || imageUrl.contains("https://")){
      return  FadeInImage(
        placeholder: AssetImage(placeholder),
        image: NetworkImage(imageUrl),
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        Io.File(imageUrl),
        fit: BoxFit.cover
      );
    }
  }

  Widget _buldNoImage(String assetsImage){

    return Image(
      image: AssetImage(assetsImage),
      fit: BoxFit.cover,
    );
  }

}

