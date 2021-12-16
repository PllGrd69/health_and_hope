import 'package:reactive_forms/reactive_forms.dart';


class _BuscarAsistenteFormController {
  final FormGroup buscarAsistenteForm = FormGroup({
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
    buscarAsistenteForm.control('dni').reset();
    buscarAsistenteForm.control('email').reset();
  }


  String get getEmail => buscarAsistenteForm.control('email').value??'';
  String get getDni => buscarAsistenteForm.control('dni').value??'';


}



final buscarAsistenteFormController = _BuscarAsistenteFormController();