package teammanager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.tips.MessageTipManager;
   
   public class TeamSortCell extends PawnSortCell
   {
      
      public static const P_vocation:String = "vocation";
      
      public static const P_lock:String = "lock";
      
      protected var _vocationStyle:String;
      
      protected var _lockStyle:String;
      
      protected var _vocation:ScaleFrameImage;
      
      protected var _lock:Image;
      
      public var dropEnable:Boolean = true;
      
      public function TeamSortCell()
      {
         super();
      }
      
      public function set vocationStyle(param1:String) : void
      {
         _vocationStyle = param1;
         onPropertiesChanged("vocation");
      }
      
      public function set lockStyle(param1:String) : void
      {
         _lockStyle = param1;
         onPropertiesChanged("lock");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["vocation"])
         {
            _vocation = ComponentFactory.Instance.creatComponentByStylename(_vocationStyle);
            _vocation.visible = false;
         }
         if(_changedPropeties["lock"])
         {
            _lock = ComponentFactory.Instance.creatComponentByStylename(_lockStyle);
            _lock.visible = false;
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_vocation)
         {
            addChild(_vocation);
         }
         if(_lock)
         {
            addChild(_lock);
         }
      }
      
      override protected function onStartDrag(param1:GameDrag) : void
      {
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      override protected function onDragStop(param1:GameDrag) : void
      {
         var _loc10_:TeamSortCell = null;
         var _loc2_:ThaneInfo = null;
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:CampaignArmy = null;
         var _loc8_:CampaignArmy = null;
         var _loc4_:String = null;
         var _loc5_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is TeamSortCell)
            {
               _loc10_ = param1.dropTarget as TeamSortCell;
               _loc2_ = _loc10_.hero;
               _loc7_ = _loc10_.index;
               _loc3_ = _loc10_.pos;
               if(!(hero && _loc10_.dropEnable))
               {
                  __iTEM_DROP_BagNotic();
                  return;
               }
               _loc6_ = RoomManager.instance.roomInfo.getPlayerByUserId(hero.userId,"");
               if(_loc2_)
               {
                  _loc8_ = RoomManager.instance.roomInfo.getPlayerByUserId(_loc2_.userId);
               }
               if(_loc6_ && _loc6_.state == 2 || _loc8_ && _loc8_.state == 2)
               {
                  _loc4_ = LanguageMgr.GetTranslation("teammanager.pve.command01");
                  MessageTipManager.instance().show(_loc4_);
                  __iTEM_DROP_BagNotic();
                  return;
               }
               _loc10_.hero = hero;
               hero = _loc2_;
               if(_loc3_ == 0)
               {
                  _loc5_ = pos % 3 == 0 ? 0 : 2;
                  _loc3_ = _loc7_ * 3 - _loc5_;
                  _loc10_.pos = pos;
                  pos = _loc3_;
               }
               else
               {
                  _loc9_ = pos % 3 == 0 ? 0 : 2;
                  _loc11_ = _loc3_ % 3 == 0 ? 0 : 2;
                  _loc10_.pos = index * 3 - _loc11_;
                  pos = _loc7_ * 3 - _loc9_;
               }
               dispatchEvent(new Event("EDIT_TEAM_FIGHT_POS"));
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         else
         {
            param1.stopImmediatePropagation();
         }
         SoundManager.instance.play("003",true);
         __iTEM_DROP_BagNotic();
      }
      
      override protected function __iTEM_DROP_BagNotic() : void
      {
         super.__iTEM_DROP_BagNotic();
         NotificationManager.instance.sendNotification("END_DRAG",this);
      }
      
      override public function refreshView() : void
      {
         if(_hero)
         {
            buttonMode = true;
            if(_icon)
            {
               _icon.tipData = _hero;
               _icon.icon = IconFactory.getHeadIcon(_hero.headId,"head");
            }
         }
         else
         {
            buttonMode = false;
            if(_icon)
            {
               _icon.icon = null;
               _icon.tipData = null;
            }
         }
         if(_icon.icon == null)
         {
            if(_backTxt)
            {
               _backTxt.visible = true;
            }
         }
         else if(_backTxt)
         {
            _backTxt.visible = false;
         }
         if(_vocation)
         {
            _vocation.visible = false;
         }
         if(_lock)
         {
            _lock.visible = false;
         }
         if(!_hero)
         {
            return;
         }
         setVocation();
      }
      
      protected function setVocation() : void
      {
         if(!_vocation)
         {
            return;
         }
         _vocation.visible = true;
         _vocation.setFrame(_hero.templateInfo.Job);
      }
      
      public function setCellStatus(param1:Boolean = false) : void
      {
         _lock.visible = false;
         dropEnable = !param1;
         if(param1)
         {
            if(!_hero)
            {
               if(_lock)
               {
                  _lock.visible = true;
               }
            }
         }
      }
      
      public function get vocation() : DisplayObject
      {
         return _vocation;
      }
      
      public function get lock() : DisplayObject
      {
         return _lock;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _vocation = null;
         _lock = null;
      }
   }
}

