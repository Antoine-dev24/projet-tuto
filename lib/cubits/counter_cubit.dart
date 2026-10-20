import 'package:flutter_bloc/flutter_bloc.dart';

// A Cubit holds a state (here an int) and exposes methods
// that call emit() to publish a new state.
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(10); // initial state

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}
