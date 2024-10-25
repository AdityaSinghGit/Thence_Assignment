import 'package:flutter/material.dart'
    show
        Align,
        Alignment,
        BorderRadius,
        BoxDecoration,
        BoxShadow,
        BuildContext,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        LinearGradient,
        MediaQuery,
        Offset,
        StatelessWidget,
        Text,
        TextStyle,
        Widget;

class BottomContainerWithTitle extends StatelessWidget {
  const BottomContainerWithTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade900,
              Colors.grey.shade700,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 30),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Title
                Text(
                  "Instant Crush",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                //Subtitle
                Text(
                  "feat. Julian Casablancas",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
