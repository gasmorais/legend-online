package map.campaign.mediator.mapview
{
   import com.pickgliss.utils.ObjectUtils;
   import thessbox.view.ThessBoxLeftView;
   import yishi.interfaces.IMediator;
   
   public class ThessBoxMediator implements IMediator
   {
      
      private var _leftView:ThessBoxLeftView;
      
      public function ThessBoxMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         initView();
      }
      
      private function initView() : void
      {
         _leftView = new ThessBoxLeftView();
         _leftView.y = 295;
         _leftView.show();
      }
      
      public function unregister(param1:Object) : void
      {
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
      }
   }
}

