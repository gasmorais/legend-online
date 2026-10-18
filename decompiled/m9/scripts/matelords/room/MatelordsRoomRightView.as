package matelords.room
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.MatelordsEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.matelords.MatelordsModel;
   import mvc.module.matelords.MatelordsPlayerInfo;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.MatelordsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MatelordsRoomRightView extends Sprite implements Disposeable
   {
      
      private var _groupBtn1:SelectedIconButton;
      
      private var _groupBtn2:SelectedIconButton;
      
      private var _groupBtn3:SelectedIconButton;
      
      private var _groupBtn4:SelectedIconButton;
      
      private var _groupSelectedGroup:SelectedButtonGroup;
      
      private var _bg:MutipleImage;
      
      private var _rankTitleTxt:FilterFrameText;
      
      private var _nameTitleTxt:FilterFrameText;
      
      private var _winTitleTxt:FilterFrameText;
      
      private var _selfRankTxt:FilterFrameText;
      
      private var _selfScoreText:FilterFrameText;
      
      private var _teamTypeText:FilterFrameText;
      
      private var _rankListPanel:ListPanel;
      
      private var _teamSortBtn:IconButton;
      
      private var _inspireBtn:IconButton;
      
      private var _inspireBitmap:Bitmap;
      
      private var _inspireContainer:Sprite;
      
      private var _rightBottomView:ScaleBitmapImage;
      
      private var _demonBtn:BaseButton;
      
      private var _demonScoreBg:ScaleBitmapImage;
      
      private var _demonScoreText:FilterFrameText;
      
      private var imspireCost:int = ConfigInfoManager.instance.getMatelordsInspireCost();
      
      private var _model:MatelordsModel = MatelordsManager.instance.model;
      
      private var scoreArr:Array = [0,0,0,0];
      
      public function MatelordsRoomRightView()
      {
         scoreArr = ConfigInfoManager.instance.getMatelordsTeamSorce();
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _groupBtn1 = ComponentFactory.Instance.creatComponentByStylename("matelords.matelordsroom.GroupBtn1");
         _groupBtn2 = ComponentFactory.Instance.creatComponentByStylename("matelords.matelordsroom.GroupBtn2");
         _groupBtn3 = ComponentFactory.Instance.creatComponentByStylename("matelords.matelordsroom.GroupBtn3");
         _groupBtn4 = ComponentFactory.Instance.creatComponentByStylename("matelords.matelordsroom.GroupBtn4");
         _bg = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomRightBg");
         _rankTitleTxt = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.FinalRoomRightRankTitleTxt");
         _nameTitleTxt = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomRightNameTitleTxt");
         _winTitleTxt = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomRightWinTitleTxt");
         _selfRankTxt = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.RoomRightSelfRankTxt");
         _selfScoreText = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomRightSelfWinCountTxt");
         _teamTypeText = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.teamTypeText");
         _rankListPanel = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalRoomRightRankListPanel");
         _rightBottomView = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.rightBottomView");
         _teamSortBtn = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalTeamSortBtn");
         _inspireBtn = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.FinalInspireBtn");
         _inspireBitmap = ComponentFactory.Instance.creatBitmap("asset.matelords.InspireBitmap");
         _inspireContainer = ComponentFactory.Instance.creatCustomObject("matelords.inspireContainer");
         _inspireBtn.addChild(_inspireContainer);
         _demonBtn = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.demonBtn");
         _demonScoreBg = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.demonScoreBg");
         _demonScoreText = ComponentFactory.Instance.creatComponentByStylename("matelordsroom.demonScoreText");
         _rankTitleTxt.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.contribution.ConsortiaContributeFrame.rankingTxtText");
         _nameTitleTxt.text = LanguageMgr.GetTranslation("matelords.room.MatelordsFinalRoomRightView.teamTitle");
         _winTitleTxt.text = LanguageMgr.GetTranslation("matelords.room.MatelordsFinalRoomRightView.winTitle");
         addChild(_groupBtn1);
         addChild(_groupBtn2);
         addChild(_groupBtn3);
         addChild(_groupBtn4);
         addChild(_bg);
         addChild(_rankTitleTxt);
         addChild(_nameTitleTxt);
         addChild(_winTitleTxt);
         addChild(_selfRankTxt);
         addChild(_selfScoreText);
         addChild(_teamTypeText);
         addChild(_rankListPanel);
         addChild(_rightBottomView);
         addChild(_teamSortBtn);
         addChild(_inspireBtn);
         addChild(_demonBtn);
         addChild(_demonScoreBg);
         addChild(_demonScoreText);
         _groupSelectedGroup = new SelectedButtonGroup();
         _groupSelectedGroup.addSelectItem(_groupBtn1);
         _groupSelectedGroup.addSelectItem(_groupBtn2);
         _groupSelectedGroup.addSelectItem(_groupBtn3);
         _groupSelectedGroup.addSelectItem(_groupBtn4);
         _groupSelectedGroup.selectIndex = _model.teamType - 1;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankTitleTxt);
         _rankTitleTxt = null;
         ObjectUtils.disposeObject(_nameTitleTxt);
         _nameTitleTxt = null;
         ObjectUtils.disposeObject(_winTitleTxt);
         _winTitleTxt = null;
         ObjectUtils.disposeObject(_selfRankTxt);
         _selfRankTxt = null;
         ObjectUtils.disposeObject(_selfScoreText);
         _selfScoreText = null;
         ObjectUtils.disposeObject(_rankListPanel);
         _rankListPanel = null;
         ObjectUtils.disposeObject(_teamSortBtn);
         _teamSortBtn = null;
         ObjectUtils.disposeObject(_inspireBtn);
         _inspireBtn = null;
         ObjectUtils.disposeObject(_inspireBitmap);
         _inspireBitmap = null;
         ObjectUtils.disposeObject(_inspireContainer);
         _inspireContainer = null;
         ObjectUtils.disposeObject(_teamTypeText);
         _teamTypeText = null;
         ObjectUtils.disposeObject(_groupBtn1);
         _groupBtn1 = null;
         ObjectUtils.disposeObject(_groupBtn2);
         _groupBtn2 = null;
         ObjectUtils.disposeObject(_groupBtn3);
         _groupBtn3 = null;
         ObjectUtils.disposeObject(_groupBtn4);
         _groupBtn4 = null;
         ObjectUtils.disposeObject(_demonBtn);
         _demonBtn = null;
         ObjectUtils.disposeObject(_demonScoreBg);
         _demonScoreBg = null;
         ObjectUtils.disposeObject(_demonScoreText);
         _demonScoreText = null;
         ObjectUtils.disposeAllChildren(this);
         _groupSelectedGroup = null;
      }
      
      private function addEvent() : void
      {
         _teamSortBtn.addEventListener("click",__teamSortBtnClickHandler);
         _inspireBtn.addEventListener("click",__inspireBtnClickHandler);
         _demonBtn.addEventListener("click",__demonBtnClickHandler);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.addEventListener("change",__onTabBtnHandler);
         }
         _model.addEventListener("DEMON_SCORE_UPDATE",__updateDemonScoreHandler);
      }
      
      private function removeEvent() : void
      {
         _teamSortBtn.removeEventListener("click",__teamSortBtnClickHandler);
         _inspireBtn.removeEventListener("click",__inspireBtnClickHandler);
         _demonBtn.removeEventListener("click",__demonBtnClickHandler);
         if(_groupSelectedGroup)
         {
            _groupSelectedGroup.removeEventListener("change",__onTabBtnHandler);
         }
         _model.removeEventListener("DEMON_SCORE_UPDATE",__updateDemonScoreHandler);
      }
      
      private function __updateDemonScoreHandler(param1:MatelordsEvent) : void
      {
         _demonScoreText.text = LanguageMgr.GetTranslation("MatelordsDemonShopFrame.demonScoreText.text",_model.altarScore);
      }
      
      private function __onTabBtnHandler(param1:Event) : void
      {
         refresh();
      }
      
      private function __teamSortBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("teammanager","MATELORDS_SORT_FRAME");
      }
      
      private function __demonBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("matelords",3);
      }
      
      private function __inspireBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc5_:String = null;
         if(_model.currentTurn >= _model.maxTurnCount)
         {
            _loc5_ = LanguageMgr.GetTranslation("matelordsroom.MatelordsInspireBtn.TipTxt03");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         if(_model.inspirLevel >= 10)
         {
            _loc5_ = LanguageMgr.GetTranslation("matelordsroom.MatelordsInspireBtn.TipTxt02");
            MessageTipManager.instance().show(_loc5_);
            return;
         }
         SoundManager.instance.play("022");
         _loc5_ = LanguageMgr.GetTranslation("matelordsroom.MatelordsInspireBtn.TipTxt01",imspireCost);
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [inspireCallBack];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function inspireCallBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point < imspireCost)
            {
               RechargeAlertMannager.show();
               return;
            }
            MatelordsManager.instance.matelordsInspire();
         }
      }
      
      public function refresh() : void
      {
         _rankListPanel.vectorListModel.clear();
         for each(var _loc3_:MatelordsPlayerInfo in showList)
         {
            _rankListPanel.vectorListModel.append(_loc3_);
         }
         var _loc2_:int = int(_groupSelectedGroup.selectIndex);
         _selfRankTxt.visible = _selfScoreText.visible = true;
         var _loc1_:String = LanguageMgr.GetTranslation("MatelordsFinalRoomRightView.selfRank.teamType" + _model.teamType);
         _selfRankTxt.text = LanguageMgr.GetTranslation("matelords.room.MatelordsFinalRoomRightView.selfRank",_loc1_);
         _selfScoreText.text = LanguageMgr.GetTranslation("matelords.room.MatelordsFinalRoomRightView.selfWinCount",_model.totalScore);
         _teamTypeText.text = LanguageMgr.GetTranslation("MatelordsRankFrame.teamTypeText.text" + _loc2_,scoreArr[_loc2_]);
         if(_model.inspirLevel < 10)
         {
            _inspireContainer.x = 60;
         }
         else
         {
            _inspireContainer.x = 60;
         }
         NumberViewUtils.getNumberView(_model.inspirLevel,_inspireContainer,_inspireBitmap.bitmapData,13,21,13,13,"0123456789",1);
         _demonScoreText.text = LanguageMgr.GetTranslation("MatelordsDemonShopFrame.demonScoreText.text",_model.altarScore);
      }
      
      private function get showList() : Array
      {
         var _loc1_:Array = [];
         for each(var _loc2_:MatelordsPlayerInfo in _model.roomRankList)
         {
            if(_loc2_.teamType == _groupSelectedGroup.selectIndex + 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc1_.sortOn("curOrder",16);
         return _loc1_;
      }
      
      public function setTabByGroup() : void
      {
         refresh();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

