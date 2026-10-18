package sevenyear.view.gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameScheduleInfo;
   import yishi.utils.DateFormatter;
   
   public class SevenYearGloryGameDailyItem extends Component
   {
      
      private var _bit0:Bitmap;
      
      private var _txtGloryGameDailyName1:FilterFrameText;
      
      private var _txtGloryGameDailyName2:FilterFrameText;
      
      private var _txtGloryGameDailyScore1:FilterFrameText;
      
      private var _txtGloryGameDailyScore2:FilterFrameText;
      
      private var _txtGloryGameDailyTime:FilterFrameText;
      
      private var _txtGloryGameDailyDesc:FilterFrameText;
      
      private var info:GloryGameScheduleInfo;
      
      public function SevenYearGloryGameDailyItem(param1:GloryGameScheduleInfo)
      {
         super();
         this.info = param1;
         initView();
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.SevenYearGloryGame.bg3");
         _txtGloryGameDailyName1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameDailyName1");
         _txtGloryGameDailyName2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameDailyName2");
         _txtGloryGameDailyScore1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameDailyScore1");
         _txtGloryGameDailyScore2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameDailyScore2");
         _txtGloryGameDailyTime = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameDailyTime");
         _txtGloryGameDailyDesc = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameDailyDesc");
         addChild(_bit0);
         addChild(_txtGloryGameDailyName1);
         addChild(_txtGloryGameDailyName2);
         addChild(_txtGloryGameDailyScore1);
         addChild(_txtGloryGameDailyScore2);
         addChild(_txtGloryGameDailyTime);
         addChild(_txtGloryGameDailyDesc);
         _txtGloryGameDailyName1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",info.teamName1);
         _txtGloryGameDailyName2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",info.teamName2);
         _txtGloryGameDailyScore1.text = info.score1 + "";
         _txtGloryGameDailyScore2.text = info.score2 + "";
         width = 195;
         height = 55;
         if(info.round == 2)
         {
            _txtGloryGameDailyDesc.text = LanguageMgr.GetTranslation("SevenYearGloryGame.winText.1");
         }
         else
         {
            _txtGloryGameDailyDesc.text = LanguageMgr.GetTranslation("SevenYearGloryGame.winText.2");
         }
         var _loc1_:Date = GloryGameManager.instance.getBattleTimeByRoundAndGroup(info.round,info.group);
         _txtGloryGameDailyTime.text = DateFormatter.timeFormat5(_loc1_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_txtGloryGameDailyName1);
         _txtGloryGameDailyName1 = null;
         ObjectUtils.disposeObject(_txtGloryGameDailyName2);
         _txtGloryGameDailyName2 = null;
         ObjectUtils.disposeObject(_txtGloryGameDailyScore1);
         _txtGloryGameDailyScore1 = null;
         ObjectUtils.disposeObject(_txtGloryGameDailyScore2);
         _txtGloryGameDailyScore2 = null;
         ObjectUtils.disposeObject(_txtGloryGameDailyTime);
         _txtGloryGameDailyTime = null;
         ObjectUtils.disposeObject(_txtGloryGameDailyDesc);
         _txtGloryGameDailyDesc = null;
         super.dispose();
      }
   }
}

