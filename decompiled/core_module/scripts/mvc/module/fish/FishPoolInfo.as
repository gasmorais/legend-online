package mvc.module.fish
{
   import yishi.manager.TempleteManager;
   
   public class FishPoolInfo
   {
      
      private var _userId:int;
      
      private var _level:int;
      
      private var _score:int;
      
      private var _sort:int;
      
      private var _currentGp:int;
      
      private var _currentMaxGp:int;
      
      private var _count:int;
      
      private var _maxCount:int;
      
      private var _cdTime:Number;
      
      private var _levelMax:int;
      
      private var _tool1:int;
      
      private var _tool2:int;
      
      private var _tool3:int;
      
      private var _tool4:int;
      
      public function FishPoolInfo()
      {
         super();
      }
      
      public function get sort() : int
      {
         return _sort;
      }
      
      public function set sort(param1:int) : void
      {
         _sort = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         if(_userId != param1)
         {
            _userId = param1;
         }
      }
      
      public function get score() : int
      {
         return _score;
      }
      
      public function set score(param1:int) : void
      {
         if(param1 == _score)
         {
            return;
         }
         _score = param1;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function set level(param1:int) : void
      {
         if(param1 == _level)
         {
            return;
         }
         _level = param1;
      }
      
      public function get currentGp() : int
      {
         return _currentGp;
      }
      
      public function set currentGp(param1:int) : void
      {
         _currentGp = param1;
         var _loc2_:Array = TempleteManager.instance.getTemplatesByType(40);
         _loc2_.sortOn("Grades",16);
         _levelMax = _loc2_[_loc2_.length - 1].Grades;
         if(_level < _levelMax)
         {
            _currentMaxGp = _loc2_[level].Data;
         }
         else
         {
            _currentMaxGp = _loc2_[_loc2_.length - 1].Data;
         }
         _currentGp = Math.min(_currentGp,_currentMaxGp);
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         if(param1 == _count)
         {
            return;
         }
         _count = param1;
      }
      
      public function get maxCount() : int
      {
         return _maxCount;
      }
      
      public function set maxCount(param1:int) : void
      {
         if(param1 == _maxCount)
         {
            return;
         }
         _maxCount = param1;
      }
      
      public function get cdTime() : Number
      {
         return _cdTime;
      }
      
      public function set cdTime(param1:Number) : void
      {
         _cdTime = param1;
      }
      
      public function get isLimit() : Boolean
      {
         return _level == _levelMax;
      }
      
      public function get currentMaxGp() : int
      {
         return _currentMaxGp;
      }
      
      public function get tool1() : int
      {
         return _tool1;
      }
      
      public function set tool1(param1:int) : void
      {
         _tool1 = param1;
      }
      
      public function get tool2() : int
      {
         return _tool2;
      }
      
      public function set tool2(param1:int) : void
      {
         _tool2 = param1;
      }
      
      public function get tool3() : int
      {
         return _tool3;
      }
      
      public function set tool3(param1:int) : void
      {
         _tool3 = param1;
      }
      
      public function get tool4() : int
      {
         return _tool4;
      }
      
      public function set tool4(param1:int) : void
      {
         _tool4 = param1;
      }
   }
}

