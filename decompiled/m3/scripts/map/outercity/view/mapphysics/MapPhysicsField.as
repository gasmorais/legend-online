package map.outercity.view.mapphysics
{
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.internals.event.OuterCityEvent;
   import map.internals.view.displaye.PhysicsMenu;
   import map.internals.view.physics.PhysicsFieldView;
   import map.outercity.manager.OuterCityManager;
   import yishi.manager.ArmyManager;
   import yishi.manager.BuildingManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MapPhysicsField extends PhysicsFieldView
   {
      
      public function MapPhysicsField()
      {
         super();
      }
      
      override public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         var _loc2_:String = null;
         var _loc4_:Object = null;
         var _loc3_:String = info.info.occupyLeagueName;
         if(!mouseHitTest())
         {
            return false;
         }
         if(ArmyManager.instance.thane.grades >= 6)
         {
            if(ArmyManager.instance.thane.userId == info.info.occupyPlayerId)
            {
               _loc4_ = {};
               _loc4_["BTN_GIVE_UP"] = giveUpCall;
               PhysicsMenu.getInstance().showPhysicsMenu(info,_loc4_);
            }
            else
            {
               if(!StringHelper.isNullOrEmpty(_loc3_) && _loc3_ == PlayerManager.instance.currentPlayerModel.playerInfo.consortiaName)
               {
                  _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsField.AttackConsortiaMember");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               if(BuildingManager.instance.model.fieldDic.getList().length >= 2)
               {
                  _loc2_ = LanguageMgr.GetTranslation("map.outercity.view.mapphysics.MapPhysicsField.txt");
                  MessageTipManager.instance().show(_loc2_);
                  return false;
               }
               NotificationManager.instance.dispatchEvent(new OuterCityEvent("START_MOVE",info));
            }
            return true;
         }
         return false;
      }
      
      private function giveUpCall() : void
      {
         OuterCityManager.instance.controler.sendGiveUp(info);
      }
   }
}

