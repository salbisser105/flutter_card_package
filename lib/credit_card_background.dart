import 'dart:ui' as ui;

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

class _GradientPainter extends CustomPainter {
  _GradientPainter({required this.strokeWidth, required this.radius});

  final double radius;
  final double strokeWidth;
  final Paint paintObject = Paint();
  final Paint paintObject2 = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    final LinearGradient gradient = LinearGradient(
        begin: Alignment.bottomRight,
        end: Alignment.topLeft,
        colors: <Color>[
          Colors.white.withAlpha(50),
          Colors.white.withAlpha(55),
          Colors.white.withAlpha(50),
        ],
        stops: const <double>[
          0.06,
          0.95,
          1
        ]);
    final RRect innerRect2 = RRect.fromRectAndRadius(
        Rect.fromLTRB(strokeWidth, strokeWidth, size.width - strokeWidth,
            size.height - strokeWidth),
        Radius.circular(radius - strokeWidth));

    final RRect outerRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(0, 0, size.width, size.height), Radius.circular(radius));
    paintObject.shader = gradient.createShader(Offset.zero & size);

    final Path outerRectPath = Path()..addRRect(outerRect);
    final Path innerRectPath2 = Path()..addRRect(innerRect2);
    canvas.drawPath(
        Path.combine(
            PathOperation.difference,
            outerRectPath,
            Path.combine(
                PathOperation.intersect, outerRectPath, innerRectPath2)),
        paintObject);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
