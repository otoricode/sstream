import 'package:sstream/sstream.dart';

extension SStreamExt<T> on T {
  SStream<T> get stream => SStream(this);
}
