import '../../class/request_state.dart';


handleRequest(response) {
  if (response is RequestState) {
    return response;
  } else {
    return RequestState.loaded;
  }
}
