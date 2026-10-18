package consortia.view.myConsortia.newui
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.myConsortia.chairmanElection.ElectionFrame;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ConsortiaControler;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   
   public class ConsortiaInfoView extends Component
   {
      
      private var _lvlContiner:Component;
      
      private var _numBitmap:BitmapData;
      
      private var _noticeText:FilterFrameText;
      
      private var _prestigeText:FilterFrameText;
      
      private var _selfGainText:FilterFrameText;
      
      private var _maintainValueTxt:FilterFrameText;
      
      private var _assetsText:FilterFrameText;
      
      private var _warthText:FilterFrameText;
      
      private var _wealthTxt:FilterFrameText;
      
      private var _numText:FilterFrameText;
      
      private var _rankText:FilterFrameText;
      
      private var _chairmanText:FilterFrameText;
      
      private var _consortiaNameText:FilterFrameText;
      
      private var _infoBg:MutipleImage;
      
      private var _publishBtn:BaseButton;
      
      private var _activeRewardView:ConsortiaActiveRewardView;
      
      private var _donateBtn:IconButton;
      
      private var _impeachBtn:TextButton;
      
      private var electionFrame:ElectionFrame;
      
      private var _txtDiscriptionChange:String = "";
      
      public function ConsortiaInfoView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _numBitmap = ComponentFactory.Instance.creatBitmapData("asset.ConsortiaInfoView.numBitmap");
         _lvlContiner = ComponentFactory.Instance.creatComponentByStylename("ConsortiaInfoView.lvlContiner");
         _noticeText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.noticeText");
         _prestigeText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.prestigeText");
         _selfGainText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.selfGainText");
         _maintainValueTxt = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.maintainValueTxt");
         _assetsText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.assetsText");
         _warthText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.warthText");
         _wealthTxt = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.wealthTxt");
         _numText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.numText");
         _rankText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.rankText");
         _chairmanText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.chairmanText");
         _consortiaNameText = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.consortiaNameText");
         _infoBg = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.infoBg");
         _publishBtn = ComponentFactory.Instance.creatComponentByStylename("Consortia.ConsortiaInfoView.publishBtn");
         _donateBtn = ComponentFactory.Instance.creatComponentByStylename("ConsortiaInfoView.consortiaDonateBtn");
         _impeachBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.impeachButton");
         _activeRewardView = ComponentFactory.Instance.creatCustomObject("ConsortiaInfoView.activeRewardView");
         addChild(_infoBg);
         addChild(_lvlContiner);
         addChild(_consortiaNameText);
         addChild(_chairmanText);
         addChild(_rankText);
         addChild(_numText);
         addChild(_wealthTxt);
         addChild(_warthText);
         addChild(_assetsText);
         addChild(_maintainValueTxt);
         addChild(_selfGainText);
         addChild(_prestigeText);
         addChild(_noticeText);
         addChild(_publishBtn);
         _publishBtn.enable = false;
         addChild(_donateBtn);
         addChild(_impeachBtn);
         _impeachBtn.visible = false;
         addChild(_activeRewardView);
         _impeachBtn.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaActivityPage.impeach");
         _noticeText.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.pronouncement");
         _noticeText.maxChars = 200;
      }
      
      private function addEvent() : void
      {
         _publishBtn.addEventListener("click",__publishBtnClickHandler);
         _donateBtn.addEventListener("click",__donateBtnHandler);
         _impeachBtn.addEventListener("click",__impeachBtnClickHandler);
         _noticeText.addEventListener("focusIn",__onFocusInHandler);
         _noticeText.addEventListener("focusOut",__onFocusOutHandler);
         _noticeText.addEventListener("change",__onDiscriptionChangeHandler);
         _noticeText.addEventListener("keyDown",__keyDownHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function removeEvent() : void
      {
         if(_publishBtn)
         {
            _publishBtn.removeEventListener("click",__publishBtnClickHandler);
         }
         if(_donateBtn)
         {
            _donateBtn.removeEventListener("click",__donateBtnHandler);
         }
         if(_impeachBtn)
         {
            _impeachBtn.removeEventListener("click",__impeachBtnClickHandler);
         }
         if(_noticeText)
         {
            _noticeText.removeEventListener("focusIn",__onFocusInHandler);
         }
         if(_noticeText)
         {
            _noticeText.removeEventListener("focusOut",__onFocusOutHandler);
         }
         if(_noticeText)
         {
            _noticeText.removeEventListener("change",__onDiscriptionChangeHandler);
         }
         if(_noticeText)
         {
            _noticeText.removeEventListener("keyDown",__keyDownHandler);
         }
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdata);
      }
      
      private function __onConsortiaInfoUpdata(param1:Event) : void
      {
         refreshView();
      }
      
      private function __impeachBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.consortiaController.getVotingUserInfos();
         electionFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.ElectionFrame");
         electionFrame.show();
      }
      
      private function __donateBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.showContributeFrame();
      }
      
      private function __publishBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.consortiaController.modifyConsortiaPlacard(_noticeText.text);
         _publishBtn.enable = false;
      }
      
      private function __onFocusInHandler(param1:FocusEvent) : void
      {
         IMEManager.enable();
         _publishBtn.enable = true;
      }
      
      private function __onFocusOutHandler(param1:FocusEvent) : void
      {
      }
      
      private function __keyDownHandler(param1:KeyboardEvent) : void
      {
         param1.stopPropagation();
      }
      
      private function __onDiscriptionChangeHandler(param1:Event) : void
      {
         if(_noticeText.textHeight > 85)
         {
            _noticeText.text = _txtDiscriptionChange;
            StageReferance.stage.focus = _publishBtn;
         }
         _txtDiscriptionChange = _noticeText.text;
      }
      
      private function refreshView() : void
      {
         _publishBtn.enable = false;
         NumberViewUtils.refreshValue(consortiaInfo.levels,_lvlContiner,_numBitmap,24,33,16,24,"0123456789");
         _consortiaNameText.text = consortiaInfo.consortiaName;
         _chairmanText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.chairmanText.text",consortiaInfo.chairmanName);
         var _loc1_:String = consortiaInfo.orderInfo ? consortiaInfo.orderInfo.gradeOrder.toString() : LanguageMgr.GetTranslation("yishi.view.PlayerMenu.consortiaName");
         _rankText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.rankText.text",_loc1_);
         _numText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.numText.text",consortiaInfo.currentCount);
         _wealthTxt.text = LanguageMgr.GetTranslation("ConsortiaInfoView.wealthTxt.text",consortiaInfo.offer);
         _warthText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.warthText.text",model.emeDreamInfo.spirit);
         _assetsText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.assetsText.text",consortiaInfo.consortiaAsset);
         var _loc2_:String = consortiaInfo.levels * 500 + "/" + LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameTopView.maintenanceCostTxt.week");
         _maintainValueTxt.text = LanguageMgr.GetTranslation("ConsortiaInfoView.maintainValueTxt.text",_loc2_);
         _selfGainText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.selfGainText.text",playerInfo.consortiaOffer);
         _prestigeText.text = LanguageMgr.GetTranslation("ConsortiaInfoView.prestigeText.text",model.reputation);
         if(consortiaInfo.votingState == 4 || consortiaInfo.votingState == 3)
         {
            _impeachBtn.visible = true;
         }
         else
         {
            _impeachBtn.visible = false;
            electionFrame && electionFrame.dispose();
            electionFrame = null;
         }
         if(consortiaInfo.placard)
         {
            _noticeText.text = consortiaInfo.placard;
         }
         else
         {
            _noticeText.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.ConsortiaFrameRightContent.discription");
         }
         if(control.getRightsByIndex(3))
         {
            _noticeText.type = "input";
         }
         else
         {
            _noticeText.type = "dynamic";
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return model.consortiaInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get control() : ConsortiaControler
      {
         return FrameControllerManager.instance.consortiaController;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_noticeText);
         _noticeText = null;
         ObjectUtils.disposeObject(_prestigeText);
         _prestigeText = null;
         ObjectUtils.disposeObject(_selfGainText);
         _selfGainText = null;
         ObjectUtils.disposeObject(_maintainValueTxt);
         _maintainValueTxt = null;
         ObjectUtils.disposeObject(_assetsText);
         _assetsText = null;
         ObjectUtils.disposeObject(_warthText);
         _warthText = null;
         ObjectUtils.disposeObject(_wealthTxt);
         _wealthTxt = null;
         ObjectUtils.disposeObject(_numText);
         _numText = null;
         ObjectUtils.disposeObject(_rankText);
         _rankText = null;
         ObjectUtils.disposeObject(_chairmanText);
         _chairmanText = null;
         ObjectUtils.disposeObject(_consortiaNameText);
         _consortiaNameText = null;
         ObjectUtils.disposeObject(_infoBg);
         _infoBg = null;
         ObjectUtils.disposeObject(_publishBtn);
         _publishBtn = null;
         ObjectUtils.disposeObject(_donateBtn);
         _donateBtn = null;
         ObjectUtils.disposeObject(_impeachBtn);
         _impeachBtn = null;
         ObjectUtils.disposeObject(electionFrame);
         electionFrame = null;
         ObjectUtils.disposeObject(_numBitmap);
         _numBitmap = null;
         ObjectUtils.disposeObject(_lvlContiner);
         _lvlContiner = null;
         ObjectUtils.disposeObject(_activeRewardView);
         _activeRewardView = null;
         super.dispose();
      }
   }
}

