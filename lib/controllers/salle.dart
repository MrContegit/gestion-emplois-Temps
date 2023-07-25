class Salle{
  bool etat;
  final  String idsalle;
  late final String libelle;
  late final int nbreplace;
  late final int periodeUtil;




  Salle({
    this.etat=false,
    required this.idsalle,
    required this.libelle,
    required this.nbreplace,
    required this.periodeUtil,
  });

  Map<String, dynamic> toJson()=>{
    'etat':etat,
    'idsalle':idsalle,
    'libelle':libelle,
    'nbreplace':nbreplace,
    'periodeUtil':periodeUtil,

  };
  static Salle fromJson(Map<String,dynamic> json){
    
    Salle salle = Salle(
    etat:json['etat'],
    idsalle:json['idsalle'],
    libelle:json['libelle'],
    nbreplace:json['nbreplace'],
    periodeUtil:json['periodeUtil'],
    );
    return salle;
  }
  
}