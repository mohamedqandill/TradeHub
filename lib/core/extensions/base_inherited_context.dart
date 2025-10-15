import 'package:flutter/cupertino.dart';
import 'package:tradehub/core/base/base_inherited_widgets.dart';

extension BaseInheritedContext on BuildContext {
  BaseInheritedWidget get base => BaseInheritedWidget.of(this);
}
