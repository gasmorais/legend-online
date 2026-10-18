package buildings.politics.view
{
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import ui.queuebar.view.QueueItem;
   
   public class LevyQueueItem extends QueueItem
   {
      
      public function LevyQueueItem()
      {
         super();
         _back.width = 216;
         _back.visible = true;
         _back.x = 13;
         _back.y = 2;
         _button.visible = false;
         _button.x = 204;
         _button.y = 4;
         _time.x = 146;
         _title.y = 2;
         _time.y = 4;
      }
      
      override protected function updateView() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("buildings.politics.view.update");
         var _loc2_:String = LanguageMgr.GetTranslation("buildings.politics.view.update2");
         updateTxt(_loc1_,_loc2_);
         buttonMode = false;
         _button.visible = _data.remainTime > 0;
      }
      
      override protected function __overHandler(param1:MouseEvent) : void
      {
      }
      
      override protected function __outHandler(param1:MouseEvent) : void
      {
      }
   }
}

