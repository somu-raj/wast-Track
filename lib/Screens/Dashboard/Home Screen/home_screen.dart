import 'package:flutter/material.dart';
import 'package:waste_track/Screens/Admin/Invoices%20Screen/invoices_screen.dart';
import 'package:waste_track/Screens/Admin/Nylon%20Management%20Screen/nylon_management_screen.dart';
import 'package:waste_track/Screens/Admin/Revenue%20Screen/revenue_screen.dart';
import 'package:waste_track/Screens/Admin/Ticketing%20Screen/ticketing%20Screen.dart';
import 'package:waste_track/Screens/Admin/User%20Management%20Screen/user_management_screen.dart';
import 'package:waste_track/Screens/Admin/Vendor%20Manangement%20Screen/vendor_management_screen.dart';
import 'package:waste_track/Screens/Admin/Waste%20Collection%20Screen/waste_collection_screen.dart';
import 'package:waste_track/Screens/Admin/Withdraw%20Request%20Screen/withraw_request_screen.dart';
import 'package:waste_track/Screens/Common%20Widget/Home%20Widget/home_widget.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Calendar/state_gov_calendar.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Nylon%20Management/state_gov_nylon_management.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Revenue%20Generated/state_gov_revenue_generated.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Sales%20Report/state_gov_sales_report.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Ticketing/state_gov_ticketing.dart';
import 'package:waste_track/Screens/State%20Government%20Agency/State%20Gov%20Waste%20Collection/state_gov_waste_management.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Calendar/sub_calendar.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Invoices/sub_invoices.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Nylon%20Management/sub_nylon_management.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Revenue/sub_Revenue.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Ticketing/sub_ticketing.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20User%20Management/sub_user_management.dart';
import 'package:waste_track/Screens/Sub%20Admin/Sub%20Waste%20Collection/sub_waste_collection.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Calendar/ven_staff_calendar.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Sales%20Report/ven_staff_sales_report.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Ticketing/ven_staff_ticketing.dart';
import 'package:waste_track/Screens/Vendor%20Staff/Vendor%20Staff%20Waste%20Collected/vendor_staff_waste_collected.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Assigned%20Areas/vendor_assigned_areas.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Calendar/vendor_calendar.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Order%20Management/vendor_order_management.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Revenue%20Generated/vendor_revenue_generated.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Sales%20Report/vendor_sales_report.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Staff%20Management/vendor_staff_management.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Ticketing/ven_ticketing.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Waste%20Management/vendor_waste_management.dart';
import 'package:waste_track/Screens/Vendor/Vendor%20Withdraw%20Request/Vendor_withdraw_request.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Calendar/was_agency_calendar.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Nylon%20Management/was_agency_nylon_management.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Revenue%20Generated/was_agency_revenue_generated.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Sales%20Report/was_agency_sales_report.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Staff%20Management/was_agency_staff_management.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Ticketing/was_agency_ticketing.dart';
import 'package:waste_track/Screens/Waste%20Management%20Agency/Was%20Agency%20Wast%20Collection/was_agency_wast_collection.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Calendar/was_staff_calendar.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Sales%20Report/was_staff_sales_report.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Ticketing/was_staff_ticketing.dart';
import 'package:waste_track/Screens/Waste%20Management%20Staff/Was%20Staff%20Waste%20Collection/was_staff_waste_collection.dart';
import 'package:waste_track/Utils/Components/dataStroage_database.dart';

