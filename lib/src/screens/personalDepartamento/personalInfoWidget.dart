import 'package:flutter/material.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/widgets/dialogContentWidget.dart';

class InfoUsuarioModalWidget extends StatelessWidget {
  final UserModel usuario;

  InfoUsuarioModalWidget({required this.usuario});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyle = TextFontStyle.of(context);

    final valor = ModalBaseCustomWidget(
        children: [
          SizedBox(width:responsive.width),
          Text(
            '${usuario.firstName} ${usuario.lastName}',
            style: fontStyle.subtitle2.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          _buildActivo(fontStyle, responsive),
          _buildEmail(fontStyle, responsive),
          _buildGenero(fontStyle, responsive),
          _buildInformacion(fontStyle, responsive),
          _buildFechaNacimiento(fontStyle, responsive),
          _buildDeireccion(fontStyle, responsive),
          _buildBienvenida(fontStyle, responsive),
          _buildDNI(fontStyle, responsive),
        ]
    );

    return valor;
  }



  Widget _buildActivo(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activo: ', style: fontStyle.normalText1.copyWith(color: Colors.white),),
              Text(
                '${usuario.isActive}',
                style: fontStyle.normalText1.copyWith(color: Colors.white),
              ),
            ],
          ),
      ),
    );
  }

  Widget _buildEmail(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Email: ', style: fontStyle.normalText1.copyWith(color: Colors.white)),
            Text('${usuario.email}', style: fontStyle.normalText1.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildGenero(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Género: ', style: fontStyle.normalText1.copyWith(color: Colors.white)),
            Text('${usuario.genero}', style: fontStyle.normalText1.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildInformacion(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Información: ', style: fontStyle.normalText1.copyWith(color: Colors.white)),
            Text('${usuario.informacion}', style: fontStyle.normalText1.copyWith(color: Colors.white)),
          ],
        )
      ),
    );
  }

  Widget _buildFechaNacimiento(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Fecha de Nacimiento: ', style: fontStyle.normalText1.copyWith(color: Colors.white)),
            Text('${usuario.fechaNacimiento}', style: fontStyle.normalText1.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildDeireccion(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dirección: ', style: fontStyle.normalText1.copyWith(color: Colors.white)),
            Text('${usuario.direccionActual}', style: fontStyle.normalText1.copyWith(color: Colors.white)),
          ],
        ),
      ),
    );
  }


  Widget _buildBienvenida(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bienvenida: ', style: fontStyle.normalText1.copyWith(color: Colors.white)),
            Text('${usuario.bienvenida}', style: fontStyle.normalText1.copyWith(color: Colors.white)),
          ]
        ),
      ),
    );
  }

  Widget _buildDNI(TextFontStyle fontStyle, Responsive responsive) {
    return Container(
      width: responsive.ip(26),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('DNI: ', style: fontStyle.normalText1.copyWith(color: Colors.white), textAlign: TextAlign.start),
            Text('${usuario.dni}', style: fontStyle.normalText1.copyWith(color: Colors.white), textAlign: TextAlign.start),
          ],
        ),
      ),
    );
  }


}

