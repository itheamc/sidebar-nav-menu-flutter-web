import 'package:flutter/material.dart';

class ASideMenu extends StatefulWidget {
  final double minWidth;
  final double maxWidth;
  final double elevation;
  final Color? shadowColor;
  final int itemsCount;
  final Widget Function(
          BuildContext context, Duration duration, double value, int index)
      itemsBuilder;
  final Widget Function(Duration duration, double value)? headerBuilder;

  const ASideMenu({
    Key? key,
    required this.itemsCount,
    required this.itemsBuilder,
    this.headerBuilder,
    this.minWidth = 80.0,
    this.maxWidth = 260.0,
    this.elevation = 10.0,
    this.shadowColor,
  }) : super(key: key);

  @override
  State<ASideMenu> createState() => _ASideMenuState();
}

class _ASideMenuState extends State<ASideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// On Toggle
  void _onToggle() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return SizedBox(
            width: widget.minWidth +
                ((widget.maxWidth - widget.minWidth) *
                    _animationController.value),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Material(
                    elevation: widget.elevation,
                    shadowColor: widget.shadowColor ??
                        theme.dividerColor.withOpacity(0.5),
                    child: ListView(
                      children: [
                        Container(
                          padding:
                          const EdgeInsets.only(top: 25.0, bottom: 30.0),
                          child: Row(
                            children: [
                              const Padding(
                                padding:
                                EdgeInsets.only(left: 17.0, right: 15.0),
                                child: Icon(Icons.factory, size: 36.0,),
                              ),
                              Flexible(
                                child: Transform.scale(
                                  scale: _animationController.value,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: Text(
                                      "Aarohi Botique".toUpperCase(),
                                      style: theme.textTheme.headline6?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ...List.generate(
                          widget.itemsCount,
                          (index) => widget.itemsBuilder(
                              context,
                              _animationController.duration!,
                              _animationController.value,
                              index),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      elevation: 10.0,
                      shadowColor: theme.dividerColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10.0),
                      child: InkWell(
                        onTap: _onToggle,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Ink(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.dividerColor.withOpacity(0.075)),
                          child: Center(
                            child: AnimatedRotation(
                              turns: _animationController.value / 2,
                              duration: _animationController.duration!,
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

/// A Side menu item widget
class ASideMenuItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final Duration duration;
  final double animValue;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onClick;
  final bool selected;

  const ASideMenuItem({
    Key? key,
    required this.label,
    required this.icon,
    this.duration = const Duration(milliseconds: 320),
    this.animValue = 1.0,
    this.onClick,
    this.margin,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: margin ?? const EdgeInsets.symmetric(vertical: 2.5),
      child: InkWell(
        onTap: onClick,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          decoration: BoxDecoration(
            color: selected ? theme.dividerColor.withOpacity(0.05) : null,
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 23.0, right: 15.0),
                child: Icon(icon),
              ),
              Flexible(
                child: AnimatedScale(
                  duration: duration,
                  scale: animValue,
                  alignment: Alignment.centerLeft,
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: Text(
                    label,
                    style: theme.textTheme.bodyText1
                        ?.copyWith(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
