import 'package:flutter/material.dart';

@optionalTypeArgs
mixin CancelMixin<T extends StatefulWidget> on State<T>  {
  List<Function> _disposeFunc = List<Function>();

  void addToDispose(Function func) {
    _disposeFunc.add(func);
  }

  @override
  void dispose() {
    // dispose all func
    _disposeFunc.forEach((f) => f());
    super.dispose();
  }
}