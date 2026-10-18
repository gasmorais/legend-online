package mainBar.vicePassword
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ChangeVPView extends Frame
   {
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg:MovieClip;
      
      private var _submitButton:BaseButton;
      
      private var _cancelButton:BaseButton;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _txt4:FilterFrameText;
      
      private var _c:Sprite;
      
      private var _btnReset:BtnResetVp;
      
      public function ChangeVPView()
      {
         super();
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         _c = new Sprite();
         _c.x = -22;
         _c.y = -6;
         this.addToContent(_c);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.back");
         _c.addChild(_bg1);
         _bg = ComponentFactory.Instance.creat("asset.vicepassword.bgchange");
         _c.addChild(_bg);
         this.titleText = LanguageMgr.GetTranslation("mainBar.vicePassword.changeviewtitle");
         _submitButton = ComponentFactory.Instance.creat("vicepassword.AlertButtonConfirm_2");
         _c.addChild(_submitButton);
         _cancelButton = ComponentFactory.Instance.creat("vicepassword.AlertButtonCancel_2");
         _c.addChild(_cancelButton);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.change.p1");
         _c.addChild(_txt1);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.change.p2");
         _c.addChild(_txt2);
         _txt3 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.change.p3");
         _c.addChild(_txt3);
         _txt4 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.p3");
         _c.addChild(_txt4);
         _txt1.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         _txt2.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         _txt3.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         _txt4.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewdes");
         _btnReset = ComponentFactory.Instance.creatComponentByStylename("vicepassword.btnReset");
         _c.addChild(_btnReset);
         StageReferance.stage.focus = _txt1;
         _txt1.setSelection(0,_txt1.length);
         _txt1.tabIndex = 0;
         _txt2.tabEnabled = true;
         _txt2.tabIndex = 1;
         _txt3.tabEnabled = true;
         _txt3.tabIndex = 2;
         _txt1.maxChars = 6;
         _txt2.maxChars = 6;
         _txt3.maxChars = 6;
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__frameResponse);
         _submitButton.addEventListener("click",__confirmClick);
         _cancelButton.addEventListener("click",__cancelClick);
         _txt1.addEventListener("click",txt1ClickHandler);
         _txt2.addEventListener("click",txt2ClickHandler);
         _txt3.addEventListener("click",txt3ClickHandler);
         _btnReset.addEventListener("click",resetClickHandler);
         _txt1.addEventListener("change",txt1ChangeHandler);
         _txt2.addEventListener("change",txt2ChangeHandler);
         _txt3.addEventListener("change",txt3ChangeHandler);
         MsgMan.addObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT",this,opSuccess);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameResponse);
         _submitButton.removeEventListener("click",__confirmClick);
         _cancelButton.removeEventListener("click",__cancelClick);
         _txt1.removeEventListener("click",txt1ClickHandler);
         _txt2.removeEventListener("click",txt2ClickHandler);
         _txt3.removeEventListener("click",txt3ClickHandler);
         _btnReset.removeEventListener("click",resetClickHandler);
         _txt1.removeEventListener("change",txt1ChangeHandler);
         _txt2.removeEventListener("change",txt2ChangeHandler);
         _txt3.removeEventListener("change",txt3ChangeHandler);
         MsgMan.removeObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT",this,opSuccess);
      }
      
      private function opSuccess(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      protected function txt1ChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         _txt1.displayAsPassword = true;
         if(VicePasswordUtil.numCheck(_txt1.text) == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description8");
            MessageTipManager.instance().show(_loc2_);
         }
         else if(VicePasswordUtil.numCheck(_txt1.text) == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description9");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      protected function txt2ChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         _txt2.displayAsPassword = true;
         if(VicePasswordUtil.numCheck(_txt2.text) == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description8");
            MessageTipManager.instance().show(_loc2_);
         }
         else if(VicePasswordUtil.numCheck(_txt2.text) == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description9");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      protected function txt3ChangeHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         _txt3.displayAsPassword = true;
         if(VicePasswordUtil.numCheck(_txt3.text) == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description8");
            MessageTipManager.instance().show(_loc2_);
         }
         else if(VicePasswordUtil.numCheck(_txt3.text) == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description9");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      protected function __clickHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.vicepassword.HelpFrame");
         _loc2_["show"]();
      }
      
      private function resetClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = LanguageMgr.GetTranslation("vicepassword.description5");
         SimpleAlertHelper.instance.data = [confirmReset];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true);
      }
      
      private function confirmReset(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            VicePasswordUtil.vpOp(VicePasswordUtil.RESET_PW);
            dispose();
         }
      }
      
      private function txt1ClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         if(_txt1.text == _loc2_)
         {
            _txt1.text = "";
            _txt1.displayAsPassword = true;
         }
      }
      
      private function txt2ClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         if(_txt2.text == _loc2_)
         {
            _txt2.text = "";
            _txt2.displayAsPassword = true;
         }
      }
      
      private function txt3ClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         if(_txt3.text == _loc2_)
         {
            _txt3.text = "";
            _txt3.displayAsPassword = true;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
               break;
            case 2:
               __confirmClick(null);
               break;
            default:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function __cancelClick(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         SoundManager.instance.play("022");
         if(_txt1.text == LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes") || _txt1.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description15");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_txt2.text == LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes") || _txt2.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description14");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_txt3.text == LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes") || _txt3.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description13");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(VicePasswordUtil.strCheck(_txt3.text) && VicePasswordUtil.strCheck(_txt2.text))
         {
            if(_txt3.text != _txt2.text)
            {
               _loc2_ = LanguageMgr.GetTranslation("vicepassword.description7");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(VicePasswordUtil.numCheckSame(_txt3.text) || VicePasswordUtil.numCheckSame(_txt2.text))
            {
               _loc2_ = LanguageMgr.GetTranslation("vicepassword.description111");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(VicePasswordUtil.numCheckContinuity(_txt3.text) || VicePasswordUtil.numCheckContinuity(_txt2.text))
            {
               _loc2_ = LanguageMgr.GetTranslation("vicepassword.description112");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_txt3.text == _txt2.text)
            {
               VicePasswordUtil.vpOp(VicePasswordUtil.CHANGE_PW,_txt2.text,_txt3.text,_txt1.text);
               return;
            }
            return;
         }
         _loc2_ = LanguageMgr.GetTranslation("vicepassword.description6");
         MessageTipManager.instance().show(_loc2_);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_txt2);
         _txt2 = null;
         ObjectUtils.disposeObject(_txt3);
         _txt3 = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_submitButton);
         _submitButton = null;
         ObjectUtils.disposeObject(_cancelButton);
         _cancelButton = null;
         ObjectUtils.disposeObject(_btnReset);
         _btnReset = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

