
import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/models/models/progresoActividadModel.dart';
import 'package:health_and_hope/src/models/models/tarjetaModificacionModel.dart';
import 'package:health_and_hope/src/screens/actividad/actividadesScreen.dart';
import 'package:health_and_hope/src/utils/helpers.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/widgets/buttonCustom.dart';
import 'package:intl/intl.dart';

class ParticipanteHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(responsive.ip(2)),
          child: Column(
            children: [
              SizedBox(height: responsive.ip(2), width: responsive.width),
              _buildTitle(context),
              SizedBox(height: responsive.ip(2)),
              _buildProgesoDiaActividades(context),
              SizedBox(height: responsive.ip(2)),
              _CardsImages(),
              SizedBox(height: responsive.ip(2)),
              _ActividadButton(),
              SizedBox(height: responsive.ip(2)),
            ],
          ),
        ),
      ),
    );
  }

  Text _buildTitle(BuildContext context) {
    final stateUser = BlocProvider.of<UserAppBloc>(context, listen: true).state;
    return Text(
      'Hola, ${stateUser.userAccess!.username}',
      style: TextFontStyle.of(context).title1,
    );
  }

  Widget _buildProgesoDiaActividades(BuildContext context) {
      return BlocBuilder<ProgresoActividadBloc, ProgroseActividadState>(
          builder: (context, state) {
            if (state.listProgresoActividad!=null) {
              final valores = state.listProgresoActividad!.map((e) {
                return _ProgresoDiaContent(progresoActividad: e);
              }).toList();
              return Column(
                children: valores,
              ) ;
            }
            return Container();
          }
      );
    // return _ProgresoDiaContent();
  }

}


class _CardsImages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Container(
      width: responsive.ip(70),
      height: responsive.ip(35),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return FadeInImage(
            image: NetworkImage(
              'https://mejorconsalud.as.com/wp-content/uploads/2015/03/ormas-para-beber-agua-menos-aburrido-640x640.jpg',
            ),
            placeholder: AssetImage(
              'assets/app/gifs/jar-loading.gif',
            ),
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/app/gifs/pato.gif',
                fit: BoxFit.cover,
              );
            },
            fit: BoxFit.cover,
          );
        },
        itemCount: 3,
        pagination: SwiperPagination(),
        control: SwiperControl(),
      ),
    );
  }
}


class _ActividadButton extends StatelessWidget {
  Widget _buttonModel(BuildContext context, Responsive responsive, TarjetaModificacionModel tarjetaModif) {
    return Container(
      padding: EdgeInsets.only(bottom: responsive.ip(1)),
      width: responsive.ip(70),
      child: ButtonActionWidget(
        padding: EdgeInsets.symmetric(horizontal: responsive.ip(1.5), vertical: responsive.ip(1.5)),
        text: tarjetaModif.titulo!,
        onPressed: () => onPressed(context, tarjetaModif),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return BlocBuilder<TarjetaModificacionBloc, TarjetaModificacionState>(
      builder: (context, state) {
        if (state.listTarjetaModificacion !=null) {
          final buttons = state.listTarjetaModificacion!.map(
            (e) => _buttonModel(context, responsive,e)
          ).toList();
          return Column(
            children: buttons,
          );
        } else if (state.listTarjetaModificacion == null) {
          return Center(
              child: CircularProgressIndicator()
          );
        } else {
          return Container();
        }
      }
    );

  }

  void onPressed (BuildContext context, TarjetaModificacionModel tarjetaModif) {
    Navigator.pushNamed(
      context,
      ActividadesUsuarioScreen.routeName,
      arguments: tarjetaModif
    );
  }
}


class _ProgresoDiaContent extends StatelessWidget {
  final ProgresoActividadDiarioModel progresoActividad;

  const _ProgresoDiaContent({Key? key, required this.progresoActividad}) : super(key: key);
  BoxDecoration myBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      boxShadow: [
        new BoxShadow(
          color: Colors.black.withOpacity(0.7),
          offset: new Offset(0, 1),
          blurRadius: 6.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final fontStyle = TextFontStyle.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: responsive.ip(2)),
      width: responsive.ip(70),
      decoration: myBoxDecoration(context),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(responsive.ip(3)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: responsive.width),
                Text(progresoActividad.tarjetaUsuario!.titulo??'', style: fontStyle.normalText1),
                Text('Cambio por ${progresoActividad.cantidadDias} días', style: fontStyle.normalText2),
                Text('Dia ${progresoActividad.numDiaHoy}', style: fontStyle.normalText2),
                if(progresoActividad.actividadHoy!=null)Text(
                  '${progresoActividad.actividadHoy!.porcentajeAvanzado}',
                  style: fontStyle.normalText2
                ),
              ],
            )
          ),
          Container(
            child: BarChartPage(
                listaActividad: progresoActividad.actividadesDiarias!,
            )
          ),
        ],
      ),
    );
  }
}


