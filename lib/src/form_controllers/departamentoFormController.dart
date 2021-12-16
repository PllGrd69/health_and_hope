import 'package:reactive_forms/reactive_forms.dart';


class _DepartamentoFormController {
  final FormGroup departamentoForm = FormGroup({
    'nombre':FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(4),
        Validators.maxLength(50),
      ],
      value: ''
    ),
  });

  void cleanData() {
    this.departamentoForm.control('nombre').reset();
  }

  bool get isNombreValid => this.departamentoForm.control('nombre').valid;

  String get getNombre => this.departamentoForm.control('nombre').value;
  set errorNombre(String value) => this.departamentoForm.control('nombre').setErrors({value:'nombre'});

  void errorFormsMapFromApi(Map<dynamic,dynamic>? errors){
    if (errors!=null) {
      if (errors.containsKey('nombre')){
        errorNombre = errors['nombre'][0];
      }
    }
  }

}



final departamentoFormController = _DepartamentoFormController();