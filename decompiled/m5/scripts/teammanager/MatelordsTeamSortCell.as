package teammanager
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import mvc.module.children.ChildData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   
   public class MatelordsTeamSortCell extends PawnSortCell
   {
      
      public static const CHANGE_POS_EVENT:String = "CHANGE_POS_EVENT";
      
      public static const P_vocation:String = "vocation";
      
      public static const P_lock:String = "lock";
      
      protected var _vocationStyle:String;
      
      protected var _lockStyle:String;
      
      protected var _vocation:ScaleFrameImage;
      
      protected var _lock:Image;
      
      public var dropEnable:Boolean = true;
      
      public function MatelordsTeamSortCell()
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
         var _loc2_:MatelordsTeamSortCell = null;
         var _loc4_:ThaneInfo = null;
         var _loc5_:ChildData = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is MatelordsTeamSortCell)
            {
               _loc2_ = param1.dropTarget as MatelordsTeamSortCell;
               _loc4_ = _loc2_.hero;
               _loc5_ = _loc2_.child;
               _loc3_ = int(param1.target.pos);
               _loc6_ = _loc2_.pos;
               if(!_loc2_.dropEnable)
               {
                  __iTEM_DROP_BagNotic();
                  return;
               }
               dispatchEvent(new NotificationEvent("CHANGE_MATELORDS_POS_EVENT",{
                  "old":_loc3_,
                  "now":_loc6_
               }));
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
         var _loc1_:ChildTempInfo = null;
         if(_hero)
         {
            buttonMode = true;
            if(_icon)
            {
               _icon.tipData = _hero;
               _icon.icon = IconFactory.getHeadIcon(_hero.headId,"head");
            }
         }
         else if(_child)
         {
            buttonMode = true;
            if(_icon)
            {
               _icon.tipData = _child;
               _loc1_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_child.job,_child.growthGrade);
               if(_loc1_)
               {
                  _icon.icon = PathManager.info.ResourcePath + "icon" + _loc1_.Icon;
               }
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

