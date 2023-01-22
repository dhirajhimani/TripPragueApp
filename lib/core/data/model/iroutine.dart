import 'package:dartx/dartx.dart';

abstract class IRoutine {
  IRoutine({
    required this.title,
    this.description,
    this.url,
  });

  late String title;
  String? description;
  String? url;
}


class DailyRoutine extends IRoutine {
  DailyRoutine({
    required super.title,
    super.description,
    super.url,
  });

  factory DailyRoutine.fromBlock(String content) {
    final List<String> array = content.split('\n');

    return DailyRoutine(
      title: array.elementAtOrDefault(0, '').trim(),
      description: array.elementAtOrDefault(2, '').trim(),
      url: array.elementAtOrDefault(1, '').trim(),
    );
  }
}

