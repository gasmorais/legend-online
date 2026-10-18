package mvc.module.revenge
{
   import flash.utils.Dictionary;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.RevengeRoadTempInfo;
   import yishi.manager.TempleteManager;
   
   public class RevengeModel
   {
      
      public var op:int;
      
      public var nodeId:int;
      
      public var revengeHeart:int;
      
      public var buyCount:int;
      
      public var updateTime:String;
      
      public var boxState:String = "";
      
      public var currFightNodeId:int = -1;
      
      public var selectNodeID:int;
      
      public var nodeDic:Dictionary = new Dictionary();
      
      public var MAX_VALUE:int;
      
      public var renewNum:int;
      
      public var buyTimeMax:int;
      
      public var buyTimePrice:int;
      
      public var bossMaxBuyNum:int;
      
      public var bossMaxBuyPrice:int;
      
      public function RevengeModel()
      {
         var _loc1_:Array = null;
         super();
         var _loc2_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("revenge_road_config");
         if(_loc2_)
         {
            _loc1_ = _loc2_.ConfigValue.split(",");
            if(_loc1_)
            {
               MAX_VALUE = int(_loc1_[0]);
               renewNum = int(_loc1_[1]);
               buyTimeMax = int(_loc1_[2]);
               buyTimePrice = int(_loc1_[3]);
               bossMaxBuyNum = int(_loc1_[4]);
               bossMaxBuyPrice = int(_loc1_[5]);
            }
         }
      }
      
      public function checkIsNeedBuyAlert(param1:int) : Boolean
      {
         var _loc2_:RevengeRoadTempInfo = TempleteManager.instance.revengeRoadTempCate.getTempInfo(param1);
         var _loc3_:int = buyTimeMax - buyCount;
         if(revengeHeart < _loc2_.Cost && _loc3_ > 0)
         {
            return true;
         }
         return false;
      }
   }
}

