import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/batch_entity.dart';

@JsonSerializable()
class BatchApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? batchId;
  final String batchName;

  const BatchApiModel({
    this.batchId,
    required this.batchName,
  });

  const BatchApiModel.empty()
      : batchId = '',
        batchName = '';



  //From Json,
  //Server => dart
  factory BatchApiModel.fromJson (Map<String,dynamic>json){
    return BatchApiModel(
      batchId:json['_id'],
      batchName: json['batchName'],
    );
  }

  //To Json
  //dart => Server
  Map<String, dynamic> toJson(){
    return{
      // '_id': batchId,
      'batchName': batchName,
    };

  }


  //From Entity
  static BatchApiModel fromEntity(BatchEntity entity)=> BatchApiModel(
    batchName: entity.batchName,
  );

  // To Entity
  BatchEntity toEntity() => BatchEntity(
    batchId: batchId,
    batchName: batchName,
  );

  //to Entity List

  static List <BatchEntity> toEntityList (List <BatchApiModel>models)=>
      models.map((model)=> model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [batchId, batchName];


}
