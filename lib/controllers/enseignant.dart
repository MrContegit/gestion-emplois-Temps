class Enseignant{
  String id;
  final  String nom;
  final String email;
  final String idMat;
  final String numeroTel;
  final String password;



  Enseignant({
    required this.id,
    required this.nom,
    required this.email,
    required this.idMat,
    required this.numeroTel,
    required this.password
  });

  Map<String, dynamic> toJson()=>{
    'id':id,
    'nom':nom,
    'email':email,
    'idMat':idMat,
    'numeroTel':numeroTel,
    'password':password

  };
  static Enseignant fromJson(Map<String,dynamic> json){
    
    Enseignant es = Enseignant(
    id: json['codeEns'],
    nom: json['nom'], 
    email: json['email'], 
    idMat: json['idMat'], 
    numeroTel: json['numeroTel'], 
    password: json['password']
    );
    return es;
  }
  
}