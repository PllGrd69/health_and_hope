
import 'package:reactive_forms/reactive_forms.dart';

class UserInformationController {
  final FormGroup userInformationForm= FormGroup({
    'username':FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(5),
        Validators.maxLength(20),
      ],
      value: ''
    ),
    'first_name':FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
        value: ''
    ),
    'last_name':FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
        value: ''
    ),
    'email':FormControl<String>(
        validators: [
          Validators.required,
          Validators.email,
          Validators.maxLength(60),
        ],
        value: ''
    ),
    'informacion':FormControl<String>(
        validators: [
          Validators.maxLength(250),
        ],
        value: ''
    ),
  });

  void cleanData() {
    this.userInformationForm.control('username').reset();
    this.userInformationForm.control('first_name').reset();
    this.userInformationForm.control('last_name').reset();
    this.userInformationForm.control('email').reset();
    this.userInformationForm.control('informacion').reset();
  }

  String get getInformacion => this.userInformationForm.control('informacion').value;
  set setInformacion(String value) => this.userInformationForm.control('informacion').value = value;
  set errorInformacion(String value) => this.userInformationForm.control('informacion').setErrors({value:'informacion'});

  String get getEmail => this.userInformationForm.control('email').value;
  set setEmail(String value) => this.userInformationForm.control('email').value = value;
  set errorEmail(String value) => this.userInformationForm.control('email').setErrors({value:'email'});

  String get getLastName => this.userInformationForm.control('last_name').value;
  set setLastName(String value) => this.userInformationForm.control('last_name').value = value;
  set errorLastName(String value) => this.userInformationForm.control('last_name').setErrors({value:'last_name'});

  String get getUsername => this.userInformationForm.control('username').value;
  set setUsername(String value) => this.userInformationForm.control('username').value = value;
  set errorUsername(String value) => this.userInformationForm.control('username').setErrors({value:'username'});

  String get getFirstName => this.userInformationForm.control('first_name').value;
  set setFirstName(String value) => this.userInformationForm.control('first_name').value = value;
  set errorFirstName(String value) => this.userInformationForm.control('first_name').setErrors({value:'first_name'});

  void errorFormsMapFromApi(Map<dynamic,dynamic>? errors){
    if (errors!=null) {
      if (errors.containsKey('informacion')) errorInformacion = errors['informacion'][0];
      if (errors.containsKey('email')) errorEmail = errors['email'][0];
      if (errors.containsKey('last_name')) errorLastName = errors['last_name'][0];
      if (errors.containsKey('username')) errorUsername = errors['username'][0];
      if (errors.containsKey('first_name')) errorFirstName = errors['first_name'][0];
    }
  }

}

final userInformationController = UserInformationController();