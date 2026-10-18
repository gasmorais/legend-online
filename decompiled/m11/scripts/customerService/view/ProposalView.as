package customerService.view
{
   import mvc.module.customerService.CustomerServiceModel;
   
   public class ProposalView extends CustomerServiceSelectedView
   {
      
      public function ProposalView(param1:CustomerServiceModel)
      {
         super(param1);
         viewType = "ProposalView";
      }
   }
}

