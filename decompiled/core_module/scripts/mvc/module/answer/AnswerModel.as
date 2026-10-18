package mvc.module.answer
{
   import flash.events.EventDispatcher;
   
   public final class AnswerModel extends EventDispatcher
   {
      
      private var _systemTotalNum:int;
      
      private var _systemLastNum:int;
      
      private var _state:uint = 0;
      
      private var _startTime:int;
      
      private var _time:uint = 0;
      
      private var _totalSocre:int = 0;
      
      private var _ranKing:int = 0;
      
      private var _heartCount:int = -1;
      
      private var _doubleCount:int = -1;
      
      private var _eyeCount:int = -1;
      
      private var _curData:AnswerItemData = new AnswerItemData();
      
      private var _curExp:int = 0;
      
      private var _extraExp:int = 0;
      
      private var _sucCount:int = 0;
      
      private var _selectedAnswer:int = -1;
      
      public function AnswerModel()
      {
         super();
      }
      
      public function get systemTotalNum() : int
      {
         return _systemTotalNum;
      }
      
      public function set systemTotalNum(param1:int) : void
      {
         _systemTotalNum = param1;
      }
      
      public function get systemLastNum() : int
      {
         return _systemLastNum;
      }
      
      public function set systemLastNum(param1:int) : void
      {
         _systemLastNum = param1;
      }
      
      public function get state() : uint
      {
         return _state;
      }
      
      public function set state(param1:uint) : void
      {
         _state = param1;
      }
      
      public function get startTime() : int
      {
         return _startTime;
      }
      
      public function set startTime(param1:int) : void
      {
         _startTime = param1;
      }
      
      public function get time() : uint
      {
         return _time;
      }
      
      public function set time(param1:uint) : void
      {
         _time = param1;
      }
      
      public function get totalSocre() : int
      {
         return _totalSocre;
      }
      
      public function set totalSocre(param1:int) : void
      {
         _totalSocre = param1;
      }
      
      public function get ranKing() : int
      {
         return _ranKing;
      }
      
      public function set ranKing(param1:int) : void
      {
         _ranKing = param1;
      }
      
      public function get heartCount() : int
      {
         return _heartCount;
      }
      
      public function set heartCount(param1:int) : void
      {
         _heartCount = param1;
      }
      
      public function get doubleCount() : int
      {
         return _doubleCount;
      }
      
      public function set doubleCount(param1:int) : void
      {
         _doubleCount = param1;
      }
      
      public function get eyeCount() : int
      {
         return _eyeCount;
      }
      
      public function set eyeCount(param1:int) : void
      {
         _eyeCount = param1;
      }
      
      public function get curData() : AnswerItemData
      {
         return _curData;
      }
      
      public function set curData(param1:AnswerItemData) : void
      {
         _curData = param1;
      }
      
      public function get curExp() : int
      {
         return _curExp;
      }
      
      public function set curExp(param1:int) : void
      {
         _curExp = param1;
      }
      
      public function get extraExp() : int
      {
         return _extraExp;
      }
      
      public function set extraExp(param1:int) : void
      {
         _extraExp = param1;
      }
      
      public function get sucCount() : int
      {
         return _sucCount;
      }
      
      public function set sucCount(param1:int) : void
      {
         _sucCount = param1;
      }
      
      public function getIndexByTmp(param1:int) : int
      {
         var _loc2_:int = 0;
         var _loc4_:int = -1;
         var _loc3_:int = int(_curData.answerVec.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(_curData.answerVec[_loc2_].tmpIndex == param1)
            {
               _loc4_ = _curData.answerVec[_loc2_].index;
               break;
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      public function unSelectedAnswer() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(curData.answerVec.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            curData.answerVec[_loc1_].state = 4;
            _loc1_++;
         }
      }
      
      public function useHeart() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(curData.answerVec.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            curData.answerVec[_loc1_].state = 5;
            _loc1_++;
         }
      }
      
      public function delErrorAnswer() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:Array = String(curData.answer).split("");
         var _loc4_:int = int(curData.answerVec.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_.length)
            {
               if(curData.answerVec[_loc2_].index == int(_loc1_[_loc3_]))
               {
                  curData.answerVec[_loc2_].state = 5;
               }
               _loc3_++;
            }
            _loc2_++;
         }
      }
      
      public function get selectedAnswer() : int
      {
         return _selectedAnswer;
      }
      
      public function set selectedAnswer(param1:int) : void
      {
         _selectedAnswer = param1;
      }
      
      public function askAnswerState() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = int(curData.answerVec.length);
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(curData.answerVec[_loc1_])
            {
               if(curData.answerVec[_loc1_].state != 5)
               {
                  curData.answerVec[_loc1_].state = 0;
               }
            }
            _loc1_++;
         }
      }
      
      public function selectAnswer(param1:int) : void
      {
         var _loc2_:int = 0;
         selectedAnswer = param1;
         var _loc3_:int = int(curData.answerVec.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(curData.answerVec[_loc2_])
            {
               curData.answerVec[_loc2_].state = curData.answerVec[_loc2_].tmpIndex == param1 ? 1 : 4;
            }
            _loc2_++;
         }
      }
      
      public function verAnswerRes() : Boolean
      {
         if(selectedAnswer == -1)
         {
            return false;
         }
         return curData.answerVec[selectedAnswer].index == curData.answer;
      }
      
      public function rightAnswer(param1:int) : void
      {
         var _loc2_:int = int(curData.answerVec.length);
         if(selectedAnswer != -1)
         {
            if(curData.answerVec[selectedAnswer].index != param1)
            {
               curData.answerVec[selectedAnswer].state = 3;
            }
            else
            {
               curData.answerVec[selectedAnswer].state = 2;
            }
         }
      }
   }
}

