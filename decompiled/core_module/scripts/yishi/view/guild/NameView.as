package yishi.view.guild
{
   import com.pickgliss.loader.DataAnalyzer;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.NamesLibAnalyzer;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import manager.NamesLibManager;
   import yishi.datas.UserInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class NameView extends Sprite implements Disposeable
   {
      
      private var _bg:Bitmap;
      
      private var _tipInput:Bitmap;
      
      private var _shaiziBtn:BaseButton;
      
      private var _submitBtn:IconButton;
      
      private var _inputTxt:FilterFrameText;
      
      private var _describtTxt:FilterFrameText;
      
      private var _backCall:Function;
      
      private var _data:Object;
      
      public const MAX_LENGTH:int = 12;
      
      public const MIN_LENGTH:int = 4;
      
      private var _nickName:String;
      
      private var _txtChange:String = "";
      
      public function NameView(param1:Function = null, param2:Object = null)
      {
         super();
         _backCall = param1;
         _data = param2;
         init();
         _shaiziBtn.addEventListener("click",__shaiziBtnClickHandler);
         _submitBtn.addEventListener("click",__onClick);
         _inputTxt.addEventListener("keyDown",__keyDownHandler);
         _inputTxt.addEventListener("change",__onTxtChange);
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.rename.ReNameBgAsset");
         addChild(_bg);
         _tipInput = ComponentFactory.Instance.creatBitmap("asset.rename.InputNameTipAsset");
         _tipInput.y = 35;
         addChild(_tipInput);
         _shaiziBtn = ComponentFactory.Instance.creatComponentByStylename("rename.ShaiziBtn");
         addChild(_shaiziBtn);
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("rename.SubmitBtn");
         addChild(_submitBtn);
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("rename.ReNameTxt");
         addChild(_inputTxt);
         _describtTxt = ComponentFactory.Instance.creatComponentByStylename("rename.RenameFrameDescribeTxt");
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         _describtTxt.setFrame(2);
         _describtTxt.y = 129;
         addChild(_describtTxt);
         _shaiziBtn.visible = false;
         if(DisplayLoader.isDebug)
         {
            LoaderManagerII.instance.load(ComponentSetting.NamesLibPath,7,10,onSingleLoadComplete);
         }
         else
         {
            LoaderManagerII.instance.load(ComponentSetting.NamesLibPath,5,10,onSingleLoadComplete);
         }
      }
      
      private function onSingleLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:DataAnalyzer = null;
         if(!NamesLibManager.hasSetup)
         {
            _loc3_ = new NamesLibAnalyzer(NamesLibManager.setup);
            _loc3_.analyze(String(param2));
         }
         _nickName = _inputTxt.text;
         _nickName = _nickName.replace("\r","");
         if(_nickName == "")
         {
            _inputTxt.text = NamesLibManager.newName(ArmyManager.instance.thane.templateInfo.Sexs).replace("\r","");
         }
         if(_inputTxt.text != "")
         {
            _shaiziBtn.visible = true;
         }
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 13)
         {
            case 0:
               __onClick(null);
         }
         param1.stopPropagation();
      }
      
      private function __shaiziBtnClickHandler(param1:MouseEvent) : void
      {
         _inputTxt.text = NamesLibManager.newName(ArmyManager.instance.thane.templateInfo.Sexs).replace("\r","");
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         loadCheckNickname();
      }
      
      private function loadCheckNickname() : void
      {
         _nickName = StringHelper.trim(_inputTxt.text);
         _nickName = _nickName.replace("\r","");
         var _loc4_:int = StringHelper.checkStringLength(_nickName);
         if(_nickName == "")
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt02");
            return;
         }
         if(_loc4_ < 4)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt03");
            return;
         }
         if(_loc4_ > 12)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt04");
            return;
         }
         if(FilterWordManager.containUnableChar(_nickName) || FilterWordManager.filterWrod(_nickName) != _nickName)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt05");
            return;
         }
         _submitBtn.enable = false;
         var _loc2_:UserInfo = PlayerManager.instance.currentPlayerModel.userInfo;
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["userid"] = _loc2_.userId;
         _loc1_["username"] = _loc2_.user;
         _loc1_["nickname"] = _nickName;
         _loc1_["site"] = _loc2_.site;
         _loc1_["key"] = _loc2_.key;
         _loc1_["rnd"] = Math.random();
         var _loc3_:String = ComponentSetting.REQUEST_PATH + "namedservlet";
         LoaderManagerII.instance.load(_loc3_,7,0,__namedCompleteHandler,null,__onLoadNameError,null,_loc1_);
      }
      
      private function __namedCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:XML = XML(param2);
         var _loc3_:String = _loc4_.@value;
         var _loc5_:int = int(_loc4_.@type);
         if(_loc3_ == "true" && (_loc5_ == 0 || _loc5_ == 3))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt08"));
            if(_backCall != null)
            {
               _backCall();
            }
            dispose();
         }
         else
         {
            _submitBtn.enable = true;
            _describtTxt.setFrame(1);
            _describtTxt.text = _loc4_.@message;
         }
      }
      
      private function __onLoadNameError(param1:LoaderInfo, param2:Object) : void
      {
         _submitBtn.enable = true;
         _describtTxt.setFrame(1);
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.view.AddUserNameFrame.checkNickErrorEvent2");
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         _describtTxt.setFrame(2);
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         if(StringHelper.checkStringLength(_inputTxt.text) > 12)
         {
            _inputTxt.text = _txtChange;
         }
         _txtChange = _inputTxt.text;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,0,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         _data = null;
         _backCall = null;
         if(_shaiziBtn)
         {
            _shaiziBtn.removeEventListener("click",__shaiziBtnClickHandler);
            _shaiziBtn.dispose();
            _shaiziBtn = null;
         }
         if(_submitBtn)
         {
            _submitBtn.removeEventListener("click",__onClick);
            _submitBtn.dispose();
            _submitBtn = null;
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("keyDown",__keyDownHandler);
            _inputTxt.removeEventListener("change",__onTxtChange);
            _inputTxt = null;
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

