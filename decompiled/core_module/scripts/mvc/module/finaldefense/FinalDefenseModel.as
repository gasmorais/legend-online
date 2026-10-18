package mvc.module.finaldefense
{
   import flash.utils.Dictionary;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import mvc.module.finaldefense.info.FinalDefenseInfo;
   
   public class FinalDefenseModel
   {
      
      public var info:FinalDefenseInfo;
      
      public var npcList:Dictionary;
      
      public var isGameStar:Boolean = false;
      
      public var dropDict:Dictionary;
      
      public function FinalDefenseModel()
      {
         super();
         info = new FinalDefenseInfo();
         npcList = new Dictionary();
         dropDict = new Dictionary();
      }
      
      public function hasMonsterByRow(param1:int) : Boolean
      {
         var _loc3_:Boolean = false;
         for each(var _loc2_:DitchNpcInfoData in npcList)
         {
            if(_loc2_.rowIndex == param1)
            {
               _loc3_ = true;
               break;
            }
         }
         return _loc3_;
      }
      
      public function getMonsterIdByRow(param1:int) : int
      {
         var _loc3_:int = -1;
         for each(var _loc2_:DitchNpcInfoData in npcList)
         {
            if(_loc2_.rowIndex == param1)
            {
               _loc3_ = _loc2_.id;
               break;
            }
         }
         return _loc3_;
      }
      
      public function delDeaNPC(param1:int) : void
      {
         delete npcList[param1];
      }
      
      public function delDeaSelfNPC(param1:int) : void
      {
         info.delSelfNPC(param1);
      }
      
      public function cleanMonsterData() : void
      {
         for(var _loc1_:String in npcList)
         {
            delete npcList[_loc1_];
         }
      }
      
      public function getSelfNpcByRow(param1:int) : int
      {
         var _loc3_:int = -1;
         for each(var _loc2_:DitchNpcInfoData in info.selfNPCList)
         {
            if(_loc2_.rowIndex == param1)
            {
               _loc3_ = _loc2_.id;
               break;
            }
         }
         return _loc3_;
      }
   }
}

