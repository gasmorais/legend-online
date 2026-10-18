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
   import yishi.view.tips.MessageTipManager;
   
   public class ConfirmVPView extends Frame
   {
      
      private var _txt1:FilterFrameText;
      
      private var _submitButton:BaseButton;
      
      private var _cancelButton:BaseButton;
      
      private var _c:Sprite;
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg:MovieClip;
      
      public function ConfirmVPView()
      {
         super();
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         titleText = LanguageMgr.GetTranslation("mainBar.vicePassword.checkviewtitle");
         _c = new Sprite();
         _c.x = -31;
         _c.y = -13;
         this.addToContent(_c);
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.backcheck");
         _c.addChild(_bg1);
         _bg = ComponentFactory.Instance.creat("asset.vicepassword.bgcheck");
         _c.addChild(_bg);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.confirm.p1");
         _c.addChild(_txt1);
         _txt1.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         _submitButton = ComponentFactory.Instance.creat("vicepassword.checkAlertButtonConfirm_2");
         _c.addChild(_submitButton);
         _cancelButton = ComponentFactory.Instance.creat("vicepassword.checkAlertButtonCancel_2");
         _c.addChild(_cancelButton);
         StageReferance.stage.focus = _txt1;
         _txt1.setSelection(0,_txt1.length);
         _txt1.maxChars = 6;
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__frameResponse);
         _submitButton.addEventListener("click",__confirmClick);
         _cancelButton.addEventListener("click",__cancelClick);
         _txt1.addEventListener("click",txt1ClickHandler);
         _txt1.addEventListener("change",txt1ChangeHandler);
         MsgMan.addObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT",this,opSuccess);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameResponse);
         _submitButton.removeEventListener("click",__confirmClick);
         _cancelButton.removeEventListener("click",__cancelClick);
         _txt1.removeEventListener("click",txt1ClickHandler);
         _txt1.removeEventListener("change",txt1ChangeHandler);
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
      
      private function txt1ClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         if(_txt1.text == _loc2_)
         {
            _txt1.text = "";
            _txt1.displayAsPassword = true;
         }
      }
      
      private function __confirmClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(param1 != null)
         {
            param1.stopPropagation();
            param1.stopImmediatePropagation();
         }
         SoundManager.instance.play("022");
         if(_txt1.text == LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes"))
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description12");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(VicePasswordUtil.strCheck(_txt1.text))
         {
            VicePasswordUtil.vpOp(VicePasswordUtil.CHECK_PW,_txt1.text);
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description6");
            MessageTipManager.instance().show(_loc2_);
         }
      }
      
      private function __cancelClick(param1:MouseEvent) : void
      {
         dispose();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_submitButton);
         _submitButton = null;
         ObjectUtils.disposeObject(_cancelButton);
         _cancelButton = null;
         ObjectUtils.disposeObject(_txt1);
         _txt1 = null;
         ObjectUtils.disposeObject(_c);
         _c = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg1);
         _bg1 = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

