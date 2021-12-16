import 'package:reactive_forms/reactive_forms.dart';


class _SendEmailResetPwdController {
  final FormGroup resetPasswordForm= FormGroup({
    'email':FormControl<String>(
      validators: [
        Validators.required,
        Validators.email,
        Validators.maxLength(60),
      ],
      value: ''
    ),
    'token':FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(8),
        Validators.minLength(8),
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
    'bell': FormControl<String>(
      validators: [
        Validators.required,
      ],
      value: 'Default',
    ),
  }, validators: [
    _mustMatch('password', 'passwordConfirmation')
  ]);

  void cleanData() {
    this.resetPasswordForm.control('email').reset();
    this.resetPasswordForm.control('token').reset();
    this.resetPasswordForm.control('password').reset();
    this.resetPasswordForm.control('passwordConfirmation').reset();
  }

  bool get isEmailValid => this.resetPasswordForm.control('email').valid;
  String get getEmail => this.resetPasswordForm.control('email').value;
  void touchErrorEmail() => this.resetPasswordForm.control('email').markAsTouched();
  set errorEmail(String value) => this.resetPasswordForm.control('email').setErrors({value:'email'});

  String get getToken => this.resetPasswordForm.control('token').value;
  set errorToken(String value) => this.resetPasswordForm.control('token').setErrors({value:'token'});

  String get getPassword => this.resetPasswordForm.control('password').value;
  set errorPassword(String value) => this.resetPasswordForm.control('password').setErrors({value:'password'});


  void errorFormsMapFromApi(Map<dynamic,dynamic>? errors){

    if (errors!=null) {
      print("-----------------Mapeo de errores");
      if (errors.containsKey('email')){
        errorEmail = 'No pudimos encontrar una cuenta asociada.';
        resetPasswordForm.control('email').markAsTouched();
      }
      if (errors.containsKey('token')) {
        errorToken = errors['token'][0];
        resetPasswordForm.control('token').markAsTouched();
      }
      if (errors.containsKey('password')) {
        errorPassword = errors['password'][0];
        resetPasswordForm.control('password').markAsTouched();
      }
    }
  }

}


ValidatorFunction _mustMatch(String controlName, String matchingControlName) {
  return (AbstractControl<dynamic> control) {
    final form = control as FormGroup;
    final formControl = form.control(controlName);
    final matchingFormControl = form.control(matchingControlName);
    if (formControl.value != matchingFormControl.value) {
      matchingFormControl.setErrors({'mustMatch': true});
      matchingFormControl.markAsTouched();
    } else {
      matchingFormControl.removeError('mustMatch');
    }
    return null;
  };
}

final sendEmailResetPwdController = _SendEmailResetPwdController();