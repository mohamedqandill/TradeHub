import 'package:flutter/material.dart';

enum TransitionType {
  fade,
  slideRight,
  slideLeft,
  slideUp,
  slideDown,
  scale,
  rotation,
  size,
  combined, // fade + slide
}

extension PageTransitions on Widget {
  PageRouteBuilder customRoute({
    RouteSettings? settings,
    Duration duration = const Duration(milliseconds: 400),
    TransitionType type = TransitionType.fade,
  }) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => this,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curve =
            CurvedAnimation(parent: animation, curve: Curves.easeInOut);

        switch (type) {
          case TransitionType.fade:
            return FadeTransition(opacity: curve, child: child);

          case TransitionType.slideRight:
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                      .animate(curve),
              child: child,
            );

          case TransitionType.slideLeft:
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                      .animate(curve),
              child: child,
            );

          case TransitionType.slideUp:
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                      .animate(curve),
              child: child,
            );

          case TransitionType.slideDown:
            return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                      .animate(curve),
              child: child,
            );

          case TransitionType.scale:
            return ScaleTransition(
              scale: Tween<double>(begin: 0.8, end: 1.0).animate(curve),
              child: child,
            );

          case TransitionType.rotation:
            return RotationTransition(
              turns: Tween<double>(begin: 0.5, end: 1.0).animate(curve),
              child: child,
            );

          case TransitionType.size:
            return Align(
              child: SizeTransition(
                sizeFactor: curve,
                axis: Axis.vertical,
                child: child,
              ),
            );

          case TransitionType.combined:
            return FadeTransition(
              opacity: curve,
              child: SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                        .animate(curve),
                child: child,
              ),
            );
        }
      },
    );
  }
}
