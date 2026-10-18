package simplegame.hamster
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.text.TextFormat;
   import flash.ui.Mouse;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   
   public class HamsterGame extends Sprite implements IEnterFrame
   {
      
      public static const POS:Array = [new Point(181,120),new Point(338,121),new Point(499,120),new Point(428,190),new Point(271,191),new Point(179,259),new Point(338,241),new Point(497,259)];
      
      private var _timeId:uint;
      
      private var _scoreCount:int;
      
      private var _currentCursor:MovieClip;
      
      private var _stageMove:MovieClip;
      
      private var _timeMc:MovieClip;
      
      private var _succeedMc:MovieClip;
      
      private var _timer:Timer;
      
      private var _currentGameTime:int;
      
      private var _scoreCondition:int;
      
      private var _timeCondition:int;
      
      private var _successCallBack:Function;
      
      private var _lostCallBack:Function;
      
      private var _isGameStart:Boolean = false;
      
      private var _isMouseOut:Boolean = true;
      
      private var _textFormat:TextFormat;
      
      private var susliks_1:MovieClip;
      
      private var susliks_2:MovieClip;
      
      private var _timeId2:int;
      
      private var _countFrame:int = 1;
      
      private var _countFrame2:int = 1;
      
      private var randTemp:int = -1;
      
      private var rand:int;
      
      public function HamsterGame(param1:int, param2:int, param3:Function, param4:Function)
      {
         super();
         _timeCondition = param1;
         _scoreCondition = param2;
         _successCallBack = param3;
         _lostCallBack = param4;
         initView();
      }
      
      public function gameStart() : void
      {
         scoreCount = 0;
         _currentGameTime = _timeCondition;
         _stageMove["Integral_txt"].text = _scoreCount.toString() + "/" + _scoreCondition;
         _stageMove["Time_txt"].text = _currentGameTime.toString();
         EnterFrameManager.instance.registeEnterFrame(this);
         _timeMc.gotoAndPlay(1);
         addChild(_timeMc);
      }
      
      private function initView() : void
      {
         _stageMove = ComponentFactory.Instance.creatCustomObject("task.HamsterGameBack");
         _timeMc = ComponentFactory.Instance.creatCustomObject("task.HamsterGameCountDownMc");
         _timeMc.stop();
         _timeMc.x = 342;
         _timeMc.y = 140;
         _succeedMc = ComponentFactory.Instance.creatCustomObject("task.HamsterGameSucceedMc");
         _succeedMc.stop();
         _succeedMc.x = 270;
         _succeedMc.y = 140;
         addChild(_stageMove);
         susliks_1 = ComponentFactory.Instance.creatCustomObject("task.HamsterGameSusliks");
         susliks_1.mouseChildren = false;
         susliks_1.mouseEnabled = false;
         susliks_2 = ComponentFactory.Instance.creatCustomObject("task.HamsterGameSusliks");
         susliks_2.mouseChildren = false;
         susliks_2.mouseEnabled = false;
         _timer = new Timer(1000);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__mouseDown);
         addEventListener("mouseUp",__mouseUp);
         StageReferance.stage.addEventListener("mouseOver",_mouseOverHandler);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
         _timeId = setTimeout(growSusliks,200,susliks_1,_timeId);
         _timeId2 = setTimeout(growSusliks,1200,susliks_2,_timeId2);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(!_currentGameTime)
         {
            _timer.stop();
            _gameOver();
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            _lostCallBack();
            return;
         }
         _currentGameTime = _currentGameTime - 1;
         _stageMove["Time_txt"].text = _currentGameTime.toString();
         _textFormat = _stageMove["Time_txt"].getTextFormat();
         _textFormat.italic = true;
         _stageMove["Time_txt"].setTextFormat(_textFormat);
      }
      
      private function frameUpdateView() : void
      {
         var _loc1_:int = 0;
         if(_currentCursor)
         {
            _currentCursor.x = this.mouseX;
            _currentCursor.y = this.mouseY;
         }
         if(susliks_1 && susliks_1.parent)
         {
            _countFrame = _countFrame + 1;
            if(susliks_1.currentFrame == 20 || susliks_1.currentFrame == 33 || _countFrame >= 34)
            {
               susliks_1.gotoAndStop(1);
               susliks_1.parent.removeChild(susliks_1);
               _loc1_ = 400 + 200 * Math.random();
               _timeId = setTimeout(growSusliks,_loc1_,susliks_1,_timeId);
               _countFrame = 1;
            }
         }
         if(susliks_2 && susliks_2.parent)
         {
            _countFrame2 = _countFrame2 + 1;
            if(susliks_2.currentFrame == 20 || susliks_2.currentFrame == 33 || _countFrame2 >= 34)
            {
               susliks_2.gotoAndStop(1);
               susliks_2.parent.removeChild(susliks_2);
               _loc1_ = 550 + 250 * Math.random();
               _timeId2 = setTimeout(growSusliks,_loc1_,susliks_2,_timeId2);
               _countFrame2 = 1;
            }
         }
      }
      
      private function growSusliks(param1:MovieClip, param2:int) : void
      {
         rand = Math.floor(Math.random() * POS.length);
         if(randTemp == -1)
         {
            randTemp = rand;
         }
         else
         {
            while(rand == randTemp)
            {
               rand = Math.floor(Math.random() * POS.length);
            }
            randTemp = rand;
         }
         var _loc3_:Point = POS[rand];
         if(param1)
         {
            param1.x = _loc3_.x;
            param1.y = _loc3_.y;
            if(_stageMove)
            {
               _stageMove.addChild(param1);
               _stageMove.addChild((parent as HamsterGameFrame).closeBtn);
            }
            param1.gotoAndPlay(1);
         }
         clearTimeout(param2);
      }
      
      private function __mouseDown(param1:MouseEvent) : void
      {
         if(_currentCursor == null)
         {
            return;
         }
         _currentCursor.gotoAndPlay(2);
         if(susliks_1 && susliks_1.parent)
         {
            if(_currentCursor["hitarea"].hitTestObject(susliks_1["hitarea"]) && susliks_1.currentFrame < 19)
            {
               susliks_1.gotoAndPlay(21);
               _scoreCount += 100;
               _stageMove["Integral_txt"].text = _scoreCount.toString() + "/" + _scoreCondition;
               if(_scoreCount >= _scoreCondition)
               {
                  _gameOver();
                  addChild(_succeedMc);
                  _succeedMc.gotoAndPlay(1);
               }
            }
         }
         if(susliks_2 && susliks_2.parent)
         {
            if(_currentCursor["hitarea"].hitTestObject(susliks_2["hitarea"]) && susliks_2.currentFrame < 19)
            {
               susliks_2.gotoAndPlay(21);
               _scoreCount += 100;
               _stageMove["Integral_txt"].text = _scoreCount.toString() + "/" + _scoreCondition;
               if(_scoreCount >= _scoreCondition)
               {
                  _gameOver();
                  addChild(_succeedMc);
                  _succeedMc.gotoAndPlay(1);
               }
            }
         }
      }
      
      private function __mouseUp(param1:MouseEvent) : void
      {
         if(_currentCursor)
         {
            _currentCursor.gotoAndStop(1);
         }
      }
      
      private function _resetCursor() : void
      {
         if(_currentCursor && _currentCursor.parent)
         {
            _currentCursor.parent.removeChild(_currentCursor);
         }
         _currentCursor = null;
         Mouse.show();
         Mouse.cursor = "auto";
      }
      
      private function showCursorByType() : void
      {
         _currentCursor = ComponentFactory.Instance.creatCustomObject("task.HamsterGameStick");
         _currentCursor.mouseEnabled = false;
         _currentCursor.mouseChildren = false;
         _currentCursor.gotoAndStop(1);
         addChild(_currentCursor);
         enterFrame();
         Mouse.hide();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseDown",__mouseDown);
         removeEventListener("mouseUp",__mouseUp);
         _timer.removeEventListener("timer",__timerHandler);
         StageReferance.stage.removeEventListener("mouseOver",_mouseOverHandler);
      }
      
      private function _mouseOverHandler(param1:MouseEvent) : void
      {
         Mouse.hide();
      }
      
      private function _gameOver() : void
      {
         removeEvent();
         _isGameStart = false;
         _resetCursor();
         clearTimeout(_timeId);
         clearTimeout(_timeId2);
         if(susliks_1.parent)
         {
            susliks_1.parent.removeChild(susliks_1);
         }
         if(susliks_2.parent)
         {
            susliks_2.parent.removeChild(susliks_2);
         }
      }
      
      public function dispose() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         if(_isGameStart)
         {
            _gameOver();
            _timer.stop();
         }
         _timer = null;
         ObjectUtils.disposeObject(_succeedMc);
         _succeedMc = null;
         ObjectUtils.disposeObject(_currentCursor);
         _currentCursor = null;
         ObjectUtils.disposeObject(susliks_1);
         susliks_1 = null;
         ObjectUtils.disposeObject(susliks_2);
         susliks_2 = null;
         ObjectUtils.disposeObject(_stageMove);
         _stageMove = null;
         ObjectUtils.disposeObject(_timeMc);
         _timeMc = null;
      }
      
      public function enterFrame() : void
      {
         if(_isGameStart)
         {
            frameUpdateView();
            if(mouseX >= 565 && mouseX <= 645 && mouseY <= 60 && mouseY >= 10)
            {
               _resetCursor();
            }
            else if(!_currentCursor)
            {
               showCursorByType();
            }
            return;
         }
         if(_timeMc && _timeMc.parent && _timeMc.currentFrame == _timeMc.totalFrames)
         {
            _timeMc.gotoAndStop(1);
            removeChild(_timeMc);
            _isGameStart = true;
            showCursorByType();
            initEvent();
         }
         else if(_succeedMc && _succeedMc.parent && _succeedMc.currentFrame == _succeedMc.totalFrames)
         {
            removeChild(_succeedMc);
            _succeedMc.gotoAndStop(1);
            EnterFrameManager.instance.unRegisteEnterFrame(this);
            _successCallBack();
         }
      }
      
      public function set gameTime(param1:int) : void
      {
         _currentGameTime = param1;
         _stageMove["Time_txt"].text = _currentGameTime.toString();
      }
      
      public function get scoreCount() : int
      {
         return _scoreCount;
      }
      
      public function set scoreCount(param1:int) : void
      {
         _scoreCount = param1;
      }
   }
}

