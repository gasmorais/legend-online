package customerService.view
{
   import mvc.module.customerService.CustomerServiceModel;
   
   public class OtherView extends CustomerServiceSelectedView
   {
      
      public function OtherView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "OtherView";
      }
   }
}

