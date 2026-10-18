package mvc.module.skytreasure.info
{
   public class SkyTreasurePlayerVO
   {
      
      public static const DEFAULT_INTEGRAL:int = -1;
      
      private var _height:int;
      
      private var _integral:int = -1;
      
      public var rank:int;
      
      private var _actionEnergy:int;
      
      public function SkyTreasurePlayerVO()
      {
         super();
      }
      
      public function set integral(param1:int) : void
      {
         _integral = param1;
      }
      
      public function get integral() : int
      {
         return _integral;
      }
      
      public function get height() : int
      {
         return _height;
      }
      
      public function set height(param1:int) : void
      {
         _height = param1;
      }
      
      public function updateHeightAndIntegral(param1:int) : void
      {
         if(param1 == _height)
         {
            return;
         }
         var _loc2_:int = param1 - _height;
         if(_loc2_ < param1 && _loc2_ > -1)
         {
            _integral = _loc2_;
         }
         _height = param1;
      }
      
      public function get actionEnergy() : int
      {
         return _actionEnergy;
      }
      
      public function set actionEnergy(param1:int) : void
      {
         _actionEnergy = param1;
      }
      
      public function useActionEnergy() : void
      {
         if(actionEnergy > 0)
         {
            actionEnergy = actionEnergy - 1;
         }
      }
   }
}

