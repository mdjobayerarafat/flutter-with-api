import 'panda.dart';

class PandaList {
  final List<Panda> pandas;

  PandaList({
    required this.pandas,
  });

  factory PandaList.fromJson(List<dynamic> json) {
    return PandaList(
      pandas: json.map((pandaJson) => Panda.fromJson(pandaJson)).toList(),
    );
  }
}