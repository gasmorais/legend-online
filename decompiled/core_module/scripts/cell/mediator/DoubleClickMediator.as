package cell.mediator
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import yishi.interfaces.IMediator;
   import yishi.view.community.BaseItemView;
   
   public class DoubleClickMediator implements IMediator
   {
      
      protected var _cell:BaseItemView;
      
      public function DoubleClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseItemView;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell = null;
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
      }
      
      protected function __mouseDoubleClick(param1:Event) : void
      {
      }
   }
}

