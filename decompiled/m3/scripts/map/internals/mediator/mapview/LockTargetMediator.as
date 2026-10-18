package map.internals.mediator.mapview
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import map.campaign.CampaignManager;
   import map.campaign.view.physics.CampaignArmyView;
   import map.outercity.helper.mapview.MapViewHelper;
   import map.space.SpaceManager;
   import map.space.event.SpaceEvent;
   import map.space.view.physics.SpaceArmyView;
   import mvc.module.armyII.BaseArmy;
   import stage3drender.avatar.SpaceAvatar;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.interfaces.IMediator;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   
   public class LockTargetMediator implements IMediator
   {
      
      protected var _selfInfo:BaseArmy;
      
      protected var _targetInfo:BaseArmy;
      
      protected var _selectFlag:MovieClip;
      
      protected var _target:Sprite;
      
      protected var _playerModel:PlayerModel;
      
      private var _timer:Timer;
      
      public function LockTargetMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _target = param1 as Sprite;
         _playerModel = PlayerManager.instance.currentPlayerModel;
         _selectFlag = ComponentFactory.Instance.creatCustomObject("asset.map.SelectTargetAsset2");
         _playerModel.addEventListener("TARGET_CHANGE",__lockTargetHandler);
         _selectFlag.gotoAndStop(1);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timeTickHandler);
         _timer.stop();
      }
      
      public function unregister(param1:Object) : void
      {
         unlockTarget();
         _playerModel.removeEventListener("TARGET_CHANGE",__lockTargetHandler);
         _playerModel = null;
         _target = null;
         if(_timer)
         {
            _timer.removeEventListener("timer",__timeTickHandler);
            _timer.stop();
            _timer = null;
         }
         dispose();
      }
      
      private function __lockTargetHandler(param1:SpaceEvent) : void
      {
         _targetInfo = param1.data as BaseArmy;
         if(_targetInfo)
         {
            lockTarget();
            if(PlayerManager.instance.currentPlayerModel.reinforce && PlayerManager.instance.currentPlayerModel.reinforce == _targetInfo)
            {
               moveArmyByPos(_targetInfo);
            }
         }
         else
         {
            unlockTarget();
         }
      }
      
      private function moveArmyByPos(param1:BaseArmy) : void
      {
         var _loc3_:Object = getArmyView(_targetInfo);
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            if(_loc3_ is SpaceArmyView)
            {
               _loc4_ = (_loc3_ as SpaceArmyView).x;
               _loc2_ = (_loc3_ as SpaceArmyView).y;
            }
            else if(_loc3_ is SpaceAvatar)
            {
               _loc4_ = (_loc3_ as SpaceAvatar).x;
               _loc2_ = (_loc3_ as SpaceAvatar).y;
            }
            SpaceManager.instance.controller.moveArmyByPos(_loc4_,_loc2_);
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            if(_loc3_ is CampaignArmyView)
            {
               _loc4_ = (_loc3_ as CampaignArmyView).x;
               _loc2_ = (_loc3_ as CampaignArmyView).y;
            }
            CampaignManager.instance.controller.moveArmyByPos(_loc4_,_loc2_);
         }
      }
      
      private function getArmyView(param1:BaseArmy) : Object
      {
         var _loc2_:Object = null;
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            _loc2_ = SpaceManager.instance.controller.getArmyView(_targetInfo);
         }
         else if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = CampaignManager.instance.controller.getArmyView(_targetInfo);
         }
         return _loc2_;
      }
      
      private function lockTarget() : void
      {
         if(_targetInfo.mountTemplateId > 0)
         {
            _selectFlag.gotoAndStop(1);
         }
         else
         {
            _selectFlag.gotoAndStop(2);
         }
         var _loc1_:Object = getArmyView(_targetInfo);
         if(_loc1_ is SpaceArmyView || _loc1_ is CampaignArmyView)
         {
            _loc1_.avatarView.addChildAt(_selectFlag,0);
         }
         else if(_loc1_ is SpaceAvatar)
         {
            _loc1_.showSelected();
         }
         if(_timer)
         {
            _timer.reset();
            _timer.start();
         }
      }
      
      private function unlockTarget() : void
      {
         if(!_targetInfo)
         {
            if(_selectFlag && _selectFlag.parent)
            {
               _selectFlag.parent.removeChild(_selectFlag);
            }
            return;
         }
         var _loc1_:Object = getArmyView(_targetInfo);
         if(_loc1_ is SpaceArmyView || _loc1_ is CampaignArmyView)
         {
            if(_selectFlag && _selectFlag.parent)
            {
               _selectFlag.parent.removeChild(_selectFlag);
            }
         }
         else if(_loc1_ is SpaceAvatar)
         {
            _loc1_.showUnSelected();
         }
         if(_timer)
         {
            _timer.stop();
         }
      }
      
      private function __timeTickHandler(param1:TimerEvent) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Boolean = false;
         var _loc2_:Rectangle = MapViewHelper.getCurrentMapRect(_target);
         if(_targetInfo && _loc2_)
         {
            _loc3_ = getArmyView(_targetInfo);
            if(_loc3_)
            {
               _loc4_ = !getPlaying(_loc3_,_loc2_);
               if(!_loc4_)
               {
                  _playerModel.selectTarget = null;
                  _timer.stop();
               }
            }
         }
      }
      
      private function getPlaying(param1:Object, param2:Rectangle) : Boolean
      {
         var _loc3_:Boolean = false;
         if(param1.x < param2.x - StageReferance.gameStageWidth / 2 - param1.width - 100)
         {
            _loc3_ = true;
         }
         else if(param1.x > param2.x + StageReferance.gameStageWidth / 2 + 100)
         {
            _loc3_ = true;
         }
         else if(param1.y < param2.y - StageReferance.stageHeight / 2 - param1.height - 100)
         {
            _loc3_ = true;
         }
         else if(param1.y > param2.y + StageReferance.stageHeight / 2 + 100)
         {
            _loc3_ = true;
         }
         return _loc3_;
      }
      
      private function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_selectFlag);
      }
   }
}

