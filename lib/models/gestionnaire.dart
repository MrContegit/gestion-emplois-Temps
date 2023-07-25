class Gestion {
  String bgImage;
  String icon;
  String name;
  String type;

  String text;
  String description;
  List<String> images;

  Gestion(
    this.bgImage,
    this.icon,
    this.name,
    this.type,
  
    this.description,
    this.images,
    this.text,
  );

  static List<Gestion> gestions() {
    return [
      Gestion(
        'assets/images/cour.png',
        'assets/images/JeMorganise1.png',
        'Emplois de Temps Scolaire',
        'SHOOL TIME',
     
        "visualiser l'emplois de temps remis par votre chef de département........",
        [
       
        ],
         'Ori and The Forest',
      ),
      Gestion(
        'assets/images/school3.png',
        'assets/images/school3.png',
        'Je Crai Mon Propre emplois ',
        'Gest-Time',
        
        "Gerer mieux son emplois de temps necessite une prise en compte de tous les paramètre incluents les tâches journalier à effectuer..",
        [
          'assets/images/rl2.jpg',
          
          
        ],
         'Emplois de Temps Scolaire',
      ),
    ];
  }
}
