
import 'package:reactive_forms/reactive_forms.dart';

class _RegisterController {
  final FormGroup registerForm= FormGroup({
    'nombres':FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
        value: ''
    ),
    'apellidos':FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(50),
        ],
        value: ''
    ),
    'genero': FormControl<String>(
        validators: [
          Validators.required,
        ],
        value: ''
    ),
    'fechaNacimiento': FormControl<DateTime>(
        validators: [
          Validators.required,
        ],
        value: null
    ),
    'direccionActual': FormControl<String>(
        validators: [
          Validators.required,
          Validators.maxLength(75),
        ],
        value: ''
    ),
    'dni': FormControl<String>(
        validators: [
          Validators.required,
          Validators.number,
          Validators.maxLength(8),
          Validators.minLength(8),
        ],
        value: ''
    ),
    'user':FormControl<String>(
        validators: [
          Validators.required,
          Validators.minLength(5),
          Validators.maxLength(20),
        ],
        value: ''
    ),
    'rol':FormControl<String>(
        validators: [
          Validators.required,
        ],
        value: ''
    ),
    'email':FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
        Validators.minLength(5),
        Validators.maxLength(60),
      ],
      value: ''
    ),
    'password':FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
        Validators.maxLength(25),
        Validators.pattern(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$'),
      ],
      value: ''
    ),
    'passwordConfirmation':FormControl<String>(value: ''),
  }, validators: [
    _mustMatch('password', 'passwordConfirmation')
  ]);

  void cleanData() {
    this.registerForm.control('nombres').reset();
    this.registerForm.control('apellidos').reset();
    this.registerForm.control('genero').reset();
    this.registerForm.control('fechaNacimiento').reset();
    this.registerForm.control('direccionActual').reset();
    this.registerForm.control('dni').reset();
    this.registerForm.control('rol').reset();
    this.registerForm.control('user').reset();
    this.registerForm.control('email').reset();
    this.registerForm.control('password').reset();
    this.registerForm.control('passwordConfirmation').reset();
  }

  String get getRol => this.registerForm.control('rol').value;
  set setRol(String rol) => this.registerForm.control('rol').value = rol;
  set errorRol(String value) => this.registerForm.control('rol').setErrors({value:'rol'});

  String get getDni => this.registerForm.control('dni').value;
  set errorDni(String value) => this.registerForm.control('dni').setErrors({value:'dni'});

  String get getDireccionActual => this.registerForm.control('direccionActual').value;
  set errorDireccionActual(String value) => this.registerForm.control('direccionActual').setErrors({value:'direccionActual'});

  DateTime get getFechaNacimiento{
    return this.registerForm.control('fechaNacimiento').value;
  }
  set errorFechaNacimiento(String value) => this.registerForm.control('fechaNacimiento').setErrors({value:'fechaNacimiento'});

  String get getGenero => this.registerForm.control('genero').value;
  set errorGenero(String value) => this.registerForm.control('genero').setErrors({value:'genero'});



  String get getUser => this.registerForm.control('user').value;
  set errorUser(String value) => this.registerForm.control('user').setErrors({value:'user'});

  String get getApellidos => this.registerForm.control('apellidos').value;
  set errorApellidos(String value) => this.registerForm.control('apellidos').setErrors({value:'apellidos'});

  String get getEmail => this.registerForm.control('email').value;
  set errorEmail(String value) => this.registerForm.control('email').setErrors({value:'email'});

  String get getNombres => this.registerForm.control('nombres').value;
  set errorNombres(String value) => this.registerForm.control('nombres').setErrors({value:'nombres'});

  String get getPassword => this.registerForm.control('password').value;
  set errorPassword(String value) => this.registerForm.control('password').setErrors({value:'password'});

  void errorFormsMapFromApi(Map<dynamic,dynamic>? errors){
    if (errors!=null) {
      if (errors.containsKey('email')) errorEmail = errors['email'][0];
      if (errors.containsKey('first_name')) errorNombres = errors['first_name'][0];
      if (errors.containsKey('last_name')) errorApellidos = errors['last_name'][0];
      if (errors.containsKey('username')) errorUser = errors['username'][0];
      if (errors.containsKey('password')) errorPassword = errors['password'][0];
      if (errors.containsKey('rol')) errorRol= errors['rol'][0];
      if (errors.containsKey('dni')) errorDni = errors['dni'][0];
      if (errors.containsKey('direccionActual')) errorDireccionActual = errors['direccionActual'][0];
      if (errors.containsKey('fechaNacimiento')) errorFechaNacimiento = errors['fechaNacimiento'][0];
      if (errors.containsKey('genero')) errorGenero = errors['genero'][0];
    }
  }

}

final registerUserController = _RegisterController();




ValidatorFunction _mustMatch(String controlName, String matchingControlName) {
  return (AbstractControl<dynamic> control) {
    final form = control as FormGroup;

    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);

    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});

      // force messages to show up as soon as possible
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError('mustMatch');
    }

    return null;
  };
}