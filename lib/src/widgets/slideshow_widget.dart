
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class Slideshow extends StatelessWidget {
  const Slideshow({
    required this.slides,
    this.puntosArriva = false,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.bulletPrimario = 12,
    this.bulletSecundario = 12,
  });
  final List<Widget> slides;
  final bool puntosArriva;
  final Color colorPrimario;
  final Color colorSecundario;
  final double bulletPrimario;
  final double bulletSecundario;
  @override
  Widget build(BuildContext context) {

    return SafeArea(

        child: BlocProvider(
          create: (_)=> _SlideshowBloc(),
          child: Center(
            child: Builder(
              builder: (BuildContext context){
                Future.microtask(() {
                  final blocSlideShow = BlocProvider.of<_SlideshowBloc>(context, listen: false);
                  blocSlideShow.add(_ColorPrimario(colorPrimario: colorPrimario));
                  blocSlideShow.add(_ColorSecundario(colorSecundario: colorSecundario));
                  blocSlideShow.add(_BulletPrimario(bulletPrimario: bulletPrimario));
                  blocSlideShow.add(_BulletSecundario(bulletSecundario: bulletSecundario));
                });
                return CrearStructuraSlideshow(
                  puntosArriva: puntosArriva,
                  slides: slides,
                );
              }
            )
          ),
        )
    );
  }
}

class CrearStructuraSlideshow extends StatelessWidget {
  const CrearStructuraSlideshow({Key? key, required this.puntosArriva, required this.slides}) : super(key: key);
  final puntosArriva;
  final List<Widget> slides;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(puntosArriva) _Dots(slidesNum: slides.length),
        Expanded(
          child: _Slides(slides: this.slides),
        ),
        if(!puntosArriva) _Dots(slidesNum: slides.length),
      ],
    );
  }
}


class _Dots extends StatelessWidget {
  final int slidesNum;
  const _Dots({required this.slidesNum});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(slidesNum, (index) => _Dot(index: index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blocSlideShowState = BlocProvider.of<_SlideshowBloc>(context, listen: true).state;

    final bool condicion = blocSlideShowState.currentPage >= index-0.5 && blocSlideShowState.currentPage < index+0.5;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: (condicion)? blocSlideShowState.bulletPrimario:blocSlideShowState.bulletSecundario,
      height: (condicion)? blocSlideShowState.bulletPrimario:blocSlideShowState.bulletSecundario,
      decoration: BoxDecoration(
          color: (condicion)? blocSlideShowState.colorPrimario: blocSlideShowState.colorSecundario,
          shape: BoxShape.circle
      ),
    );
  }
}

class _Slides extends StatefulWidget {
  const _Slides({Key? key, required this.slides}) : super(key: key);
  final List<Widget> slides;
  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    pageViewController.addListener(() {
      BlocProvider.of<_SlideshowBloc>(context, listen: false).add(
        _CurrentPage(currentPage: pageViewController.page??-1)
      );
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        controller: pageViewController,
        children: widget.slides.map((Widget slide) => _Slide(slide: slide)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({Key? key, required this.slide}) : super(key: key);
  final Widget slide;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: slide,
    );
  }
}


class _SlideshowBloc extends Bloc<_SlideshowEvent, _SlideshowState> {

  _SlideshowBloc(): super(_SlideshowState().initState());
  @override
  Stream<_SlideshowState> mapEventToState(_SlideshowEvent event)  async* {
    if (event is _CurrentPage){
      yield state.copyWith(
        currentPage: (event).currentPage,
      );
    } else if (event is _ColorPrimario) {
      yield state.copyWith(
        colorPrimario: (event).colorPrimario
      );
    } else if (event is _ColorSecundario) {
      yield state.copyWith(
        colorSecundario: (event).colorSecundario
      );
    } else if (event is _BulletPrimario) {
      yield state.copyWith(
        bulletPrimario: (event).bulletPrimario
      );
    } else if (event is _BulletSecundario) {
      yield state.copyWith(
        bulletSecundario: (event).bulletSecundario
      );
    }
  }
}

@immutable
abstract class _SlideshowEvent{}
class _CurrentPage extends _SlideshowEvent{
  final double currentPage;
  _CurrentPage({required this.currentPage});
}
class _ColorPrimario extends _SlideshowEvent {
  final Color colorPrimario;
  _ColorPrimario({required this.colorPrimario});
}
class _ColorSecundario extends _SlideshowEvent {
  final Color colorSecundario;
  _ColorSecundario({required this.colorSecundario});
}
class _BulletPrimario extends _SlideshowEvent {
  final double bulletPrimario;
  _BulletPrimario({required this.bulletPrimario});
}
class _BulletSecundario extends _SlideshowEvent {
  final double bulletSecundario;
  _BulletSecundario({required this.bulletSecundario});
}


class _SlideshowState {
  double currentPage = 0;
  Color colorPrimario = Colors.blue;
  Color colorSecundario = Colors.grey;
  double bulletPrimario = 12;
  double bulletSecundario = 12;

  _SlideshowState({
    this.currentPage = 0,
    this.colorPrimario = Colors.blue,
    this.colorSecundario = Colors.grey,
    this.bulletPrimario = 12,
    this.bulletSecundario = 12
  });

  _SlideshowState copyWith({
    double? currentPage,
    Color? colorPrimario,
    Color? colorSecundario,
    double? bulletPrimario,
    double? bulletSecundario,
  }) => _SlideshowState(
    currentPage: currentPage??this.currentPage,
    colorPrimario: colorPrimario??this.colorPrimario,
    colorSecundario: colorSecundario??this.colorSecundario,
    bulletPrimario: bulletPrimario??this.bulletPrimario,
    bulletSecundario: bulletSecundario??this.bulletSecundario,
  );
  _SlideshowState initState()=> _SlideshowState();
}
