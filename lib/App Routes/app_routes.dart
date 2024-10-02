import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Admin/Invoices%20Screen/Invoice%20Details/invoice_details.dart';
import 'package:waste_track/Screens/Admin/Nylon%20Management%20Screen/Nylon%20Details/Generated%20Details/generate_details.dart';
import 'package:waste_track/Screens/Admin/Ticketing%20Screen/Widgets/ticket_details_screen.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Ecoblue%20Sub%20Admin/Widgets/ecoblue_sub_admin_add.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Ecoblue%20Sub%20Admin/Widgets/ecoblue_sub_admin_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Enforcement%20Team/Widget/enforcement_team_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Nylon%20Production%20Company/Widget/nylon_producation_company_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/State%20Management%20Agency/Widget/state_management_agency_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Sub%20Admin/Widgets/sub_admin_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Sub%20Admin/Widgets/sub_admin_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Sub%20Admin/Widgets/tickets_resolved_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Vendor%20Details%20Screen/vendor_details_screen.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Vendor%20Edit%20Screen/venor_edit_screen.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Widgets/Vendor%20Staff/Widgets/vendor_serial_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Widgets/Vendor%20Staff/Widgets/vendor_staff_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Widgets/Vendor%20Staff/Widgets/vendor_staff_list_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Widgets/all_details_view.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Vendor/Widgets/batch_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Waste%20Management%20Agency/Waste%20Manaement%20Edit/waste_management_agency_edit.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Waste%20Management%20Agency/Waste%20Management%20Details/waste_management_agency_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Waste%20Management%20Agency/Waste%20Managment%20Staff/waste_management_staff_details.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/Waste%20Management%20Agency/Waste%20Managment%20Staff/waste_management_staff_edit.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/All%20Vendor%20Details/all_vendor_details.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/All%20Vendor%20Edit/all_vendor_edit.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/All%20Vendor%20Saff/Widgets/all_vendor_staff_details.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/All%20Vendor%20Saff/Widgets/all_vendor_staff_edit.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/All%20Vendor%20Saff/Widgets/all_vendor_staff_serial_details.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/all_vendor_batch_details.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/All%20Vendor/Widgets/all_vendor_viewDetails.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/Order%20History/Widget/invoice_genrated.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/Order%20History/Widget/order_history_details.dart';
import 'package:waste_track/Screens/Admin/Withdraw%20Request%20Screen/Widget/Withdraw_view_deatails.dart';
import 'package:waste_track/Screens/Dashboard/Change%20Password%20Screen/change_password_screen.dart';
import 'package:waste_track/Screens/Dashboard/Notification%20Screen/notification_screen.dart';
import 'package:waste_track/Screens/Dashboard/Notification%20Screen/notification_screen_profile.dart';
import 'package:waste_track/Screens/Dashboard/Profile%20Screen/Edit%20Profile%20Screen/edit_profile_screen.dart';
import 'package:waste_track/Screens/Dashboard/Vendor%20Bank%20Details%20Screen/vendor_bank_details_screen.dart';
import 'package:waste_track/Screens/Dashboard/dashboard_screen.dart';
import 'package:waste_track/Screens/Forget%20Password/forget_password.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Nylon%20Management/Widget/state_gov_nylon_management_details.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Sales%20Report/Widgets/state_gov_sales_batch_details.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Sales%20Report/Widgets/state_gov_sales_details.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Ticketing/Widgets/state_gov_create_ticket.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Ticketing/Widgets/state_gov_ticketing_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Invoices/Widget/sub_invoices_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Nylon%20Management/Sub%20Nylon%20Management%20Details/sub_nylon_management_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Ticketing/Widget/sub_ticketing_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/V%20Venor%20Staff%20List/v_vendor_staff_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/V%20Venor%20Staff%20List/v_vendor_staff_serial_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/purchaseHis_viewDetails.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/Widgets/vendor_pur_batchDetails.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Vendor/Vendor%20ViewDetails/vendor_viewDetails.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Waste%20Management%20Agency/Widgets/wasteMa_agency_details.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/Sub%20User%20Waste%20Management%20Agency/Widgets/wasteMa_staff_details.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Sales%20Report/Widgets/ven_staff_sales_batch_details.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Sales%20Report/Widgets/ven_staff_sales_report_details.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Ticketing/Widgets/Ven_staff_create_ticket.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Ticketing/Widgets/ven_staff_ticket_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Order%20Management/By%20Nylon/Widgets/billing_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Order%20Management/By%20Nylon/Widgets/by_nylon_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Order%20Management/By%20Nylon/Widgets/place_order.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Sales%20Report/Widgets/vendor_salesRe_batch_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Sales%20Report/Widgets/vendor_sales_report_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Staff%20Management/All%20Staff/Widget/edit_all_staff.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Staff%20Management/All%20Staff/Widget/vendor_all_staff_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Staff%20Management/All%20Staff/Widget/waste_serial_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Ticketing/Widget/ticket_details.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Ticketing/Widget/vendor_create_ticketing.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Withdraw%20Request/Withdrawal%20History/Widget/withdrawal_history_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Nylon%20Management/Widget/was_agency_nylon_man_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Sales%20Report/Widgets/was_agency_sale_batch_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Sales%20Report/Widgets/was_agency_sales_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Staff%20Management/All%20Staff/Widgets/was_agency_allStaff_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Staff%20Management/All%20Staff/Widgets/was_agency_edit_allStaff.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Ticketing/Widgets/was_agency_create_ticket.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Ticketing/Widgets/was_agency_ticket_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Sales%20Report/Widgets/was_staff_sales_batch_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Sales%20Report/Widgets/was_staff_sales_details.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Ticketing/Widgets/was_staff_create_ticket.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Ticketing/Widgets/was_staff_ticket_details.dart';

