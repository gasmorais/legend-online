package mvc.module.forbiddenboss
{
   import yishi.utils.SimpleDictionary;
   
   public class ForbiddenBossModel
   {
      
      private var _belongReward:String;
      
      private var _joinReward:String;
      
      private var _firstReward:String;
      
      public var areaName:String;
      
      public var bossList:Array = [];
      
      public var needverify:Boolean = false;
      
      public var belongRewardDic:SimpleDictionary;
      
      public var joinRewardDic:SimpleDictionary;
      
      public var firstRewardDic:SimpleDictionary;
      
      public var recordArr:Array = [];
      
      public var rankList:Array = [];
      
      public var maxHp:Number = 0;
      
      public var ConsortiaName:String = "";
      
      public var SelectBoss:int = 0;
      
      public function ForbiddenBossModel()
      {
         super();
         belongRewardDic = new SimpleDictionary();
         joinRewardDic = new SimpleDictionary();
         firstRewardDic = new SimpleDictionary();
      }
      
      public function set belongReward(param1:String) : void
      {
         splitArr(param1,belongRewardDic);
      }
      
      public function set joinReward(param1:String) : void
      {
         splitArr(param1,joinRewardDic);
      }
      
      public function set firstReward(param1:String) : void
      {
         splitArr(param1,firstRewardDic);
      }
      
      private function splitArr(param1:String, param2:SimpleDictionary) : void
      {
         var _loc5_:int = 0;
         param2.clear();
         var _loc4_:Array = param1.split("|");
         var _loc3_:Array = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_].split(",");
            if(_loc3_ && _loc3_.length == 2)
            {
               param2.add(_loc3_[0],_loc3_[1]);
            }
            _loc5_++;
         }
      }
   }
}

