package mvc.module.war2023.info
{
   public class SecretwarResultInfo
   {
      
      public var winCamp:int;
      
      public var blueScore:int;
      
      public var redScore:int;
      
      public var allkList:Array = [];
      
      public var blueList:Array = [];
      
      public var redList:Array = [];
      
      public var isOver:Boolean = false;
      
      public function SecretwarResultInfo()
      {
         super();
      }
      
      public function clear() : void
      {
         allkList.length = 0;
         blueList.length = 0;
         redList.length = 0;
      }
      
      public function doRank() : void
      {
         allkList.sortOn(["score","fightPower"],[0x10 | 2,0x10 | 2]);
         blueList.sortOn(["score","fightPower"],[0x10 | 2,0x10 | 2]);
         redList.sortOn(["score","fightPower"],[0x10 | 2,0x10 | 2]);
      }
   }
}

