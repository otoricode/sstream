import 'package:sstream/sstream.dart';

void main() {
  SStream<int> count = SStream(0);
  count.stream.listen((event) {
    print(event);
  });
  count.add(1);
  count.add(100);
  print(count.value);
}