import '../../Admin/Calendar Screen/calendar_screen.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin Calendar/eco_blue_sub_calendar.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin Invoices/eco_blue_sub_admin_invoices.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin Nylon Management/eco_blue_sub_admin_nylon_management.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin Revenue/eco_blue_sub_admin_Revenue.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin Ticketing/eco_blue_sub_admin_ticketing.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin User Management/eco_blue_sub_admin_user_management.dart';
import '../../Eco Blue Sub Admin/Eco Blue Sub Admin Waste Collection/eco_blue_sub_admin_waste_collection.dart';
import '../../Enforcement  Team/Enforcement  Team Revenue Generated/enfocement_team_revenue_generated.dart';
import '../../Enforcement  Team/Enforcement Team Ticketing/enfocement_team_ticketing.dart';
import '../../Enforcement  Team/Enforcement Team Waste Collection/enfocement_team_waste_management.dart';
import '../../Nylon Management Agency/Nylon Management Revenue Generated/nylon_management_revenue_generated.dart';
import '../../Nylon Management Agency/Nylon Management Sales Report/nylon_management_sales_report.dart';
import '../../Nylon Management Agency/Nylon Management Waste Collection/nylon_management_waste_management.dart';
import '../../Nylon Management Agency/Nylon Management/nylon_management.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> widgetList = [];
  String userType = "";

  @override
  void initState() {
    getData();
    super.initState();
  }
  getData() async {
    await getUserType();
  }
  getUserType() async {
    var userType = await SharedPref().getUserType();
    debugPrint("user type ==> $userType");
    if (userType == "1") {
      widgetList = [
        UserManagementScreen(),
        NylonManagementScreen(),
        VendorManagementScreen(),
        RevenueScreen(),
        WithdrawRequestScreen(),
        InvoicesScreen(),
        WastCollectionScreen(),
       // CalendarScreen(),
       // TicketingScreen(),
      ];

    }
    else if (userType == "2") {
      widgetList = [
        SubAdminUserManagement(),
        SubAdminNylonManagement(),
        SubAdminRevenue(),
        SubAdminInvoices(),
        SubAdminWasteCollection(),
        //SubAdminCalendar(),
        //SubAdminTicketing(),
      ];
    }
    else if (userType == "3") {
      widgetList = [
        EcoBlueSubAdminUserManagement(),
        EcoBlueSubAdminNylonManagement(),
        EcoBlueSubAdminRevenue(),
        EcoBlueSubAdminInvoices(),
        EcoBlueSubAdminWasteCollection(),
        //EcoBlueSubAdminCalendar(),
        //EcoBlueSubAdminTicketing(),
      ];
    }
    else if (userType == "4") {
      widgetList = [
        VendorStaffManagement(),
        VendorOrderManagement(),
        VendorWasteManagement(),
       // VendorSalesReport(),
        VendorWithdrawRequest(),
        VendorRevenueGenerated(),
        VendorAssignedAreas(),
        //VendorCalendar(),
        //VendorTicket(),
      ];
    }
    else if (userType == "5") {
      widgetList = [
        VenStaffWasteCollected(),
       // VenStaffSalesReport(),
        //VenStaffCalendar(),
        //VenStaffTicketing(),
      ];
    }
    else if (userType == "6") {
      widgetList = [
        //WasAgencyStaffManagement(),
        VendorStaffManagement(),
        WasAgencyNylonManagement(),
        WasAgencyWasteCollection(),
        WasAgencyRevenueGenerated(),
       // WasAgencySalesReport(),
        //WasAgencyCalendar(),
        //WasAgencyTicketing(),
      ];
    }
    else if (userType == "7") {
      widgetList = [
        WasStaffWasteCollection(),
       // WasStaffSalesReport(),
        //WasStaffCalendar(),
        //WasStaffTicketing(),
      ];
    }
    else if(userType =="8"){
      widgetList = [
        NylonManagement(),
        NylonManagementRevenueGenerated(),
        NylonManagementSalesReport(),
        NylonManagementWasteCollection(),
        //NylonProductionCalendar(),
        //NylonProductionTicketing(),
      ];
    }
    else if (userType == "10"){
      widgetList = [
        EnforcementTeamRevenueGenerated(),
        EnforcementTeamWasteCollection(),
        //EnforcementTeamTicketing(),
      ];
    }
    else {
      widgetList = [
        StateGovNylonManagement(),
        StateGovRevenueGenerated(),
       // StateGovSalesReport(),
        StateGovWasteCollection(),
        //StateGovCalendar(),
       // StateGovTicketing(),
      ];
    }
    setState(() {});
  }


  // getUserType() async {
  //   var userType = await SharedPref().getUserType();
  //   debugPrint("user type ==> $userType");
  //     if (userType == "1") {
  //       widgetList = [
  //         UserManagementScreen(),
  //         NylonManagementScreen(),
  //         VendorManagementScreen(),
  //         RevenueScreen(),
  //         WithdrawRequestScreen(),
  //         InvoicesScreen(),
  //         WastCollectionScreen(),
  //         CalendarScreen(),
  //         TicketingScreen(),
  //       ];
  //
  //     }
  //     else if(userType == "3"){
  //       widgetList = [
  //         UserManagementScreen(),
  //         NylonManagementScreen(),
  //         VendorManagementScreen(),
  //         RevenueScreen(),
  //         WithdrawRequestScreen(),
  //         InvoicesScreen(),
  //         WastCollectionScreen(),
  //         CalendarScreen(),
  //         TicketingScreen(),
  //       ];
  //     }
  //     else if (userType == "subAdmin") {
  //       widgetList = [
  //         SubAdminUserManagement(),
  //         SubAdminNylonManagement(),
  //         SubAdminRevenue(),
  //         SubAdminInvoices(),
  //         SubAdminWasteCollection(),
  //         SubAdminCalendar(),
  //         SubAdminTicketing(),
  //       ];
  //     }
  //     else if (userType == "4") {
  //       widgetList = [
  //         VendorStaffManagement(),
  //         VendorOrderManagement(),
  //         VendorWasteManagement(),
  //         VendorSalesReport(),
  //         VendorWithdrawRequest(),
  //         VendorRevenueGenerated(),
  //         VendorAssignedAreas(),
  //         VendorCalendar(),
  //         VendorTicket(),
  //       ];
  //     }
  //     else if (userType == "vendorStaff") {
  //       widgetList = [
  //         VenStaffWasteCollected(),
  //         VenStaffSalesReport(),
  //         VenStaffCalendar(),
  //         VenStaffTicketing(),
  //       ];
  //     }
  //     else if (userType == "wasteManagementAgency") {
  //       widgetList = [
  //         WasAgencyStaffManagement(),
  //         WasAgencyNylonManagement(),
  //         WasAgencyWasteCollection(),
  //         WasAgencyRevenueGenerated(),
  //         WasAgencySalesReport(),
  //         WasAgencyCalendar(),
  //         WasAgencyTicketing(),
  //       ];
  //     }
  //     else if (userType == "wasteManagementStaff") {
  //       widgetList = [
  //         WasStaffWasteCollection(),
  //         WasStaffSalesReport(),
  //         WasStaffCalendar(),
  //         WasStaffTicketing(),
  //       ];
  //     }
  //     else {
  //       widgetList = [
  //         StateGovNylonManagement(),
  //         StateGovRevenueGenerated(),
  //         StateGovSalesReport(),
  //         StateGovWasteCollection(),
  //         StateGovCalendar(),
  //         StateGovTicketing(),
  //       ];
  //     }
  //     setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 0),
        child: HomeWidget(widgetList: widgetList),
      ),
    );
  }
}
