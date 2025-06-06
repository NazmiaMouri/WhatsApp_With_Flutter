// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      type: json['type'] as String,
      msg: json['msg'] as String,
      time: json['time'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'type': instance.type,
      'msg': instance.msg,
      'time': instance.time,
    };
