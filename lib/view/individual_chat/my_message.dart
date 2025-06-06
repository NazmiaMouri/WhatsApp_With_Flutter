import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whats_app/constants/colors.dart';
import 'package:whats_app/constants/screen_size.dart';
import 'package:flutter/material.dart';

class MyMessage extends StatelessWidget {
  const MyMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: ScreenSize.width / 2),
      color: AppColors.myMessageBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'skdosfsfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsd'
            'fsdfsdfsdfsdfsdfsdfsdfsdfsd',
            overflow: TextOverflow.clip,
            softWrap: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '11:30',
                textAlign: TextAlign.end,
                style: TextStyle(color: AppColors.textLight, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: SvgPicture.asset(
                  'assets/icons/Icone=Tick.svg',
                  height: 20,
                  width: 20,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
