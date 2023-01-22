part of 'trip_prague_bloc.dart';

@freezed
class TripPragueState with _$TripPragueState {
  factory TripPragueState({
    required AuthStatus authStatus,
    required ThemeMode themeMode,
    required bool isLoading,
    Failure? failure,
    User? user,
  }) = _TripPragueState;

  factory TripPragueState.initial() => _TripPragueState(
        authStatus: AuthStatus.unknown,
        themeMode: ThemeMode.system,
        isLoading: false,
      );
}
