package buildings.seminary.view
{
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import ui.queuebar.view.QueueItem;
   
   public class TechnologyOrderItemView extends QueueItem
   {
      
      public function TechnologyOrderItemView()
      {
         super();
         _back.width -= 23;
         _back.visible = true;
         _button.x = 165;
         _button.y = 3;
         _time.x = 112;
         _time.y = 3;
      }
      
      override protected function updateView() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("buildings.seminary.view.TechnologyOrderItemView.content");
         var _loc2_:String = LanguageMgr.GetTranslation("buildings.seminary.view.TechnologyOrderItemView.content2");
         updateTxt(_loc1_,_loc2_);
         buttonMode = false;
      }
      
      override protected function __overHandler(param1:MouseEvent) : void
      {
      }
      
      override protected function __outHandler(param1:MouseEvent) : void
      {
      }
      
      public function set backVisible(param1:Boolean) : void
      {
         if(_back)
         {
            _back.visible = param1;
         }
      }
   }
}

