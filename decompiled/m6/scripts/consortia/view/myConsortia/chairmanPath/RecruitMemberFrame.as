package consortia.view.myConsortia.chairmanPath
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.pickgliss.utils.StringUtils;
   import com.road.yishi.proto.consortia.ConditionSpeakMsg;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import yishi.comm.PackageOut;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.StringHelper;
   
   public class RecruitMemberFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _text:FilterFrameText;
      
      private var _firstInFlag:Boolean = true;
      
      private var _describe:FilterFrameText;
      
      private var _confitmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      public function RecruitMemberFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitMemberBack");
         _text = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitMemberTxt");
         _describe = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitMemberDesc");
         _confitmBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitMemberConfirm");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RecruitMemberCancel");
         addToContent(_back);
         addToContent(_text);
         addToContent(_describe);
         addToContent(_confitmBtn);
         addToContent(_cancelBtn);
         var _loc1_:int = int(ConsortiaManager.instance.model.consortiaInfo.speakTimes);
         _text.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.RecruitMemberFrame.text");
         _describe.htmlText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.RecruitMemberFrame.describe",_loc1_);
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaChairmanPath.command04");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confitmBtn.addEventListener("click",__confirmhandler);
         _cancelBtn.addEventListener("click",__cancelhandler);
         _text.addEventListener("focusIn",__focusInHandler);
         _text.addEventListener("change",__onTextChanged);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confitmBtn.removeEventListener("click",__confirmhandler);
         _cancelBtn.removeEventListener("click",__cancelhandler);
         _text.removeEventListener("focusIn",__focusInHandler);
         _text.removeEventListener("change",__onTextChanged);
      }
      
      private function __onTextChanged(param1:Event) : void
      {
         if(StringUtils.checkStringLength(_text.text) >= 54)
         {
            _text.text = StringUtils.substr(_text.text,54);
         }
      }
      
      private function __focusInHandler(param1:FocusEvent) : void
      {
         _text.setFrame(2);
         if(_firstInFlag)
         {
            _text.text = "";
            _firstInFlag = false;
         }
      }
      
      private function __confirmhandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = _text.text;
         _loc2_ = StringHelper.trim(_loc2_);
         _loc2_ = FilterWordManager.filterWrod(_loc2_);
         _loc2_ = StringHelper.rePlaceHtmlTextField(_loc2_);
         if(_loc2_ == "" || _loc2_ == LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.RecruitMemberFrame.text"))
         {
            _loc2_ = "";
         }
         var _loc4_:PackageOut = new PackageOut(8335);
         var _loc3_:ConditionSpeakMsg = new ConditionSpeakMsg();
         _loc3_.speak = _loc2_;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
         dispose();
      }
      
      private function __cancelhandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_confitmBtn);
         _confitmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         super.dispose();
      }
   }
}

