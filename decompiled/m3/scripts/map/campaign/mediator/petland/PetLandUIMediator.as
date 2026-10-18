package map.campaign.mediator.petland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import events.TaskEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import map.campaign.CampaignManager;
   import map.campaign.data.PetBossModel;
   import map.campaign.view.layer.NpcLayer;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.data.CampaignNode;
   import ui.tasktracebar.TaskTraceBar;
   import ui.toptoolbar.TopToolsBar;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.manager.TaskManage;
   import yishi.utils.MsgMan;
   import yishi.utils.WorldBossHelper;
   
   public class PetLandUIMediator implements IMediator
   {
      
      private var _btnDic:Dictionary;
      
      private var _itemDic:Dictionary;
      
      private var _uiSprite:Sprite;
      
      private var _npcLayer:NpcLayer;
      
      private var _petBossModel:PetBossModel;
      
      public function PetLandUIMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _npcLayer = CampaignManager.instance.mapView.npcLayer;
         _uiSprite = new Sprite();
         (param1 as Sprite).addChild(_uiSprite);
         _petBossModel = CampaignManager.instance.petBossModel;
         addAllBtn();
         addEvent();
         __petBossSwitchHandler(null,null);
      }
      
      private function addEvent() : void
      {
         if(TaskManage.instance.cate)
         {
            TaskManage.instance.cate.addEventListener("task_added",__refreshTaskHandler);
            TaskManage.instance.cate.addEventListener("task_remove",__refreshTaskHandler);
         }
         NotificationManager.instance.addEventListener("NPC_LOAD_COMPLETE",layout);
         MsgMan.addObserver("CampaignEvent.PET_BOSS_SWITCH",this,__petBossSwitchHandler);
      }
      
      private function removeEvent() : void
      {
         if(TaskManage.instance.cate)
         {
            TaskManage.instance.cate.removeEventListener("task_added",__refreshTaskHandler);
            TaskManage.instance.cate.removeEventListener("task_remove",__refreshTaskHandler);
         }
         NotificationManager.instance.removeEventListener("NPC_LOAD_COMPLETE",layout);
         MsgMan.removeObserver("CampaignEvent.PET_BOSS_SWITCH",this,__petBossSwitchHandler);
      }
      
      private function __petBossSwitchHandler(param1:String, param2:Object) : void
      {
         var _loc4_:CampaignNode = null;
         if(WorldBossHelper.checkInPetBossFloor(CampaignManager.instance.mapId))
         {
            addAllBtn();
         }
         else
         {
            for each(var _loc3_:NpcAvatarView in _npcLayer.avatarList)
            {
               _loc4_ = _loc3_.nodeInfo as CampaignNode;
               if(_loc4_.param4 == "3" && _btnDic[_loc3_])
               {
                  _btnDic[_loc3_].removeEventListener("click",__onClickHandler);
                  _btnDic[_loc3_].removeEventListener("mouseOver",__onOverHandler);
                  _btnDic[_loc3_].removeEventListener("mouseOut",__onOutHandler);
                  ObjectUtils.disposeObject(_btnDic[_loc3_]);
                  delete _itemDic[_btnDic[_loc3_]];
                  delete _btnDic[_loc3_];
                  break;
               }
            }
         }
         TopToolsBar.instance.show();
         if(TaskTraceBar.instance.isLoaded)
         {
            TaskTraceBar.instance.show();
         }
      }
      
      private function __refreshTaskHandler(param1:TaskEvent) : void
      {
         var _loc4_:CampaignNode = null;
         var _loc5_:BaseButton = null;
         var _loc2_:Boolean = false;
         for each(var _loc3_:NpcAvatarView in _npcLayer.avatarList)
         {
            if(_loc3_ && _loc3_.nodeInfo && _loc3_.nodeInfo.info)
            {
               if(_loc3_.nodeInfo.info.types == 61)
               {
                  _loc4_ = _loc3_.nodeInfo as CampaignNode;
                  if(_loc4_ && _loc4_.param4 == "1")
                  {
                     _loc5_ = _btnDic[_loc3_] as BaseButton;
                     if(_loc5_)
                     {
                        _loc2_ = Boolean(TaskManage.instance.cate.hasTaskAndNotCompleted(TaskManage.PET_SYSTEM_OPEN_TASK02));
                        _loc5_.visible = _loc2_;
                     }
                  }
               }
            }
         }
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         clearAllBtn();
         ObjectUtils.disposeObject(_uiSprite);
         _npcLayer = null;
         _uiSprite = null;
         _petBossModel = null;
      }
      
      private function layout(param1:NotificationEvent) : void
      {
         var _loc2_:Object = param1.data;
         if(!_btnDic[_loc2_])
         {
            return;
         }
         var _loc3_:DisplayObject = _btnDic[_loc2_] as DisplayObject;
         if(_loc3_)
         {
            _loc3_.y = _loc2_.y - _loc3_.height + _loc2_.showNamePosY;
         }
      }
      
      private function addAllBtn() : void
      {
         var _loc3_:CampaignNode = null;
         var _loc4_:SimpleBitmapButton = null;
         var _loc1_:Boolean = false;
         if(!_btnDic)
         {
            _btnDic = new Dictionary(true);
         }
         if(!_itemDic)
         {
            _itemDic = new Dictionary(true);
         }
         for each(var _loc2_:NpcAvatarView in _npcLayer.avatarList)
         {
            _loc3_ = _loc2_.nodeInfo as CampaignNode;
            if(_loc3_.info.types == 61)
            {
               if(!(_loc3_.info.state == 9 || _loc3_.info.state == 8))
               {
                  _loc4_ = _btnDic[_loc2_];
                  if(!_loc4_)
                  {
                     if(_loc3_.param4 == "3")
                     {
                        _loc4_ = ComponentFactory.Instance.creatComponentByStylename("map.space.NPCBtnAttack");
                     }
                     else
                     {
                        _loc4_ = ComponentFactory.Instance.creatComponentByStylename("map.space.NPCBtn" + _loc3_.sonType);
                     }
                     _loc4_.addEventListener("click",__onClickHandler);
                     _loc4_.addEventListener("mouseOver",__onOverHandler);
                     _loc4_.addEventListener("mouseOut",__onOutHandler);
                     _btnDic[_loc2_] = _loc4_;
                  }
                  if(_loc4_)
                  {
                     _itemDic[_loc4_] = _loc2_;
                     if(!_loc4_.parent)
                     {
                        _loc4_.x = _loc2_.x - _loc4_.width / 2;
                        _loc4_.y = _loc2_.y - _loc4_.height + _loc2_.showNamePosY;
                        _uiSprite.addChild(_loc4_);
                     }
                     if(_loc3_.param4 == "1")
                     {
                        _loc1_ = Boolean(TaskManage.instance.cate.hasTaskAndNotCompleted(TaskManage.PET_SYSTEM_OPEN_TASK02));
                        _loc4_.visible = _loc1_;
                     }
                  }
               }
            }
         }
      }
      
      private function clearAllBtn() : void
      {
         for each(var _loc1_:SimpleBitmapButton in _btnDic)
         {
            _loc1_.removeEventListener("click",__onClickHandler);
            _loc1_.removeEventListener("mouseOver",__onOverHandler);
            _loc1_.removeEventListener("mouseOut",__onOutHandler);
            ObjectUtils.disposeObject(_loc1_);
         }
         for(var _loc2_:String in _itemDic)
         {
            _itemDic[_loc2_] = null;
            delete _itemDic[_loc2_];
         }
         _itemDic = null;
         _btnDic = null;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc2_:NpcAvatarView = _itemDic[_loc3_] as NpcAvatarView;
         CampaignManager.instance.mapModel.selectNode = _loc2_.nodeInfo as CampaignNode;
         _loc2_.attackFun();
         param1.stopPropagation();
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc2_:NpcAvatarView = _itemDic[_loc3_] as NpcAvatarView;
         _loc2_.mouseMoveHandler(param1);
         param1.stopPropagation();
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         var _loc3_:SimpleBitmapButton = param1.currentTarget as SimpleBitmapButton;
         var _loc2_:NpcAvatarView = _itemDic[_loc3_] as NpcAvatarView;
         _loc2_.mouseOutHandler(param1);
         param1.stopPropagation();
      }
   }
}

