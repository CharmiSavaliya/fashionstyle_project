class CategoryModel {
  final String name;
  final int index;

  CategoryModel({
    required this.index,
    required this.name,
  });
}

List<CategoryModel> categoryList = [
  CategoryModel(index: 0, name: "All"),
  CategoryModel(index: 1, name: "Newest"),
  CategoryModel(index: 2, name: "Popular"),
  CategoryModel(index: 3, name: "Men"),
  CategoryModel(index: 4, name: "Women"),
];

class ProductModel {
  final String productname;
  final String image;
  final String price;
  final String rating;
  final String category;
  final String style;

  bool isselected;

  ProductModel(
      {required this.productname,
      required this.image,
      required this.price,
      required this.rating,
      required this.category,
      required this.style,
      required this.isselected});
}

List<ProductModel> productAll = [
  ProductModel(
    productname: "Men Shirt",
    image: "assets/mshirt.jpeg",
    price: "\$40.00",
    rating: "4.9",
    category: "Men",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women Jacket",
    image: "assets/wjacket.jpeg",
    price: " \$23.00",
    rating: "5.0",
    category: "Newest",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women pent",
    image: "assets/wpent.jpeg",
    price: "\$30.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men Jacket",
    image: "assets/mjacket.jpeg",
    price: "\$35.00",
    rating: "5.0",
    category: "Men",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men pent",
    image: "assets/mpent0.jpeg",
    price: "\$73.00",
    rating: "4.9",
    category: "Men",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women Shirt",
    image: "assets/wshirt.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men Shirt",
    image: "assets/mshirt.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Newest",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "women jacket",
    image: "assets/wjacket0.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women pent",
    image: "assets/wpent0.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men Shirt",
    image: "assets/mshirt3.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Men",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men Shirt",
    image: "assets/mtshirt.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Men",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men pent",
    image: "assets/mpent1.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Newest",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women Shirt",
    image: "assets/wshirt2.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Popular",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women pent",
    image: "assets/wpent2.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Popular",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women T-Shirt",
    image: "assets/wtshirt.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men Shirt",
    image: "assets/mshirt1.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Men",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women Shirt",
    image: "assets/wshirt1.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Men Shirt",
    image: "assets/mshirt0.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Popular",
    style: "Men's Style",
    isselected: false,
  ),
  ProductModel(
    productname: "Women Shirt",
    image: "assets/wshirt2.jpeg",
    price: "\$33.00",
    rating: "4.9",
    category: "Women",
    style: "Female's Style",
    isselected: false,
  ),
];