import '../Screens/Admin/Nylon Management Screen/Nylon Details/Assigned Details/assigned_details.dart';
import '../Screens/Admin/User Management Screen/Enforcement Team/Widget/enforcement_team_add.dart';
import '../Screens/Admin/User Management Screen/State Management Agency/Widget/state_management_agency_add.dart';
import '../Screens/Admin/User Management Screen/Sub Admin/Widgets/sub_admin_add.dart';
import '../Screens/Admin/Vendor Manangement Screen/All Vendor/Widgets/All Vendor Saff/Widgets/vendor_add_saff_list.dart';
import '../Screens/Eco Blue Sub Admin/Eco Blue Sub Admin Nylon Management/Eco Blue Sub Admin Nylon Management Details/eco_blue_sub_admin_nylon_management_details.dart';
import '../Screens/Login Screen/login_screen.dart';
import '../Screens/Registration Screen/registration_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppScreen.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppScreen.registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case AppScreen.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      // case AppScreen.otpScreen:
      //   var arguments = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //       builder: (_) => OtpScreen(
      //             mobileNumber: arguments['mobile'],
      //             isAppClosed: arguments['isAppClosed'],
      //             isRecoverPassword: arguments['isRecoverPassword'],
      //           ));
      case AppScreen.changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case AppScreen.dashboard:
        return MaterialPageRoute(builder: (_) => DashBoard());
      case AppScreen.notificationScreen:
        return MaterialPageRoute(builder: (_) =>  NotificationScreen());

      case AppScreen.notificationProfileScreen:
        return MaterialPageRoute(builder: (_) =>  NotificationProfileScreen());

      case AppScreen.editProfileScreen:
        return MaterialPageRoute(builder: (_) =>  EditProfileScreen());

      case AppScreen.vendorBankDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  BankDetailsScreen());
      case AppScreen.ticketResolvedDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const TicketsResolvedDetails());

      // ADMIN
      case AppScreen.invoiceDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  InvoiceDetails());
      case AppScreen.withdrawDetailsScreen:
        return MaterialPageRoute(builder: (_) => const WithdrawViewDetails());

      // Sub-Admin
      case AppScreen.subAdminDetailsScreen:
        return MaterialPageRoute(builder: (_) => const SubAdminDetails());
      case AppScreen.subAdminEditScreen:
        return MaterialPageRoute(builder: (_) =>  SubAdminEditScreen());
      case AppScreen.subAdminAddScreen:
        return MaterialPageRoute(builder: (_) => const SubAdminAddScreen());

        // Eco-blueSubAdmin
      case AppScreen.ecoBlueSubAdminDetailsScreen:
        return MaterialPageRoute(builder: (_) => const EcoBlueSubAdminAddScreen());
      case AppScreen.ecoBlueSubAdminEditScreen:
        return MaterialPageRoute(builder: (_) =>  EcoBlueSubAdminEditScreen());
      case AppScreen.ecoBlueSubAdminAddScreen:
        return MaterialPageRoute(builder: (_) => const EcoBlueSubAdminAddScreen());

      // Vendor
      case AppScreen.vendorDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VendorDetailsScreen());
      case AppScreen.vendorEditScreen:
        return MaterialPageRoute(builder: (_) => const VendorEditScreen());
      case AppScreen.allViewDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AllViewDetailsScreen());
      case AppScreen.batchDetailsScreen:
        return MaterialPageRoute(builder: (_) => const BatchDetails());
      case AppScreen.serialDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VendorSerialDetails());
      case AppScreen.vendorStaffListDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VendorStaffListDetails());
      case AppScreen.vendorStaffListEditScreen:
        return MaterialPageRoute(builder: (_) => const VendorStaffListEdit());

      //Waste Management Agency
      case AppScreen.WasteManagementDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasteManagementAgencyDetails());
      case AppScreen.WasteManagementEditScreen:
        return MaterialPageRoute(
            builder: (_) => const WasteManagementAgencyEdit());

      //Waste Management Agency Staff
      case AppScreen.WasteManagementStaffDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasteManagementStaffDetails());
      case AppScreen.WasteManagementStaffEditScreen:
        return MaterialPageRoute(
            builder: (_) =>  WasteManagementStaffEdit());

      // Nylon Management Company
      case AppScreen.nylonProductionCompanyEditScreen:
        return MaterialPageRoute(
            builder: (_) => const NylonProductionCompanyEdit());

      // State Management Agency
      case AppScreen.stateGovernmentAgencyEditScreen:
        return MaterialPageRoute(
            builder: (_) => const StateManagementAgencyEdit());
      case AppScreen.stateGovernmentAgencyAddScreen:
        return MaterialPageRoute(
            builder: (_) => const StateManagementAgencyAdd());

      // Enforcement Team
      case AppScreen.enforcementTeamEditScreen:
        return MaterialPageRoute(builder: (_) => const EnforcementTeamEdit());
      case AppScreen.enforcementTeamAddScreen:
        return MaterialPageRoute(builder: (_) => const EnforcementTeamAdd());

      // Nylon Management
      case AppScreen.generatedDetailsScreen:
        return MaterialPageRoute(builder: (_) => const GeneratedDetails());
      case AppScreen.assignedDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AssignedDetails());

      // Vendor Management
      case AppScreen.allVendorDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  AllVendorDetails());
      case AppScreen.allVendorEditScreen:
        return MaterialPageRoute(builder: (_) => const AllVendorEdit());
      case AppScreen.allVendorViewDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AllVendorViewDetails());
      case AppScreen.allVendorBatchDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AllVendorBatchDetails());
      case AppScreen.allVendorSerialDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const AllVeStaffSerialDetails());
      case AppScreen.AllVendorStaffDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AllVendorStaffDetails());
      case AppScreen.editAllVendorStaffScreen:
        return MaterialPageRoute(builder: (_) => const AllVendorStaffEdit());
      case AppScreen.vendorAddStaffList:
        return MaterialPageRoute(builder: (_) => const VendorAddStaffList());

      case AppScreen.orderHistoryDetailsScreen:
        return MaterialPageRoute(builder: (_) =>  OrderHistoryDetails());
      case AppScreen.orderHistoryInvoiceGenScreen:
        return MaterialPageRoute(
            builder: (_) =>  OrderHistoryInvoiceGenerated());

      // Ticketing
      case AppScreen.adminTicketDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AdminTicketsDetails());

      /// SUB_ADMIN

      // Vendor
      case AppScreen.vendorViewDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VendorViewDetails());

      // Purchase History
      case AppScreen.vendorPurchaseHistoryViewDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VendorPurchaseHistoryViewDetails());
      case AppScreen.vendorPurBatchDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VendorPurBatchDetails());
      case AppScreen.vendorPurSerialDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VendorStaffPurSerialDetails());

      case AppScreen.vendorStaffDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VVendorStaffDetails());

      // Waste Management Agency
      case AppScreen.subUserWasteMaAgDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const SubUserWasteMaAgencyDetails());
      case AppScreen.subUserWasteMaStaffDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const SubUserWasteMaStaffDetails());

      // Nylon Management
      case AppScreen.subNylonManagementDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const SubNylonManagementDetails());

      //  Invoice
      case AppScreen.subInvoiceDetailsScreen:
        return MaterialPageRoute(builder: (_) => const SubInvoiceDetails());

      //  Ticketing
      case AppScreen.subTicketingDetailsScreen:
        return MaterialPageRoute(builder: (_) => const SubTicketingDetails());

      /// VENDOR

      // Staff Management
      case AppScreen.vendorAllStaffDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VendorAllStaffDetails());

      case AppScreen.editAllVendorStaffDetailsScreen:
        return MaterialPageRoute(builder: (_) => const EditAllVendorStaff(),);
      case AppScreen.wasteSerialDetailsScreen:
        return MaterialPageRoute(builder: (_) => const WasteSerialDetails());

      // Order Management
      case AppScreen.byNylonDetailsScreen:
        return MaterialPageRoute(builder: (_) => const ByNylonDetails());
      case AppScreen.editBellingDetailsScreen:
        return MaterialPageRoute(builder: (_) => const EditBillingDetails());
      case AppScreen.nylonPlaceOrderScreen:
        return MaterialPageRoute(builder: (_) =>  NylonPlaceOrder());

      // Sales Report
      case AppScreen.vendorSalesReportDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VendorSalesReportDetails());
      case AppScreen.vendorSalesReBatchDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VendorSaleReBatchDetails());

      // Withdraw Request
      case AppScreen.withdrawalHistoryDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WithdrawalHistoryDetails());
      // Ticketing
      case AppScreen.vendorCreateTicketingScreen:
        return MaterialPageRoute(builder: (_) => const VeCreateTicket());
      case AppScreen.vendorTicketingDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VendorTicketingDetails());

      /// VENDOR STAFF

      // Sales Report
      case AppScreen.vendorStaffSalesReDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VenStaffSalesReportDetails());
      case AppScreen.vendorStaffSalesBatchDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const VenStaffSalesBatchDetails());

      // Ticketing
      case AppScreen.vendorStaffCreateTicketingScreen:
        return MaterialPageRoute(builder: (_) => const VenStaffCreateTicket());
      case AppScreen.vendorStaffTicketingDetailsScreen:
        return MaterialPageRoute(builder: (_) => const VenStaffTicketDetails());

      /// WASTE MANAGEMENT AGENCY

      // Staff Management
      case AppScreen.wasAgencyAllStaffDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasAgencyAllStaffDetails());

      case AppScreen.editAllWasAgencyStaffDetailsScreen:
        return MaterialPageRoute(builder: (_) => const WasAgencyEditAllStaff());

      // Nylon Management
      case AppScreen.wasAgencyNylonManDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasAgencyNylonManagementDetails());

      // Sales Report
      case AppScreen.wasAgencySalesReDetailsScreen:
        return MaterialPageRoute(builder: (_) => const WasAgencySalesDetails());
      case AppScreen.wasAgencySalesBatchDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasAgencySalesBatchDetails());

      // Ticketing
      case AppScreen.wasAgencyCreateTicketingScreen:
        return MaterialPageRoute(builder: (_) => const WasAgencyCreateTicket());
      case AppScreen.wasAgencyTicketingDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasAgencyTicketDetails());

      //// WASTE MANAGEMENT STAFF

      // Sales Report
      case AppScreen.wasStaffSalesReDetailsScreen:
        return MaterialPageRoute(builder: (_) => const WasStaffSalesDetails());
      case AppScreen.wasStaffSalesBatchDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const WasStaffSalesBatchDetails());
      // Ticketing
      case AppScreen.wasStaffCreateTicketingScreen:
        return MaterialPageRoute(builder: (_) => const WasStaffCreateTicket());
      case AppScreen.wasStaffTicketingDetailsScreen:
        return MaterialPageRoute(builder: (_) => const WasStaffTicketDetails());

      /// STATE GOVERNMENT AGENCY

      // Nylon Management
      case AppScreen.stateGovNylonManaDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const StateGovNylonManagementDetails());

      // Sales Report
      case AppScreen.stateGovSalesReDetailsScreen:
        return MaterialPageRoute(builder: (_) => const StateGovSalesDetails());
      case AppScreen.stateGovSalesBatchDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => const StateGovSalesBatchDetails());

      // Ticketing
      case AppScreen.stateGovCreateTicketingScreen:
        return MaterialPageRoute(builder: (_) => const StateGovCreateTicket());
      case AppScreen.stateGovTicketingDetailsScreen:
        return MaterialPageRoute(builder: (_) => const StateGovTicketDetails());
    }

    return _errorRoute();
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("something went wrong"),
        ),
      );
    });
  }
}

