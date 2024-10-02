// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// import '../Models/API Response Models/Cart Model/cart_model.dart';
// import '../Models/API Response Models/Product Model/product_model.dart';
// import '../Models/API Response Models/User Data Model/userdata_model.dart';

// class SQLService {
//   Database? db;

//   Future openDB() async {
//     try {
//       // Get a location using getDatabasesPath
//       var databasesPath = await getDatabasesPath();
//       String path = join(databasesPath, 'quickby.db');
//       // open the database
//       db = await openDatabase(
//         path,
//         version: 1,
//         onCreate: (Database db, int version) async {
//           // print(db);
//           this.db = db;
//           createTables();
//         },
//       );
//       return true;
//     } catch (e) {
//       // print("ERROR IN OPEN DATABASE $e");
//       return Future.error(e);
//     }
//   }

//   createTables() async {
//     try {
//       var usersqry = "CREATE TABLE IF NOT EXISTS users ( "
//           "email Text,"
//           "name Text,"
//           "mobile Text,"
//           "address Text,"
//           "gender Text,"
//           "dob Text,"
//           "state Text,"
//           "city Text,"
//           "my_refer Text,"
//           "created_at Text,";
//       await db?.execute(usersqry);

//       var favsqry = "CREATE TABLE IF NOT EXISTS favoriteProducts ( "
//           "id INTEGER PRIMARY KEY,"
//           "product_key Text,"
//           "Product_Name Text,"
//           "Product_Description Text,"
//           "Product_Price Text,"
//           "Product_Image Text)";

//       await db?.execute(favsqry);

//       var cartqry = "CREATE TABLE IF NOT EXISTS cartProducts ( "
//           "id INTEGER PRIMARY KEY,"
//           "Cart_key Text,"
//           "Cart_Name Text,"
//           "Cart_Image Text,"
//           "Cart_Description Text,"
//           "Cart_quantity Text,"
//           "Cart_price Text)";

//       await db?.execute(cartqry);
//     } catch (e) {
//       if (kDebugMode) {
//         print("ERROR IN CREATE TABLE");
//       }
//       if (kDebugMode) {
//         print(e);
//       }
//     }
//   }

//   Future getUser() async {
//     try {
//       var list = await db?.rawQuery('SELECT * FROM users', []);
//       if (kDebugMode) {
//         print("list data is $list");
//       }
//       return list ?? [];
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   Future addToUser(UserData data) async {
//     // print("add user data is ${data.userName}  and ${data.userEmail}, ${data.userMobile},${data.userImage},${data.userDob}, ${data.userGender},${data.userState},${data.userCity},${data.loginId}");
//     await db?.transaction((txn) async {
//       var qry =
//           'INSERT INTO users(email, name, mobile, address, landMark, dob, state, city, my_refer, wallet, created_at) VALUES("${data.email}", "${data.name}", "${data.mobile}", "${data.address}", "${data.landMark}", "${data.dob}", "${data.state}", "${data.city}", "${data.myRefer}", "${data.createdAt}")';
//       if (kDebugMode) {
//         print("insert query => ${qry}");
//       }
//       int id1 = await txn.rawInsert(qry);
//       return id1;
//     });
//     if (kDebugMode) {
//       print("user added");
//     }
//   }

//   Future updateUserData(UserData data) async {
//     // print("user data update query ${data.userName}");
//     var qry =
//         "UPDATE users SET name = '${data.name}', email = '${data.email}', address = '${data.address}', landMark = '${data.landMark}', city = '${data.city}', state = '${data.state}', dob = '${data.dob}' ";
//     if (kDebugMode) {
//       print("user data update query $qry");
//     }
//     return await db?.rawUpdate(qry);
//   }

//   Future deleteUser() async {
//     var qry = "DELETE FROM users";
//     return await db?.rawDelete(qry);
//   }

// //get model for products
//   Future<List<ProductModel>> getProduct() async {
//     try {
//       var list = await db?.rawQuery('SELECT * FROM favoriteProducts', []);
//       // print("list data is $list");
//       List<ProductModel> productData = [];
//       for (var element in list!) {
//         if (kDebugMode) {
//           print("element data on dbHelper => $element");
//         }
//         productData.add(ProductModel.fromJson(element));

//         if (kDebugMode) {
//           print("element data on dbHelper after => ${productData}");
//         }
//       }
//       // var userData = UserModel.fromJson(list!.first);
//       return productData;
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   //get model for cart
//   Future<List<CartModel>> getCart() async {
//     try {
//       var list = await db?.rawQuery('SELECT * FROM cartProducts', []);
//       // print("list data is $list");
//       List<CartModel> cartData = [];
//       for (var element in list!) {
//         if (kDebugMode) {
//           print("element data on dbHelper => $element");
//         }
//         cartData.add(CartModel.fromJson(element));

//         if (kDebugMode) {
//           print("element data on dbHelper after => ${cartData}");
//         }
//       }
//       // var userData = UserModel.fromJson(list!.first);
//       return cartData;
//     } catch (e) {
//       return Future.error(e);
//     }
//   }

//   // add products
//   Future addToProduct(ProductModel data) async {
//     await db?.transaction((txn) async {
//       var qry =
//           'INSERT INTO favoriteProducts(product_key ,Product_Name, Product_Description, Product_Image ,Product_Price) VALUES("${data.productId}", "${data.name}", "${data.description}","${data.image}","${data.price}")';
//       if (kDebugMode) {
//         print("Insert query => $qry ");
//       }
//       int id1 = await txn.rawInsert(qry);
//       return id1;
//     });
//   }

//   // add cart
//   Future addToCart(CartModel data) async {
//     await db?.transaction((txn) async {
//       var qry =
//           'INSERT INTO cartProducts(Cart_key ,Cart_Name, Cart_Image,Cart_Description,Cart_quantity,Cart_price) VALUES("${data.cartId}", "${data.name}","${data.image}","${data.description}","${data.quantity}","${data.price}")';
//       if (kDebugMode) {
//         print("Insert query => $qry ");
//       }
//       int id1 = await txn.rawInsert(qry);
//       return id1;
//     });
//   }

//   Future updateCart(String quantity, String id) async {
//     var qry =
//         "UPDATE cartProducts SET Cart_quantity = '${quantity}' WHERE Cart_key = '${id}' ";
//     if (kDebugMode) {
//       print("user data update query $qry");
//     }
//     return await db?.rawUpdate(qry);
//   }

//   // remove products
//   Future removeProduct(String id) async {
//     var qry = "DELETE FROM favoriteProducts WHERE product_key = '${id}' ";
//     if (kDebugMode) {
//       print("remove query=>${qry}");
//     }
//     return await db?.rawDelete(qry);
//   }

//   // remove cart
//   Future removeCart(String id) async {
//     var qry = "DELETE FROM cartProducts WHERE Cart_key = '${id}' ";
//     if (kDebugMode) {
//       print("remove query=>${qry}");
//     }
//     return await db?.rawDelete(qry);
//   }

//   Future deleteCart() async {
//     var qry = "DELETE FROM cartProducts";
//     return await db?.rawDelete(qry);
//   }
// // Future closeUserDb() async{
// //   return await db?.close();
// // }
// }
