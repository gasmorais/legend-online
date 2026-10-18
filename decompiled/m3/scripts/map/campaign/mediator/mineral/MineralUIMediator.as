package map.campaign.mediator.mineral
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.layer.CampaignMainBuidingLayer;
   import map.campaign.view.layer.NpcLayer;
   import map.campaign.view.physics.CampaignNpcPhysics;
   import map.campaign.view.physics.NpcAvatarView;
   import map.campaign.view.ui.mineral.MineralRightView;
   import map.campaign.view.ui.pvpmap.PvpPlayerRiverView;
   import map.internals.data.CampaignNode;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.view.component.MovieButton;
   
   public class MineralUIMediator implements IMediator, IEnterFrame
   {
      
      private var _rightUI:MineralRightView;
      
      private var _riverView:PvpPlayerRiverView;
      
      private var _selfArmy:CampaignArmy;
      
      private var _btnDic:Dictionary;
      
      private var _itemDic:Dictionary;
      
      private var _uiSprite:Sprite;
      
      private var _npcLayer:NpcLayer;
      
      public function MineralUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         _rightUI = new MineralRightView();
         _npcLayer = CampaignManager.instance.mapView.npcLayer;
         _uiSprite = new Sprite();
         (param1 as Sprite).addChild(_uiSprite);
         addAllBtn();
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         _selfArmy.addEventListener("IS_DIE",__dieHandler);
         __resizeHandler(null);
         __dieHandler(null);
         LayerManager.Instance.addToLayer(_rightUI,4,false);
         NotificationManager.instance.addEventListener("NPC_LOAD_COMPLETE",layout);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__dieHandler);
         }
         if(_riverView)
         {
            _riverView.dispose();
         }
         _riverView = null;
         if(_rightUI)
         {
            _rightUI.dispose();
         }
         _rightUI = null;
         _uiSprite = null;
         _npcLayer = null;
         NotificationManager.instance.removeEventListener("NPC_LOAD_COMPLETE",layout);
         clearAllBtn();
      }
      
      private function layout(param1:NotificationEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(!_btnDic[_loc2_])
         {
            return;
         }
         var _loc3_:DisplayObject = _btnDic[_loc2_] as DisplayObject;
         if(_loc2_ is CampaignNpcPhysics)
         {
            _loc3_.y = _loc2_.y - _loc3_.height - 101;
         }
         else if(_loc2_ is NpcAvatarView)
         {
            _loc3_.y = _loc2_.y - _loc3_.height - 91;
         }
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNpcPhysics = null;
         var _loc4_:Object = param1.currentTarget;
         var _loc3_:NpcAvatarView = _itemDic[_loc4_] as NpcAvatarView;
         if(_loc3_)
         {
            CampaignManager.instance.mapModel.selectNode = _loc3_.nodeInfo as CampaignNode;
            _loc3_.attackFun();
         }
         else
         {
            _loc2_ = _itemDic[_loc4_] as CampaignNpcPhysics;
            CampaignManager.instance.mapModel.selectNode = _loc2_.info as CampaignNode;
            _loc2_.mouseClickHandler(param1);
         }
         param1.stopPropagation();
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNpcPhysics = null;
         var _loc4_:Object = param1.currentTarget;
         var _loc3_:NpcAvatarView = _itemDic[_loc4_] as NpcAvatarView;
         if(_loc3_)
         {
            _loc3_.mouseMoveHandler(param1);
         }
         else
         {
            _loc2_ = _itemDic[_loc4_] as CampaignNpcPhysics;
            _loc2_.mouseMoveHandler(param1);
         }
         param1.stopPropagation();
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:CampaignNpcPhysics = null;
         var _loc4_:Object = param1.currentTarget;
         var _loc3_:NpcAvatarView = _itemDic[_loc4_] as NpcAvatarView;
         if(_loc3_)
         {
            _loc3_.mouseOutHandler(param1);
         }
         else
         {
            _loc2_ = _itemDic[_loc4_] as CampaignNpcPhysics;
            _loc2_.mouseOutHandler(param1);
         }
         param1.stopPropagation();
      }
      
      public function enterFrame() : void
      {
         var _loc5_:CampaignNpcPhysics = null;
         var _loc2_:CampaignNode = null;
         var _loc3_:MovieButton = null;
         if(!_btnDic)
         {
            _btnDic = new Dictionary(true);
         }
         var _loc4_:CampaignMainBuidingLayer = CampaignManager.instance.mapView.mainBuidingLayer;
         for each(var _loc1_:DisplayObject in _loc4_.items)
         {
            if(_loc1_ is CampaignNpcPhysics)
            {
               _loc5_ = _loc1_ as CampaignNpcPhysics;
               _loc2_ = _loc5_.info as CampaignNode;
               if(!(!_loc2_ || _loc2_.sonType != 2351))
               {
                  _loc3_ = _btnDic[_loc5_];
                  if(!_loc3_)
                  {
                     _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.mineral.NPCBtn" + _loc2_.sonType);
                     _loc3_.addEventListener("click",__onClickHandler);
                     _loc3_.addEventListener("mouseOver",__onOverHandler);
                     _loc3_.addEventListener("mouseOut",__onOutHandler);
                     _btnDic[_loc5_] = _loc3_;
                     _itemDic[_loc3_] = _loc5_;
                  }
                  if(!_loc5_.parent)
                  {
                     if(_loc3_.parent)
                     {
                        _loc3_.parent.removeChild(_loc3_);
                     }
                  }
                  else if(!_loc3_.parent)
                  {
                     _loc3_.x = _loc5_.x - _loc3_.width / 2 + 27;
                     _loc3_.y = _loc5_.y - _loc3_.height - 101;
                     _uiSprite.addChild(_loc3_);
                  }
               }
            }
         }
      }
      
      private function addAllBtn() : void
      {
         var _loc2_:CampaignNode = null;
         var _loc3_:MovieButton = null;
         _btnDic = new Dictionary(true);
         _itemDic = new Dictionary(true);
         for each(var _loc1_:NpcAvatarView in _npcLayer.avatarList)
         {
            if(_loc1_.nodeInfo.info.types == 61)
            {
               _loc2_ = _loc1_.nodeInfo as CampaignNode;
               _loc3_ = _btnDic[_loc1_];
               if(!_loc3_)
               {
                  _loc3_ = ComponentFactory.Instance.creatComponentByStylename("map.mineral.NPCBtn" + _loc2_.nodeId);
                  _loc3_.addEventListener("click",__onClickHandler);
                  _loc3_.addEventListener("mouseOver",__onOverHandler);
                  _loc3_.addEventListener("mouseOut",__onOutHandler);
                  _btnDic[_loc1_] = _loc3_;
               }
               _itemDic[_loc3_] = _loc1_;
               if(!_loc3_.parent)
               {
                  _loc3_.x = _loc1_.x - _loc3_.width / 2 + 27;
                  _loc3_.y = _loc1_.y - _loc3_.height + _loc1_.showNamePosY + 39;
                  _uiSprite.addChild(_loc3_);
               }
            }
         }
      }
      
      private function __dieHandler(param1:CampaignMapEvent) : void
      {
         if(CampaignArmyState.checkDied(_selfArmy.isDie))
         {
            if(!_riverView)
            {
               _riverView = new PvpPlayerRiverView();
            }
            _riverView.riverTime = _selfArmy.riverTime / 1000 - 2;
            LayerManager.Instance.addToLayer(_riverView,4,false);
            _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
            _riverView.y = StageReferance.stageHeight - _riverView.height - 55;
         }
         else
         {
            if(_riverView)
            {
               _riverView.dispose();
            }
            _riverView = null;
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         _rightUI.x = (StageReferance.stageWidth - _rightUI.width >> 0) + 240;
         _rightUI.y = 185;
         if(_riverView)
         {
            _riverView.x = StageReferance.stageWidth - _riverView.width >> 1;
            _riverView.y = StageReferance.stageHeight - _riverView.height - 55;
         }
      }
      
      private function clearAllBtn() : void
      {
         for(var _loc1_:String in _btnDic)
         {
            if(_btnDic[_loc1_] is MovieButton)
            {
               _btnDic[_loc1_].removeEventListener("click",__onClickHandler);
               _btnDic[_loc1_].removeEventListener("mouseOver",__onOverHandler);
               _btnDic[_loc1_].removeEventListener("mouseOut",__onOutHandler);
               _btnDic[_loc1_].dispose();
            }
            _btnDic[_loc1_] = null;
            delete _btnDic[_loc1_];
         }
         for(var _loc2_:String in _itemDic)
         {
            _itemDic[_loc2_] = null;
            delete _itemDic[_loc2_];
         }
         _itemDic = null;
         _btnDic = null;
      }
   }
}

