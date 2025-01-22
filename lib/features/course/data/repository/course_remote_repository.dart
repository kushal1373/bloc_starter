import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import '../../../../core/error/failure.dart';
import '../../domain/repository/course_repository.dart';
import '../data_source/remote_datasource/course_remote_datasource.dart';


class CourseRemoteRepository implements ICourseRepository {
  final CourseRemoteDataSource _courseRemoteDataSource;

  CourseRemoteRepository( this._courseRemoteDataSource);



  @override
  Future<Either<Failure, void>> createCourse(CourseEntity course) async {
    try {
      await _courseRemoteDataSource.createCourse(course);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourse(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }
}
