class UnboardingContent {
  String image;
  String title;
  String description;
  UnboardingContent(
      {required this.description, required this.image, required this.title});
}

List<UnboardingContent> content = [
  UnboardingContent(
    description: "Pick Your Food More\n     Than 35 Times",
    image: "assets/screen1.png",
    title: "Select from Our\n     Best Menu",
  ),
  UnboardingContent(
    description:
        "You can pay cash on delivery and card\n            payment is available",
    image: "assets/screen2.png",
    title: "Easy And Online Payment",
  ),
  UnboardingContent(
    description: "Deliver Your Food At Your Doorstep",
    image: "assets/screen3.png",
    title: "Quick Delivery At Your Doorstep",
  )
];
