package yishi.view.community
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.player.PlayerRenameRspMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.net.URLVariables;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.comm.PackageIn;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PathManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.StringHelper;
   
   public class RenameView extends Sprite implements Disposeable
   {
      
      public static const TYPE_RENAME_CARD:int = 1;
      
      public static const TYPE_COMPOSE:int = 2;
      
      private var _bg:Bitmap;
      
      private var _tipInput:Bitmap;
      
      private var _tipFree:Bitmap;
      
      private var _submitBtn:IconButton;
      
      private var _closeBtn:BaseButton;
      
      private var _inputTxt:FilterFrameText;
      
      private var _describtTxt:FilterFrameText;
      
      private var _warningTxt:FilterFrameText;
      
      private var _backCall:Function;
      
      private var _data:Object;
      
      private var _type:int;
      
      public const MAX_LENGTH:int = 12;
      
      public const MIN_LENGTH:int = 4;
      
      private var _nickName:String;
      
      private var _txtChange:String = "";
      
      private var _mask:Sprite;
      
      public function RenameView(param1:int, param2:Function = null, param3:Object = null)
      {
         super();
         _type = param1;
         _backCall = param2;
         _data = param3;
         init();
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4271,__playerRenameRspHandler);
         _submitBtn.addEventListener("click",__onClick);
         _closeBtn.addEventListener("click",__onCloseClick);
         _inputTxt.addEventListener("keyDown",__keyDownHandler);
         _inputTxt.addEventListener("change",__onTxtChange);
         if(_type == 1)
         {
            StageReferance.stage.addEventListener("keyDown",__panelKeyDownHandler);
         }
         else
         {
            StageReferance.stage.addEventListener("resize",__stageResizeHandler);
         }
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.rename.ReNameBgAsset");
         addChild(_bg);
         _tipInput = ComponentFactory.Instance.creatBitmap("asset.rename.InputNameTipAsset");
         addChild(_tipInput);
         _tipFree = ComponentFactory.Instance.creatBitmap("asset.rename.ReNameFreeTipAsset");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("rename.SubmitBtn");
         addChild(_submitBtn);
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("rename.CloseBtn");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("rename.ReNameTxt");
         addChild(_inputTxt);
         _describtTxt = ComponentFactory.Instance.creatComponentByStylename("rename.RenameFrameDescribeTxt");
         _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt01");
         _describtTxt.setFrame(2);
         addChild(_describtTxt);
         _warningTxt = ComponentFactory.Instance.creatComponentByStylename("rename.RenameFrameWarningTxt");
         _warningTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt00");
         _warningTxt.setFrame(1);
         addChild(_warningTxt);
         switch(_type - 1)
         {
            case 0:
               addChild(_closeBtn);
               _tipInput.y = 35;
               break;
            case 1:
               addChild(_tipFree);
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
      
      private function __panelKeyDownHandler(param1:KeyboardEvent) : void
      {
         switch(int(param1.keyCode) - 27)
         {
            case 0:
               dispose();
         }
      }
      
      private function __onCloseClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         loadCheckNickname();
      }
      
      private function loadCheckNickname() : void
      {
         _nickName = StringHelper.trim(_inputTxt.text);
         _nickName = _nickName.replace("\r","");
         var _loc3_:int = StringHelper.checkStringLength(_nickName);
         if(_nickName == "")
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt02");
            return;
         }
         if(_loc3_ < 4)
         {
            _describtTxt.setFrame(1);
            _describtTxt.text = LanguageMgr.GetTranslation("noviceII.node.AddUserNameFrame.describt03");
            return;
         }
         if(_loc3_ > 12)
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
         var _loc1_:URLVariables = new URLVariables();
         _loc1_["nickname"] = _nickName;
         _loc1_["rnd"] = Math.random();
         var _loc2_:String = PathManager.info.REQUEST_PATH + "nicknamecheck";
         LoaderManagerII.instance.load(_loc2_,7,8,__onCheckNicknameComplete,null,__onLoadCheckNickError,null,_loc1_);
      }
      
      private function __onLoadCheckNickError(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:String = LanguageMgr.GetTranslation("public.loadErrorMsg");
         var _loc3_:String = LanguageMgr.GetTranslation("noviceII.view.AddUserNameFrame.checkNickErrorEvent2");
      }
      
      private function __onCheckNicknameComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:XML = new XML(param2);
         if(String(_loc3_.@value) == "true")
         {
            switch(_type - 1)
            {
               case 0:
                  if(_data)
                  {
                     SocketSendManager.instance.sendRename(_nickName,1,(_data as GoodsInfo).pos);
                  }
                  break;
               case 1:
                  SocketSendManager.instance.sendRename(_nickName,2);
            }
         }
         else
         {
            _submitBtn.enable = true;
            _describtTxt.setFrame(1);
            _describtTxt.text = _loc3_.@message;
         }
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
      
      private function __playerRenameRspHandler(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:PlayerRenameRspMsg = new PlayerRenameRspMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as PlayerRenameRspMsg;
         if(_loc2_.result)
         {
            dispose();
         }
         else
         {
            _submitBtn.enable = true;
         }
      }
      
      public function show() : void
      {
         if(_type == 1)
         {
            LayerManager.Instance.addToLayer(this,3,true,true,2);
         }
         else
         {
            showThisTop();
         }
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function __stageResizeHandler(param1:Event) : void
      {
         this.x = (StageReferance.stage.stageWidth - this.width) * 0.5;
         this.y = (StageReferance.stage.stageHeight - this.height) * 0.5;
      }
      
      private function showThisTop() : void
      {
         _mask = new Sprite();
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRect(-500,-200,2100,1600);
         _mask.graphics.endFill();
         StageReferance.stage.addChild(_mask);
         StageReferance.stage.addChild(this);
         this.x = (StageReferance.stage.stageWidth - this.width) * 0.5;
         this.y = (StageReferance.stage.stageHeight - this.height) * 0.5;
      }
      
      public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         if(_backCall != null)
         {
            _backCall();
         }
         _backCall = null;
         _data = null;
         StageReferance.stage.removeEventListener("keyDown",__panelKeyDownHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4271,__playerRenameRspHandler);
         StageReferance.stage.removeEventListener("resize",__stageResizeHandler);
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         if(_submitBtn)
         {
            _submitBtn.removeEventListener("click",__onClick);
            _submitBtn.dispose();
            _submitBtn = null;
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onCloseClick);
            _closeBtn.dispose();
            _closeBtn = null;
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

