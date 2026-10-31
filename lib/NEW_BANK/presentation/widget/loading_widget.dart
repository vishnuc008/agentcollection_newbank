import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable
class LoadingScreenController {
  final CloseLoadingScreen close;
  final UpdateLoadingScreen update;

  const LoadingScreenController({required this.close, required this.update});
}

class LoadingScreen {
  LoadingScreen._sharedInstance();
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  factory LoadingScreen.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    String text = 'Loading...',
    bool isDismissible = false,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showOverlay(
        context: context,
        text: text,
        isDismissible: isDismissible,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context,
    required String text,
    bool isDismissible = false,
  }) {
    final state = Overlay.of(context);
    final textController = StreamController<String>();
    textController.add(text);

    final overlay = OverlayEntry(
      builder: (context) {
        return _LoadingScreenContent(
          textController: textController,
          isDismissible: isDismissible,
          onClose: () => _controller?.close(),
        );
      },
    );

    state.insert(overlay);
    return LoadingScreenController(
      close: () {
        textController.close();
        if (overlay.mounted) {
          overlay.remove();
        }
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}

class _LoadingScreenContent extends StatefulWidget {
  final StreamController<String> textController;
  final bool isDismissible;
  final VoidCallback onClose;

  const _LoadingScreenContent({
    required this.textController,
    required this.isDismissible,
    required this.onClose,
  });

  @override
  State<_LoadingScreenContent> createState() => _LoadingScreenContentState();
}

class _LoadingScreenContentState extends State<_LoadingScreenContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(_controller);

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.black.withOpacity(0.7),
      child: GestureDetector(
        onTap: widget.isDismissible ? widget.onClose : null,
        child: Container(
          color: widget.isDismissible ? Colors.transparent : null,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Loading Icon
                  Container(
                    width: 100,
                    height: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer rotating circle
                        AnimatedBuilder(
                          animation: _rotationAnimation,
                          builder: (context, child) {
                            return Transform.rotate(
                              angle: _rotationAnimation.value,
                              child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(
                                      0xFF1a2b47,
                                    ).withOpacity(0.3),
                                    width: 3,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        // Pulsing center icon
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleAnimation.value,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1a2b47),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.hourglass_top_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Loading Text
                  StreamBuilder<String>(
                    stream: widget.textController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Text(
                              snapshot.requireData,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1a2b47),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please wait while we process your request',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

                  const SizedBox(height: 20),

                  // Dots Loading Animation
                  _buildDotsLoader(),

                  if (widget.isDismissible) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Tap anywhere to dismiss',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDotsLoader() {
    return SizedBox(
      width: 60,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _AnimatedDot(delay: 0, color: const Color(0xFF1a2b47)),
          _AnimatedDot(delay: 200, color: const Color(0xFF1a2b47)),
          _AnimatedDot(delay: 400, color: const Color(0xFF1a2b47)),
        ],
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  final int delay;
  final Color color;

  const _AnimatedDot({required this.delay, required this.color});

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}

/// Error Screen
typedef CloseErrorScreen = bool Function();
typedef UpdateErrorScreen = bool Function(String text);

@immutable
class ErrorScreenController {
  final CloseErrorScreen close;
  final UpdateErrorScreen update;

  const ErrorScreenController({required this.close, required this.update});
}

class ErrorScreen {
  ErrorScreen._sharedInstance();
  static final ErrorScreen _shared = ErrorScreen._sharedInstance();
  factory ErrorScreen.instance() => _shared;

  ErrorScreenController? _controller;

  void show({
    required BuildContext context,
    String text = 'Something went wrong!',
    String? buttonText,
    VoidCallback? onRetry,
    bool isDismissible = true,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = showErrorOverlay(
        context: context,
        text: text,
        buttonText: buttonText,
        onRetry: onRetry,
        isDismissible: isDismissible,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  ErrorScreenController? showErrorOverlay({
    required BuildContext context,
    required String text,
    String? buttonText,
    VoidCallback? onRetry,
    bool isDismissible = true,
  }) {
    final state = Overlay.of(context);
    final textController = StreamController<String>();
    textController.add(text);

    final overlay = OverlayEntry(
      builder: (overlayContext) {
        final size = MediaQuery.of(overlayContext).size;
        return Material(
          color: Colors.black.withOpacity(0.8),
          child: GestureDetector(
            onTap: isDismissible ? () => _controller?.close() : null,
            child: Container(
              color: isDismissible ? Colors.transparent : null,
              child: Center(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Error Icon with Pulse Animation
                        _PulsingErrorIcon(),

                        const SizedBox(height: 24),

                        // Error Title
                        Text(
                          'Oops!',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.red.shade700,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Error Message
                        StreamBuilder<String>(
                          stream: textController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.requireData,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),

                        const SizedBox(height: 32),

                        // Action Buttons
                        Row(
                          children: [
                            if (isDismissible)
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => _controller?.close(),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    side: BorderSide(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  child: Text(
                                    'Dismiss',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                              ),

                            if (isDismissible && onRetry != null)
                              const SizedBox(width: 12),

                            if (onRetry != null)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _controller?.close();
                                    onRetry();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1a2b47),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    buttonText ?? 'Try Again',
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    state.insert(overlay);
    return ErrorScreenController(
      close: () {
        textController.close();
        if (overlay.mounted) {
          overlay.remove();
        }
        return true;
      },
      update: (text) {
        textController.add(text);
        return true;
      },
    );
  }
}

class _PulsingErrorIcon extends StatefulWidget {
  @override
  State<_PulsingErrorIcon> createState() => _PulsingErrorIconState();
}

class _PulsingErrorIconState extends State<_PulsingErrorIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.error_outline_rounded,
              size: 50,
              color: Colors.red.shade600,
            ),
          ),
        );
      },
    );
  }
}

// Success Screen
class SuccessScreen {
  SuccessScreen._sharedInstance();
  static final SuccessScreen _shared = SuccessScreen._sharedInstance();
  factory SuccessScreen.instance() => _shared;

  OverlayEntry? _overlay;

  void show({
    required BuildContext context,
    String title = 'Success!',
    String message = 'Operation completed successfully',
    String buttonText = 'Continue',
    VoidCallback? onDismiss,
    Duration duration = const Duration(seconds: 3),
  }) {
    hide();

    final state = Overlay.of(context);
    final size = MediaQuery.of(context).size;

    _overlay = OverlayEntry(
      builder: (context) {
        return _SuccessScreenContent(
          title: title,
          message: message,
          buttonText: buttonText,
          onDismiss: () {
            hide();
            onDismiss?.call();
          },
          duration: duration,
        );
      },
    );

    state.insert(_overlay!);
  }

  void hide() {
    _overlay?.remove();
    _overlay = null;
  }
}

class _SuccessScreenContent extends StatefulWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback onDismiss;
  final Duration duration;

  const _SuccessScreenContent({
    required this.title,
    required this.message,
    required this.buttonText,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_SuccessScreenContent> createState() => _SuccessScreenContentState();
}

class _SuccessScreenContentState extends State<_SuccessScreenContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();

    // Auto dismiss
    if (widget.duration != Duration.zero) {
      Future.delayed(widget.duration, widget.onDismiss);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Material(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Success Icon
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_circle_rounded,
                          size: 50,
                          color: Colors.green.shade600,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Success Title
                      Text(
                        widget.title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.green.shade700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Success Message
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Continue Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: widget.onDismiss,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1a2b47),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            widget.buttonText,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
