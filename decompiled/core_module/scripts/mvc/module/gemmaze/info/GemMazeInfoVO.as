package mvc.module.gemmaze.info
{
   import yishi.manager.InfoTipsManager;
   
   public class GemMazeInfoVO
   {
      
      private var _gemArr:Array;
      
      public var score:int;
      
      private var _timesLeft:int;
      
      public var buyTimesLeft:int;
      
      public var helpTimesLeft:int;
      
      public var gemLevel:int;
      
      public var curExp:int;
      
      public var maxExp:int;
      
      private var _boxMark:int;
      
      private var _boxMarkArr:Array = [];
      
      public var sort:int;
      
      public var weekScore:int;
      
      public function GemMazeInfoVO()
      {
         super();
         gemArr = [];
      }
      
      public function get timesLeft() : int
      {
         return _timesLeft;
      }
      
      public function set timesLeft(param1:int) : void
      {
         if(_timesLeft != param1)
         {
            InfoTipsManager.instance.updateValue(19,param1);
         }
         _timesLeft = param1;
      }
      
      public function get boxMarkArr() : Array
      {
         return _boxMarkArr;
      }
      
      public function set boxMark(param1:int) : void
      {
         var _loc3_:int = 0;
         _boxMark = param1;
         _boxMarkArr = [0,0,0,0,0];
         var _loc2_:String = _boxMark.toString(2);
         _loc3_ = _loc2_.length - 1;
         while(_loc3_ >= 0)
         {
            if(_loc3_ >= _boxMarkArr.length)
            {
               return;
            }
            _boxMarkArr[_loc3_] = int(_loc2_.substr(_loc2_.length - 1 - _loc3_,1));
            _loc3_--;
         }
      }
      
      public function get gemArr() : Array
      {
         return _gemArr;
      }
      
      public function set gemArr(param1:Array) : void
      {
         _gemArr = param1;
      }
      
      public function getBoxStatusByIndex(param1:int) : int
      {
         return 1;
      }
      
      public function getGemMazeGemInfoVOByIndex(param1:int) : GemMazeGemInfoVO
      {
         var _loc3_:int = 0;
         var _loc2_:GemMazeGemInfoVO = null;
         _loc3_ = 0;
         while(_loc3_ < gemArr.length)
         {
            if(gemArr[_loc3_].index == param1)
            {
               _loc2_ = gemArr[_loc3_];
            }
            _loc3_++;
         }
         return _loc2_;
      }
   }
}

