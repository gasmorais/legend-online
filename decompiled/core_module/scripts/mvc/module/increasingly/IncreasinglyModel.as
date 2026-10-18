package mvc.module.increasingly
{
   import flash.events.EventDispatcher;
   
   public class IncreasinglyModel extends EventDispatcher
   {
      
      public var energy:int;
      
      public var currentLayer:int;
      
      public var currentIndex:int;
      
      public var todayHasBuyCount:int;
      
      public var enterBattleCostEnergy:int;
      
      public var bossInfos:Array;
      
      public var maxLayer:int;
      
      public var isRefresh:Boolean;
      
      public function IncreasinglyModel()
      {
         super();
      }
   }
}

