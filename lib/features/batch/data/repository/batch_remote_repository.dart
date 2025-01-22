import 'package:dartz/dartz.dart';
import 'package:softwarica_student_management_bloc/core/error/failure.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/entity/batch_entity.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/repository/batch_repository.dart';

import '../data_source/remote_datasource/batch_remote_data_source.dart';

class BatchRemoteRepository implements IBatchRepository {
  final BatchRemoteDataSource _batchRemoteDataSource;

  BatchRemoteRepository( this._batchRemoteDataSource);

  @override
  Future<Either<Failure, void>> createBatch(BatchEntity batch) async {
    try {
      await _batchRemoteDataSource.createBatch(batch);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBatch(String id) async {
    try {
      await _batchRemoteDataSource.deleteBatch(id);
      return Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BatchEntity>>> getBatches() async {
    try {
      final batches = await _batchRemoteDataSource.getBatches();
      return Right(batches);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
