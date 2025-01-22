import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:softwarica_student_management_bloc/core/network/hive_service.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:softwarica_student_management_bloc/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/use_case/login_usecase.dart';
import 'package:softwarica_student_management_bloc/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:softwarica_student_management_bloc/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/local_datasource/batch_local_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/data_source/remote_datasource/batch_remote_data_source.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/data/repository/batch_remote_repository.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/create_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/delete_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/domain/use_case/get_all_batch_usecase.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/local_datasource/course_local_data_source.dart';
import 'package:softwarica_student_management_bloc/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_local_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/data/repository/course_remote_repository.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/create_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/delete_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/domain/use_case/get_all_course_usecase.dart';
import 'package:softwarica_student_management_bloc/features/course/presentation/view_model/course_bloc.dart';
import 'package:softwarica_student_management_bloc/features/home/presentation/view_model/home_cubit.dart';
import 'package:softwarica_student_management_bloc/features/splash/presentation/view_model/splash_cubit.dart';

import '../../core/network/api_service.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();


  await _initBatchDependencies();
  await _initCourseDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
        () => ApiService(Dio()).dio,
  );
}


_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      batchBloc: getIt<BatchBloc>(),
      courseBloc: getIt<CourseBloc>(),
      registerUseCase: getIt(),
    ),
  );
}

_initCourseDependencies() {
  // Local Data Source
  getIt.registerFactory<CourseLocalDataSource>(
          () => CourseLocalDataSource(hiveService: getIt<HiveService>()));

  // Remote Data Source
  getIt.registerLazySingleton<CourseRemoteDataSource>(
        () => CourseRemoteDataSource(getIt<Dio>()),
  );

  // Batch Local Repository
  getIt.registerLazySingleton<CourseLocalRepository>(() => CourseLocalRepository(
      courseLocalDataSource: getIt<CourseLocalDataSource>()));

  // Batch Remote Repository
  getIt.registerLazySingleton(
        () => CourseRemoteRepository(getIt<CourseRemoteDataSource>(),
    ),
  );



  // Usecases
  getIt.registerLazySingleton<CreateCourseUsecase>(
    () => CreateCourseUsecase(
      courseRepository: getIt<CourseRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetAllCourseUsecase>(
    () => GetAllCourseUsecase(
      courseRepository: getIt<CourseLocalRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteCourseUsecase>(
    () => DeleteCourseUsecase(
      courseRepository: getIt<CourseLocalRepository>(),
    ),
  );

  // Bloc

  getIt.registerFactory<CourseBloc>(
    () => CourseBloc(
      createCourseUsecase: getIt<CreateCourseUsecase>(),
      getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
      deleteCourseUsecase: getIt<DeleteCourseUsecase>(),
    ),
  );
}

_initBatchDependencies() async {
  // Local Data Source
  getIt.registerFactory<BatchLocalDataSource>(
          () => BatchLocalDataSource(hiveService: getIt<HiveService>()));

  // Remote Data Source
  getIt.registerLazySingleton<BatchRemoteDataSource>(
        () => BatchRemoteDataSource(getIt<Dio>()),
  );

  // Batch Local Repository
  getIt.registerLazySingleton<BatchLocalRepository>(() => BatchLocalRepository(
      batchLocalDataSource: getIt<BatchLocalDataSource>()));

  // Batch Remote Repository
  getIt.registerLazySingleton(
        () => BatchRemoteRepository(getIt<BatchRemoteDataSource>(),
    ),
  );

  // Usecases
  getIt.registerLazySingleton<CreateBatchUseCase>(
        () => CreateBatchUseCase(batchRepository: getIt<BatchRemoteRepository>()),
  );

  getIt.registerLazySingleton<GetAllBatchUseCase>(
        () => GetAllBatchUseCase(batchRepository: getIt<BatchRemoteRepository>()),
  );

  getIt.registerLazySingleton<DeleteBatchUsecase>(
        () => DeleteBatchUsecase(batchRepository: getIt<BatchRemoteRepository>()),
  );

  // Bloc
  getIt.registerFactory<BatchBloc>(
        () => BatchBloc(
      createBatchUseCase: getIt<CreateBatchUseCase>(),
      getAllBatchUseCase: getIt<GetAllBatchUseCase>(),
      deleteBatchUsecase: getIt<DeleteBatchUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
