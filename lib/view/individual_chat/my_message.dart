import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/constants/screen_size.dart';
import 'package:flutter/material.dart';

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final Radius radius;

  ChatBubblePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    const tailWidth = 10.0;
    const tailHeight = 10.0;

    final path = Path();
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height - tailHeight),
      radius,
    );

    path.addRRect(rect);
    
    // Add tail
    path.moveTo(size.width - 20, size.height - tailHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - tailWidth, size.height - tailHeight);
    path.close();

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(ChatBubblePainter oldDelegate) => false;
}

class MyMessage extends StatelessWidget {
  const MyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChatBubblePainter(
        color: AppColors.myMessageBackground,
        radius: Radius.circular(12),
      ),
      child: Container(
        constraints: BoxConstraints(maxWidth: ScreenSize.width / 1.5),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'skdosfsfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsd'
              'fsdfsdfsdfsdfsdfsdfsdfsdfsd',
              overflow: TextOverflow.clip,
              softWrap: true,
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '11:30',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: AppColors.textLight, fontSize: 12),
                ),
                SizedBox(width: 4),
                SvgPicture.asset(
                  'assets/icons/Icone=Tick.svg',
                  height: 16,
                  width: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
