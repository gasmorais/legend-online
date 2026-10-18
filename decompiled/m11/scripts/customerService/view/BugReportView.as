package customerService.view
{
   import mvc.module.customerService.CustomerServiceModel;
   
   public class BugReportView extends CustomerServiceSelectedView
   {
      
      public function BugReportView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "BugReportView";
      }
   }
}

