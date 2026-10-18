package mainBar.vicePassword
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
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
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.CustomerServiceManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SetVPView extends Frame
   {
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg:MovieClip;
      
      private var _submitButton:BaseButton;
      
      private var _cancelButton:BaseButton;
      
      private var _txt1:FilterFrameText;
      
      private var _txt2:FilterFrameText;
      
      private var _txt3:FilterFrameText;
      
      private var _c:Sprite;
      
      private var _serviceText:FilterFrameText;
      
      private var _firstRewardCon:Component;
      
      private var _rewardBack:Scale9CornerImage;
      
      private var _rewardText:FilterFrameText;
      
      private var _rewardHbox:HBox;
      
      public function SetVPView()
      {
         super();
         initUI();
         initRewardView();
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
         _bg = ComponentFactory.Instance.creat("asset.vicepassword.bgset");
         _c.addChild(_bg);
         this.titleText = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewtitle");
         _submitButton = ComponentFactory.Instance.creat("vicepassword.AlertButtonConfirm_2");
         _c.addChild(_submitButton);
         _cancelButton = ComponentFactory.Instance.creat("vicepassword.AlertButtonCancel_2");
         _c.addChild(_cancelButton);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.p1");
         _c.addChild(_txt1);
         _txt2 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.p2");
         _c.addChild(_txt2);
         _txt3 = ComponentFactory.Instance.creatComponentByStylename("vicepassword.p3");
         _c.addChild(_txt3);
         _txt1.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         _txt2.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes");
         _txt3.text = LanguageMgr.GetTranslation("mainBar.vicePassword.setviewdes");
         _serviceText = ComponentFactory.Instance.creatComponentByStylename("vicepassword.serviceText");
         _firstRewardCon = ComponentFactory.Instance.creatComponentByStylename("vicepassword.firstRewardCon");
         _rewardBack = ComponentFactory.Instance.creatComponentByStylename("vicepassword.rewardBack");
         _rewardText = ComponentFactory.Instance.creatComponentByStylename("vicepassword.rewardText");
         _rewardHbox = ComponentFactory.Instance.creatComponentByStylename("vicepassword.rewardHbox");
         _c.addChild(_firstRewardCon);
         _firstRewardCon.visible = playerInfo.needShowReward;
         _firstRewardCon.addChild(_rewardBack);
         _firstRewardCon.addChild(_rewardText);
         _firstRewardCon.addChild(_rewardHbox);
         _serviceText.htmlText = LanguageMgr.GetTranslation("mainBar.vicePassword.serviceText.text");
         _rewardText.text = LanguageMgr.GetTranslation("mainBar.vicePassword.rewardText.text");
         StageReferance.stage.focus = _txt1;
         _txt1.setSelection(0,_txt1.length);
         _txt1.tabEnabled = true;
         _txt1.tabIndex = 0;
         _txt2.tabEnabled = true;
         _txt2.tabIndex = 1;
         _txt1.maxChars = 6;
         _txt2.maxChars = 6;
      }
      
      private function initRewardView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         _rewardHbox.removeAllChild();
         var _loc2_:Array = ConfigInfoManager.instance.getFisrtChangeVPReward();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc2_[_loc3_].split(",")[0];
            _loc4_.count = _loc2_[_loc3_].split(",")[1];
            _loc1_.data = _loc4_;
            _rewardHbox.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function addEvents() : void
      {
         addEventListener("response",__frameResponse);
         _submitButton.addEventListener("click",__confirmClick);
         _cancelButton.addEventListener("click",__cancelClick);
         _txt1.addEventListener("click",txt1ClickHandler);
         _txt2.addEventListener("click",txt2ClickHandler);
         _txt1.addEventListener("change",txt1ChangeHandler);
         _txt2.addEventListener("change",txt2ChangeHandler);
         MsgMan.addObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT",this,opSuccess);
         _serviceText.addEventListener("click",_serviceClickHandler);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("response",__frameResponse);
         _submitButton.removeEventListener("click",__confirmClick);
         _cancelButton.removeEventListener("click",__cancelClick);
         _txt1.removeEventListener("click",txt1ClickHandler);
         _txt2.removeEventListener("click",txt2ClickHandler);
         _txt1.removeEventListener("change",txt1ChangeHandler);
         _txt2.removeEventListener("change",txt2ChangeHandler);
         MsgMan.removeObserver("yishi.datas.consant.VICE_PASSWORD_OP_SUCCESS_EVENT",this,opSuccess);
         _serviceText.removeEventListener("click",_serviceClickHandler);
      }
      
      private function _serviceClickHandler(param1:MouseEvent) : void
      {
         if(CustomerServiceManager.instance.model.canOpen)
         {
            FrameControllerManager.instance.openControllerByInfo("customerservice",null,6);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mainBar.SmallMapBar.customerservice"));
         }
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
      
      protected function __clickHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("core.vicepassword.HelpFrame");
         _loc2_["show"]();
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
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description12");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(_txt2.text == LanguageMgr.GetTranslation("mainBar.vicePassword.setviewinputdes") || _txt2.text == "")
         {
            _loc2_ = LanguageMgr.GetTranslation("vicepassword.description13");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(VicePasswordUtil.strCheck(_txt1.text) && VicePasswordUtil.strCheck(_txt2.text))
         {
            if(_txt1.text != _txt2.text)
            {
               _loc2_ = LanguageMgr.GetTranslation("vicepassword.description7");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(VicePasswordUtil.numCheckSame(_txt1.text) || VicePasswordUtil.numCheckSame(_txt2.text))
            {
               _loc2_ = LanguageMgr.GetTranslation("vicepassword.description111");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(VicePasswordUtil.numCheckContinuity(_txt1.text) || VicePasswordUtil.numCheckContinuity(_txt2.text))
            {
               _loc2_ = LanguageMgr.GetTranslation("vicepassword.description112");
               MessageTipManager.instance().show(_loc2_);
               return;
            }
            if(_txt1.text == _txt2.text)
            {
               VicePasswordUtil.vpOp(VicePasswordUtil.SET_PW,_txt1.text,_txt2.text);
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
         ObjectUtils.disposeObject(_serviceText);
         _serviceText = null;
         ObjectUtils.disposeObject(_rewardBack);
         _rewardBack = null;
         ObjectUtils.disposeObject(_firstRewardCon);
         _firstRewardCon = null;
         ObjectUtils.disposeObject(_rewardText);
         _rewardText = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

