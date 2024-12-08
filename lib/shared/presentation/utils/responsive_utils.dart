import 'package:flutter/material.dart';

class ResponsiveUtils{

  static double getMultiplier(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      return 1.0; // Tablets
    } else {
      return 1.0;
    }
  }

  // Método para obtener un tamaño de fuente escalado en SP
  static double getSp(BuildContext context, double fontSize) {

    // Obtener el tamaño de la pantalla en píxeles lógicos
    double screenWidth = MediaQuery.of(context).size.width;

    // Establecer un tamaño base para la pantalla (típicamente 360.0)
    double baseScreenWidth = 360.0;

    // Obtener el devicePixelRatio, para compensar la densidad de píxeles
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Cálculo del tamaño de la fuente escalado
    double scaleFactor = screenWidth / baseScreenWidth;
    double scaledFontSize = fontSize * scaleFactor * devicePixelRatio;

    return scaledFontSize;
  }
}