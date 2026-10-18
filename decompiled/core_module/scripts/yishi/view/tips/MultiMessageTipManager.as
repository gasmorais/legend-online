package yishi.view.tips
{
   import com.pickgliss.ui.LayerManager;
   import flash.display.Sprite;
   import map.campaign.CampaignManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.scene.SceneManager;
   import yishi.utils.WorldBossHelper;
   
   public class MultiMessageTipManager extends Sprite
   {
      
      private static var _instance:MultiMessageTipManager;
      
      private const MAX_COUNT:int = 3;
      
      private var tipList:Array = [];
      
      private var countForResetY:int = 0;
      
      public function MultiMessageTipManager()
      {
         super();
         addEvent();
      }
      
      public static function get instance() : MultiMessageTipManager
      {
         if(_instance == null)
         {
            _instance = new MultiMessageTipManager();
         }
         return _instance;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("SWITCH_SCENE",__onSceneChangeHandler);
      }
      
      private function __onSceneChangeHandler(param1:NotificationEvent) : void
      {
         visible = SceneManager.instance.currentType != "BATTLE_SCENE";
      }
      
      public function show(param1:String) : void
      {
         var _loc5_:MultiMessageTipItem = null;
         var _loc2_:MultiMessageTipItem = null;
         mouseEnabled = false;
         mouseChildren = false;
         var _loc4_:int = CampaignManager.instance.mapId;
         if(SceneManager.instance.currentType == "BATTLE_SCENE" || WorldBossHelper.checkIsNoviceMap(_loc4_))
         {
            return;
         }
         if(tipList.length < 3)
         {
            _loc5_ = new MultiMessageTipItem(callBack);
         }
         else
         {
            _loc5_ = tipList.shift();
         }
         _loc5_.setTip(param1);
         _loc5_.mouseEnabled = _loc5_.mouseChildren = false;
         addChild(_loc5_);
         tipList.push(_loc5_);
         var _loc3_:int = 0;
         if(tipList.length < 3)
         {
            while(_loc3_ < tipList.length)
            {
               _loc2_ = tipList[_loc3_];
               _loc2_.y = -300 + (3 - tipList.length + _loc3_) * 30;
               _loc3_++;
            }
         }
         else
         {
            while(_loc3_ < tipList.length)
            {
               _loc2_ = tipList[_loc3_];
               _loc2_.y = -300 + _loc3_ * 30;
               _loc3_++;
            }
         }
         if(this.parent == null)
         {
            LayerManager.Instance.addToLayer(this,0,true);
         }
      }
      
      private function callBack() : void
      {
         if(this.numChildren <= 0 && this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

