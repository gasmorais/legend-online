package mvc.module.finaldefense.info
{
   import flash.utils.Dictionary;
   import managers.FinalDefenseManager;
   import yishi.manager.NotificationManager;
   
   public class FinalDefenseInfo
   {
      
      public var ditchTempId1:int;
      
      public var ditchTempId2:int;
      
      public var ditchTempId3:int;
      
      public var ditchTempId4:int;
      
      public var skillCount1:int;
      
      public var skillCount2:int;
      
      public var skillCount3:int;
      
      public var energy:int;
      
      public var score:int;
      
      public var boxTakeMark:int;
      
      private var _rounds:int = 0;
      
      public var op:int;
      
      public var boxId:int;
      
      public var skillIndex:int;
      
      public var npcIndex:int;
      
      public var nextTempIndex:int;
      
      public var selfNPCList:Dictionary;
      
      public var leftSecond:int = 0;
      
      public var id:int;
      
      public function FinalDefenseInfo()
      {
         super();
         selfNPCList = new Dictionary();
      }
      
      public function get rounds() : int
      {
         return _rounds;
      }
      
      public function set rounds(param1:int) : void
      {
         if(_rounds != 0 && param1 != 0 && _rounds != param1)
         {
            NotificationManager.instance.sendNotification("FINAL_DEFENSE_ROUND_OVER");
            FinalDefenseManager.ins.model.isGameStar = false;
         }
         _rounds = param1;
      }
      
      public function delSelfNPC(param1:int) : void
      {
         delete selfNPCList[param1];
      }
   }
}

