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
   
   public class SevenYearGloryGameScheduleData2 extends Component
   {
      
      private var _txtGloryGameScheduleType2Name1:FilterFrameText;
      
      private var _txtGloryGameScheduleType2Score1:FilterFrameText;
      
      private var _txtGloryGameScheduleType2Name2:FilterFrameText;
      
      private var _txtGloryGameScheduleType2Score2:FilterFrameText;
      
      private var _txtGloryGameScheduleType2Time:FilterFrameText;
      
      private var _round:int;
      
      private var _group:int;
      
      public function SevenYearGloryGameScheduleData2()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txtGloryGameScheduleType2Name1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType2Name1");
         _txtGloryGameScheduleType2Score1 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType2Score1");
         _txtGloryGameScheduleType2Name2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType2Name2");
         _txtGloryGameScheduleType2Score2 = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType2Score2");
         _txtGloryGameScheduleType2Time = ComponentFactory.Instance.creatComponentByStylename("ui.sevenyear.txtGloryGameScheduleType2Time");
         addChild(_txtGloryGameScheduleType2Name1);
         addChild(_txtGloryGameScheduleType2Score1);
         addChild(_txtGloryGameScheduleType2Name2);
         addChild(_txtGloryGameScheduleType2Score2);
         addChild(_txtGloryGameScheduleType2Time);
      }
      
      public function setData(param1:int, param2:int) : void
      {
         var _loc4_:Array = null;
         this._group = param2;
         this._round = param1;
         var _loc5_:Vector.<GloryGameScheduleInfo> = GloryGameManager.instance.getSchedulesByRoundAndGroup(param1,param2 + 1);
         if(_loc5_.length)
         {
            _txtGloryGameScheduleType2Name1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc5_[0].teamName1);
            _txtGloryGameScheduleType2Name2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc5_[0].teamName2);
            _txtGloryGameScheduleType2Score1.text = _loc5_[0].score1 + "";
            _txtGloryGameScheduleType2Score2.text = _loc5_[0].score2 + "";
         }
         else
         {
            if(param1 == 3)
            {
               _loc4_ = [["A","B"],["B","C"],["C","D"],["D","A"]];
               _txtGloryGameScheduleType2Name1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr2",_loc4_[param2][0],1);
               _txtGloryGameScheduleType2Name2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr2",_loc4_[param2][1],2);
            }
            else if(param1 == 4)
            {
               _txtGloryGameScheduleType2Name1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr3",(param2 + 1) * 2 - 1);
               _txtGloryGameScheduleType2Name2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr3",(param2 + 1) * 2);
            }
            else if(param1 == 5)
            {
               _txtGloryGameScheduleType2Name1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr4",1);
               _txtGloryGameScheduleType2Name2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr4",2);
            }
            _txtGloryGameScheduleType2Score1.text = "0";
            _txtGloryGameScheduleType2Score2.text = "0";
         }
         var _loc3_:Date = GloryGameManager.instance.getBattleTimeByRoundAndGroup(param1,param2 + 1);
         _txtGloryGameScheduleType2Time.text = DateFormatter.timeFormat1(_loc3_);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_txtGloryGameScheduleType2Name1);
         _txtGloryGameScheduleType2Name1 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType2Score1);
         _txtGloryGameScheduleType2Score1 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType2Name2);
         _txtGloryGameScheduleType2Name2 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType2Score2);
         _txtGloryGameScheduleType2Score2 = null;
         ObjectUtils.disposeObject(_txtGloryGameScheduleType2Time);
         _txtGloryGameScheduleType2Time = null;
         super.dispose();
      }
   }
}

