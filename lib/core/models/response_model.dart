
class ResponseModel<T> {
  final T? data;

  const ResponseModel({
    this.data,
  });

  factory ResponseModel.fromJson(T? json) {
    return ResponseModel(
      data: json,
    );
  } 
  
}
