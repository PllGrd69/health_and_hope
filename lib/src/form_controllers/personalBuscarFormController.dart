import 'package:reactive_forms/reactive_forms.dart';


class _BuscarPersonalFormController {
  final FormGroup buscarPersonalTodosForm = FormGroup({
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
    buscarPersonalTodosForm.control('dni').reset();
    buscarPersonalTodosForm.control('email').reset();
  }

  String get getEmail => buscarPersonalTodosForm.control('email').value??'';
  String get getDni => buscarPersonalTodosForm.control('dni').value??'';

}



final buscarPersonalTodosFormController = _BuscarPersonalFormController();