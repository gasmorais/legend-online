package sevenyear.view.gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameBetInfo;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.event.GloryGameEvent;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearGloryGameForecastView extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _txtGloryGameForecastRule:FilterFrameText;
      
      private var _txtGloryGameForecastTime5:FilterFrameText;
      
      private var _txtGloryGameForecastAward1:FilterFrameText;
      
      private var _gloryGameForecastPic1:MutipleImage;
      
      private var _btnGloryGameLock:BaseButton;
      
      private var _gloryGameForecastPic2:MutipleImage;
      
      private var _txtGloryGameForecastTime1:FilterFrameText;
      
      private var _txtGloryGameForecastTime2:FilterFrameText;
      
      private var _txtGloryGameForecastTime4:FilterFrameText;
      
      private var _txtGloryGameForecastTime3:FilterFrameText;
      
      private var _bit1:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var posArr:Array = [[3,1,24,93],[3,2,24,194],[3,3,24,295],[3,4,24,396],[4,1,258,147],[4,2,258,350],[5,1,478,250],[6,1,478,376]];
      
      private var itemArr:Array;
      
      private var _isMask:Boolean = false;
      
      private var _tipIcon:Image;
      
      private var groupArr:Array = [[[1],[2]],[[2],[3]],[[3],[4]],[[4],[1]],[[1,2],[2,3]],[[3,4],[4,1]],[[1,2,3],[1,3,4]],[[1,2,3,4],[1,2,3,4]]];
      
      public function SevenYearGloryGameForecastView()
      {
         super();
         initView();
         initEvent();
         GloryGameManager.instance.sendOpenBet();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.str12");
         _txtGloryGameForecastRule = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastRule");
         _txtGloryGameForecastTime5 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastTime5");
         _txtGloryGameForecastAward1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastAward1");
         _gloryGameForecastPic1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGameForecastPic1");
         _btnGloryGameLock = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.btnGloryGameLock");
         _gloryGameForecastPic2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.gloryGameForecastPic2");
         _txtGloryGameForecastTime1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastTime1");
         _txtGloryGameForecastTime2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastTime2");
         _txtGloryGameForecastTime4 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastTime4");
         _txtGloryGameForecastTime3 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameForecastTime3");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.bg8");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.scrollPanel2");
         _tipIcon = ComponentFactory.Instance.creatComponentByStylename("SevenYear.icontip");
         _tipIcon.x = 774;
         _tipIcon.y = 288;
         addChild(_bit1);
         addChild(_bit0);
         addChild(_txtGloryGameForecastTime5);
         addChild(_txtGloryGameForecastAward1);
         addChild(_gloryGameForecastPic1);
         addChild(_btnGloryGameLock);
         addChild(_gloryGameForecastPic2);
         addChild(_txtGloryGameForecastTime1);
         addChild(_txtGloryGameForecastTime2);
         addChild(_txtGloryGameForecastTime4);
         addChild(_txtGloryGameForecastTime3);
         addChild(_scrollPanel);
         addChild(_tipIcon);
         _tipIcon.tipData = LanguageMgr.GetTranslation("SevenYearGradeView.icon.tip");
         _scrollPanel.setView(_txtGloryGameForecastRule);
         _txtGloryGameForecastRule.text = LanguageMgr.GetTranslation("SevenYearGloryGame.forecast.rule");
         _scrollPanel.invalidateViewport();
         _txtGloryGameForecastAward1.text = ConfigInfoManager.instance.getForecastAward() + "";
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc4_:SevenYearGloryGameForecastComboItem = null;
         var _loc2_:int = 0;
         var _loc1_:Array = null;
         var _loc5_:Array = null;
         var _loc3_:GloryGameBetInfo = null;
         if(itemArr)
         {
            for each(_loc4_ in itemArr)
            {
               _loc4_.dispose();
            }
         }
         itemArr = [];
         _loc2_ = 0;
         while(_loc2_ < posArr.length)
         {
            _loc1_ = posArr[_loc2_];
            _loc5_ = groupArr[_loc2_];
            _loc4_ = new SevenYearGloryGameForecastComboItem(_loc5_,_loc1_[0],_loc1_[1],_loc2_);
            addChild(_loc4_);
            _loc4_.x = _loc1_[2];
            _loc4_.y = _loc1_[3];
            itemArr.push(_loc4_);
            _loc2_++;
         }
         if(hasBeted)
         {
            isMask = true;
            _loc3_ = GloryGameManager.instance.model.myBetInfos.getValueByIndex(0) as GloryGameBetInfo;
            _txtGloryGameForecastTime5.text = LanguageMgr.GetTranslation("SevenYearGloryGame.forecast.str1",_loc3_.betTimeStr);
         }
         else
         {
            isMask = false;
            _txtGloryGameForecastTime5.text = "";
         }
         _txtGloryGameForecastTime1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.forecast.str2",DateFormatter.timeFormat1(GloryGameManager.instance.getBattleTimeByRoundAndGroup(2)));
         _txtGloryGameForecastTime2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.forecast.str2",DateFormatter.timeFormat1(GloryGameManager.instance.getBattleTimeByRoundAndGroup(3)));
         _txtGloryGameForecastTime3.text = LanguageMgr.GetTranslation("SevenYearGloryGame.forecast.str2",DateFormatter.timeFormat1(GloryGameManager.instance.getBattleTimeByRoundAndGroup(4)));
         _txtGloryGameForecastTime4.text = LanguageMgr.GetTranslation("SevenYearGloryGame.forecast.str2",DateFormatter.timeFormat1(GloryGameManager.instance.getBattleTimeByRoundAndGroup(5)));
         if(model.currentRound == 1 && model.currentState < 5)
         {
            _btnGloryGameLock.enable = false;
         }
      }
      
      public function get hasBeted() : Boolean
      {
         return GloryGameManager.instance.model.myBetInfos && !GloryGameManager.instance.model.myBetInfos.isEmpty;
      }
      
      public function get model() : GloryGameModel
      {
         return GloryGameManager.instance.model;
      }
      
      private function initEvent() : void
      {
         GloryGameManager.instance.addEventListener("BET_INFO_UPDATE",onUpdate);
         GloryGameManager.instance.addEventListener("SCHEDULE_INFO_UPDATE",onUpdateOneTime);
         _btnGloryGameLock.addEventListener("click",onClickLock);
      }
      
      private function removeEvent() : void
      {
         GloryGameManager.instance.removeEventListener("BET_INFO_UPDATE",onUpdate);
         GloryGameManager.instance.removeEventListener("SCHEDULE_INFO_UPDATE",onUpdateOneTime);
         if(_btnGloryGameLock)
         {
            _btnGloryGameLock.removeEventListener("click",onClickLock);
         }
      }
      
      protected function onUpdate(param1:GloryGameEvent) : void
      {
         initItem();
      }
      
      protected function onUpdateOneTime(param1:GloryGameEvent) : void
      {
         GloryGameManager.instance.removeEventListener("SCHEDULE_INFO_UPDATE",onUpdateOneTime);
         initItem();
      }
      
      protected function onClickUnlock(param1:MouseEvent) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation(""));
         _btnGloryGameLock.visible = true;
         isMask = false;
      }
      
      protected function onClickLock(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(hasBeted)
         {
            _loc2_ = LanguageMgr.GetTranslation("SevenYearGloryGame.lock.hint");
         }
         else
         {
            _loc2_ = LanguageMgr.GetTranslation("SevenYearGloryGame.lock.hint2");
         }
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc4_:String = LanguageMgr.GetTranslation("public.cancel");
         SimpleAlertHelper.instance.data = [lockConfirm];
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc2_,_loc3_,_loc4_,false,false,false,1);
      }
      
      private function lockConfirm(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:Array = null;
         if(param1)
         {
            _loc3_ = [];
            for each(var _loc4_:SevenYearGloryGameForecastComboItem in itemArr)
            {
               _loc3_.push(_loc4_.selectedData);
            }
            if(_loc3_.length)
            {
               GloryGameManager.instance.sendBet(_loc3_);
            }
         }
      }
      
      public function get isMask() : Boolean
      {
         return _isMask;
      }
      
      public function set isMask(param1:Boolean) : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastRule);
         _txtGloryGameForecastRule = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastTime5);
         _txtGloryGameForecastTime5 = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastAward1);
         _txtGloryGameForecastAward1 = null;
         ObjectUtils.disposeObject(_gloryGameForecastPic1);
         _gloryGameForecastPic1 = null;
         ObjectUtils.disposeObject(_btnGloryGameLock);
         _btnGloryGameLock = null;
         ObjectUtils.disposeObject(_gloryGameForecastPic2);
         _gloryGameForecastPic2 = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastTime1);
         _txtGloryGameForecastTime1 = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastTime2);
         _txtGloryGameForecastTime2 = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastTime3);
         _txtGloryGameForecastTime3 = null;
         ObjectUtils.disposeObject(_txtGloryGameForecastTime4);
         _txtGloryGameForecastTime4 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_tipIcon);
         _tipIcon = null;
         LogicUtils.disposeDisplayCollection(itemArr);
         itemArr = null;
         super.dispose();
      }
   }
}