class BarChartPage extends StatelessWidget {
  final List<ActividadProgresoModel> listaActividad;

  const BarChartPage({Key? key, required this.listaActividad}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final listaActividades = listaActividad.map((e)  {
      String dia = DateFormat.EEEE('es_ES').format(DateTime.parse(e.actividadFecha!));
      return BarChartModel(
        titulo: dia.substring(0, 2),
        valorEsperado: e.totalActividades!.toDouble(),
        valorOptenido: e.actividadesMarcadas!.toDouble()
      );
    }).toList();


    if (listaActividades==null || listaActividades.isEmpty) return Container();

    return Container(
      color: Color(0xff232040),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(28.0),
          child: BarChartWidget(
            elementos: listaActividades,
            children: [
              // Text(
              //   'Progreso',
              //   style: TextStyle(color: Colors.white, fontSize: 22),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

class BarChartModel {
  final String titulo;
  final double valorEsperado;
  final double valorOptenido;
  BarChartModel({required this.titulo,required this.valorEsperado,required this.valorOptenido});

}

class BarChartWidget extends StatefulWidget {
  final List<BarChartModel> elementos;
  final List<Widget> children;
  const BarChartWidget({Key? key,required this.elementos, required this.children}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartWidgetState();
}

class BarChartWidgetState extends State<BarChartWidget> {
  final Color leftBarColor = HelpersAppsColors().colorBase;
  final Color rightBarColor = Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  double? maxY = 20;
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    int value = 0;
    final items = widget.elementos.map((e) => makeGroupData(value++, e.valorEsperado, e.valorOptenido)).toList();
    this.maxY = widget.elementos[0].valorEsperado;
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;



    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Color(0xff2c4260),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: widget.children,
              ),
              SizedBox(
                height: 38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: this.maxY??20.0,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (_a, _b, _c, _d) => null,
                        ),
                        touchCallback: (FlTouchEvent event, response) {
                          if (response == null || response.spot == null) {
                            setState(() {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                            });
                            return;
                          }

                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;

                          setState(() {
                            if (!event.isInterestedForInteractions) {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                              return;
                            }
                            showingBarGroups = List.of(rawBarGroups);
                            if (touchedGroupIndex != -1) {
                              var sum = 0.0;
                              for (var rod
                              in showingBarGroups[touchedGroupIndex]
                                  .barRods) {
                                sum += rod.y;
                              }
                              final avg = sum /
                                  showingBarGroups[touchedGroupIndex]
                                      .barRods
                                      .length;

                              showingBarGroups[touchedGroupIndex] =
                                  showingBarGroups[touchedGroupIndex].copyWith(
                                    barRods: showingBarGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(y: avg);
                                    }).toList(),
                                  );
                            }
                          });
                        }),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: SideTitles(showTitles: false),
                      topTitles: SideTitles(showTitles: false),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) => widget.elementos[value.toInt()].titulo,
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => TextStyle(
                            color: Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 8,
                        reservedSize: 28,
                        interval: 1,
                        getTitles: (value) {
                          if (value == 0) {
                            return '0';
                          } else if (value == (widget.elementos[0].valorEsperado*0.5)) {
                            return '${(widget.elementos[0].valorEsperado*0.5).toInt()}';
                          } else if (value == widget.elementos[0].valorEsperado) {
                            return '${value.toInt()}';
                          } else {
                            return '';
                          }
                        },
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        colors: [leftBarColor],
        width: width,
      ),
      BarChartRodData(
        y: y2,
        colors: [rightBarColor],
        width: width,
      ),
    ]);
  }

  Widget makeTransactionsIcon() {
    final width = 4.5;
    final space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