class AppScreen {
  static const String login = "/login";
  static const String registration = "/registration";
  static const String forgetPassword = "/forgetPassword";
  static const String changePassword = "/changePassword";
  static const String otpScreen = "/otpScreen";
  static const String dashboard = "/dashboard";
  static const String homeScreen = "/homeScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String notificationProfileScreen = "/notificationProfileScreen";
  static const String vendorBankDetailsScreen = "/vendorBankDetailsScreen";
  static const String editProfileScreen = "/editProfileScreen";

  // ADMIN

  static const String ticketResolvedDetailsScreen =
      "/ticketResolvedDetailsScreen";
  static const String invoiceDetailsScreen = "/invoiceDetailsScreen";
  static const String withdrawDetailsScreen = "/withdrawDetailsScreen";
// Sub-Admin
  static const String subAdminDetailsScreen = "/subAdminDetailsScreen";
  static const String subAdminEditScreen = "/subAdminEditScreen";
  static const String subAdminAddScreen = "/subAdminAddScreen";

  // Eco-blue Sub-Admin
  static const String ecoBlueSubAdminDetailsScreen = "/ecoBlueSubAdminDetailsScreen";
  static const String ecoBlueSubAdminEditScreen = "/ecoBlueSubAdminEditScreen";
  static const String ecoBlueSubAdminAddScreen = "/ecoBlueSubAdminAddScreen";

// Vendor
  static const String vendorDetailsScreen = "/vendorDetailsScreen";
  static const String vendorEditScreen = "/vendorEditScreen";
  static const String allViewDetailsScreen = "/allViewDetailsScreen";
  static const String batchDetailsScreen = "/batchDetailsScreen";
  static const String serialDetailsScreen = "/serialDetailsScreen";
  static const String vendorStaffListDetailsScreen =
      "/vendorStaffListDetailsScreen";
  static const String vendorStaffListEditScreen = "/vendorStaffListEditScreen";

// Waste Management Agency
  static const String WasteManagementDetailsScreen =
      "/WasteManagementDetailsScreen";
  static const String WasteManagementEditScreen = "/WasteManagementEditScreen";
  // Waste Management Agency Staff
  static const String WasteManagementStaffDetailsScreen =
      "/WasteManagementStaffDetailsScreen";
  static const String WasteManagementStaffEditScreen =
      "/WasteManagementStaffEditScreen";
  // Nylon Production Company
  static const String nylonProductionCompanyEditScreen =
      "/nylonProductionCompanyEditScreen";
  // State Government Agency
  static const String stateGovernmentAgencyEditScreen =
      "/stateGovernmentAgencyEditScreen";
  static const String stateGovernmentAgencyAddScreen =
      "/stateGovernmentAgencyAddScreen";
  // Enforcement Team
  static const String enforcementTeamEditScreen = "/enforcementTeamEditScreen";
  static const String enforcementTeamAddScreen = "/enforcementTeamAddScreen";
  // Nylon Management
  static const String generatedDetailsScreen = "/generatedDetailsScreen";
  static const String assignedDetailsScreen = "/assignedDetailsScreen";
  // Vendor Management
  static const String allVendorDetailsScreen = "/allVendorDetailsScreen";
  static const String allVendorEditScreen = "/allVendorEditScreen";
  static const String vendorAddStaffList = "/vendorAddStaffList";
  static const String allVendorViewDetailsScreen =
      "/allVendorViewDetailsScreen";
  static const String allVendorBatchDetailsScreen =
      "/allVendorBatchDetailsScreen";
  static const String allVendorSerialDetailsScreen =
      "/allVendorSerialDetailsScreen";
  static const String AllVendorStaffDetailsScreen =
      "/AllVendorStaffDetailsScreen";
  static const String editAllVendorStaffScreen = "/editAllVendorStaffScreen";
  static const String orderHistoryDetailsScreen = "/orderHistoryDetailsScreen";
  static const String orderHistoryInvoiceGenScreen =
      "/orderHistoryInvoiceGenScreen";
  // Ticketing
  static const String adminTicketDetailsScreen = "/adminTicketDetailsScreen";

