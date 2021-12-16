import 'package:reactive_forms/reactive_forms.dart';

class _BuscarParticipanteFormController {
  final FormGroup buscarParticipanteTodosForm = FormGroup({
    'dni':FormControl<String>(
      validators: [
        Validators.maxLength(8),
      ],
      value: ''
    ),
    'email': FormControl<String>(
      validators: [
        Validators.maxLength(100),
      ],
      value: ''
    ),
  });

  void cleanData() {
    buscarParticipanteTodosForm.control('dni').reset();
    buscarParticipanteTodosForm.control('email').reset();
  }

  String get getEmail => buscarParticipanteTodosForm.control('email').value??'';
  String get getDni => buscarParticipanteTodosForm.control('dni').value??'';

}


final buscarParticipanteTodosFormController = _BuscarParticipanteFormController();