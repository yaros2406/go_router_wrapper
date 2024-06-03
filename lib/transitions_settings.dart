import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

//Типы перехода
enum TransitionType {
  push,
  pushNamed,
  go,
  goNamed,
  popUntil,
}

// Модель перехода
class TransitionRule {
  final String pathPattern;
  final TransitionType type;
  final String? targetPath;

  TransitionRule({
    required this.pathPattern,
    required this.type,
    this.targetPath,
  });
}

void handleTransition(BuildContext context, TransitionRule rule) {
  switch (rule.type) {
    case TransitionType.push:
      if (rule.targetPath != null) {
        context.push(rule.targetPath!);
      }
      break;
    case TransitionType.go:
      if (rule.targetPath != null) {
        context.go(rule.targetPath!);
      }
      break;
    case TransitionType.popUntil:
      Navigator.of(context).popUntil((route) => route.isFirst);
      break;
    case TransitionType.pushNamed:
      if (rule.targetPath != null) {
        context.pushNamed(rule.targetPath!);
      }
    case TransitionType.goNamed:
      if (rule.targetPath != null) {
        context.goNamed(rule.targetPath!);
      }
  }
}