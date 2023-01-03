import 'package:sstream/sstream.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = 0.stream;

    setUp(() {});

    test('First Test', () async {
      expectLater(awesome.stream, emitsThrough(100));
      awesome.add(100);
      expect(awesome.value, 100);
    });
  });
}
