import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FrontPage extends ConsumerStatefulWidget {
  const FrontPage({super.key});

  @override
  ConsumerState<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends ConsumerState<FrontPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/language');
    });
  }

  @override
  Widget build(BuildContext context) {
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
