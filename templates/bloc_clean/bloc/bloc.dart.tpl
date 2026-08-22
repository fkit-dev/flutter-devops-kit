import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/{{usecaseFile}}';
import '{{eventFile}}';
import '{{stateFile}}';

// FKIT generated BLoC: replace placeholder flow with feature behavior.
class {{bloc}} extends Bloc<{{event}}, {{state}}> {
  {{bloc}}({
    required {{usecase}} {{usecaseInstance}},
  })  : _{{usecaseInstance}} = {{usecaseInstance}},
        super(const {{state}}.initial()) {
    on<{{featurePascal}}Started>(_onStarted);
  }

   final {{usecase}} _{{usecaseInstance}};

  Future<void> _onStarted(
    {{featurePascal}}Started event,
    Emitter<{{state}}> emit,
  ) async {
    emit(const {{state}}.loading());

    try {
      // TODO: Call use case.
      // await _{{usecaseInstance}}();

      emit(const {{state}}.success());
    } catch (e) {
      emit(
        {{state}}.failure(
          message: e.toString(),
        ),
      );
    }
  }
}
