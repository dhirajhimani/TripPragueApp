import 'package:dartz/dartz.dart';
import 'package:trip_prague/core/domain/model/failures.dart';
import 'package:trip_prague/features/home/domain/model/post.dart';

abstract class IPostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
}
