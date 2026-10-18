package mvc.module.remainsexplore
{
   public class RemainsExploreNodeInfo
   {
      
      public var checkpointId:int;
      
      public var chapterId:int;
      
      public var node:int;
      
      public var progress:int;
      
      public var exploreCost:int;
      
      public var isBoss1Pass:Boolean;
      
      public var isBoss2Pass:Boolean;
      
      public function RemainsExploreNodeInfo()
      {
         super();
      }
      
      public function get isShowBoss1() : Boolean
      {
         return !isBoss1Pass && progress >= 50;
      }
      
      public function get isShowBoss2() : Boolean
      {
         return !isBoss2Pass && progress >= 100;
      }
   }
}

