

class ApiEndpoints{
  ApiEndpoints._(); // private constructor

  static const Duration ConnectionTimeout = Duration(seconds: 5000);
  static const Duration receiveTimeout = Duration(seconds: 5000);
  static const String baseUrl = "http://10.0.2.2:3000/api/v1/";


// ============================Auth Routes ==================================




  // ============================Course Routes ==================================

  static const String createCourse = "/course/createCourse";
  static const String getAllCourse = "/course/getAllCourse";

// ================================= Batch Routes ============================
  static const String createBatch = "/batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";


}





