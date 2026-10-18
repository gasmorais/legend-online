package consortia.view.myConsortia
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.utils.StringHelper;
   
   public class ConsortiaFrameRightContent extends Sprite implements Disposeable
   {
      
      private var _discriptionBtn:SelectedButton;
      
      private var _pronouncementBtn:SelectedButton;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _bg:Bitmap;
      
      private var _lineBg:Image;
      
      private var _confirmBtn:TextButton;
      
      private var _discriptionTxt:FilterFrameText;
      
      private var _discriptionTipTxt:FilterFrameText;
      
      private var _pronouncementTipTxt:FilterFrameText;
      
      private var _pronouncementTxt:FilterFrameText;
      
      private var _data:ConsortiaInfo;
      
      private var _isDisChanged:Boolean;
      
      private var _isProChanged:Boolean;
      
      private var _discriptionContainer:Sprite;
      
      private var _pronounceContainer:Sprite;
      
      private var _txtDiscriptionChange:String = "";
      
      private var _txtProFocusOutChange:String = "";
      
      public function ConsortiaFrameRightContent()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _discriptionBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.DiscriptionBtn");
         _pronouncementBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.PronouncementBtn");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.pronouncementBg");
         _lineBg = ComponentFactory.Instance.creatComponentByStylename("consortia.DiscriptionLineImg");
         _discriptionTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.DiscriptionText");
         _pronouncementTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.DiscriptionText");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RightConfirmButton");
         _discriptionTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.DiscriptionInputTipTextStyle");
         _pronouncementTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.PronouncementInputTipTextStyle");
         addChild(_discriptionBtn);
         addChild(_pronouncementBtn);
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_discriptionBtn);
         _buttonGroup.addSelectItem(_pronouncementBtn);
         _pronouncementBtn.dispatchEvent(new MouseEvent("click"));
         addChild(_bg);
         addChild(_lineBg);
         _lineBg.visible = false;
         _discriptionTxt.text = "";
         _discriptionTxt.maxChars = 200;
         _pronouncementTxt.maxChars = 200;
         _pronouncementTxt.text = "";
         _confirmBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.confirm");
         addChild(_confirmBtn);
         _confirmBtn.enable = false;
         _confirmBtn.visible = false;
         _discriptionTipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.discription");
         _discriptionTipTxt.visible = false;
         _discriptionContainer = new Sprite();
         addChild(_discriptionContainer);
         _discriptionContainer.addChild(_discriptionTxt);
         _discriptionContainer.addChild(_discriptionTipTxt);
         _discriptionContainer.visible = false;
         _pronouncementTipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.pronouncement");
         _pronouncementTipTxt.visible = false;
         _pronounceContainer = new Sprite();
         addChild(_pronounceContainer);
         _pronounceContainer.addChild(_pronouncementTxt);
         _pronounceContainer.addChild(_pronouncementTipTxt);
      }
      
      private function uninit() : void
      {
         if(_buttonGroup)
         {
            _buttonGroup.dispose();
         }
         _buttonGroup = null;
         if(_discriptionBtn)
         {
            _discriptionBtn.dispose();
         }
         _discriptionBtn = null;
         if(_pronouncementBtn)
         {
            _pronouncementBtn.dispose();
         }
         _pronouncementBtn = null;
         if(_bg)
         {
            if(_bg.bitmapData)
            {
               _bg.bitmapData.dispose();
            }
            if(_bg.parent)
            {
               _bg.parent.removeChild(_bg);
            }
         }
         _bg = null;
         if(_lineBg)
         {
            _lineBg.dispose();
         }
         _lineBg = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_discriptionTxt)
         {
            _discriptionTxt.dispose();
         }
         _discriptionTxt = null;
         if(_discriptionTipTxt)
         {
            _discriptionTipTxt.dispose();
         }
         _discriptionTipTxt = null;
         if(_pronouncementTipTxt)
         {
            _pronouncementTipTxt.dispose();
         }
         _pronouncementTipTxt = null;
         if(_pronouncementTxt)
         {
            _pronouncementTxt.dispose();
         }
         _pronouncementTxt = null;
         ObjectUtils.disposeObject(_discriptionContainer);
         _discriptionContainer = null;
         ObjectUtils.disposeObject(_pronounceContainer);
         _pronounceContainer = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function addEvent() : void
      {
         _discriptionTxt.addEventListener("focusIn",__onFocusInHandler);
         _discriptionTxt.addEventListener("focusOut",__onFocusOutHandler);
         _discriptionTxt.addEventListener("change",__onDiscriptionChangeHandler);
         _discriptionTxt.addEventListener("keyDown",__keyDownHandler);
         _pronouncementTxt.addEventListener("focusIn",__onProFocusInHandler);
         _pronouncementTxt.addEventListener("change",__onProFocusOutChangeHandler);
         _pronouncementTxt.addEventListener("focusOut",__onProFocusOutHandler);
         _pronouncementTxt.addEventListener("keyDown",__keyDownHandler);
         _discriptionBtn.addEventListener("click",__onDiscriptionHandler);
         _pronouncementBtn.addEventListener("click",__onPronouncementHandler);
         _confirmBtn.addEventListener("click",__onConfirmHandler);
      }
      
      private function removeEvent() : void
      {
         _discriptionTxt.removeEventListener("focusIn",__onFocusInHandler);
         _discriptionTxt.removeEventListener("focusOut",__onFocusOutHandler);
         _discriptionTxt.removeEventListener("change",__onDiscriptionChangeHandler);
         _discriptionTxt.removeEventListener("keyDown",__keyDownHandler);
         _pronouncementTxt.removeEventListener("focusIn",__onProFocusInHandler);
         _pronouncementTxt.removeEventListener("focusOut",__onProFocusOutHandler);
         _pronouncementTxt.removeEventListener("keyDown",__keyDownHandler);
         _pronouncementTxt.removeEventListener("change",__onProFocusOutChangeHandler);
         _discriptionBtn.removeEventListener("click",__onDiscriptionHandler);
         _pronouncementBtn.removeEventListener("click",__onPronouncementHandler);
         _confirmBtn.removeEventListener("click",__onConfirmHandler);
      }
      
      private function __onFocusInHandler(param1:Event) : void
      {
         if(!_isDisChanged)
         {
            _discriptionTipTxt.visible = false;
         }
         IMEManager.enable();
         _confirmBtn.enable = true;
      }
      
      private function __onFocusOutHandler(param1:Event) : void
      {
         if(!_isDisChanged && Boolean(StringHelper.isNullOrEmpty(_discriptionTxt.text)))
         {
            _discriptionTipTxt.visible = true;
         }
      }
      
      private function __onProFocusInHandler(param1:Event) : void
      {
         if(!_isProChanged)
         {
            _pronouncementTipTxt.visible = false;
         }
         IMEManager.enable();
         _confirmBtn.enable = true;
      }
      
      private function __onProFocusOutHandler(param1:Event) : void
      {
         if(!_isProChanged && Boolean(StringHelper.isNullOrEmpty(_pronouncementTxt.text)))
         {
            _pronouncementTipTxt.visible = true;
         }
      }
      
      private function __onDiscriptionChangeHandler(param1:Event) : void
      {
         if(_discriptionTxt.textHeight > 205)
         {
            _discriptionTxt.text = _txtDiscriptionChange;
            StageReferance.stage.focus = _confirmBtn;
         }
         _txtDiscriptionChange = _discriptionTxt.text;
      }
      
      private function __onProFocusOutChangeHandler(param1:Event) : void
      {
         if(_pronouncementTxt.textHeight > 205)
         {
            _pronouncementTxt.text = _txtProFocusOutChange;
            StageReferance.stage.focus = _confirmBtn;
         }
         _txtProFocusOutChange = _pronouncementTxt.text;
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __onDiscriptionHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _confirmBtn.enable = false;
         _discriptionContainer.visible = true;
         _pronounceContainer.visible = false;
         setDiscriptionBtn();
         setDiscription();
      }
      
      private function __onPronouncementHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _confirmBtn.enable = false;
         _discriptionContainer.visible = false;
         _pronounceContainer.visible = true;
         setPronouncementBtn();
         setPronouncement();
      }
      
      private function __onConfirmHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!_confirmBtn.enable)
         {
            return;
         }
         if(_discriptionBtn.selected)
         {
            FrameControllerManager.instance.consortiaController.modifyConsortiaDiscription(_discriptionTxt.text);
         }
         else
         {
            FrameControllerManager.instance.consortiaController.modifyConsortiaPlacard(_pronouncementTxt.text);
         }
         _confirmBtn.enable = false;
      }
      
      public function get data() : ConsortiaInfo
      {
         return _data;
      }
      
      public function set data(param1:ConsortiaInfo) : void
      {
         _data = param1;
         setDiscription();
         setPronouncement();
         setConfirmBtn();
      }
      
      private function setDiscription() : void
      {
         if(StringHelper.isNullOrEmpty(_data.description) && modifydEscRights)
         {
            _isDisChanged = false;
            _discriptionTipTxt.visible = true;
            _discriptionTxt.text = "";
         }
         else
         {
            _discriptionTipTxt.visible = false;
            _isDisChanged = true;
            _discriptionTxt.text = _data.description ? _data.description : "";
         }
         _txtDiscriptionChange = _discriptionTxt.text;
      }
      
      private function setPronouncement() : void
      {
         if(_data && StringHelper.isNullOrEmpty(_data.placard) && modifydBBSRights)
         {
            _isProChanged = false;
            _pronouncementTipTxt.visible = true;
            _pronouncementTxt.text = "";
         }
         else
         {
            _pronouncementTipTxt.visible = false;
            _isProChanged = true;
            _pronouncementTxt.text = _data.placard;
         }
         _txtProFocusOutChange = _pronouncementTxt.text;
      }
      
      public function setConfirmBtn() : void
      {
         if(_discriptionContainer.visible)
         {
            setDiscriptionBtn();
         }
         else
         {
            setPronouncementBtn();
         }
      }
      
      private function setDiscriptionBtn() : void
      {
         if(modifydEscRights)
         {
            _confirmBtn.visible = true;
            _lineBg.visible = true;
            _discriptionTxt.mouseEnabled = _discriptionTxt.selectable = true;
         }
         else
         {
            _confirmBtn.visible = false;
            _lineBg.visible = false;
            _discriptionTxt.mouseEnabled = _discriptionTxt.selectable = false;
         }
      }
      
      private function get modifydEscRights() : Boolean
      {
         return FrameControllerManager.instance.consortiaController.getRightsByIndex(30);
      }
      
      private function setPronouncementBtn() : void
      {
         if(modifydBBSRights)
         {
            _confirmBtn.visible = true;
            _lineBg.visible = true;
            _pronouncementTxt.selectable = _pronouncementTxt.mouseEnabled = true;
         }
         else
         {
            _confirmBtn.visible = false;
            _lineBg.visible = false;
            _pronouncementTxt.selectable = _pronouncementTxt.mouseEnabled = false;
         }
      }
      
      private function get modifydBBSRights() : Boolean
      {
         return FrameControllerManager.instance.consortiaController.getRightsByIndex(4);
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
   }
}

