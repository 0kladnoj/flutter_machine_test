import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(State initialState) : super(initialState);

  State handleError(String massage);

  Future<State> performSafeAction(
    AsyncValueGetter<State> callback,
  ) async {
    try {
      return await callback();
    } catch (exception) {
      return handleError('$exception');
    }
  }
}
