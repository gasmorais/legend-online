package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.consant.SkillPriorityType;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerFastSkillItem extends Component
   {
      
      private var _indexBack:Image;
      
      private var _indexTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _icon:BaseIconView;
      
      private var _index:int;
      
      private var _overEffect:Image;
      
      private var _superSkill:Bitmap;
      
      private var _data:SkillInfo;
      
      public var isUsed:Boolean;
      
      public function DragonTalkerFastSkillItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("DragonTalkerFastSkillItem.FastKeyItemIcon");
         _overEffect = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFastSkillItem.SkillItemSelectedBack");
         _indexBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFastSkillItem.FastKeyItemIndex");
         _indexTxt = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFastSkillItem.FastKeyItemIndexTxt");
         _txt = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerFastSkillItem.FastKeyItemTxt");
         _superSkill = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerFastSkillItem.SuperSkill");
         addChild(_txt);
         addChild(_icon);
         addChild(_overEffect);
         _overEffect.visible = false;
         addChild(_indexBack);
         addChild(_indexTxt);
         addChild(_superSkill);
         _superSkill.visible = false;
         _overEffect.mouseChildren = _overEffect.mouseEnabled = false;
         _indexBack.mouseChildren = _overEffect.mouseEnabled = false;
         _txt.text = LanguageMgr.GetTranslation("armyII.viewII.skill.FastSkillItem.txt");
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("mouseDown",__clickHandler);
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
         _loc2_.dropChecks = [DragonTalkerFastSkillItem,stage];
      }
      
      private function getDragIconObj() : DisplayObject
      {
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         return new Bitmap(_loc1_);
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:DragonTalkerFastSkillItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is DragonTalkerFastSkillItem)
            {
               _loc2_ = param1.dropTarget as DragonTalkerFastSkillItem;
               swap(this,_loc2_);
               param1.stopImmediatePropagation();
               MsgMan.notifyObserver("SET_FAST_KEY");
            }
         }
         param1.stopImmediatePropagation();
      }
      
      private function swap(param1:DragonTalkerFastSkillItem, param2:DragonTalkerFastSkillItem) : void
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
         _data = param1;
         if(_data)
         {
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
         _data = null;
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
         super.dispose();
      }
   }
}

