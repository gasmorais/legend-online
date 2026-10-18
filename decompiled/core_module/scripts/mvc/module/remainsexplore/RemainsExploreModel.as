package mvc.module.remainsexplore
{
   import yishi.utils.SimpleDictionary;
   
   public class RemainsExploreModel
   {
      
      public var tempAreaId:int;
      
      public var tempNodeId:int;
      
      public var tinder:int;
      
      public var canBuyTimes:int;
      
      public var dayLiveness:int;
      
      public var weekLiveness:int;
      
      public var boss1NodeId:int;
      
      public var boss2NodeId:int;
      
      public var nodeList:SimpleDictionary;
      
      public var eventType:int;
      
      public var dayLeedList:Array;
      
      public var weekLeedList:Array;
      
      private var _boxStates:String;
      
      private var _dic:SimpleDictionary;
      
      public function RemainsExploreModel()
      {
         super();
         nodeList = new SimpleDictionary();
         _dic = new SimpleDictionary();
      }
      
      public function getInfoById(param1:int, param2:int) : RemainsExploreNodeInfo
      {
         for each(var _loc3_:RemainsExploreNodeInfo in nodeList.getList())
         {
            if(_loc3_.chapterId == param1 && _loc3_.node == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function get currentInfo() : RemainsExploreNodeInfo
      {
         for each(var _loc1_:RemainsExploreNodeInfo in nodeList.getList())
         {
            if(_loc1_.chapterId == tempAreaId && _loc1_.node == tempNodeId)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function getState(param1:int, param2:int) : int
      {
         var _loc3_:String = param1 + "_" + param2;
         if(_dic[_loc3_])
         {
            return _dic[_loc3_];
         }
         return 0;
      }
      
      public function set boxStates(param1:String) : void
      {
         var _loc3_:Array = null;
         var _loc5_:String = null;
         _boxStates = param1;
         var _loc4_:Array = _boxStates.split(",");
         if(_loc4_)
         {
            for each(var _loc2_:String in _loc4_)
            {
               _loc3_ = _loc2_.split("|");
               if(_loc3_ && _loc3_.length >= 2)
               {
                  _loc5_ = _loc3_[0] + "_" + _loc3_[1];
                  if(!_dic[_loc5_])
                  {
                     _dic.add(_loc5_,_loc3_[2]);
                  }
                  else
                  {
                     _dic[_loc5_] = _loc3_[2];
                  }
               }
            }
         }
      }
   }
}

