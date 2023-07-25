class Matiere{
  late int  credit;
  final  String libelle;
  late final int volumeHoraire;




  Matiere({
    required this.credit,
    required this.libelle,
    required this.volumeHoraire,
  });

  Map<String, dynamic> toJson()=>{
    'credit':credit,
    'volumeHoraire':volumeHoraire,
    'libelle':libelle,
  };
  static Matiere fromJson(Map<String,dynamic> json){
    
    Matiere matiere = Matiere(
    credit:json['credit'],
    libelle:json['libelle'],
    volumeHoraire:json['volumeHoraire'],
    );
    return matiere;
  }
  
}