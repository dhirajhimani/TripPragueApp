import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:trip_prague/app/constants/enum.dart';
import 'package:trip_prague/core/domain/bloc/trip_prague/trip_prague_bloc.dart';
import 'package:trip_prague/core/domain/interface/i_user_repository.dart';
import 'package:trip_prague/core/domain/model/failures.dart';
import 'package:trip_prague/features/auth/domain/interface/i_auth_repository.dart';

import '../../../utils/test_utils.dart';
import 'trip_prague_bloc_test.mocks.dart';

@GenerateMocks(<Type>[
  IUserRepository,
  TripPragueBloc,
  IAuthRepository,
])
void main() {
  late MockIUserRepository userRepository;
  late MockIAuthRepository authRepository;
  late TripPragueBloc tripPragueBloc;

  setUp(() async {
    userRepository = MockIUserRepository();
    authRepository = MockIAuthRepository();
    tripPragueBloc = TripPragueBloc(userRepository, authRepository);
  });

  group('TripPragueBloc initialize', () {
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        TripPragueState.initial().copyWith(isLoading: true),
        tripPragueBloc.state
            .copyWith(authStatus: AuthStatus.unauthenticated, user: null),
      ],
    );

    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an authenticated with user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => some(mockUser));

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        TripPragueState.initial().copyWith(isLoading: true),
        tripPragueBloc.state
            .copyWith(authStatus: AuthStatus.authenticated, user: mockUser),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) => bloc.initialize(),
      expect: () => <dynamic>[
        TripPragueState.initial().copyWith(isLoading: true),
        tripPragueBloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });

  group('TripPragueBloc getUser ', () {
    setUp(() async {
      tripPragueBloc = TripPragueBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await tripPragueBloc.initialize();
    });
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.getUser(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );

    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an authenticated with user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => some(mockUser));

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.getUser(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit  a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.getUser(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });

  group('TripPragueBloc logout ', () {
    setUp(() async {
      tripPragueBloc = TripPragueBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await tripPragueBloc.initialize();
    });
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(authRepository.logout()).thenAnswer((_) async => right(unit));

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.logout(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit a failed state',
      build: () {
        when(authRepository.logout()).thenAnswer(
          (_) async => left(Failure.unexpected(throwsException.toString())),
        );

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.logout(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit a failed state when unexpected error occurs',
      build: () {
        when(authRepository.logout()).thenThrow(throwsException);

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.logout(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          isLoading: false,
          failure: Failure.unexpected(throwsException.toString()),
        ),
      ],
    );
  });

  group('TripPragueBloc authenticate', () {
    setUp(() async {
      tripPragueBloc = TripPragueBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await tripPragueBloc.initialize();
    });
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an authenticated user state',
      build: () => tripPragueBloc,
      act: (TripPragueBloc bloc) async => bloc.authenticate(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: mockUser,
          isLoading: false,
        ),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit an unauthenticated with null user state',
      build: () {
        when(userRepository.user).thenAnswer((_) async => none());
        when(authRepository.logout()).thenAnswer((_) async => right(unit));

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.authenticate(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.unauthenticated,
          user: null,
          isLoading: false,
        ),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit a failed state',
      build: () {
        when(userRepository.user).thenThrow(throwsException);

        return tripPragueBloc;
      },
      act: (TripPragueBloc bloc) async => bloc.authenticate(),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(
          authStatus: AuthStatus.authenticated,
          isLoading: true,
          failure: null,
          user: mockUser,
        ),
        tripPragueBloc.state
            .copyWith(failure: Failure.unexpected(throwsException.toString())),
      ],
    );
  });
  group('TripPragueBloc switchTheme ', () {
    setUp(() async {
      tripPragueBloc = TripPragueBloc(userRepository, authRepository);
      when(userRepository.user).thenAnswer((_) async => some(mockUser));
      await tripPragueBloc.initialize();
    });
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit a dark theme mode',
      build: () => tripPragueBloc,
      act: (TripPragueBloc bloc) async => bloc.switchTheme(Brightness.light),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(themeMode: ThemeMode.dark),
      ],
    );
    blocTest<TripPragueBloc, TripPragueState>(
      'should emit a light theme mode',
      build: () => tripPragueBloc,
      act: (TripPragueBloc bloc) async => bloc.switchTheme(Brightness.dark),
      expect: () => <dynamic>[
        tripPragueBloc.state.copyWith(themeMode: ThemeMode.light),
      ],
    );
  });
}
