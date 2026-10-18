package armyII.viewII.skill
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.SkillEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.consant.SkillPriorityType;
   import yishi.events.NotificationEvent;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class FastSkillItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _indexBack:Bitmap;
      
      private var _indexTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _data:SkillInfo;
      
      private var _icon:BaseIconView;
      
      private var _index:int;
      
      private var _overEffect:DisplayObject;
      
      private var _superSkill:Bitmap;
      
      public var isUsed:Boolean;
      
      public function FastSkillItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.army.FastKeyItem");
         _icon = ComponentFactory.Instance.creatCustomObject("army.skill.FastKeyItemIcon");
         _overEffect = ComponentFactory.Instance.creatBitmap("asset.army.SkillItemSelectedBack3");
         _indexBack = ComponentFactory.Instance.creatBitmap("asset.army.FastKeyItemIndex");
         _indexTxt = ComponentFactory.Instance.creatComponentByStylename("army.FastKeyItemIndexTxt");
         _txt = ComponentFactory.Instance.creatComponentByStylename("army.FastKeyItemTxt");
         _txt.text = LanguageMgr.GetTranslation("armyII.viewII.skill.FastSkillItem.txt");
         _superSkill = ComponentFactory.Instance.creatBitmap("asset.army.SuperSkill");
         addChild(_back);
         addChild(_txt);
         addChild(_icon);
         addChild(_overEffect);
         _overEffect.x = -9;
         _overEffect.y = -8.5;
         _overEffect.visible = false;
         addChild(_indexBack);
         addChild(_indexTxt);
         addChild(_superSkill);
         _superSkill.x = 1;
         _superSkill.y = 0;
         _superSkill.visible = false;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__clickHandler);
         NotificationManager.instance.addEventListener("SKILL_RESET",__resetHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _overEffect.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(_data)
         {
            _overEffect.visible = false;
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("mouseDown",__clickHandler);
         NotificationManager.instance.removeEventListener("SKILL_RESET",__resetHandler);
         if(_data)
         {
            _data.removeEventListener("SKILL_UPGRADE",__upgradeHandler);
         }
      }
      
      private function __resetHandler(param1:NotificationEvent) : void
      {
         data = null;
         isUsed = false;
         refreshView();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [FastSkillItem,Stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         return new Bitmap(_loc1_);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:FastSkillItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is FastSkillItem)
            {
               _loc2_ = param1.dropTarget as FastSkillItem;
               swap(this,_loc2_);
               param1.stopImmediatePropagation();
               NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
            }
            else
            {
               data = null;
               refreshView();
               NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
               param1.stopImmediatePropagation();
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function swap(param1:FastSkillItem, param2:FastSkillItem) : void
      {
         var _loc3_:SkillInfo = param2.data;
         param2.data = param1.data;
         param2.refreshView();
         param1.data = _loc3_;
         param1.refreshView();
      }
      
      public function refreshView() : void
      {
         if(!_icon)
         {
            return;
         }
         if(_data)
         {
            _icon.tipData = _data.templateInfo;
            _icon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icons);
         }
         else
         {
            _icon.tipData = null;
            _icon.icon = null;
         }
      }
      
      private function __upgradeHandler(param1:SkillEvent) : void
      {
         if(_data)
         {
            _icon.tipData = _data.templateInfo;
         }
      }
      
      public function set index(param1:int) : void
      {
         _indexTxt.text = param1.toString();
         _index = param1 - 1;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set data(param1:SkillInfo) : void
      {
         if(_data)
         {
            _data.removeEventListener("SKILL_UPGRADE",__upgradeHandler);
         }
         _data = param1;
         if(_data)
         {
            _data.addEventListener("SKILL_UPGRADE",__upgradeHandler);
            _superSkill.visible = SkillPriorityType.isSuperSkill(_data.templateInfo.Priority);
         }
         else
         {
            isUsed = false;
            _superSkill.visible = false;
         }
      }
      
      public function get data() : SkillInfo
      {
         return _data;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
         _data = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_indexBack);
         _indexBack = null;
         ObjectUtils.disposeObject(_indexTxt);
         _indexTxt = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_overEffect);
         _overEffect = null;
         ObjectUtils.disposeObject(_superSkill);
         _superSkill = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

