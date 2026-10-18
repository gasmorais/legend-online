package consortia.view.myConsortia.chairmanPath.consortiaEmail
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.FilterWordManager;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringUtil;
   import yishi.utils.TextFieldHelp;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaEmailGroupSendView extends Frame implements IManualSize
   {
      
      private var _line:BitmapData;
      
      private var _comBoxBack:Bitmap;
      
      private var _memberView:ConsortiaEmailView;
      
      private var _background:MutipleImage;
      
      private var _costValue:FilterFrameText;
      
      private var _subjectValue:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _sendBtn:SelectedCheckButton;
      
      private var _closeBtn:SelectedCheckButton;
      
      private var _pointIcon:ScaleFrameImage;
      
      private var _control:ConsortiaControler;
      
      private var _model:ConsortiaModel;
      
      private var NEEDED_POINT:int;
      
      private var _target:String;
      
      private var _subject:String;
      
      private var _contentValue:String;
      
      public function ConsortiaEmailGroupSendView()
      {
         super();
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,383,491);
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         _background = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteEmailBack");
         _comBoxBack = ComponentFactory.Instance.creatBitmap("asset.writeemail.WriteMailSelectInputBg");
         _costValue = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteEmailCostValueText");
         NEEDED_POINT = int(TempleteManager.instance.getConfigInfoByConfigName("Mail_NeedPoint").ConfigValue);
         _costValue.text = String(NEEDED_POINT);
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("core.PayType");
         _subjectValue = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteTitleValueText");
         _content = ComponentFactory.Instance.creatComponentByStylename("writeemail.WriteContentText");
         _sendBtn = ComponentFactory.Instance.creatComponentByStylename("writeemail.sendBtn");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("writeemail.CloseBtn");
         _memberView = ComponentFactory.Instance.creatCustomObject("writeemail.memberView");
         _line = ComponentFactory.Instance.creatBitmapData("asset.core.WriteEmailLine");
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.ConsortiaEmailGroupSengView.title");
         _subjectValue.maxChars = 15;
         _sendBtn.text = LanguageMgr.GetTranslation("public.send");
         _closeBtn.text = LanguageMgr.GetTranslation("public.cancel1");
         addToContent(_background);
         addToContent(_comBoxBack);
         addToContent(_costValue);
         addToContent(_pointIcon);
         addToContent(_subjectValue);
         addToContent(_content);
         addToContent(_sendBtn);
         addToContent(_closeBtn);
         addToContent(_memberView);
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new Bitmap(_line);
            _loc1_.x = 5;
            _loc1_.y = _loc2_ * 24 + 84;
            addToContent(_loc1_);
            _loc2_++;
         }
         _pointIcon.setFrame(1);
         _pointIcon.x = _costValue.x + _costValue.textWidth + 3;
         _pointIcon.y = 55;
         _pointIcon.width = 23;
         _pointIcon.height = 21;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sendBtn.addEventListener("click",__sendHandler);
         _closeBtn.addEventListener("click",__closeHandler);
         _memberView.nameText.addEventListener("keyDown",__focusInHandler);
         _subjectValue.addEventListener("keyDown",__focusInHandler);
         _content.addEventListener("keyDown",__focusInHandler);
         _content.addEventListener("change",__onContentChangeHandler);
         _content.addEventListener("scroll",__onScrollHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sendBtn.removeEventListener("click",__sendHandler);
         _closeBtn.removeEventListener("click",__closeHandler);
         _memberView.nameText.removeEventListener("keyDown",__focusInHandler);
         _subjectValue.removeEventListener("keyDown",__focusInHandler);
         _content.removeEventListener("keyDown",__focusInHandler);
         _content.removeEventListener("change",__onContentChangeHandler);
         _content.removeEventListener("scroll",__onScrollHandler);
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
      
      private function __sendHandler(param1:MouseEvent) : void
      {
         var _loc4_:Array = null;
         var _loc9_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc3_:int = 0;
         var _loc8_:int = 0;
         var _loc10_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:String = "";
         if(VersionSwitch.FILTER_TRIM)
         {
            _target = StringUtil.remove(_memberView.nameText.text," ");
            _subject = StringUtil.remove(FilterWordManager.filterWrod(_subjectValue.text)," ");
            _contentValue = StringUtil.remove(FilterWordManager.filterWrod(_content.text)," ");
         }
         else
         {
            _target = _memberView.nameText.text;
            _subject = FilterWordManager.filterWrod(_subjectValue.text);
            _contentValue = FilterWordManager.filterWrod(_content.text);
         }
         if(!_target)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.target");
         }
         else if(!_subject)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.subject");
         }
         else if(!_contentValue)
         {
            _loc2_ = LanguageMgr.GetTranslation("emailII.view.WriteEmailFrame.content");
         }
         else
         {
            _loc4_ = _target.split(",");
            _loc9_ = ConsortiaManager.instance.model.consortiaMemberList.getList();
            _loc6_ = [];
            _loc7_ = [];
            _loc3_ = int(_loc9_.length);
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc6_.push((_loc9_[_loc8_] as ThaneInfo).nickName);
               _loc8_++;
            }
            for each(var _loc5_:String in _loc4_)
            {
               if(_loc6_.indexOf(_loc5_) == -1)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.consortiaEmail.ConsortiaEmailGroupSendView.noCurrentMember"));
                  return;
               }
               _loc10_ = 0;
               while(_loc10_ < _loc3_)
               {
                  if((_loc9_[_loc10_] as ThaneInfo).nickName == _loc5_)
                  {
                     _loc7_.push((_loc9_[_loc10_] as ThaneInfo).userId);
                  }
                  _loc10_++;
               }
            }
            sendEmail(_loc7_);
         }
         if(_loc2_)
         {
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function sendEmail(param1:Array) : void
      {
         SimpleAlertHelper.instance.data = [sendMailCall,param1];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("consortia.view.myConsortia.chairmanPath.consortiaEmail.ConsortiaEmailGroupSendView.sendMail",NEEDED_POINT);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",NEEDED_POINT);
      }
      
      private function sendMailCall(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            _control.sendEmail(param3,_subject,_contentValue,param2);
         }
         dispose();
      }
      
      private function __closeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         dispose();
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __onContentChangeHandler(param1:Event) : void
      {
         TextFieldHelp.limitLines(_content,7);
      }
      
      private function __onScrollHandler(param1:Event) : void
      {
         _content.scrollV = 1;
      }
      
      public function show(param1:ConsortiaControler) : void
      {
         _control = param1;
         initEvent();
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
         StageReferance.stage.focus = _subjectValue;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         _line = null;
         _comBoxBack = null;
         _memberView = null;
         _background = null;
         _costValue = null;
         _subjectValue = null;
         _content = null;
         _sendBtn = null;
         _closeBtn = null;
         _pointIcon = null;
         _control = null;
         _model = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

