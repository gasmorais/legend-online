package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.events.PlayerEvent;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.NumberViewUtils;
   
   public class CrossGuildSeasonView extends Component
   {
      
      private var _stateBack:Bitmap;
      
      private var _stateText:FilterFrameText;
      
      private var _selfScoreText:FilterFrameText;
      
      private var _vsScoreText:FilterFrameText;
      
      private var _vsNameText:FilterFrameText;
      
      private var _seasonImage:ScaleFrameImage;
      
      private var _signTypeImage:ScaleFrameImage;
      
      private var _stateImage:ScaleFrameImage;
      
      private var _rankBtn:IconButton;
      
      private var _attackConrtibutionBtn:IconButton;
      
      private var _numbit:BitmapData;
      
      private var _numContiner1:Component;
      
      private var _numContiner2:Component;
      
      private var _numbit2:BitmapData;
      
      private var _seasonContiner:Component;
      
      public function CrossGuildSeasonView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _stateBack = ComponentFactory.Instance.creatBitmap("asset.CrossGuildSeasonView.stateBack");
         _stateText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.stateText");
         _selfScoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.selfScoreText");
         _vsScoreText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.vsScoreText");
         _vsNameText = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.vsNameText");
         _seasonImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.seasonImage");
         _signTypeImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.signTypeImage");
         _stateImage = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.stateImage");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.rankBtn");
         _attackConrtibutionBtn = ComponentFactory.Instance.creatComponentByStylename("CrossGuild.CrossGuildSeasonView.attackConrtibutionBtn");
         _numbit = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildSignItem.numbit");
         _numContiner1 = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSeasonView.numContiner1");
         _numContiner2 = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSeasonView.numContiner2");
         _numbit2 = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildSignFrame.numbitmap");
         _seasonContiner = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSeasonView.seasonContiner");
         addChild(_seasonImage);
         addChild(_stateBack);
         addChild(_stateImage);
         addChild(_seasonContiner);
         addChild(_signTypeImage);
         addChild(_numContiner1);
         addChild(_numContiner2);
         addChild(_stateText);
         addChild(_vsNameText);
         addChild(_vsScoreText);
         addChild(_selfScoreText);
         addChild(_attackConrtibutionBtn);
         addChild(_rankBtn);
      }
      
      private function addEvent() : void
      {
         _attackConrtibutionBtn.addEventListener("click",_attackConrtibutionBtnClickHandler);
         _rankBtn.addEventListener("click",_rankBtnClickHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_attackConrtibutionBtn)
         {
            _attackConrtibutionBtn.removeEventListener("click",_attackConrtibutionBtnClickHandler);
         }
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",_rankBtnClickHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateTimeHandler);
      }
      
      private function __updateTimeHandler(param1:PlayerEvent) : void
      {
         if(model.state == 2 || model.state == 4 || model.state == 6)
         {
            updateShowTime();
         }
      }
      
      private function _attackConrtibutionBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildAttackContributionFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildAttackContributionFrame");
         _loc2_.show();
      }
      
      private function _rankBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:CrossGuildRankFrame = ComponentFactory.Instance.creatComponentByStylename("crossguild.CrossGuildRankFrame");
         _loc2_.show();
      }
      
      public function refreshView() : void
      {
         if(model.vsGuild)
         {
            _vsNameText.text = model.vsGuild.consortiaName;
            _vsScoreText.text = model.vsGuild.score + "";
         }
         else
         {
            if(model.isBye)
            {
               _vsNameText.text = LanguageMgr.GetTranslation("svs.view.SvsFrame.svsInfoTipsTxt02");
            }
            else
            {
               _vsNameText.text = LanguageMgr.GetTranslation("fund.FundRewardView.getTime.line");
            }
            _vsScoreText.text = LanguageMgr.GetTranslation("fund.FundRewardView.getTime.line");
         }
         _selfScoreText.text = model.selfGuild.score + "";
         NumberViewUtils.refreshValue(model.season,_seasonContiner,_numbit2,23,28,18,23,"0123456789");
         _seasonContiner.x = model.season > 9 ? -10 : 0;
         refreshStateView();
      }
      
      private function refreshStateView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(model.signType == 0)
         {
            _signTypeImage.setFrame(1);
            _signTypeImage.y = 7;
            _numContiner1.visible = _numContiner2.visible = false;
         }
         else
         {
            _signTypeImage.setFrame(2);
            _signTypeImage.y = 9;
            _numContiner1.visible = _numContiner2.visible = true;
            NumberViewUtils.refreshValue(model.defendNum,_numContiner1,_numbit,18,20,11,18,"0123456789");
            NumberViewUtils.refreshValue(model.defendNum,_numContiner2,_numbit,18,20,11,18,"0123456789");
         }
         if(model.state == 1)
         {
            _seasonImage.setFrame(2);
            _seasonImage.y = 1;
            _stateImage.setFrame(1);
            _seasonContiner.visible = false;
            _signTypeImage.visible = false;
            _numContiner1.visible = _numContiner2.visible = false;
            _loc1_ = model.signStartTime.month + 1;
            _loc2_ = int(model.signStartTime.date);
            _stateText.text = LanguageMgr.GetTranslation("ConsortiaActivityListView.crossGuildAcitveItem.text1",_loc1_,_loc2_);
         }
         else
         {
            _seasonContiner.visible = true;
            _signTypeImage.visible = true;
            _seasonImage.setFrame(1);
            _seasonImage.y = 10;
            if(model.state == 3 || model.state == 5)
            {
               _stateImage.setFrame(1);
               _stateText.text = LanguageMgr.GetTranslation("CrossGuildSeasonView.stateText.text" + model.state);
            }
            else
            {
               _stateImage.setFrame(int(model.state / 2) + 1);
               updateShowTime();
            }
         }
      }
      
      private function updateShowTime() : void
      {
         var _loc3_:Number = (model.endTime.time - playerModel.sysCurtime.time) / 1000;
         var _loc2_:String = "";
         var _loc1_:String = "";
         if(_loc3_ <= 0)
         {
            _loc2_ = "00:00:00";
            _loc1_ = LanguageMgr.GetTranslation("CrossGuildSeasonView.stateText.text" + model.state);
         }
         else
         {
            _loc2_ = DateFormatter.getConsortiaCountDate(_loc3_);
            _loc1_ = LanguageMgr.GetTranslation("CrossGuildSeasonView.stateText.text" + model.state,_loc2_,model.fightIndex);
         }
         _stateText.htmlText = _loc1_;
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      private function get consorModel() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_stateBack);
         _stateBack = null;
         ObjectUtils.disposeObject(_stateText);
         _stateText = null;
         ObjectUtils.disposeObject(_selfScoreText);
         _selfScoreText = null;
         ObjectUtils.disposeObject(_vsScoreText);
         _vsScoreText = null;
         ObjectUtils.disposeObject(_vsNameText);
         _vsNameText = null;
         ObjectUtils.disposeObject(_seasonImage);
         _seasonImage = null;
         ObjectUtils.disposeObject(_signTypeImage);
         _signTypeImage = null;
         ObjectUtils.disposeObject(_stateImage);
         _stateImage = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_attackConrtibutionBtn);
         _attackConrtibutionBtn = null;
         ObjectUtils.disposeObject(_numbit);
         _numbit = null;
         ObjectUtils.disposeObject(_numContiner1);
         _numContiner1 = null;
         ObjectUtils.disposeObject(_numContiner2);
         _numContiner2 = null;
         ObjectUtils.disposeObject(_numbit2);
         _numbit2 = null;
         ObjectUtils.disposeObject(_seasonContiner);
         _seasonContiner = null;
         super.dispose();
      }
   }
}

