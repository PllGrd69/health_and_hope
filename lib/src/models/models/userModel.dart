import 'dart:convert';
import 'package:health_and_hope/src/models/baseModel/baseModel.dart';
import 'package:intl/intl.dart';

// class CreateUserModel implements BaseModel{
//   CreateUserModel({
//     required this.email,
//     required this.firstName,
//     required this.lastName,
//     required this.username,
//     required this.password,
//   });
//
//   String email;
//   String firstName;
//   String lastName;
//   String username;
//   String password;
//
//   factory CreateUserModel.fromJson(List<int> str) => CreateUserModel.fromMap(json.decode(utf8.decode(str)));
//
//   String toJson() => json.encode(toMap());
//
//   factory CreateUserModel.fromMap(Map<String, dynamic> json) => CreateUserModel(
//     email: json["email"],
//     firstName: json["first_name"],
//     lastName: json["last_name"],
//     username: json["username"],
//     password: json["password"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "email": email,
//     "first_name": firstName,
//     "last_name": lastName,
//     "username": username,
//     "password": password,
//   };
// }

class CreateUserModel implements BaseModel {
  CreateUserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.username,
    this.password,
    this.genero,
    this.fechaNacimiento,
    this.direccionActual,
    this.dni,
    this.rol,
  });

  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? username;
  String? password;
  String? genero;
  String? fechaNacimiento;
  String? direccionActual;
  String? dni;
  String? rol;

  factory CreateUserModel.fromJson(String str) => CreateUserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CreateUserModel.fromMap(Map<String, dynamic> json) => CreateUserModel(
    id: json["id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    password: json["password"],
    genero: json["genero"],
    fechaNacimiento: json["fechaNacimiento"],
    direccionActual: json["direccionActual"],
    dni: json["dni"],
    rol: json["rol"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "password": password,
    "genero": genero,
    "fechaNacimiento": fechaNacimiento,
    "direccionActual": direccionActual,
    "dni": dni,
    "rol": rol,
  };
}



// class UserModel extends BaseModel{
//   UserModel({
//     this.id,
//     this.username,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.avatar= '',
//     this.informacion = '',
//     this.created= '',
//     this.modified= '',
//     this.lastLogin= '',
//     this.rol,
//   });
//
//   UserModel copyWith({UserModel? userModel}){
//     if (userModel!=null) {
//       return UserModel(
//         id: (userModel.id==null || userModel.id!.isEmpty)?this.id:userModel.id,
//         username: (userModel.username==null || userModel.username!.isEmpty)?this.username:userModel.username,
//         firstName: (userModel.firstName==null || userModel.firstName!.isEmpty)?this.firstName:userModel.firstName,
//         lastName: (userModel.lastName==null || userModel.lastName!.isEmpty)?this.lastName:userModel.lastName,
//         email: (userModel.email==null || userModel.email!.isEmpty)?this.email:userModel.email,
//         avatar: (userModel.avatar==null || userModel.avatar!.isEmpty)?this.avatar:userModel.avatar,
//         informacion: (userModel.informacion==null || userModel.informacion!.isEmpty)?this.informacion:userModel.informacion,
//         created: (userModel.created==null || userModel.created!.isEmpty)?this.created:userModel.created,
//         modified: (userModel.modified==null || userModel.modified!.isEmpty)?this.modified:userModel.modified,
//         lastLogin: (userModel.lastLogin==null || userModel.lastLogin!.isEmpty)?this.lastLogin:userModel.lastLogin,
//         rol: (userModel.rol==null)?this.rol:userModel.rol,
//       );
//     }else {
//       return this;
//     }
//   }
//
//   bool compareValues({UserModel? userModel}){
//     if (userModel != null) {
//       bool username = this.username == userModel.username;
//       bool firstName = this.firstName == userModel.firstName;
//       bool lastName = this.lastName == userModel.lastName;
//       bool email = this.email == userModel.email;
//       bool informacion = this.informacion == userModel.informacion;
//
//       return (username && firstName && lastName && email && informacion);
//     }
//     return false;
//   }
//
//   String? id;
//   String? username;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? avatar;
//   String? informacion;
//   String? created;
//   String? modified;
//   String? lastLogin;
//   String? rol;
//
//   factory UserModel.fromJson(List<int> str) => UserModel.fromMap(json.decode(utf8.decode(str)));
//
//   String toJson() => json.encode(toMap());
//
//   // String httpsFormatUrl(String url){
//   //   return url.replaceAll("http://", "https://")
//   // }
//
//   factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
//     id: json["id"]??'',
//     username: json["username"]??'',
//     firstName: json["first_name"]??'',
//     lastName: json["last_name"]??'',
//     email: json["email"]??'',
//     avatar: (json["avatar"]??''),
//     informacion: json["informacion"]??'',
//     created: json["created"]??'',
//     modified: json["modified"]??'',
//     lastLogin: json["last_login"]??'',
//     rol: json["rol"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "username": username,
//     "first_name": firstName,
//     "last_name": lastName,
//     "email": email,
//     "avatar": avatar,
//     "informacion": informacion,
//     "created": created,
//     "modified": modified,
//     "last_login": lastLogin,
//     "rol": rol,
//   };
// }



class UserModel extends BaseModel {
  UserModel({
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.isActive,
    this.email,
    this.avatar,
    this.informacion,
    this.genero,
    this.fechaNacimiento,
    this.direccionActual,
    this.latitud,
    this.longitud,
    this.bienvenida,
    this.dni,
    this.created,
    this.modified,
    this.rol,
  });

  String? id;
  String? username;
  String? firstName;
  String? lastName;
  bool? isActive;
  String? email;
  String? avatar;
  String? informacion;
  String? genero;
  String? fechaNacimiento;
  String? direccionActual;
  String? latitud;
  String? longitud;
  bool? bienvenida;
  String? dni;
  String? created;
  String? modified;
  String? rol;


  String get getCreated {
    final fechaFormat = DateTime.parse(this.created!).toLocal();
    final DateFormat formatter = DateFormat('yyyy-MM-dd').add_jm();
    final String formatted = formatter.format(fechaFormat);
    return formatted;
  }

  String get getModified {
    final fechaFormat = DateTime.parse(this.modified!).toLocal();
    final DateFormat formatter = DateFormat('yyyy-MM-dd').add_jm();
    final String formatted = formatter.format(fechaFormat);
    return formatted;
  }

  UserModel copyWith({UserModel? userModel}){
    if (userModel!=null) {
      return UserModel(
        id: (userModel.id==null || userModel.id!.isEmpty)?this.id:userModel.id,
        username: (userModel.username==null || userModel.username!.isEmpty)?this.username:userModel.username,
        firstName: (userModel.firstName==null || userModel.firstName!.isEmpty)?this.firstName:userModel.firstName,
        lastName: (userModel.lastName==null || userModel.lastName!.isEmpty)?this.lastName:userModel.lastName,
        email: (userModel.email==null || userModel.email!.isEmpty)?this.email:userModel.email,
        avatar: (userModel.avatar==null || userModel.avatar!.isEmpty)?this.avatar:userModel.avatar,
        informacion: (userModel.informacion==null || userModel.informacion!.isEmpty)?this.informacion:userModel.informacion,
        created: (userModel.created==null || userModel.created!.isEmpty)?this.created:userModel.created,
        modified: (userModel.modified==null || userModel.modified!.isEmpty)?this.modified:userModel.modified,
        rol: (userModel.rol==null)?this.rol:userModel.rol,
      );
    }else {
      return this;
    }
  }

  bool compareValues({UserModel? userModel}){
    if (userModel != null) {
      bool username = this.username == userModel.username;
      bool firstName = this.firstName == userModel.firstName;
      bool lastName = this.lastName == userModel.lastName;
      bool email = this.email == userModel.email;
      bool informacion = this.informacion == userModel.informacion;

      return (username && firstName && lastName && email && informacion);
    }
    return false;
  }

  factory UserModel.fromJson(String str) => UserModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    isActive: json["is_active"],
    email: json["email"],
    avatar: json["avatar"],
    informacion: json["informacion"],
    genero: json["genero"],
    fechaNacimiento: json["fechaNacimiento"],
    direccionActual: json["direccionActual"],
    latitud: json["latitud"],
    longitud: json["longitud"],
    bienvenida: json["bienvenida"],
    dni: json["dni"],
    created: json["created"],
    modified: json["modified"],
    rol: json["rol"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "is_active": isActive,
    "email": email,
    "avatar": avatar,
    "informacion": informacion,
    "genero": genero,
    "fechaNacimiento": fechaNacimiento,
    "direccionActual": direccionActual,
    "latitud": latitud,
    "longitud": longitud,
    "bienvenida": bienvenida,
    "dni": dni,
    "created": created,
    "modified": modified,
    "rol": rol,
  };
}