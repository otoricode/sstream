import 'package:sstream/sstream.dart';

abstract class SState<T> {
  void update(T value);
  void clear();
  void none();
}

class State<T> extends SState<T> {
  final SStream<SValueState<T>> _stream = SStream(SWaiting());
  SValueState<T> get state => _stream.value;

  void wait() {
    final current = _stream.value;
    if (current is SValue<T>) {
      _stream.add(SWaiting(currentValue: current));
      return;
    }
    _stream.add(SWaiting());
  }

  void error(Error err) {
    final current = _stream.value;
    if (current is SValue<T>) {
      _stream.add(SError(error: err, currentValue: current));
    }
    _stream.add(SError(error: err));
  }

  @override
  void update(T value) {
    _stream.add(SValue(value));
  }

  @override
  void clear() {
    _stream.add(SEmpty());
  }

  @override
  void none() {
    _stream.add(SNone());
  }

  State({
    T? value,
    SValueState<T>? initialState,
  }) {
    if (value != null) {
      _stream.add(SValue(value));
      return;
    }
    if (initialState != null) {
      _stream.add(initialState);
    }
  }
}

abstract class SValueState<T> {}

class SNone<T> extends SValueState<T> {}

class SWaiting<T> extends SValueState<T> {
  final SValue<T>? currentValue;
  SWaiting({
    this.currentValue,
  });
}

class SEmpty<T> extends SValueState<T> {}

class SValue<T> extends SValueState<T> {
  final T value;
  SValue(this.value);
}

class SError<T> extends SValueState<T> {
  final SValue<T>? currentValue;
  final Error error;
  SError({
    this.currentValue,
    required this.error,
  });
}
