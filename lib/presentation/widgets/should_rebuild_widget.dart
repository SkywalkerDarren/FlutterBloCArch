import 'package:flutter/material.dart';

typedef ShouldRebuildFunction<T extends Widget> = bool Function(
    T oldWidget, T newWidget);

class ShouldRebuild<T extends Widget> extends StatefulWidget {
  final T child;
  final ShouldRebuildFunction<T> shouldRebuild;
  ShouldRebuild({required this.child, required this.shouldRebuild});
  @override
  _ShouldRebuildState createState() => _ShouldRebuildState<T>();
}

class _ShouldRebuildState<T extends Widget> extends State<ShouldRebuild<T>> {
  T? oldWidget;
  @override
  Widget build(BuildContext context) {
    final newWidget = widget.child;
    if (oldWidget == null) {
      this.oldWidget = newWidget;
    } else if (widget.shouldRebuild(oldWidget!, newWidget)) {
      this.oldWidget = newWidget;
    }
    return oldWidget!;
  }
}
