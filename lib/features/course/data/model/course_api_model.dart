import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/entity/course_entity.dart';


@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? courseId;
  final String courseName;

  const CourseApiModel({
    this.courseId,
    required this.courseName,
  });

  const CourseApiModel.empty()
      : courseId = '',
        courseName = '';



  //From Json,
  //Server => dart
  factory CourseApiModel.fromJson (Map<String,dynamic>json){
    return CourseApiModel(
      courseId:json['_id'],
      courseName: json['courseName'],
    );
  }

  //To Json
  //dart => Server
  Map<String, dynamic> toJson(){
    return{
      // '_id': batchId,
      'courseName': courseName,
    };

  }


  //From Entity
  static CourseApiModel fromEntity(CourseEntity entity)=> CourseApiModel(
    courseName: entity.courseName,
  );

  // To Entity
  CourseEntity toEntity() => CourseEntity(
    courseId: courseId,
    courseName: courseName,
  );

  //to Entity List

  List <CourseEntity> toEntityList (List <CourseApiModel>models)=>
      models.map((model)=> model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [courseId, courseName];


}
