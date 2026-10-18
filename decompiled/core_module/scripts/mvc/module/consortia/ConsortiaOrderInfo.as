package mvc.module.consortia
{
   import yishi.utils.ClassFactory;
   
   public class ConsortiaOrderInfo
   {
      
      public var consortiaID:int;
      
      public var gradeOrder:int;
      
      public var fightPowerOrder:int;
      
      public var offer:int;
      
      public var lastDayOffer:int;
      
      private var _lastDayDate:Object;
      
      public var lastDayOrder:int;
      
      public var lastWeekOffer:int;
      
      private var _lastWeekDate:Object;
      
      public var lastWeekOrder:int;
      
      public function ConsortiaOrderInfo()
      {
         super();
      }
      
      public function get lastDayDate() : Object
      {
         return _lastDayDate;
      }
      
      public function set lastDayDate(param1:Object) : void
      {
         if(_lastDayDate is Date)
         {
            _lastDayDate = param1;
         }
         else
         {
            _lastDayDate = ClassFactory.copyDateType(param1);
         }
      }
      
      public function get lastWeekDate() : Object
      {
         return _lastWeekDate;
      }
      
      public function set lastWeekDate(param1:Object) : void
      {
         if(_lastWeekDate is Date)
         {
            _lastWeekDate = param1;
         }
         else
         {
            _lastWeekDate = ClassFactory.copyDateType(param1);
         }
      }
   }
}

