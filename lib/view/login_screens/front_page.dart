import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FrontPage extends ConsumerWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Flexible(
          flex: 4,
          child: Image.asset(
            'assets/images/WhatsAppIcon.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.center,
          ),
        ),
        Spacer(flex:2),
        Flexible(
          flex: 1,
          child: Image.asset(
            'assets/images/FromMeta.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            alignment: AlignmentDirectional.bottomCenter,
          ),
        )
      ]),
    );
  }
}
