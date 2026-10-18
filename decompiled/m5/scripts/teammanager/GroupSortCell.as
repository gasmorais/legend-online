package teammanager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   
   public class GroupSortCell extends PawnSortCell
   {
      
      public static const CHANGE_POS_EVENT:String = "CHANGE_POS_EVENT";
      
      public static const P_vocation:String = "vocation";
      
      public static const P_lock:String = "lock";
      
      protected var _vocationStyle:String;
      
      protected var _lockStyle:String;
      
      protected var _vocation:ScaleFrameImage;
      
      protected var _lock:Image;
      
      public var dropEnable:Boolean = true;
      
      public function GroupSortCell()
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
         var _loc2_:GroupSortCell = null;
         var _loc3_:ThaneInfo = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is GroupSortCell)
            {
               _loc2_ = param1.dropTarget as GroupSortCell;
               _loc3_ = _loc2_.hero;
               if(!(hero && _loc2_.dropEnable))
               {
                  __iTEM_DROP_BagNotic();
                  return;
               }
               _loc2_.hero = hero;
               hero = _loc3_;
               dispatchEvent(new Event("CHANGE_POS_EVENT"));
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

