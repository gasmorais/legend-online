package airgarden
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import managers.AirGardenManager;
   import mvc.ModuleFrameInfo;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class AirGardenCreatePartyFrame extends Frame
   {
      
      private var _textBack:ScaleBitmapImage;
      
      private var _alertText:FilterFrameText;
      
      private var _declarationText:FilterFrameText;
      
      private var _costText:FilterFrameText;
      
      private var _pointImage:Image;
      
      private var _sureBtn:SelectedCheckButton;
      
      private var _cancelBtn:SelectedCheckButton;
      
      private var declarationDefaultText:String;
      
      private var inputTextLen:int = 60;
      
      private var partyCost:int;
      
      public function AirGardenCreatePartyFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _alertText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.alertText");
         _textBack = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.textBack");
         _declarationText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.declarationText");
         _costText = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.costText");
         _pointImage = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.pointImage");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.sureBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("AirGardenCreatePartyFrame.cancelBtn");
         addToContent(_alertText);
         addToContent(_textBack);
         addToContent(_declarationText);
         addToContent(_costText);
         addToContent(_pointImage);
         addToContent(_sureBtn);
         addToContent(_cancelBtn);
         partyCost = ConfigInfoManager.instance.getAirGardenPartyCost();
         declarationDefaultText = LanguageMgr.GetTranslation("AirGardenCreatePartyFrame.declarationDefaultText.text");
         _costText.htmlText = LanguageMgr.GetTranslation("AirGardenCreatePartyFrame.costText.text",partyCost);
         _pointImage.x = _costText.x + _costText.textWidth + 3;
         _alertText.text = LanguageMgr.GetTranslation("AirGardenCreatePartyFrame.alertText.text");
         _declarationText.text = declarationDefaultText;
         _declarationText.setSelection(0,_declarationText.length);
         _declarationText.setFocus();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sureBtn.addEventListener("click",__sureClickHandler);
         _cancelBtn.addEventListener("click",__onCloseClick);
         _declarationText.addEventListener("change",__inputTextChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_sureBtn)
         {
            _sureBtn.removeEventListener("click",__sureClickHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__onCloseClick);
         }
         if(_declarationText)
         {
            _declarationText.removeEventListener("change",__inputTextChangeHandler);
         }
      }
      
      private function __inputTextChangeHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_declarationText.text) > inputTextLen)
         {
            _declarationText.text = declarationDefaultText;
         }
         declarationDefaultText = _declarationText.text;
      }
      
      private function __sureClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc4_:String = StringHelper.trimRight(_declarationText.text);
         if(StringHelper.isNullOrEmpty(_loc4_))
         {
            _loc4_ = LanguageMgr.GetTranslation("AirGardenCreatePartyFrame.declarationDefaultText.text");
         }
         if(_loc4_ != FilterWordManager.filterWrod(_loc4_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.im.view.IMStateReplyInputView.dirtyWordTip"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("AirGardenCreatePartyFrame.createParty.onAlert",partyCost);
         SimpleAlertHelper.instance.data = [sureBackHandler,_loc4_];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,false);
      }
      
      private function sureBackHandler(param1:Boolean, param2:Boolean, param3:String) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(partyCost,false))
         {
            return;
         }
         AirGardenManager.instance.airGardenCreateParty(param3);
         dispose();
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("AirGardenCreatePartyFrame.title.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         ObjectUtils.disposeObject(_declarationText);
         _declarationText = null;
         ObjectUtils.disposeObject(_textBack);
         _textBack = null;
         ObjectUtils.disposeObject(_costText);
         _costText = null;
         ObjectUtils.disposeObject(_pointImage);
         _pointImage = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         super.dispose();
      }
   }
}

