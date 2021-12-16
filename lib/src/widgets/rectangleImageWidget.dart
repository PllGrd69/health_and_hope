import 'package:flutter/material.dart';
import 'dart:io' as Io;


class RectangleImageWidget extends StatelessWidget {
  final String? urlImage;
  const RectangleImageWidget({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return _builImageUser(urlImage);
  }


  Widget _builImageUser(String? image) {
    if(image!=null && image.contains('assets/')) {
      return _buldNoImage(image);
    }

    return (image==null || image.isEmpty)?
    _buldNoImage('assets/app/img/no-image.png')
        :
    _buldFadeInImage(
        imageUrl: image,
        placeholder: 'assets/app/gifs/pato.gif'
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
