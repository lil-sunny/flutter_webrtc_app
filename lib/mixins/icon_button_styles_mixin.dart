import "package:flutter/material.dart";

mixin IconButtonStylesMixin {
  Color get defaultIconColor => Color.fromARGB(255, 243, 243, 243);
  double get defaultIconSize => 20.0;
  EdgeInsets get defaultPadding => EdgeInsets.all(8.0);

  Color get lightIconColor => defaultIconColor;
  double get lightIconSize => defaultIconSize;
  EdgeInsets get lightPadding => defaultPadding;

  Color get darkIconColor => Color.fromARGB(255, 25, 25, 25); // Ваш колір для темного стилю
  double get darkIconSize => defaultIconSize;
  EdgeInsets get darkPadding => defaultPadding;

  Widget lightIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: lightIconColor,
      iconSize: lightIconSize,
      padding: lightPadding,
    );
  }

  Widget darkIconButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Icon(icon),
      onPressed: onPressed,
      color: darkIconColor,
      iconSize: darkIconSize,
      padding: darkPadding,
    );
  }
}