import 'package:flutter/material.dart'
    show
        StatelessWidget,
        Key,
        Widget,
        Image,
        BoxFit,
        Alignment,
        MediaQuery,
        BuildContext;

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/Rectangle 20.png',
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.7,
    );
  }
}
