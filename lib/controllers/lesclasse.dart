class LesClasses{
  final String idclasse;
  final  String libelleclasse;
  final int nbreEtudiant;



  LesClasses({
    required this.idclasse,
    required this.libelleclasse,
    required this.nbreEtudiant
  });

  Map<String, dynamic> toJson()=>{
    'idclasse':idclasse,
    'libelleclasse':libelleclasse,
    'nbreEtudiant':nbreEtudiant,


  };
  static LesClasses fromJson(Map<String,dynamic> json){
    
    LesClasses lesclasses = LesClasses(
    idclasse:json['idclasse'],
    libelleclasse:json['libelleclasse'],
    nbreEtudiant:json['nbreEtudiant'],
    );
    return lesclasses;
  }
  
}