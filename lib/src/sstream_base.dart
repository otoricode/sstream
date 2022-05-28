import 'dart:async';

/// Checks if you are awesome. Spoiler: you are.
class SStream<T> {
  final StreamController<T> _controller = StreamController<T>.broadcast();

  T _value;
  Object? error;

  SStream(this._value);
  T get value => _value;
  void Function(T event) get add => (event) {
        _value = event;
        _controller.sink.add(event);
      };
  Stream<T> get stream => _controller.stream;
  Function(Object err) get addError => ((err) {
        _controller.addError(err);
        error = err;
      });
}
