import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:health_and_hope/src/bloc/bloc.dart';
import 'package:health_and_hope/src/models/baseModel/models.dart';
import 'package:health_and_hope/src/screens/calendario/inforDiaModalWidget.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'package:health_and_hope/src/utils/textFontStyle.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarioParticipanteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    BlocProvider.of<ProgresoActividadBloc>(context, listen: false).add(MiTarjetaProgresoActividadEvent());

    final builder = BlocBuilder<ProgresoActividadBloc, ProgroseActividadState>(
      builder: (context, state) {
        if (state.listTarjetaProgresoActividad!=null) {

          final valores = state.listTarjetaProgresoActividad!.map((e) {
            return Column(
              children: [
                SizedBox(height: responsive.ip(3)),
                Text(e.tarjetaUsuario!.titulo!, style: TextFontStyle.of(context).title2),
                TableEventsCalendar(progresoActividad: e),
                SizedBox(height: responsive.ip(5)),
              ],
            );
          }).toList();

          return Column(children: valores);
        }
        return Container();
      }
    );
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: responsive.ip(3)),
          child: builder
        )
      )
    );


  }
}

class TableEventsCalendar extends StatefulWidget {
  final ProgresoActividadDiarioModel progresoActividad;

  const TableEventsCalendar({
    Key? key,
    required this.progresoActividad,
  }) : super(key: key);

  @override
  _TableEventsCalendarState createState() => _TableEventsCalendarState();
}

class _TableEventsCalendarState extends State<TableEventsCalendar> {
  // late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    final fechaActual = widget.progresoActividad.actividadHoy!.actividadFecha;
    _focusedDay = (fechaActual!=null)? DateTime.parse(fechaActual): DateTime.now();
    // _focusedDay = DateTime.parse(widget.progresoActividad.actividadHoy!.actividadFecha!);
    _selectedDay = _focusedDay;
    // _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    // _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);
    for (var i=0; i<days.length; i++){
      print(days[i]);
    }
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay)  {
    final valor = widget.progresoActividad.actividadesDiarias!.where((element){
      final fechaActividad = DateTime.parse(element.actividadFecha!);
      final fecha = DateTime.parse(selectedDay.toString().substring(0, selectedDay.toString().length-1));
      return fechaActividad == fecha;
    }).toList();

    if (valor.isNotEmpty){
      SmartDialog.show(
          tag: 'CalendarioDiaSelect',
          alignmentTemp: Alignment.center,
          widget: InfoDiaModalWidget(
            actividadProgreso: valor[0],
          )
      );
    }

    print(selectedDay);

    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
    // `start` or `end` could be null
    // if (start != null && end != null) {
    //   _selectedEvents.value = _getEventsForRange(start, end);
    // } else if (start != null) {
    //   _selectedEvents.value = _getEventsForDay(start);
    // } else if (end != null) {
    //   _selectedEvents.value = _getEventsForDay(end);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.1),
      child: TableCalendar<Event>(
        firstDay: DateTime.parse(widget.progresoActividad.tarjetaUsuario!.fechaInicio!),
        lastDay: DateTime.parse(widget.progresoActividad.tarjetaUsuario!.fechaFin!),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        rangeStartDay: _rangeStart,
        rangeEndDay: _rangeEnd,
        calendarFormat: _calendarFormat,
        rangeSelectionMode: _rangeSelectionMode,
        // eventLoader: _getEventsForDay,
        eventLoader: (day) {
          final valor = widget.progresoActividad.actividadesDiarias!.where((element){
            final fechaActividad = DateTime.parse(element.actividadFecha!);
            final fecha = DateTime.parse(day.toString().substring(0, day.toString().length-1));
            return fechaActividad == fecha;
          }).toList();

          if (valor.isNotEmpty){
            if (valor[0].actividadesMarcadas!=0){
              return [Event('xd')];
            }
          }
          return [];
        },
        // startingDayOfWeek: StartingDayOfWeek.monday,
        calendarStyle: CalendarStyle(
          // Use `CalendarStyle` to customize the UI
          outsideDaysVisible: false,
        ),
        onDaySelected: _onDaySelected,
        onRangeSelected: _onRangeSelected,
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
      ),
    );
  }
}
//
//


class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(2021, 12, 1);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);