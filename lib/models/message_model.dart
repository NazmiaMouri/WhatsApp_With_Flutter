import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

enum MessageStatus { sent, delivered, seen }

@JsonSerializable()
class Message {
  final String type;
  final String msg;
  final String time;
  final MessageStatus status;

  Message({
    required this.type,
    required this.msg,
    required this.time,
    this.status = MessageStatus.sent,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
