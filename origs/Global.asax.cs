using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace MBv8Web
{
    public partial class Global :  System.Web.HttpApplication
    {

        protected void Application_OnStart(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }

       

        // Manually added for routing test for Semi MVC implementation
        void RegisterRoutes(RouteCollection routes)
        {
            // Main menu routes    
            routes.MapPageRoute("", "Index/", "~/Default.aspx");
            routes.MapPageRoute("", "Login/", "~/html/pages/login.aspx");
            routes.MapPageRoute("", "Profile/", "~/html/pages/profile.aspx");
            //routes.MapPageRoute("", "Profile/updatesql", "~/html/pages/profile.aspx");
            //routes.MapPageRoute("img", "IMG/", "~/html/img/img.img");

            routes.MapPageRoute("", "Main/", "~/html/index.aspx");

            // Bank Transactions
            routes.MapPageRoute("", "Transaction/", "~/html/transactions.aspx");
            routes.MapPageRoute("", "Bank-Account/", "~/html/bank-accounts.aspx");
            routes.MapPageRoute("", "Banking-Deposit/","~/html/banking-deposit.aspx");
            routes.MapPageRoute("", "Fund-Transfer/","~/html/fund-transfer.aspx");
            routes.MapPageRoute("", "Check-Inventory/","~/html/check-inventory.aspx");
            routes.MapPageRoute("", "Bank-Recon/", "~/html/bank-recon.aspx");

            // AP Transactions
            routes.MapPageRoute("", "Share-Withdrawals/", "~/html/ap-share-withdrawal.aspx");
            routes.MapPageRoute("", "Loan-Disbursement/", "~/html/ap-loan-disbursement.aspx");
            routes.MapPageRoute("", "Po-Transactions/", "~/html/po-transaction.aspx");
            routes.MapPageRoute("", "Bills-Payment/", "~/html/bills-payment.aspx");
            routes.MapPageRoute("", "Vendor-Management/", "~/html/ap-add-vendor.aspx");

            // fix assets
            routes.MapPageRoute("", "Fix-Assets/", "~/html/fix-asset.aspx");
            routes.MapPageRoute("", "Asset-Report/", "~/html/fix-asset-depreciation.aspx");
            routes.MapPageRoute("", "Asset-SellDispose/", "~/html/fix-asset-sell-disposal.aspx");

            // Operation
            routes.MapPageRoute("", "Cash-Advance/", "~/html/bank-operations.aspx?module=cashadvance");
            routes.MapPageRoute("", "Petty-Cash/", "~/html/bank-operations.aspx?module=pettycash");
            routes.MapPageRoute("", "Payroll/", "~/html/bank-operations.aspx?module=payroll");
            routes.MapPageRoute("", "GenericGL/", "~/html/gen-entry.aspx");

            routes.MapPageRoute("", "Bank-Reconrpt/", "~/html/Bank-ReconReport.aspx");

            // Self Web Service
            routes.MapPageRoute("", "mcuserv/", "~/html/pages/mcuservjs.aspx");
            routes.MapPageRoute("", "appconfig/", "~/html/pages/app-settings.aspx");

            routes.MapPageRoute("", "BackUp/", "~/html/pages/backdb.aspx");
          //  routes.MapPageRoute("", "Index/", "~/Default.aspx");
        }

       
    }
}