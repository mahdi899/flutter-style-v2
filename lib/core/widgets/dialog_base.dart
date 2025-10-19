import 'package:flutter/material.dart';

import 'package:astyle_flutter/app/theme/app_theme.dart';
import 'package:astyle_flutter/core/widgets/glass_card.dart';

class DialogBase extends StatelessWidget {
  const DialogBase({
    super.key,
    this.title,
    required this.content,
    this.actions = const <Widget>[],
    this.padding = const EdgeInsets.fromLTRB(24, 24, 24, 16),
    this.actionsPadding = const EdgeInsets.only(top: 20),
    this.actionsAlignment = MainAxisAlignment.end,
  });

  final Widget? title;
  final Widget content;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry actionsPadding;
  final MainAxisAlignment actionsAlignment;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final List<Widget> actionWidgets = <Widget>[];
    for (int i = 0; i < actions.length; i++) {
      actionWidgets.add(
        Padding(
          padding: EdgeInsetsDirectional.only(start: i == 0 ? 0 : 12),
          child: actions[i],
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: GlassCard(
        padding: padding,
        borderRadius: AppRadii.border24,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (title != null) ...<Widget>[
              DefaultTextStyle(
                style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                    ) ??
                    TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                child: title!,
              ),
              const SizedBox(height: 12),
            ],
            content,
            if (actions.isNotEmpty) ...<Widget>[
              Padding(
                padding: actionsPadding,
                child: Row(
                  mainAxisAlignment: actionsAlignment,
                  children: actionWidgets,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
