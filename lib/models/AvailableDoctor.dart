class AvailableDoctor {
  final String name, sector, patients, image;
  final int experience;

  AvailableDoctor(
      {this.name, this.sector, this.experience, this.patients, this.image});
}

List<AvailableDoctor> demoAvailableDoctors = [
  AvailableDoctor(
    name: "Dr. Vichit Jem",
    sector: "General Department",
    experience: 1,
    image: "assets/images/Serena_Gome.png",
  ),
  AvailableDoctor(
    name: "Dr. Arma AG",
    sector: "General Department",
    experience: 2,
    image: "assets/images/Asma_Khan.png",
  ),
  AvailableDoctor(
    name: "Dr. Chanan Ya",
    sector: "Internal Medicine Department",
    experience: 5,
    image: "assets/images/Kiran_Shakia.png",
  ),
  AvailableDoctor(
    name: "Dr. Sutthipong api",
    sector: "Internal Medicine Department",
    experience: 3,
    image: "assets/images/Masuda_Khan.png",
  ),
  AvailableDoctor(
    name: "Dr. Dumrong meung",
    sector: "Internal Medicine Department",
    experience: 4,
    image: "assets/images/Johir_Raihan.png",
  ),
];
