package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.module.planeswar.PlanesArmy;
   import mvc.module.planeswar.PlanesWarModel;
   import yishi.ai.BaseArmyAiInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.PlayerManager;
   
   public class PlanesWalkLayer extends Sprite implements IEnterFrame, Disposeable
   {
      
      private var _walkTarget:MovieClip;
      
      private var armyView:PlanesArmyView;
      
      public function PlanesWalkLayer()
      {
         super();
         addEvent();
         addToStage(null);
         this.mouseEnabled = false;
      }
      
      public function addToStage(param1:Event) : void
      {
         initArmyView();
         _walkTarget = ComponentFactory.Instance.creatCustomObject("asset.outercity.WalkTargetEffectAsset");
         _walkTarget.mouseChildren = _walkTarget.mouseEnabled = false;
         _walkTarget.scrollRect = null;
         addChild(_walkTarget);
         _walkTarget.stop();
         _walkTarget.visible = false;
      }
      
      private function initArmyView() : void
      {
         var _loc1_:PlanesArmy = model.selfArmy;
         armyView = new PlanesArmyView();
         armyView.info = new BaseArmyAiInfo();
         armyView.info.speed = 7;
         armyView.info.isLiving = true;
         _loc1_.armyView = armyView;
         armyView.armyInfo = _loc1_;
         addChild(armyView);
         armyView.x = _loc1_.x * 100 + 50;
         armyView.y = _loc1_.y * 100 + 50;
         if(model.planesWarInfo.dead)
         {
            armyView.showDie(false);
         }
         else
         {
            armyView.showLife();
         }
      }
      
      public function get walkTarget() : MovieClip
      {
         return _walkTarget;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         PlanesWarManager.instance.addEventListener("PLANES_MOVE_PATH",__moveBackHandler);
         PlanesWarManager.instance.addEventListener("PLANES_REVIVE_BACK",updateUserArmyViewState);
         PlanesWarManager.instance.addEventListener("HELP_RERIVE_BACK",updateUserArmyViewState);
         PlanesWarManager.instance.addEventListener("PLANES_WARINFO_UPDATE",updateUserArmyViewState);
         PlanesWarManager.instance.addEventListener("RESTORE_POSXY",restorePosXYState);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         PlanesWarManager.instance.removeEventListener("PLANES_MOVE_PATH",__moveBackHandler);
         PlanesWarManager.instance.removeEventListener("PLANES_REVIVE_BACK",updateUserArmyViewState);
         PlanesWarManager.instance.removeEventListener("HELP_RERIVE_BACK",updateUserArmyViewState);
         PlanesWarManager.instance.removeEventListener("PLANES_WARINFO_UPDATE",updateUserArmyViewState);
         PlanesWarManager.instance.removeEventListener("RESTORE_POSXY",restorePosXYState);
      }
      
      private function __moveBackHandler(param1:PlanesWarEvent) : void
      {
         var _loc4_:int = 0;
         var _loc8_:Point = null;
         var _loc6_:Object = param1.data;
         var _loc7_:int = int(_loc6_.userId);
         var _loc2_:Array = _loc6_.path;
         if(_loc2_.length == 0)
         {
            return;
         }
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc8_ = new Point();
            _loc8_.x = (_loc2_[_loc4_].x * 100 + 50) / 20;
            _loc8_.y = (_loc2_[_loc4_].y * 100 + 50) / 20;
            _loc3_.push(_loc8_);
            _loc4_++;
         }
         var _loc5_:PlanesArmy = model.selfArmy;
         if(model.selfArmy)
         {
            (_loc5_.armyView as PlanesArmyView).avatarView.state = 4;
            (_loc5_.armyView as PlanesArmyView).info.pathInfo = _loc3_;
            _loc5_.isMoving = true;
         }
      }
      
      private function updateUserArmyViewState(param1:PlanesWarEvent) : void
      {
         var _loc3_:int = int(param1.data);
         var _loc2_:PlanesArmyView = model.selfArmy.armyView as PlanesArmyView;
         if(_loc2_ == null)
         {
            return;
         }
         if(model.planesWarInfo.dead)
         {
            _loc2_.showDie(true);
         }
         else
         {
            _loc2_.showLife();
         }
      }
      
      private function restorePosXYState(param1:PlanesWarEvent) : void
      {
         var _loc2_:PlanesArmyView = model.selfArmy.armyView as PlanesArmyView;
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.x = model.planesWarInfo.posX * 100 + 50;
         _loc2_.y = model.planesWarInfo.posY * 100 + 50;
         _loc2_.info.pathInfo = [];
         model.selfArmy.walkPath = [];
         model.selfArmy.isMoving = false;
         PlanesWarManager.instance.updateMapAndGridInfo();
         model.endPoint = null;
      }
      
      public function enterFrame() : void
      {
         if(model.selfArmy.armyView)
         {
            (model.selfArmy.armyView as PlanesArmyView).execute();
         }
      }
      
      private function createPlanesMapArmy(param1:PlanesArmy) : PlanesArmyView
      {
         var _loc2_:PlanesArmyView = getPlanesArmyViewById(param1.userId);
         if(!_loc2_)
         {
            _loc2_ = new PlanesArmyView();
            _loc2_.info = new BaseArmyAiInfo();
         }
         _loc2_.info.speed = 7;
         _loc2_.info.isLiving = true;
         param1.armyView = _loc2_;
         _loc2_.armyInfo = param1;
         return _loc2_;
      }
      
      private function getPlanesArmyViewById(param1:int) : PlanesArmyView
      {
         return model.selfArmy.armyView as PlanesArmyView;
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      private function get playerinfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_walkTarget);
         _walkTarget = null;
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

