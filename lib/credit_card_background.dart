import 'package:flutter/material.dart';

import 'constants.dart';

class CardBackground extends StatelessWidget {
  const CardBackground({
    Key? key,
    required this.backgroundGradientColor,
    this.backgroundImage,
    this.backgroundNetworkImage,
    required this.child,
    this.width,
    this.height,
    required this.padding,
    this.border,
    this.chipPadding,
  })  : assert(
            (backgroundImage == null && backgroundNetworkImage == null) ||
                (backgroundImage == null && backgroundNetworkImage != null) ||
                (backgroundImage != null && backgroundNetworkImage == null),
            "You can't use network image & asset image at same time for card background"),
        super(key: key);

  final String? backgroundImage;
  final String? backgroundNetworkImage;
  final Widget child;
  final Gradient backgroundGradientColor;
  final double? width;
  final double? height;
  final double padding;
  final BoxBorder? border;
  final EdgeInsets? chipPadding;

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double screenWidth = constraints.maxWidth.isInfinite
          ? MediaQuery.of(context).size.width
          : constraints.maxWidth;
      final double screenHeight = MediaQuery.of(context).size.height;
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: border,
              gradient: backgroundGradientColor,
              image: backgroundImage != null && backgroundImage!.isNotEmpty
                  ? DecorationImage(
                      image: ExactAssetImage(
                        backgroundImage!,
                      ),
                      fit: BoxFit.fill,
                    )
                  : backgroundNetworkImage != null &&
                          backgroundNetworkImage!.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(
                            backgroundNetworkImage!,
                          ),
                          fit: BoxFit.fill,
                        )
                      : null,
            ),
            width: width ?? screenWidth,
            height: height ??
                (orientation == Orientation.portrait
                    ? (((width ?? screenWidth) - (padding * 2)) *
                        AppConstants.creditCardAspectRatio)
                    : screenHeight / 2),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(8),
              child: Container(
                child: child,
              ),
            ),
          ),
        ],
      );
    });
  }
}
