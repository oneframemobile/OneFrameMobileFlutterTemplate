import 'package:networking/networking/model/error_model.dart';
import 'package:networking/networking/model/result_model.dart';
import 'package:networking/networking/network_learning.dart';
import 'package:networking/networking/network_listener.dart';

class ServiceLearning extends NetworkLearning {
  @override
  checkCustomError(NetworkListener listener, ErrorModel error) {
    try {
      error.data = error.data.error;
      return sendError(listener, error);
    } catch (e) {
      return sendError(listener, error);
    }
  }

  @override
  checkSuccess<T>(NetworkListener listener, ResultModel result) {
    try {
      var data = result.data as dynamic;
      bool isDataList;
      try{
        isDataList = data.list is List;
      }
      catch(e){
        isDataList = false;
      }
      if (isDataList || data.errorMessage == null) {
        return sendSuccess(listener, result as dynamic);
      } else {
        ErrorModel<String> error = new ErrorModel();
        error.description = "Hata!";
        return sendError(listener, error);
      }
    } on NoSuchMethodError catch (e) {
      ErrorModel<StackTrace> error = new ErrorModel();
      error.data = e.stackTrace;
      return sendError(listener, error);
    }
  }
}
