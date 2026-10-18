package pet.property
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PathManager;
   import yishi.service.managers.CastleServiceManager;
   import yishi.service.services.AmfResponder;
   import yishi.view.tips.MessageTipManager;
   
   public class PetRenameView extends Frame
   {
      
      private var _tipInput:FilterFrameText;
      
      protected var _submitBtn:IconButton;
      
      private var _closeBtn:BaseButton;
      
      private var _nameBg:ScaleBitmapImage;
      
      private var _inputTxt:FilterFrameText;
      
      protected var _describtTxt:FilterFrameText;
      
      protected var _typeStr:String;
      
      protected var _nickName:String = "";
      
      public const MAX_LENGTH:int = 12;
      
      public const MIN_LENGTH:int = 4;
      
      private var _txtChange:String = "";
      
      public var data:Object;
      
      public function PetRenameView()
      {
         super();
         setTypeStr();
         initView();
         addEvent();
      }
      
      protected function setTypeStr() : void
      {
         _typeStr = LanguageMgr.GetTranslation("pet.renameFrame.typeStr");
      }
      
      protected function initView() : void
      {
         _tipInput = ComponentFactory.Instance.creatComponentByStylename("petrename.inputTipTxt");
         _nameBg = ComponentFactory.Instance.creatComponentByStylename("petRename.NameBg");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("petRename.NameTxt");
         _describtTxt = ComponentFactory.Instance.creatComponentByStylename("petRename.RenameFrameDescribeTxt");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("petRename.AlertButtonConfirm_2");
         addToContent(_tipInput);
         addToContent(_nameBg);
         addToContent(_inputTxt);
         addToContent(_submitBtn);
         addToContent(_describtTxt);
         _inputTxt.text = "";
         _tipInput.text = LanguageMgr.GetTranslation("pet.renameFrame.inputName");
         _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt01",_typeStr);
         _describtTxt.setFrame(2);
         this.titleText = LanguageMgr.GetTranslation("public.prompt");
      }
      
      private function uintView() : void
      {
         _tipInput = null;
         _nameBg = null;
         _inputTxt = null;
         _submitBtn = null;
         _describtTxt = null;
      }
      
      private function addEvent() : void
      {
         _submitBtn.addEventListener("click",__submitHandler);
         this.addEventListener("response",__frameResponse);
         _inputTxt.addEventListener("keyDown",__keyDownHandler);
         _inputTxt.addEventListener("change",__onTxtChange);
      }
      
      private function removeEvent() : void
      {
         if(_submitBtn)
         {
            _submitBtn.removeEventListener("click",__submitHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("keyDown",__keyDownHandler);
            _inputTxt.removeEventListener("change",__onTxtChange);
         }
         this.removeEventListener("response",__frameResponse);
      }
      
      protected function __submitHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = clientCheck();
         if(_loc2_)
         {
            _submitBtn.enable = false;
            serverCheck();
         }
      }
      
      private function clientCheck() : Boolean
      {
         _nickName = _inputTxt.text;
         _nickName = _nickName.replace("\r","");
         var _loc1_:int = getNameLength(_nickName);
         if(_nickName == "")
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt02",_typeStr);
            return false;
         }
         if(_nickName == data.name)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt09",_typeStr);
            return false;
         }
         if(_loc1_ < 4)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt03",_typeStr);
            return false;
         }
         if(_loc1_ > 12)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt04",_typeStr);
            return false;
         }
         if(FilterWordManager.containUnableChar(_nickName) || FilterWordManager.filterWrod(_nickName) != _nickName)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt05",_typeStr);
            return false;
         }
         return true;
      }
      
      public function getNameLength(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.charCodeAt(_loc3_) >= 19968 && param1.charCodeAt(_loc3_) <= 40869)
            {
               _loc2_ += 2;
            }
            else
            {
               _loc2_ += 1;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      protected function serverCheck() : void
      {
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["nickname"] = _nickName;
         _loc1_["rnd"] = Math.random();
         _loc1_["type"] = 1;
         var _loc2_:String = PathManager.info.REQUEST_PATH + "nicknamecheck";
         LoaderManagerII.instance.load(_loc2_,7,8,__serverCheckResult,null,null,null,_loc1_);
      }
      
      protected function __serverCheckResult(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:XML = new XML(param2);
         if(String(_loc3_.@value) == "true")
         {
            CastleServiceManager.instance.petRename(data.petId,_nickName).onResult = renameResult;
         }
         else
         {
            _submitBtn.enable = true;
            _describtTxt.setFrame(1);
            _describtTxt.text = String(_loc3_.@message);
         }
      }
      
      protected function renameResult(param1:AmfResponder) : void
      {
         var _loc2_:String = null;
         if(isDie)
         {
            return;
         }
         if(param1.result == 3)
         {
            _loc2_ = LanguageMgr.GetTranslation("pet.renameFrame.describt08");
            MessageTipManager.instance().show(_loc2_);
            dispose();
         }
         else
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt06");
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               __submitHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         _describtTxt.setFrame(2);
         _describtTxt.text = LanguageMgr.GetTranslation("pet.renameFrame.describt01",_typeStr);
         var _loc2_:int = int(_inputTxt.text.replace(/[^\x00-\xff]/g,"xx").length);
         if(_loc2_ > 12)
         {
            _inputTxt.text = _txtChange;
         }
         _submitBtn.enable = true;
         _txtChange = _inputTxt.text;
      }
      
      public function show() : void
      {
         StageReferance.stage.focus = _inputTxt;
         _inputTxt.setFocus();
         LayerManager.Instance.addToLayer(this,2,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uintView();
         super.dispose();
         data = null;
      }
   }
}

