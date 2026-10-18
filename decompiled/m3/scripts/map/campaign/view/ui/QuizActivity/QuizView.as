package map.campaign.view.ui.QuizActivity
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.answerquestion.SingleAnswerQuestionMsg;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.MsgMan;
   import yishi.view.tools.QuickenMovieClip;
   
   public class QuizView extends Component
   {
      
      private var _bg:MovieClip;
      
      private var _txtQuestion:FilterFrameText;
      
      private var _txtAnswer1:FilterFrameText;
      
      private var _txtAnswer2:FilterFrameText;
      
      private var _txtTime:FilterFrameText;
      
      private var _timer:TimerTicker;
      
      private var _quizInfo:SingleAnswerQuestionMsg;
      
      private var _selectPosX:int;
      
      private var _c:Sprite;
      
      private var _restSecond:int;
      
      private var _selected:int;
      
      private var _isOver:Boolean = false;
      
      private var _selectMC:QuickenMovieClip;
      
      private var _mcC:Sprite;
      
      public function QuizView()
      {
         super();
         this.visible = false;
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         _bg = ComponentFactory.Instance.creat("asset.quiz.bg1");
         this.addChild(_bg);
         _txtQuestion = ComponentFactory.Instance.creatComponentByStylename("quiz.txt1");
         this.addChild(_txtQuestion);
         _c = new Sprite();
         _c.x = 0;
         _c.y = 76;
         this.addChild(_c);
         _mcC = new Sprite();
         _c.addChild(_mcC);
         _txtAnswer1 = ComponentFactory.Instance.creatComponentByStylename("quiz.txt.answer1");
         _c.addChild(_txtAnswer1);
         _txtAnswer2 = ComponentFactory.Instance.creatComponentByStylename("quiz.txt.answer2");
         _c.addChild(_txtAnswer2);
         _txtTime = ComponentFactory.Instance.creatComponentByStylename("quiz.txt.time");
         this.addChild(_txtTime);
         _timer = new TimerTicker(1000);
         _timer.addEventListener("timer",timeHandler);
         _timer.start();
         _selectMC = new QuickenMovieClip(ComponentFactory.Instance.creat("asset.quiz.selectMC"));
         _selectMC.gotoAndStop(0);
         _selectMC.addFrameScript(_selectMC.totalFrames - 1,mcPlayerOver);
      }
      
      private function mcPlayerOver() : void
      {
         _mcC.addChild(_selectMC);
      }
      
      private function mcPrepare() : void
      {
         if(_selectMC.parent)
         {
            _selectMC.parent.removeChild(_selectMC);
         }
         _selectMC.gotoAndStop(0);
      }
      
      protected function timeHandler(param1:TimerEvent) : void
      {
         if(_quizInfo == null)
         {
            this.visible = false;
            return;
         }
         if(_quizInfo.id == 1 && _restSecond > 25)
         {
            this.visible = false;
            _isOver = false;
            mcPrepare();
         }
         else if(_restSecond <= 25 && _restSecond > 0)
         {
            this.visible = true;
            _txtTime.text = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.countdown",_restSecond);
            _isOver = false;
            mcPrepare();
         }
         else if(_restSecond <= 0 && _restSecond >= -5)
         {
            _isOver = true;
            this.visible = true;
            _txtTime.text = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.countdown2",String(_restSecond + 5));
            if(_selectMC.parent == null)
            {
               _c.addChild(_selectMC);
            }
            _selectMC.play();
            if(_quizInfo.result == 1)
            {
               _selectMC.x = _txtAnswer1.x + 30;
            }
            else
            {
               _selectMC.x = _txtAnswer2.x + 30;
            }
            _selectMC.y = -18;
         }
         _restSecond = _restSecond - 1;
      }
      
      private function addEvents() : void
      {
         MsgMan.addObserver("yishi.datas.consant.QUIZ_ACTIVITY_GET_QUESTION_EVENT",this,__getQuestionHandler);
         StageReferance.stage.addEventListener("resize",__stageResize);
         __stageResize(null);
      }
      
      private function removeEvents() : void
      {
         MsgMan.removeObserver("yishi.datas.consant.QUIZ_ACTIVITY_GET_QUESTION_EVENT",this,__getQuestionHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timeHandler);
            _timer = null;
         }
         StageReferance.stage.removeEventListener("resize",__stageResize);
      }
      
      protected function __stageResize(param1:Event) : void
      {
         this.x = (StageReferance.stage.stageWidth - 390) * 0.5;
         this.y = 42;
      }
      
      private function __getQuestionHandler(param1:String, param2:Object) : void
      {
         mcPrepare();
         _quizInfo = param2 as SingleAnswerQuestionMsg;
         _restSecond = (Number(_quizInfo.time) - PlayerManager.instance.currentPlayerModel.nowDate) / 1000;
         _txtQuestion.text = _quizInfo.id + "." + _quizInfo.question;
         _txtAnswer1.text = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.walkLeft") + _quizInfo.option1;
         _txtAnswer2.x = _txtAnswer1.x + _txtAnswer1.textWidth + 25;
         _txtAnswer2.text = LanguageMgr.GetTranslation("map.campaign.view.ui.QuizActivity.walkRight") + _quizInfo.option2;
         _c.x = (390 - _c.width) * 0.5;
         var _loc4_:int = CampaignManager.instance.mapModel.selfMemberData.curPosX * 20;
         var _loc3_:int = CampaignManager.instance.mapModel.mapTempInfo.Width * 0.5;
         if(_loc4_ <= _loc3_)
         {
            _selected = 1;
         }
         else
         {
            _selected = 2;
         }
         if(_selected == 2)
         {
            _txtAnswer1.textColor = 16777215;
            _txtAnswer2.textColor = 7266082;
         }
         else
         {
            _txtAnswer1.textColor = 7266082;
            _txtAnswer2.textColor = 16777215;
         }
         timeHandler(null);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,0,false,false,0,0);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      public function selecteChanged(param1:int) : void
      {
         if(_isOver)
         {
            return;
         }
         _selected = param1;
         if(param1 == 1)
         {
            _txtAnswer1.textColor = 7266082;
            _txtAnswer2.textColor = 16777215;
         }
         else
         {
            _txtAnswer1.textColor = 16777215;
            _txtAnswer2.textColor = 7266082;
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvents();
         ObjectUtils.disposeObject(_txtQuestion);
         _txtQuestion = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

