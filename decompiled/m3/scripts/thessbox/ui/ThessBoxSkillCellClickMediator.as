package thessbox.ui
{
   import com.pickgliss.utils.DoubleClickManager;
   import flash.events.Event;
   import managers.TheseussoulManager;
   import mvc.module.theseus.ThessboxFightInfo;
   import thessbox.view.ThessBoxSkillCell;
   import yishi.interfaces.IMediator;
   
   public class ThessBoxSkillCellClickMediator implements IMediator
   {
      
      private var _cell:ThessBoxSkillCell;
      
      public function ThessBoxSkillCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as ThessBoxSkillCell;
         if(_cell.icon)
         {
            DoubleClickManager.Instance.enableDoubleClick(_cell.icon);
            _cell.icon.addEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.addEventListener("interactive_double_click",__mouseDoubleClick);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            DoubleClickManager.Instance.disableDoubleClick(_cell.icon);
            _cell.icon.removeEventListener("interactive_click",__mouseClickByClicker);
            _cell.icon.removeEventListener("interactive_double_click",__mouseDoubleClick);
            _cell = null;
         }
      }
      
      protected function __mouseClickByClicker(param1:Event) : void
      {
         if(!_cell || !_cell.data <= 0)
         {
            return;
         }
      }
      
      private function __mouseDoubleClick(param1:Event) : void
      {
         if(!_cell || !_cell.data <= 0)
         {
            return;
         }
         var _loc2_:ThessboxFightInfo = TheseussoulManager.Instance.thessboxInInfo;
         if(_cell.type == 1)
         {
            _cell.data = -1;
            _loc2_.updateEquip(_cell.pos,_cell.data);
         }
         else if(_cell.type == 2)
         {
         }
      }
   }
}

