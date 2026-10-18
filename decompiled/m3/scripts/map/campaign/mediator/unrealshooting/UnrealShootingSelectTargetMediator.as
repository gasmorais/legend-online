package map.campaign.mediator.unrealshooting
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.helper.hero.CampaignArmyViewHelper;
   import map.campaign.view.physics.CampaignArmyView;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.physics.physicsview.CampaignNpcView;
   import map.internals.data.CampaignNode;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.PlayerManager;
   
   public class UnrealShootingSelectTargetMediator implements IMediator, IEnterFrame
   {
      
      private var _controller:CampaignMapController;
      
      private var _playerModel:PlayerModel;
      
      private var _mapModel:CampaignMapModel;
      
      private var _selectedEffect:MovieClip;
      
      private var _selectedObject:Sprite;
      
      private var _selectData:EventDispatcher;
      
      private var _selfArmy:CampaignArmy;
      
      public function UnrealShootingSelectTargetMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _controller = CampaignManager.instance.controller;
         _playerModel = PlayerManager.instance.currentPlayerModel;
         _mapModel = CampaignManager.instance.mapModel;
         _selfArmy = _mapModel.selfMemberData;
         _selectedEffect = ComponentFactory.Instance.creat("asset.gvgcross.SelectEffect");
         _selectedEffect.gotoAndStop(1);
         _selectedEffect.mouseEnabled = _selectedEffect.mouseChildren = false;
         addEvent();
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         removeDieListener();
         ObjectUtils.disposeObject(_selectedEffect);
         _selectedEffect = null;
         _controller = null;
         _playerModel = null;
         _mapModel = null;
         _selfArmy = null;
      }
      
      private function addEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         if(_controller)
         {
            _controller.addEventListener("curSelectedObject",__targetChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_controller)
         {
            _controller.removeEventListener("curSelectedObject",__targetChangeHandler);
         }
      }
      
      private function __targetChangeHandler(param1:Event) : void
      {
         var _loc3_:* = null;
         var _loc2_:CampaignNode = null;
         var _loc4_:Sprite = _controller.curSelectedObject;
         if(_loc4_)
         {
            removeDieListener();
            if(_loc4_ is CampaignArmyView)
            {
               _selectData = (_loc4_ as CampaignArmyView).data;
               _loc4_.addEventListener("dispose",__disopseHandler);
               _loc4_.addChildAt(_selectedEffect,0);
               _selectedEffect.gotoAndStop(1);
            }
            else if(_loc4_ is CampaignNpcView)
            {
               _loc2_ = (_loc4_ as CampaignNpcView).info as CampaignNode;
               _loc4_.addEventListener("dispose",__disopseHandler);
               _selectData = _loc2_;
               (_loc4_ as CampaignNpcView).movie.addChildAt(_selectedEffect,0);
               if(CampaignArmyViewHelper.checkUnrealShootingTower(_loc2_))
               {
                  _selectedEffect.gotoAndStop(3);
               }
               else
               {
                  _selectedEffect.gotoAndStop(1);
               }
            }
            else if(_loc4_ is NpcAvatarView)
            {
               _loc2_ = (_loc4_ as NpcAvatarView).nodeInfo as CampaignNode;
               _loc4_.addEventListener("dispose",__disopseHandler);
               _selectData = _loc2_;
               (_loc4_ as NpcAvatarView).addChildAt(_selectedEffect,0);
               _selectedEffect.gotoAndStop(1);
            }
            addDieListener();
         }
         else if(_selectedEffect.parent)
         {
            _selectedEffect.parent.removeChild(_selectedEffect);
            _selectedEffect.stop();
         }
      }
      
      private function __disopseHandler(param1:Event) : void
      {
         (param1.currentTarget as EventDispatcher).removeEventListener("dispose",__disopseHandler);
         if(_controller)
         {
            _controller.curSelectedObject = null;
         }
      }
      
      private function addDieListener() : void
      {
         if(_selectData)
         {
            if(_selectData is CampaignNode)
            {
               (_selectData as CampaignNode).info.addEventListener("UP_STATE",__dieHandler);
            }
            _selectData.addEventListener("IS_DIE",__dieHandler);
         }
      }
      
      private function removeDieListener() : void
      {
         if(_selectData)
         {
            if(_selectData is CampaignNode)
            {
               (_selectData as CampaignNode).info.removeEventListener("UP_STATE",__dieHandler);
            }
            _selectData.removeEventListener("IS_DIE",__dieHandler);
         }
      }
      
      private function __dieHandler(param1:Event) : void
      {
         var _loc2_:CampaignNode = null;
         var _loc3_:CampaignArmy = null;
         if(param1.currentTarget is CampaignNode)
         {
            _loc2_ = param1.currentTarget as CampaignNode;
            if(_loc2_.info.state == 8)
            {
               removeDieListener();
               _controller.curSelectedObject = null;
            }
         }
         else if(param1.currentTarget is CampaignArmy)
         {
            _loc3_ = param1.currentTarget as CampaignArmy;
            if(CampaignArmyState.checkDied(_loc3_.isDie))
            {
               removeDieListener();
               _controller.curSelectedObject = null;
            }
         }
      }
      
      public function enterFrame() : void
      {
         if(!_selectedEffect.parent)
         {
            return;
         }
         if(!_controller.curSelectedObject)
         {
            return;
         }
         if(!_mapModel.selfMemberData)
         {
            return;
         }
         var _loc1_:Number = _controller.curSelectedObject.x - _mapModel.selfMemberData.curPosX * 20;
         var _loc2_:Number = _controller.curSelectedObject.y - _mapModel.selfMemberData.curPosY * 20;
         if(Math.sqrt(_loc1_ * _loc1_ + _loc2_ * _loc2_) > 950)
         {
            _controller.curSelectedObject = null;
         }
      }
   }
}

