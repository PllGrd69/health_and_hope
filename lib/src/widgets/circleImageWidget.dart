import 'package:flutter/material.dart';
import 'package:health_and_hope/src/utils/responsive.dart';
import 'dart:io' as Io;

class CircleImageAvatarWidget extends StatelessWidget {
  // const CircleImageWidget({Key? key}) : super(key: key);
  final String? imageUrl;
  final double radio;
  final double padding;

  const CircleImageAvatarWidget({
    this.imageUrl,
    required this.radio,
    required this.padding
  });

  @override
  Widget build(BuildContext context) {
    return _AvatarCircle(image: imageUrl, radio: radio, padding: padding,);
  }
}


class _AvatarCircle extends StatelessWidget {
  final String? image;
  final double radio;
  final double padding;
  const _AvatarCircle({this.image, required this.radio, required this.padding});

  @override
  Widget build(BuildContext context) {
    return _buildCircleAvatar(image, radio, context);
  }
  Widget _buildCircleAvatar(String? image, double size, BuildContext context) {
    final responsive = Responsive.of(context);
    return ClipOval(
      child: Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(padding/*responsive.ip(0.5)*/),
        decoration: BoxDecoration (
            shape: BoxShape.circle,
            color: Colors.white
        ),
        child: ClipOval(
          child: Container(
            decoration: BoxDecoration (
                shape: BoxShape.circle,
                color: Colors.grey
            ),
            child:  (image==null || image.isEmpty)?
            _buldNoImage('assets/app/img/no-image.png')
                :
            _buldFadeInImage(
                imageUrl: image,
                placeholder: 'assets/app/gifs/pato.gif'
            ),
          ),
        ),
      ),
    );



  }

  Widget _buldFadeInImage({required String placeholder, required String imageUrl}) {
    if (imageUrl.contains("http://") || imageUrl.contains("https://")){
      return  FadeInImage(
        placeholder: AssetImage(placeholder),
        image: NetworkImage(imageUrl),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            'assets/app/img/not-found-img.png',
            fit: BoxFit.cover,
          );
        },
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
          Io.File(imageUrl),
          fit: BoxFit.cover
      );
    }
  }

  Widget _buldNoImage(String assetsImage){

    return Image(
      image: AssetImage(assetsImage),
      fit: BoxFit.cover,
    );
  }
}

