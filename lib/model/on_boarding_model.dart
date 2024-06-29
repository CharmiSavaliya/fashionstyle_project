class OnBoardingModel {
  final String title;
  final String subTitle;
  final String image;
  final int index;
  OnBoardingModel({
    required this.title,
    required this.subTitle,
    required this.image,
    required this.index,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    index: 0,
    image: "assets/screen1.png",
    title: "Seamless Shopping Experience",
    subTitle: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit, sed do eiusmod tempor incididunt",
  ),
  OnBoardingModel(
    index: 1,
    image: "assets/screen2.png",
    title: "Wishlist: Where Fashion\nDreams Begin",
    subTitle: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit, sed do eiusmod tempor incididunt",
  ),
  OnBoardingModel(
    index: 2,
    image: "assets/screen3.png",
    title: "Swift and Reliable \nDelivery",
    subTitle: "Lorem ipsum dolor sit amet, consectetur\n adipiscing elit, sed do eiusmod tempor incididunt",
  ),
];
