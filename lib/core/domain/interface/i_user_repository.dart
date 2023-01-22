import 'package:dartz/dartz.dart';
import 'package:trip_prague/core/domain/model/user.dart';

abstract class IUserRepository {
  Future<Option<User>> get user;
}
