import 'dart:ui';

import 'package:any_syntax_highlighter/themes/any_syntax_highlighter_theme.dart';
import 'package:any_syntax_highlighter/themes/any_syntax_highlighter_theme_collection.dart';
import 'package:flutter/material.dart';
import 'package:any_syntax_highlighter/any_syntax_highlighter.dart';
import 'package:flutter_solidart/flutter_solidart.dart';

import '../global/variables.dart';
import '../states/signals.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(final BuildContext context) {
    return SignalBuilder(
      signal: currentRootSignal,
      builder: (final context, final model, final _) {
        final blackWhite = Theme.of(context).textTheme.bodyLarge?.color;
        return model != null
            ? AnySyntaxHighlighter(
                formatter.format(
                  model.toCode(),
                ),
                softWrap: false,
                margin: 8,
                fontSize: 16,
                theme: AnySyntaxHighlighterTheme(
                  classStyle:
                      const TextStyle(color: Color.fromRGBO(113, 176, 251, 1)),
                  staticStyle: TextStyle(color: blackWhite),
                  constructor:
                      const TextStyle(color: Color.fromRGBO(113, 176, 251, 1)),
                  multilineComment:
                      const TextStyle(color: Color.fromRGBO(187, 174, 170, 1)),
                  comment:
                      const TextStyle(color: Color.fromRGBO(187, 174, 170, 1)),
                  keyword: const TextStyle(
                    color: Color.fromRGBO(251, 114, 116, 0.807843137254902),
                    fontWeight: FontWeight.bold,
                  ),
                  identifier: TextStyle(color: blackWhite),
                  function:
                      const TextStyle(color: Color.fromRGBO(200, 132, 251, 1)),
                  number:
                      const TextStyle(color: Color.fromRGBO(113, 176, 251, 1)),
                  string:
                      const TextStyle(color: Color.fromRGBO(113, 176, 251, 1)),
                  operator: const TextStyle(
                    color: Color.fromRGBO(251, 114, 116, 0.807843137254902),
                    fontWeight: FontWeight.bold,
                  ),
                  separator: TextStyle(color: blackWhite),
                  method:
                      const TextStyle(color: Color.fromRGBO(200, 132, 251, 1)),
                  private: TextStyle(color: blackWhite),
                  decoration: BoxDecoration(color: blackWhite),
                  fontFeatures: const [FontFeature.slashedZero()],
                ),
                isSelectableText: true,
                hasCopyButton: true,
                copyIcon: const Icon(Icons.copy_outlined),
                overrideDecoration:
                    const BoxDecoration(), // default is white colored icon
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          model != null
                              ? model.name
                              : "select a root to see code",
                        ),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}
