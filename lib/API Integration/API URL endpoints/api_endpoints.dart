class Endpoints {
  Endpoints._();
  /// baseURL   local server url
 static const String baseUrl = "http://matchitsports.com:4000/api/";
  /// baseUrl client stage server url
  //static const String baseUrl = "https://kepawastetrack.ng:4001/api/";
  /// baseUrl client live server url
  // static const String baseUrl = "https://kepawastetrack.ng:4000/api/";

  /// imageURL
  static const String imageUrl = "http://162.0.208.12:4000/uploads/";
  /// imageURL client stage server url
  // static const String imageUrl = "https://kepawastetrack.ng:4001/uploads/";
  /// imageURL client live server url
  // static const String imageUrl = "https://kepawastetrack.ng:4000/uploads/";

  /// Auth
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String role = "roles";
  static const String forgot = "auth/forget-password";
  static const String profile = "auth/get-profile";
  static const String update = "auth/update-profile";
  static const String update_Password = "auth/update-password-with-current";
  static const String notification = "notifications/get-notifications";

  /// SubAdmin
  static const String subAdmin = "subadmin/add-subadmin";
  static const String getSubAdmin = "subadmin/subadmin-listing";
  static const String deleteSubAdmin = "subadmin/delete-subadmin";
  static const String updateSubAdmin = "subadmin/update-single-subadmin";

  /// EcoBlueSubAdmin
  static const String ecoBlueSubAdmin = "ecoblue/add-ecoblue-admin";
  static const String getEcoBlueSubAdmin = "ecoblue/ecoblue-admin-listing";
  static const String deleteEcoBlueSubAdmin = "ecoblue/delete-ecoblue-admin";
  static const String updateEcoBlueSubAdmin = "ecoblue/update-single-ecoblue";

  /// Waste Management Agency
  static const String addWasteAgency = "wasteagency/add-wasteagency";
   static const String getWasteAgency = "wasteagency/get-single-wasteagency";
  static const String deleteWasteAgency = "wasteagency/delete-wasteagency";
  static const String updateProfilePicWasteAgency = "wasteagency/update-wasteagency-profile";
 static const String updateWasteAgency = "wasteagency/update-single-wasteagency";


  /// Waste Management Staff
  static const String addWasteStaff = "wasteagency/add-wasteagency-staff";
  static const String getWasteStaff = "wasteagency/wasteagency-staff-listing";
  static const String deleteWasteStaff = "wasteagency/delete-wasteagency-staff";
  static const String updateWasteStaff = "wasteagency/update-single-wasteagency-staff";
  static const String verifyWasteMStaffSerialNumber =  'nylon/only-verify-serialno';


  /// StateGovernment Agency
  static const String addStateGovernmentAgency = "stategovtagency/add-stategovtagency";
  static const String getStateGovernmentAgency = "stategovtagency/get-single-stategovtagency";
  static const String deleteStateGovernmentAgency = "stategovtagency/delete-stategovtagency";
  static const String updateStateGovernmentAgency = "stategovtagency/update-single-stategovtagency";
  static const String updateProfilePicStateGovernmentAgency = "stategovtagency/update-stategovtagency-profile";


  /// nylon Production Company
  static const String addNylonProduction = "nylonproduction/add-nylonproductionagency";
   static const String getNylonProduction = "nylonproduction/get-single-nylonproductionagency";
   static const String deleteNylonProduction = "nylonproduction/delete-nylonproductionagency";
   static const String updateProfileNylonProduction = "nylonproduction/update-nylonproductionagency-profile";
   static const String updateNylonProduction = "nylonproduction/update-single-nylonproductionagency";

  /// Enforcement Team
  static const String addEnforcement = "enforcementteam/add-enforcementteam";
  static const String getEnforcement = "enforcementteam/get-single-enforcementteam";
  static const String deleteEnforcement = "enforcementteam/delete-enforcementteam";
  static const String updateEnforcement = "enforcementteam/update-single-enforcementteam";
  static const String updateProfileEnforcement = "enforcementteam/update-enforcementteam-profile";

   /// Vendor End Points
  static const String searchArea =  'area/search-area';
  static const String getVendorBatchListing =  'order/get-vendor-batch-listing';
  static const String getOrderList =  'order/get-vendor-orders';
  static const String assignVendorToArea =  'area/assign-vendor-to-area';
  static const String addVendor =  'vendor/add-vendor';
  static const String getVendors =  'vendor/vendor-listing';
  static const String UpdateSingleVendor =  'vendor/update-single-vendor';
  static const String deleteVendor =  'vendor/delete-vendor';
  static const String getSingleVendor =  'vendor/get-single-vendor';
  static const String getVendorBankDetails = 'vendor/get-bankdetails';
  static const String updateVendorBankDetails = 'vendor/save-bankdetails';
  static const String vendorGetWithdrawalAmount = 'withdrawal/get-withdrawal-amount';
  static const String vendorGetCollectionList = 'withdrawal/vendor-collection-list';
  static const String vendorWithdrawRequest = 'withdrawal/withdrawal-request';
  static const String withdrawRequestHistoryCount = 'withdrawal/withdrawal-request-count';
  static const String vendorWithdrawRequestHistoryList = 'withdrawal/withdrawal-history-list';
  static const String vendorWithdrawRequestDownloadReceipt = 'withdrawal/generate-payment-invoice';
  /// Admin
  static const String adminWithdrawRequestList = "withdrawal/withdrawal-request-list";
  static const String adminSingleWithdrawRequest = "withdrawal/single-request-data";
  static const String updateSingleWithdrawRequestStatus = "withdrawal/update-withdrawal-status";

  /// Vendor side apis
  static const String getBuyNylonDetails =  'order/get-bank-and-commission';
  static const String placeOrder =  'order/submit-order';
  static const String getVendorOrderCount =  'order/get-order-counts';
  static const String getVendorOrders =  'order/get-vendor-orders';
  static const String getVendorOrdersDetails = 'order/get-order-details';
  static const String cancelOrder = 'order/cancel-order';
  static const String generateInvoiceOrder = 'order/generate-invoice';
  static const String orderStatus = 'order/update-order-status';


  /// Area
  static const String addArea =  'area/add-area';
  static const String getArea =  'area/get-arealisting';
  static const String updateArea =  'area/update-area';
  static const String deleteArea =  'area/delete-area';
  static const String areaAlloted =  'area/alloted-area-list';
  static const String areaAssign =  'area/unassign-area';




  ///Vendor Staff End Points
  static const String addVendorStaff =  'vendor/add-vendor-staff';
  static const String getVendorStaff =  'vendor/vendor-staff-listing';
  static const String getVendorStaffCollected = 'vendor/vendor-staff-collection-list';
  static const String updateVendorStaff =  'vendor/update-single-vendor-staff';
  static const String deleteVendorStaff =  'vendor/delete-vendor-staff';
  static const String verifyVendorStaffSerialNumber =  'nylon/verify-serialno';
  static const String getCollectionListApi =  'nylon/collection-list';// vendor and vendor staff only
  static const String getWasteCollectionListApi = 'nylon/waste-collection-list'; // admin  and subAdmin  only
  static const String updateCollectionApi =  'nylon/update-collection-status';

 ///Nylon Generation
  static const String nylonGeneration =  'nylon/nylon-price-qty';
  static const String nylonGenerationPrice =  'nylon/update-nylon-price';
  static const String nylonGenerationQuantity =  'nylon/generate-nylon-rolls';
  static const String getNylonDetails =  'nylon/nylon-batch-listing';
  static const String getNylonBatchDelete =  'nylon/delete-nylon-batch';
  static const String getNylonBatchIdsDownloadUrl =  'nylon/generate-batch-qrcode-pdf';
  static const String getNylonBatchItemDetails =  'nylon/nylon-batch-items';


  /// Revenue Share
  static const String revenueShare =  'revenue/get-revenue-sharing';
  static const String revenueShareList =  'revenue/get-revenue-shared-listing';
  static const String revenueShareCount =  'revenue/get-revenue-shared-count';
  static const String revenueShareAll =  'revenue/get-revenue-sharing-for-all';
  static const String updateRevenueShareList = 'revenue/update-revenue-sharing';

  /// Invoice
  static const String getInvoiceList =  'order/invoice-listing';
  static const String getInvoiceDetailsList =  'order/get-invoice-detail';

  // receiveTimeout
  static const Duration receiveTimeout =
      Duration(milliseconds: 15000); // 15000;

  // connectTimeout
  static const Duration connectionTimeout =
      Duration(milliseconds: 15000); //15000;
}

