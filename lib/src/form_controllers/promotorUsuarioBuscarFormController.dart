import 'package:reactive_forms/reactive_forms.dart';


class _BuscarPromotorFormController {
  final FormGroup buscarPromotorForm = FormGroup({
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
    buscarPromotorForm.control('dni').reset();
    buscarPromotorForm.control('email').reset();
  }

  String get getEmail => buscarPromotorForm.control('email').value??'';
  String get getDni => buscarPromotorForm.control('dni').value??'';

}

final buscarPromotorFormController = _BuscarPromotorFormController();