  /// SUB_ADMIN

  // Vendor
  static const String vendorViewDetailsScreen = "/vendorViewDetailsScreen";
  // Purchase History
  static const String vendorPurchaseHistoryViewDetailsScreen =
      "/vendorPurchaseHistoryViewDetailsScreen";
  static const String vendorPurBatchDetailsScreen =
      "/vendorPurBatchDetailsScreen";
  static const String vendorPurSerialDetailsScreen =
      "/vendorPurSerialDetailsScreen";
  static const String vendorStaffDetailsScreen = "/vendorStaffDetailsScreen";
  // Waste Management Agency
  static const String subUserWasteMaAgDetailsScreen =
      "/subUserWasteMaAgDetailsScreen";
  static const String subUserWasteMaStaffDetailsScreen =
      "/subUserWasteMaStaffDetailsScreen";
  // Nylon Management
  static const String subNylonManagementDetailsScreen =
      "/subNylonManagementDetailsScreen";
  // Invoice
  static const String subInvoiceDetailsScreen = "/subInvoiceDetailsScreen";
  // Ticketing
  static const String subTicketingDetailsScreen = "/subTicketingDetailsScreen";

  //// VENDOR

  //  Staff Management
  static const String vendorAllStaffDetailsScreen =
      "/vendorAllStaffDetailsScreen";
  static const String editAllVendorStaffDetailsScreen =
      "/editAllVendorStaffDetailsScreen";
  static const String wasteSerialDetailsScreen = "/wasteSerialDetailsScreen";
  // Order Management
  static const String byNylonDetailsScreen = "/byNylonDetailsScreen";
  static const String editBellingDetailsScreen = "/editBellingDetailsScreen";
  static const String nylonPlaceOrderScreen = "/nylonPlaceOrderScreen";
  static const String vendorSalesReportDetailsScreen =
      "/vendorSalesReportDetailsScreen";
  static const String vendorSalesReBatchDetailsScreen =
      "/vendorSalesReBatchDetailsScreen";
  // Withdraw Request
  static const String withdrawalHistoryDetailsScreen =
      "/withdrawalHistoryDetailsScreen";
  // Ticketing
  static const String vendorCreateTicketingScreen =
      "/vendorCreateTicketingScreen";
  static const String vendorTicketingDetailsScreen =
      "/vendorTicketingDetailsScreen";

