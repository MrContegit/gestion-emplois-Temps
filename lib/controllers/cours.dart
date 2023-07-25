class Cours{
  final String idcours;
  final  String idjour;
  final String idclasse;
  final String idMatiere;
  final String idSemestre;
  final String idsalle;
  final String idenseignant;
  final String dure;



  Cours({
    required this.idcours,
    required this.idjour,
    required this.idclasse,
    required this.idMatiere,
    required this.idSemestre,
    required this.idsalle,
    required this.idenseignant,
    required this.dure
  });

  Map<String, dynamic> toJson()=>{
    'idcours':idcours,
    'idjour':idjour,
    'idclasse':idclasse,
    'idMatiere':idMatiere,
    'idSemestre':idSemestre,
    'idsalle':idsalle,
    'idenseignant':idenseignant,
    'dure':dure

  };
  static Cours fromJson(Map<String,dynamic> json){
    
    Cours cours = Cours(
    idcours:json['idcours'],
    idjour:json['idjour'],
    idclasse:json['idclasse'],
    idMatiere:json['idMatiere'],
    idSemestre:json['idSemestre'],
    idsalle:json['idsalle'],
    idenseignant:json['idenseignant'],
    dure:json['dure']
    );
    return cours;
  }
  
}