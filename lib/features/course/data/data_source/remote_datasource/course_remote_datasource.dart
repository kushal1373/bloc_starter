import 'package:dio/dio.dart';
import 'package:softwarica_student_management_bloc/app/constants/api_endpoints.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';
import '../../model/course_api_model.dart';
import '../course_data_source.dart';

class CourseRemoteDataSource implements ICourseDataSource {
  final Dio _dio;
  CourseRemoteDataSource(this._dio);

  @override
  Future<void> createCourse(CourseEntity course) async {
    try {
      // Convert entity to model
      var courseApiModel = CourseApiModel.fromEntity(course);
      var response = await _dio.post(
        ApiEndpoints.createCourse,
        data: courseApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteCourse(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<List<CourseEntity>> getCourses() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }

}
