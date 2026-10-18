package godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GodsEveningEvent;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.godsevening.GodsEveningModel;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class GEMainView extends Sprite implements Disposeable
   {
      
      private var _title:MutipleImage;
      
      private var _openTips:MovieClip;
      
      private var _yearSprite:Sprite;
      
      private var _mouthSprite:Sprite;
      
      private var _daySprite:Sprite;
      
      private var _startHourSprite:Sprite;
      
      private var _startMinuteSprite:Sprite;
      
      private var _timeNumBmdGold:BitmapData;
      
      private var _vsImage:Image;
      
      public var _team1:GradientText;
      
      public var _team2:GradientText;
      
      public var _team3:GradientText;
      
      private var _enterBtn:IconButton;
      
      private var _shopBtn:BaseButton;
      
      private var _rankBtn:IconButton;
      
      private var _checkRewardBtn:IconButton;
      
      private var _helpBtn:IconButton;
      
      private var _closeImage:Image;
      
      public function GEMainView()
      {
         super();
         initView();
         addEvent();
         GodsEveningManager.instance.sendRequestMainFrameInfo();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.Tittle");
         _openTips = ComponentFactory.Instance.creatCustomObject("GEMainFrame.OpenTips");
         _yearSprite = ComponentFactory.Instance.creatCustomObject("GEMainFrame.YearSprite");
         _mouthSprite = ComponentFactory.Instance.creatCustomObject("GEMainFrame.MouthSprite");
         _daySprite = ComponentFactory.Instance.creatCustomObject("GEMainFrame.DaySprite");
         _startHourSprite = ComponentFactory.Instance.creatCustomObject("GEMainFrame.StartHourSprite");
         _startMinuteSprite = ComponentFactory.Instance.creatCustomObject("GEMainFrame.StartMinuteSprite");
         _timeNumBmdGold = ComponentFactory.Instance.creatBitmapData("asset.GEMainFrame.timeNumBmdGold");
         _vsImage = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.VsImage");
         _team1 = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.TeamA");
         _team2 = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.TeamB");
         _team3 = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.TeamC");
         _enterBtn = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.enterBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.shopBtn");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.rankBtn");
         _checkRewardBtn = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.checkRewardBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.helpBtn");
         _closeImage = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.closeImage");
         addChild(_title);
         addChild(_openTips);
         addChild(_yearSprite);
         addChild(_mouthSprite);
         addChild(_daySprite);
         addChild(_startHourSprite);
         addChild(_startMinuteSprite);
         addChild(_vsImage);
         addChild(_team1);
         addChild(_team2);
         addChild(_team3);
         addChild(_enterBtn);
         addChild(_shopBtn);
         addChild(_rankBtn);
         addChild(_checkRewardBtn);
         addChild(_helpBtn);
         addChild(_closeImage);
         _closeImage.visible = false;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_openTips);
         _openTips = null;
         ObjectUtils.disposeAllChildren(_yearSprite);
         ObjectUtils.disposeObject(_yearSprite);
         _yearSprite = null;
         ObjectUtils.disposeAllChildren(_mouthSprite);
         ObjectUtils.disposeObject(_mouthSprite);
         _mouthSprite = null;
         ObjectUtils.disposeAllChildren(_daySprite);
         ObjectUtils.disposeObject(_daySprite);
         _daySprite = null;
         ObjectUtils.disposeAllChildren(_startHourSprite);
         ObjectUtils.disposeObject(_startHourSprite);
         _startHourSprite = null;
         ObjectUtils.disposeAllChildren(_startMinuteSprite);
         ObjectUtils.disposeObject(_startMinuteSprite);
         _startMinuteSprite = null;
         ObjectUtils.disposeObject(_timeNumBmdGold);
         _timeNumBmdGold = null;
         ObjectUtils.disposeObject(_vsImage);
         _vsImage = null;
         ObjectUtils.disposeObject(_team1);
         _team1 = null;
         ObjectUtils.disposeObject(_team2);
         _team2 = null;
         ObjectUtils.disposeObject(_team3);
         _team3 = null;
         ObjectUtils.disposeObject(_enterBtn);
         _enterBtn = null;
         ObjectUtils.disposeObject(_shopBtn);
         _shopBtn = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_checkRewardBtn);
         _checkRewardBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_closeImage);
         _closeImage = null;
      }
      
      private function addEvent() : void
      {
         _enterBtn.addEventListener("click",__enterBtnClickHandler);
         _shopBtn.addEventListener("click",__shopBtnClickHandler);
         _rankBtn.addEventListener("click",__rankBtnClickHandler);
         _checkRewardBtn.addEventListener("click",__checkRewardBtnClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         GodsEveningManager.instance.addEventListener("MAIN_FRAME_INFO",__mainInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _enterBtn.removeEventListener("click",__enterBtnClickHandler);
         _shopBtn.removeEventListener("click",__shopBtnClickHandler);
         _rankBtn.removeEventListener("click",__rankBtnClickHandler);
         _checkRewardBtn.removeEventListener("click",__checkRewardBtnClickHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         GodsEveningManager.instance.removeEventListener("MAIN_FRAME_INFO",__mainInfoHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         unInitView();
      }
      
      private function __mainInfoHandler(param1:GodsEveningEvent) : void
      {
         refreshView();
      }
      
      private function __enterBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(thane.vocationGrades < 0 || thane.vocationGrades == 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("godsEvening.mainview.tip01"));
            return;
         }
         if(GodsEveningManager.instance.model.isForceQuit && GodsEveningManager.instance.model.gameState != 0)
         {
            SimpleAlertHelper.instance.data = [forceQuitAlertCall];
            _loc2_ = LanguageMgr.GetTranslation("godsEvening.forceQuit.tip2");
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,true,true,2,"SIMPLE_ALERT",160);
            return;
         }
         GodsEveningManager.instance.sendEnterCampaign();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function forceQuitAlertCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            GodsEveningManager.instance.sendEnterCampaign();
         }
      }
      
      private function __shopBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",35);
      }
      
      private function __rankBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("godsevening",1);
      }
      
      private function __checkRewardBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("godsevening",2);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("GEMainFrame.helpFrame");
         _loc2_.show();
      }
      
      private function refreshView() : void
      {
         var _loc3_:Date = null;
         var _loc2_:GodsEveningModel = GodsEveningManager.instance.model;
         _loc3_ = _loc2_.openTime;
         _team1.text = _team2.text = _team3.text = "";
         for(var _loc1_:String in _loc2_.teamDataDic)
         {
            if(this.hasOwnProperty("_team" + _loc1_))
            {
               (this["_team" + _loc1_] as GradientText).text = _loc2_.teamDataDic[_loc1_];
            }
         }
         if(_loc3_ != null)
         {
            _openTips.visible = _yearSprite.visible = _mouthSprite.visible = _daySprite.visible = _startHourSprite.visible = _startMinuteSprite.visible = true;
            _closeImage.visible = false;
            NumberViewUtils.refreshValue(_loc3_.fullYear,_yearSprite,_timeNumBmdGold,23,31,12,23,"0123456789",true);
            NumberViewUtils.refreshValue(_loc3_.month + 1,_mouthSprite,_timeNumBmdGold,23,31,12,23,"0123456789",true);
            NumberViewUtils.refreshValue(_loc3_.date,_daySprite,_timeNumBmdGold,23,31,12,23,"0123456789",true);
            NumberViewUtils.refreshValue(_loc3_.hours,_startHourSprite,_timeNumBmdGold,23,31,12,23,"0123456789",true);
            NumberViewUtils.refreshValue(_loc3_.minutes,_startMinuteSprite,_timeNumBmdGold,23,31,12,23,"0123456789",true);
         }
         else
         {
            _openTips.visible = _yearSprite.visible = _mouthSprite.visible = _daySprite.visible = _startHourSprite.visible = _startMinuteSprite.visible = false;
         }
         if(PlayerManager.instance.currentPlayerModel.sysCurtime.time > _loc2_.endTime.time)
         {
            _openTips.visible = _yearSprite.visible = _mouthSprite.visible = _daySprite.visible = _startHourSprite.visible = _startMinuteSprite.visible = false;
            _closeImage.visible = true;
         }
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
   }
}

