import 'package:flutter/material.dart';

class CardOnBoardData {
  final String title;
  final String subtitle;
  final ImageProvider image;
  final Color backgroundColor;
  final Color titleColor;
  final Color subtitleColor;
  final Widget? background;

  const CardOnBoardData({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.backgroundColor,
    required this.titleColor,
    required this.subtitleColor,
    this.background
  });
}

class CardOnBoard extends StatelessWidget {
    const CardOnBoard({required this.data,super.key});
  
    final CardOnBoardData data;

    @override
    Widget build(BuildContext context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          if(data.background != null) data.background!,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40
            ),
            child: Column(
              children: [
                const Spacer(flex: 3,),
                Flexible(
                  flex: 20,
                  child: Image(image: data.image)
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(height: 15,)
                ),
                Text(
                  data.title,
                  style: TextStyle(
                    color: data.titleColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  ),
                  maxLines: 1,
                ),
                const Flexible(
                  flex: 1,
                  child: SizedBox(height: 15,)  
                ),
                Text(
                  data.subtitle,
                  style: TextStyle(
                    color: data.subtitleColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(flex: 10,)
              ],
            ),
          ),
        ],
      );
    }
}