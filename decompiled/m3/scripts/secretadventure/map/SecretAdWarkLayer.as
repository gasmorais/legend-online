package secretadventure.map
{
   import com.pickgliss.utils.ObjectUtils;
   import events.ObjectsEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import map.internals.utils.ArmySpeedUtils;
   import mvc.module.secret.SecretAdArmy;
   import mvc.module.secret.SecretAdventureModel;
   import secretadventure.item.SecretHexagon;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretAdventerManager;
   
   public class SecretAdWarkLayer extends Sprite implements IEnterFrame
   {
      
      private var armyView:SecretAdArmyView;
      
      public function SecretAdWarkLayer()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
         initTeamArmys();
      }
      
      private function initTeamArmys() : void
      {
         var _loc3_:int = int(model.secenInfo.currMapDataId);
         var _loc2_:Sprite = model.getMap(_loc3_);
         var _loc1_:SecretAdArmy = model.pinfo.armyData;
         armyView = createArmy(_loc1_,_loc3_);
         _loc2_.addChild(armyView);
      }
      
      private function createArmy(param1:SecretAdArmy, param2:int) : SecretAdArmyView
      {
         var _loc3_:SecretAdArmyView = new SecretAdArmyView();
         var _loc6_:AIBaseInfo = new BaseArmyAiInfo();
         _loc6_.speed = ArmySpeedUtils.getMoveSpeed(param1);
         _loc3_.info = _loc6_;
         _loc3_.data = param1;
         _loc3_.filter = null;
         _loc3_.mouseChildren = false;
         _loc3_.mouseEnabled = false;
         var _loc4_:int = int(model.pinfo.lastStandNodeId);
         var _loc5_:SecretHexagon = model.getNode(param2,_loc4_) as SecretHexagon;
         if(_loc5_)
         {
            _loc3_.x = _loc5_.x;
            _loc3_.y = _loc5_.y;
            _loc5_.updateRiver();
         }
         _loc3_.visible = !model.frameInfo.isDie;
         _loc3_.addEventListener("walkOver",__warkOverHandler);
         return _loc3_;
      }
      
      private function __warkOverHandler(param1:ObjectsEvent) : void
      {
         armyView.data.isMoving = false;
         var _loc3_:Function = model.pinfo.walkCallBack;
         if(_loc3_ != null)
         {
            _loc3_();
            model.pinfo.walkCallBack = null;
         }
         var _loc4_:int = int(model.secenInfo.currMapDataId);
         var _loc2_:SecretHexagon = model.getNode(_loc4_,model.pinfo.standNodeId) as SecretHexagon;
         if(_loc2_)
         {
            _loc2_.hideWalkFlg();
            SecretAdventerManager.Instance.opWalk(_loc4_,_loc2_.getId());
            model.pinfo.lastStandNodeId = _loc2_.getId();
         }
      }
      
      public function enterFrame() : void
      {
         if(!armyView)
         {
            return;
         }
         armyView.execute();
         if(!armyView.isLiving)
         {
            if(armyView)
            {
               armyView.dispose();
            }
            armyView = null;
         }
      }
      
      private function initEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         NotificationManager.instance.addEventListener("SecretAdEvent.transMap",transMapHandler);
         NotificationManager.instance.addEventListener("SecretAdEvent.lifeUpdate",lifeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         NotificationManager.instance.removeEventListener("SecretAdEvent.transMap",transMapHandler);
         NotificationManager.instance.removeEventListener("SecretAdEvent.lifeUpdate",lifeUpdateHandler);
         if(armyView)
         {
            armyView.removeEventListener("walkOver",__warkOverHandler);
         }
      }
      
      private function lifeUpdateHandler(param1:Event) : void
      {
         if(armyView)
         {
            armyView.visible = !model.frameInfo.isDie;
         }
         var _loc4_:int = int(model.secenInfo.currMapDataId);
         var _loc2_:int = int(model.pinfo.lastStandNodeId);
         var _loc3_:SecretHexagon = model.getNode(_loc4_,_loc2_) as SecretHexagon;
         if(_loc3_)
         {
            _loc3_.updateRiver();
         }
      }
      
      private function transMapHandler(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc3_:Sprite = null;
         var _loc2_:int = 0;
         var _loc4_:DisplayObject = null;
         if(armyView)
         {
            _loc5_ = int(model.secenInfo.currMapDataId);
            _loc3_ = model.getMap(_loc5_);
            _loc2_ = int(model.pinfo.lastStandNodeId);
            _loc4_ = model.getNode(_loc5_,_loc2_);
            if(_loc4_)
            {
               armyView.x = _loc4_.x;
               armyView.y = _loc4_.y;
            }
            _loc3_.addChild(armyView);
         }
      }
      
      private function get model() : SecretAdventureModel
      {
         return SecretAdventerManager.Instance.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(armyView);
         armyView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

