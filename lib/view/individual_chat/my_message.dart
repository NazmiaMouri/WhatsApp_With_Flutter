import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/constants/screen_size.dart';
import 'package:whats_app/models/message_model.dart';
import 'package:flutter/material.dart';

class ChatBubblePainter extends CustomPainter {
  final Color color;
  final Radius radius;
  final bool isSender;

  ChatBubblePainter({
    required this.color,
    required this.radius,
    required this.isSender,
  });

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

    if (isSender) {
      path.moveTo(size.width - 20, size.height - tailHeight);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width - tailWidth, size.height - tailHeight);
    } else {
      path.moveTo(tailWidth, size.height - tailHeight);
      path.lineTo(0, size.height);
      path.lineTo(20, size.height - tailHeight);
    }
    path.close();

    canvas.drawPath(path, Paint()..color = color);
  }

  @override
  bool shouldRepaint(ChatBubblePainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.isSender != isSender;
}

class ChatBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isSender;
  final MessageStatus status;

  const ChatBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isSender,
    this.status = MessageStatus.sent,
  });

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isSender ? AppColors.myMessageBackground : Colors.white;
    final textColor = isSender ? Colors.black : Colors.black87;
    final border = isSender ? null : Border.all(color: Colors.grey.shade300);

    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        child: CustomPaint(
          painter: ChatBubblePainter(
            color: bubbleColor,
            radius: Radius.circular(12),
            isSender: isSender,
          ),
          child: Container(
            constraints: BoxConstraints(maxWidth: ScreenSize.width / 1.5),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: border,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: TextStyle(color: textColor),
                  overflow: TextOverflow.clip,
                  softWrap: true,
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      time,
                      style:
                          TextStyle(color: AppColors.textLight, fontSize: 12),
                    ),
                    if (isSender) ...[
                      SizedBox(width: 4),
                      Icon(
                        Icons.check,
                        size: 16,
                        color: status == MessageStatus.seen
                            ? AppColors.blue
                            : AppColors.textLight,
                      ),
                    ]
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class MyMessage extends StatelessWidget {
//   final bool isSender;

//   const MyMessage({super.key, this.isSender = true});

//   @override
//   Widget build(BuildContext context) {
//     return ChatBubble(
//       message:
//           'skdosfsfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsd',
//       time: '11:30',
//       isSender: isSender,
//     );
//   }
// }
