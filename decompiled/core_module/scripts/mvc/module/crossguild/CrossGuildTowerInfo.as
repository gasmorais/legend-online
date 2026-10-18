package mvc.module.crossguild
{
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.CrossGuildManager;
   
   public class CrossGuildTowerInfo
   {
      
      public var teamId:int;
      
      public var towerId:int;
      
      public var nickName:String;
      
      public var fightPower:int;
      
      public var questId:int;
      
      public var troubleCount:int;
      
      public var userBufferId:int;
      
      public var sealAry:Array;
      
      public var defendRecordList:Array;
      
      public var attackCount:int;
      
      public var troubleMaxCount:int;
      
      public var state:int;
      
      public var towerType:int;
      
      private var _blood:int;
      
      public var totalBlood:int;
      
      public function CrossGuildTowerInfo()
      {
         super();
         sealAry = [];
         defendRecordList = [];
      }
      
      public function get blood() : int
      {
         return _blood;
      }
      
      public function set blood(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:Array = null;
         var _loc5_:Array = null;
         _blood = param1;
         if(model.defendNum == 12)
         {
            _loc2_ = ConfigInfoManager.instance.getCrossGuildWarDefend();
            _loc3_ = ConfigInfoManager.instance.getCrossGuildWarSkin();
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = _loc2_[_loc4_].split(",");
            if(towerId >= _loc6_[0] && towerId <= _loc6_[1])
            {
               totalBlood = _loc6_[2];
            }
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_].split(",");
            if(towerId >= _loc5_[0] && towerId <= _loc5_[1])
            {
               towerType = _loc5_[2];
            }
            _loc4_++;
         }
         if(blood / totalBlood > 0.75)
         {
            state = 1;
         }
         else if(blood / totalBlood > 0.2)
         {
            state = 2;
         }
         else
         {
            state = 3;
         }
      }
      
      private function get model() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
   }
}

