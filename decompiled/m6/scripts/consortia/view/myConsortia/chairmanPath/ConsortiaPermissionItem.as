package consortia.view.myConsortia.chairmanPath
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaDutyInfo;
   import yishi.manager.IMEManager;
   import yishi.utils.StringHelper;
   
   public class ConsortiaPermissionItem extends Sprite implements Disposeable, ISelectable
   {
      
      private var _inputBg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _selectedBg:ScaleFrameImage;
      
      private var _changeBtn:TextButton;
      
      private var _confirmBtn:TextButton;
      
      private var _selected:Boolean;
      
      private var _type:int;
      
      private var _data:ConsortiaDutyInfo;
      
      public function ConsortiaPermissionItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         buttonMode = true;
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionItemHightcolorBg");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.consortia.PermissionFrameInputBg");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionItemTextStyle");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionItemChangrBtn");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.PermissionItemConfirmBtn");
         _selectedBg.setFrame(1);
         _inputBg.visible = false;
         _nameTxt.text = "";
         _changeBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaPermissionItem.change");
         _changeBtn.visible = false;
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _confirmBtn.visible = false;
         addChild(_selectedBg);
         addChild(_inputBg);
         addChild(_nameTxt);
         addChild(_changeBtn);
         addChild(_confirmBtn);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _changeBtn = null;
         _confirmBtn = null;
         _data = null;
         _nameTxt = null;
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",__onChangeHandler);
         _confirmBtn.addEventListener("click",__onConfirmHandler);
         _nameTxt.addEventListener("change",__onTxtChangeHandler);
         _nameTxt.addEventListener("keyDown",__onKeydownHandler);
         _nameTxt.addEventListener("focusIn",__onFocusInHandler);
      }
      
      private function removeEvent() : void
      {
         _changeBtn.removeEventListener("click",__onChangeHandler);
         _confirmBtn.removeEventListener("click",__onConfirmHandler);
         _nameTxt.removeEventListener("change",__onTxtChangeHandler);
         _nameTxt.removeEventListener("keyDown",__onKeydownHandler);
         _nameTxt.removeEventListener("focusIn",__onFocusInHandler);
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         _changeBtn.visible = false;
         _confirmBtn.visible = true;
         _inputBg.visible = true;
         _nameTxt.type = "input";
         _nameTxt.mouseEnabled = true;
         if(stage)
         {
            stage.focus = _nameTxt;
         }
         _nameTxt.setSelection(0,_nameTxt.length);
         IMEManager.enable();
      }
      
      private function __onConfirmHandler(param1:Event) : void
      {
         _changeBtn.visible = true;
         _confirmBtn.visible = false;
         _inputBg.visible = false;
         _nameTxt.type = "dynamic";
         _nameTxt.setSelection(0,0);
         _nameTxt.mouseEnabled = false;
         if(param1)
         {
            _data.dutyName = _nameTxt.text;
         }
      }
      
      private function __onTxtChangeHandler(param1:Event) : void
      {
         if(StringHelper.isNullOrEmpty(_nameTxt.text))
         {
            _changeBtn.enable = false;
         }
         else
         {
            _changeBtn.enable = true;
         }
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            if(_changeBtn.enable && Boolean(_confirmBtn.visible))
            {
               __onConfirmHandler(param1);
            }
         }
         param1.stopPropagation();
      }
      
      private function __onFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
      }
      
      public function get data() : ConsortiaDutyInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaDutyInfo) : void
      {
         _data = param1;
         if(!_data)
         {
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         if(_selected)
         {
            _selectedBg.setFrame(2);
         }
         else
         {
            if(_confirmBtn.visible)
            {
               __onConfirmHandler(null);
               _nameTxt.text = _data.dutyName;
            }
            _selectedBg.setFrame(1);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get nameTxt() : FilterFrameText
      {
         return _nameTxt;
      }
   }
}