  //// VENDOR STAFF

  // Sales Report
  static const String vendorStaffSalesReDetailsScreen =
      "/vendorStaffSalesReDetailsScreen";
  static const String vendorStaffSalesBatchDetailsScreen =
      "/vendorStaffSalesBatchDetailsScreen";
  // Ticketing
  static const String vendorStaffCreateTicketingScreen =
      "/vendorStaffCreateTicketingScreen";
  static const String vendorStaffTicketingDetailsScreen =
      "/vendorStaffTicketingDetailsScreen";

  //// WASTE MANAGEMENT AGENCY

  //  Staff Management
  static const String wasAgencyAllStaffDetailsScreen =
      "/wasAgencyAllStaffDetailsScreen";
  static const String editAllWasAgencyStaffDetailsScreen =
      "/editAllWasAgencyStaffDetailsScreen";
  // Nylon Management
  static const String wasAgencyNylonManDetailsScreen =
      "/wasAgencyNylonManDetailsScreen";
  // Sales Report
  static const String wasAgencySalesReDetailsScreen =
      "/wasAgencySalesReDetailsScreen";
  static const String wasAgencySalesBatchDetailsScreen =
      "/wasAgencySalesBatchDetailsScreen";
  // Ticketing
  static const String wasAgencyCreateTicketingScreen =
      "/wasAgencyCreateTicketingScreen";
  static const String wasAgencyTicketingDetailsScreen =
      "/wasAgencyTicketingDetailsScreen";

  //// WASTE MANAGEMENT STAFF

  // Sales Report
  static const String wasStaffSalesReDetailsScreen =
      "/wasStaffSalesReDetailsScreen";
  static const String wasStaffSalesBatchDetailsScreen =
      "/wasStaffSalesBatchDetailsScreen";
  // Ticketing
  static const String wasStaffCreateTicketingScreen =
      "/wasStaffCreateTicketingScreen";
  static const String wasStaffTicketingDetailsScreen =
      "/wasStaffTicketingDetailsScreen";

  //// STATE GOVERNMENT AGENCY

  // Nylon Management
  static const String stateGovNylonManaDetailsScreen =
      "/stateGovNylonManaDetailsScreen";
  // Sales Report
  static const String stateGovSalesReDetailsScreen =
      "/stateGovSalesReDetailsScreen";
  static const String stateGovSalesBatchDetailsScreen =
      "/stateGovSalesBatchDetailsScreen";
  // Ticketing
  static const String stateGovCreateTicketingScreen =
      "/stateGovCreateTicketingScreen";
  static const String stateGovTicketingDetailsScreen =
      "/stateGovTicketingDetailsScreen";
}
