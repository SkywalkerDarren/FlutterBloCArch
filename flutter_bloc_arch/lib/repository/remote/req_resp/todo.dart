import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';

@JsonSerializable()
class TodoResponse {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  TodoResponse({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory TodoResponse.fromJson(Map<String, dynamic> json) =>
      _$TodoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TodoResponseToJson(this);
}
