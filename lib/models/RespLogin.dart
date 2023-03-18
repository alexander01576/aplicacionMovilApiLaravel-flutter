class RespLogin{
  final String acceso;
  final String error;

  RespLogin(this.acceso, this.error);

  RespLogin.fromJson(Map<String, dynamic>json)
    : acceso = json ['acceso'],
      error = json ['error'];

  Map<String, dynamic> ToJson() =>{
    'acceso': acceso,
    'error': error
  };
}