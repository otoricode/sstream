import 'package:sstream/sstream.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final SStream<int> awesome = SStream(0);

    setUp(() {});

    test('First Test', () async {
      expectLater(awesome.stream, emitsThrough(100));
      awesome.add(100);
      expect(awesome.value, 100);
    });
  });
}
