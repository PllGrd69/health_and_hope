import 'package:reactive_forms/reactive_forms.dart';


class _BuscarAsistentesFormController {
  final FormGroup buscarAsistenteTodosForm = FormGroup({
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
    buscarAsistenteTodosForm.control('dni').reset();
    buscarAsistenteTodosForm.control('email').reset();
  }


  String get getEmail => buscarAsistenteTodosForm.control('email').value??'';
  String get getDni => buscarAsistenteTodosForm.control('dni').value??'';


}



final buscarAsistentesTodosFormController = _BuscarAsistentesFormController();