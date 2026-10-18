package armyII.viewII
{
   import com.pickgliss.ui.core.Component;
   
   public class BaseHeroPanelII extends Component
   {
      
      public function BaseHeroPanelII()
      {
         super();
      }
      
      protected function addEvent() : void
      {
      }
      
      protected function removeEvent() : void
      {
      }
      
      public function show() : void
      {
         visible = true;
      }
      
      public function hide() : void
      {
         visible = false;
      }
   }
}

