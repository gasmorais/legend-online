package consortia.view.myConsortia.recruit
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.simple.SimplePlayerSearchRspMsg;
   import events.ConsortiaEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import yishi.comm.PackageIn;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaRecruitFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _inputBg:Image;
      
      private var _tipTxtImg:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _inputTipTxt:FilterFrameText;
      
      private var _confirmBtn:TextButton;
      
      private var _cancelBtn:TextButton;
      
      private var _txtChange:String = "";
      
      public function ConsortiaRecruitFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.command01");
         _bg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitFrameDescribeBackground");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitFrameInputBg");
         _tipTxtImg = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitTipTextStyle");
         _inputTipTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitFrameInputTipTextStyle");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitInputTextStyle");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitConfirmButton");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.ConsortiaRecruitCancelButton");
         _inputTipTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command01");
         _inputTxt.text = "";
         _confirmBtn.enable = false;
         addToContent(_bg);
         addToContent(_inputBg);
         addToContent(_tipTxtImg);
         _tipTxtImg.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.tipTxtImgText");
         addToContent(_inputTipTxt);
         addToContent(_inputTxt);
         addToContent(_confirmBtn);
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         addToContent(_cancelBtn);
         _cancelBtn.text = LanguageMgr.GetTranslation("public.close");
      }
      
      private function uninit() : void
      {
         _inputTxt = null;
         _cancelBtn = null;
         _confirmBtn = null;
      }
      
      private function addEvent() : void
      {
         _inputTxt.addEventListener("keyDown",__onKeydownHandler);
         _inputTxt.addEventListener("change",__onChangeHandler);
         addEventListener("response",__frameResponse);
         _inputTxt.addEventListener("focusIn",__onFocusInHandler);
         _inputTxt.addEventListener("focusOut",__onFocusOutHandler);
         _cancelBtn.addEventListener("click",__onCancleHandler);
         _confirmBtn.addEventListener("click",__onConfirmHandler);
         _inputTxt.addEventListener("change",__onTxtChange);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4170,__getUserInfoHandler);
         ConsortiaManager.instance.model.addEventListener("IS_CONSORTIA_EXIST",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         _inputTxt.removeEventListener("keyDown",__onKeydownHandler);
         _inputTxt.removeEventListener("change",__onChangeHandler);
         removeEventListener("response",__frameResponse);
         _inputTxt.removeEventListener("focusIn",__onFocusInHandler);
         _inputTxt.removeEventListener("focusOut",__onFocusOutHandler);
         _cancelBtn.removeEventListener("click",__onCancleHandler);
         _confirmBtn.removeEventListener("click",__onConfirmHandler);
         _inputTxt.removeEventListener("change",__onTxtChange);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4170,__getUserInfoHandler);
         ConsortiaManager.instance.model.removeEventListener("IS_CONSORTIA_EXIST",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:ConsortiaEvent) : void
      {
         dispose();
      }
      
      private function __onTxtChange(param1:Event) : void
      {
         var _loc2_:int = int(_inputTxt.text.replace(/[^\x00-\xff]/g,"xx").length);
         if(_loc2_ > 12)
         {
            _inputTxt.text = _txtChange;
         }
         _txtChange = _inputTxt.text;
      }
      
      private function __onCancleHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13 && Boolean(_confirmBtn.enable))
         {
            __onConfirmHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         if(StringHelper.isNullOrEmpty(_inputTxt.text))
         {
            _confirmBtn.enable = false;
         }
         else
         {
            _confirmBtn.enable = true;
         }
      }
      
      private function __getUserInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:PackageIn = param1.data as PackageIn;
         var _loc2_:SimplePlayerSearchRspMsg = new SimplePlayerSearchRspMsg();
         _loc2_ = _loc4_.readBody(_loc2_) as SimplePlayerSearchRspMsg;
         var _loc3_:String = "";
         if(_loc2_.hasInfo && _loc2_.info.nickName.toLowerCase() == _inputTxt.text.toLowerCase())
         {
            if(_loc2_.info.userId == PlayerManager.instance.currentPlayerModel.playerInfo.userId)
            {
               _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.command02");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            if(_loc2_.info.grades < 12)
            {
               _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.command03");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            if(_loc2_.info.consortiaID)
            {
               _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.recruit.ConsortiaRecruitFrame.command04");
               MessageTipManager.instance().show(_loc3_);
               return;
            }
            control.sendConsortiaInvitePlayer(_loc2_.info.userId);
            dispose();
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command06");
            MessageTipManager.instance().show(_loc3_);
         }
      }
      
      private function __onConfirmHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(StringHelper.isNullOrEmpty(_inputTxt.text))
         {
            _loc2_ = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaTransferFrame.command03");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         control.SearchPlayer(_inputTxt.text);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      private function __onFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _inputTipTxt.visible = false;
      }
      
      private function __onFocusOutHandler(param1:FocusEvent) : void
      {
         if(StringHelper.isNullOrEmpty(_inputTxt.text))
         {
            _inputTipTxt.visible = true;
         }
      }
      
      private function get control() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

