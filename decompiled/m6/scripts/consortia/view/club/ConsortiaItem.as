package consortia.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import yishi.utils.CheckUIModuleUtil;
   
   public class ConsortiaItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _selected:Boolean;
      
      private var _colorBg:ScaleFrameImage;
      
      private var _name:FilterFrameText;
      
      private var _chairmanName:FilterFrameText;
      
      private var _grade:FilterFrameText;
      
      private var _member:FilterFrameText;
      
      private var _checkBtn:SelectedButton;
      
      private var _lineImg:MutipleImage;
      
      private var _spaceTxt:FilterFrameText;
      
      private var _checked:Boolean;
      
      private var _hitSprite:Sprite;
      
      private var _data:ConsortiaInfo;
      
      public function ConsortiaItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _colorBg = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaItemColorBg");
         _name = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaItemNameTextStyle");
         _chairmanName = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaItemChairmanTextStyle");
         _grade = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaItemGradeTextStyle");
         _lineImg = ComponentFactory.Instance.creatComponentByStylename("consortia.itemLine_2");
         _member = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaItemMemberTextStyle");
         _checkBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaAddCheckBtn");
         _hitSprite = new Sprite();
         hitArea = _hitSprite;
         _spaceTxt = new FilterFrameText();
         buttonMode = true;
         _colorBg.setFrame(1);
         addChild(_colorBg);
         addChild(_name);
         addChild(_chairmanName);
         addChild(_grade);
         addChild(_lineImg);
         addChild(_spaceTxt);
         addChild(_member);
         addChild(_checkBtn);
         addChild(_hitSprite);
         _spaceTxt.y = 4;
      }
      
      private function setHitArea() : void
      {
         _hitSprite.graphics.clear();
         _hitSprite.graphics.beginFill(0,0);
         _hitSprite.graphics.drawRect(40,0,409,29);
         _hitSprite.y = 10;
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onClickHandler);
         _checkBtn.addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onClickHandler);
         _checkBtn.removeEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(_checkBtn.selected)
         {
            _checkBtn.selected = false;
            _checked = false;
         }
         else
         {
            _checkBtn.selected = true;
            _checked = true;
         }
      }
      
      private function __onInfoBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_data)
         {
            return;
         }
         CheckUIModuleUtil.instance.tryCall("lookconsortiainfo",callback);
      }
      
      private function callback() : void
      {
         var _loc1_:ConsortiaInfoFrame = ComponentFactory.Instance.creatComponentByStylename("lookconsortiainfoe.ConsortiaInfoFrame");
         _loc1_.data = _data;
         _loc1_.show();
      }
      
      public function get data() : ConsortiaInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaInfo) : void
      {
         _data = param1;
         if(param1 == null)
         {
            _checkBtn.visible = false;
         }
         else
         {
            _checkBtn.visible = true;
         }
         refreshView();
         setHitArea();
      }
      
      private function refreshView() : void
      {
         _colorBg.setFrame(1);
         if(_data)
         {
            setValue();
         }
         else
         {
            clear();
         }
      }
      
      private function setValue() : void
      {
         buttonMode = true;
         _name.text = _data.consortiaName;
         _chairmanName.text = _data.chairmanName;
         _grade.text = LanguageMgr.GetTranslation("public.level2",_data.levels);
         _member.text = _data.currentCount + " / " + (_data.levels * 20 + 10);
      }
      
      private function clear() : void
      {
         _name.text = "";
         _chairmanName.text = "";
         _grade.text = "";
         _member.text = "";
         buttonMode = false;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
         _spaceTxt = null;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function get checked() : Boolean
      {
         return _checkBtn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected && _data)
         {
            _colorBg.setFrame(2);
         }
         else
         {
            _colorBg.setFrame(1);
         }
      }
      
      public function setCheckState(param1:Boolean) : void
      {
         _checkBtn.selected = param1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}

