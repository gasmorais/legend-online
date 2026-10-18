package sevenyear.view.gloryGame
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameScheduleInfo;
   import yishi.utils.DateFormatter;
   
   public class SevenYearGloryGameScheduleData1 extends Component
   {
      
      private var _txtGloryGameScheduleType1Name1:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Score1:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Name2:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Score2:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Name3:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Score3:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Name4:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Score4:FilterFrameText;
      
      private var _txtGloryGameScheduleType1Time:FilterFrameText;
      
      private var _round:int;
      
      private var _group:int;
      
      public function SevenYearGloryGameScheduleData1()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txtGloryGameScheduleType1Name1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Name1");
         _txtGloryGameScheduleType1Score1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Score1");
         _txtGloryGameScheduleType1Name2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Name2");
         _txtGloryGameScheduleType1Score2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Score2");
         _txtGloryGameScheduleType1Name3 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Name3");
         _txtGloryGameScheduleType1Score3 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Score3");
         _txtGloryGameScheduleType1Name4 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Name4");
         _txtGloryGameScheduleType1Score4 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Score4");
         _txtGloryGameScheduleType1Time = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType1Time");
         addChild(_txtGloryGameScheduleType1Name1);
         addChild(_txtGloryGameScheduleType1Score1);
         addChild(_txtGloryGameScheduleType1Name2);
         addChild(_txtGloryGameScheduleType1Score2);
         addChild(_txtGloryGameScheduleType1Name3);
         addChild(_txtGloryGameScheduleType1Score3);
         addChild(_txtGloryGameScheduleType1Name4);
         addChild(_txtGloryGameScheduleType1Score4);
         addChild(_txtGloryGameScheduleType1Time);
      }
      
      public function setData(param1:int, param2:int) : void
      {
         var infos:Vector.<GloryGameScheduleInfo>;
         var date:Date;
         var _round:int = param1;
         var _group:int = param2;
         this._group = _group;
         this._round = _round;
         infos = GloryGameManager.instance.getSchedulesByRoundAndGroup(_round,_group + 1);
         infos.sort(function(param1:GloryGameScheduleInfo, param2:GloryGameScheduleInfo):int
         {
            if(param1.rank > param2.rank)
            {
               return 1;
            }
            if(param1.rank < param2.rank)
            {
               return -1;
            }
            return 0;
         });
         if(infos.length == 4)
         {
            _txtGloryGameScheduleType1Name1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",infos[0].teamName1);
            _txtGloryGameScheduleType1Name2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",infos[1].teamName1);
            _txtGloryGameScheduleType1Name3.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",infos[2].teamName1);
            _txtGloryGameScheduleType1Name4.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",infos[3].teamName1);
            _txtGloryGameScheduleType1Score1.text = infos[0].score1 + "-" + infos[0].score2;
            _txtGloryGameScheduleType1Score2.text = infos[1].score1 + "-" + infos[1].score2;
            _txtGloryGameScheduleType1Score3.text = infos[2].score1 + "-" + infos[2].score2;
            _txtGloryGameScheduleType1Score4.text = infos[3].score1 + "-" + infos[3].score2;
         }
         else
         {
            _txtGloryGameScheduleType1Name1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr1",_group + 1);
            _txtGloryGameScheduleType1Name2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr1",_group + 5);
            _txtGloryGameScheduleType1Name3.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr1",_group + 9);
            _txtGloryGameScheduleType1Name4.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr1",_group + 13);
            _txtGloryGameScheduleType1Score1.text = "0-0";
            _txtGloryGameScheduleType1Score2.text = "0-0";
            _txtGloryGameScheduleType1Score3.text = "0-0";
            _txtGloryGameScheduleType1Score4.text = "0-0";
         }
         date = GloryGameManager.instance.getBattleTimeByRoundAndGroup(_round,_group + 1);
         _txtGloryGameScheduleType1Time.text = DateFormatter.timeFormat1(date);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Name1);
         _txtGloryGameScheduleType1Name1 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Score1);
         _txtGloryGameScheduleType1Score1 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Name2);
         _txtGloryGameScheduleType1Name2 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Score2);
         _txtGloryGameScheduleType1Score2 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Name3);
         _txtGloryGameScheduleType1Name3 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Score3);
         _txtGloryGameScheduleType1Score3 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Name4);
         _txtGloryGameScheduleType1Name4 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Score4);
         _txtGloryGameScheduleType1Score4 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType1Time);
         _txtGloryGameScheduleType1Time = null;
         super.dispose();
      }
   }
}

