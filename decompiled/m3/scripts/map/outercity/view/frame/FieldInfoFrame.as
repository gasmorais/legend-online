package map.outercity.view.frame
{
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.internals.view.frame.FieldInfoView;
   import map.outercity.manager.OuterCityManager;
   import yishi.manager.ArmyManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class FieldInfoFrame extends FieldInfoView
   {
      
      public function FieldInfoFrame()
      {
         super();
      }
      
      override protected function __attackHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(ArmyManager.instance.thane.userId == _wildLand.info.occupyPlayerId)
         {
            SimpleAlertHelper.instance.data = [__giveUpCall];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("map.FieldInfoFrame.prompt");
            _loc5_ = LanguageMgr.GetTranslation("map.FieldInfoFrame.content");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
         }
         else
         {
            OuterCityManager.instance.controler.sendAttack(_wildLand.posX,_wildLand.posY);
         }
         if(_frame && _frame.parent)
         {
            _frame.parent.removeChild(_frame);
         }
      }
      
      private function __giveUpCall(param1:Boolean) : void
      {
         if(param1)
         {
            OuterCityManager.instance.controler.sendGiveUp(_wildLand);
         }
      }
      
      override protected function __moveHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         close();
      }
   }
}

