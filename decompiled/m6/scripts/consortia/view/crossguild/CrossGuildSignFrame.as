package consortia.view.crossguild
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import consortia.view.crossguild.view.CrossGuildRankFrame;
   import consortia.view.crossguild.view.CrossGuildSignItem;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class CrossGuildSignFrame extends Frame
   {
      
      private var _timeText:FilterFrameText;
      
      private var _signNeedText:FilterFrameText;
      
      private var _selectImage:Image;
      
      private var _mBack:MutipleImage;
      
      private var _signBtn:IconButton;
      
      private var _hasSignBtn:IconButton;
      
      private var _rewardBtn:BaseButton;
      
      private var _policyBtn:BaseButton;
      
      private var _numbit:BitmapData;
      
      private var _seasonContiner:Component;
      
      private var _itemBox:VBox;
      
      private var _signAlertText:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var needWealth:int;
      
      private var selectIndex:int;
      
      public function CrossGuildSignFrame()
      {
         super();
         initView();
         initItemView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _timeText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.timeText");
         _signNeedText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.signNeedText");
         _selectImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.selectImage");
         _mBack = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.mBack");
         _signBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.signBtn");
         _rewardBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.rewardBtn");
         _policyBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.policyBtn");
         _itemBox = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.itemBox");
         _signAlertText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSignFrame.signAlertText");
         _numbit = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildSignFrame.numbitmap");
         _seasonContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSignFrame.seasonContiner");
         _hasSignBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSignFrame.hasSignBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.HelpBtn");
         _helpBtn.tipData = LanguageMgr.GetTranslation("CrossGuild.helpBtn.tipData");
         addToContent(_helpBtn);
         _helpBtn.x = 465;
         _helpBtn.y = 10;
         addToContent(_mBack);
         addToContent(_seasonContiner);
         addToContent(_timeText);
         addToContent(_itemBox);
         addToContent(_selectImage);
         addToContent(_signNeedText);
         addToContent(_signBtn);
         addToContent(_hasSignBtn);
         addToContent(_policyBtn);
         addToContent(_rewardBtn);
         addToContent(_signAlertText);
         _hasSignBtn.enable = false;
         _hasSignBtn.visible = false;
         needWealth = ConfigInfoManager.instance.getCrossGuildSignWealth();
      }
      
      private function initItemView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CrossGuildSignItem = null;
         _loc2_ = 1;
         while(_loc2_ <= 1)
         {
            _loc1_ = new CrossGuildSignItem();
            _itemBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _policyBtn.addEventListener("click",_policyBtnClickHandler);
         _rewardBtn.addEventListener("click",_rewardBtnClickHandler);
         _signBtn.addEventListener("click",_signBtnClickHandler);
         MsgMan.addObserver("CROSS_GUILD_MAIN_CHANGE",this,__mainInfoChangeHandler);
         _helpBtn.addEventListener("click",__helpClickHandler);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_policyBtn)
         {
            _policyBtn.removeEventListener("click",_policyBtnClickHandler);
         }
         if(_rewardBtn)
         {
            _rewardBtn.removeEventListener("click",_rewardBtnClickHandler);
         }
         if(_signBtn)
         {
            _signBtn.removeEventListener("click",_signBtnClickHandler);
         }
         MsgMan.removeObserver("CROSS_GUILD_MAIN_CHANGE",this,__mainInfoChangeHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.helperFrame");
         _loc2_.show();
      }
      
      private function __mainInfoChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function _policyBtnClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("crossguild",2);
      }
      
      private function _rewardBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildRankFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildRankFrame");
         _loc2_.show();
      }
      
      private function _signBtnClickHandler(param1:MouseEvent) : void
      {
         CrossGuildManager.instance.sendCrossGuildSign(1);
      }
      
      private function refreshView() : void
      {
         var _loc1_:String = LanguageMgr.GetTranslation("public.dateType",model.signEndTime.fullYear,model.signEndTime.month + 1,model.signEndTime.date);
         _timeText.text = LanguageMgr.GetTranslation("CrossGuildSignFrame.timeText.text",_loc1_);
         _signNeedText.text = LanguageMgr.GetTranslation("CrossGuildSignFrame.signNeedText.text",needWealth);
         NumberViewUtils.refreshValue(model.season,_seasonContiner,_numbit,23,28,16,23,"0123456789");
         _seasonContiner.x = model.season > 9 ? 173 : 188;
         if(model.state == 1)
         {
            _signAlertText.text = LanguageMgr.GetTranslation("CrossGuildSignFrame.signAlertText.text",DateFormatter.transDate(model.signStartTime.time / 1000));
         }
         else
         {
            _signAlertText.text = "";
         }
         _signBtn.enable = ConsortiaManager.instance.model.consortiaInfo.chairmanID == playerInfo.userId || Boolean(FrameControllerManager.instance.consortiaController.getRightsByNum(20));
         if(model.signType)
         {
            _signBtn.visible = false;
            _hasSignBtn.visible = true;
         }
         else
         {
            _signBtn.visible = true;
            _hasSignBtn.visible = false;
         }
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
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_crossgvg");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_timeText);
         _timeText = null;
         ObjectUtils.disposeObject(_signNeedText);
         _signNeedText = null;
         ObjectUtils.disposeObject(_selectImage);
         _selectImage = null;
         ObjectUtils.disposeObject(_mBack);
         _mBack = null;
         ObjectUtils.disposeObject(_signBtn);
         _signBtn = null;
         ObjectUtils.disposeObject(_rewardBtn);
         _rewardBtn = null;
         ObjectUtils.disposeObject(_policyBtn);
         _policyBtn = null;
         ObjectUtils.disposeObject(_numbit);
         _numbit = null;
         ObjectUtils.disposeObject(_seasonContiner);
         _seasonContiner = null;
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_signAlertText);
         _signAlertText = null;
         ObjectUtils.disposeObject(_hasSignBtn);
         _hasSignBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         super.dispose();
      }
   }
}

