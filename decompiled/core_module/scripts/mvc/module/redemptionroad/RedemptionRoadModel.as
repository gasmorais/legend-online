package mvc.module.redemptionroad
{
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class RedemptionRoadModel
   {
      
      private var _difficulty:int;
      
      public var curLayer:int;
      
      public var roadPaths:Array;
      
      public var maxLayer:int;
      
      public var nodeDic:SimpleDictionary;
      
      private var _selectPos:int;
      
      public var cdEndTime:Date;
      
      public var maxDiffCount:int = 3;
      
      public function RedemptionRoadModel()
      {
         super();
         roadPaths = [];
         nodeDic = new SimpleDictionary();
         maxLayer = ConfigInfoManager.instance.getRedemptionRoadLayerConfig().length;
      }
      
      public function get selectPos() : int
      {
         return _selectPos;
      }
      
      public function set selectPos(param1:int) : void
      {
         if(_selectPos == param1)
         {
            return;
         }
         _selectPos = param1;
         MsgMan.notifyObserver("NODE_POS_SELECT");
      }
      
      public function get difficulty() : int
      {
         return _difficulty;
      }
      
      public function set difficulty(param1:int) : void
      {
         if(_difficulty == param1)
         {
            return;
         }
         _difficulty = param1;
         MsgMan.notifyObserver("DIFF_CHANGE");
      }
      
      public function getShowNodeInfo(param1:int = 0) : RedemptionRoadNodeInfo
      {
         if(isClearance)
         {
            return null;
         }
         if(nodeDic[curLayer + "_" + param1])
         {
            return nodeDic[curLayer + "_" + param1] as RedemptionRoadNodeInfo;
         }
         return null;
      }
      
      public function get isClearance() : Boolean
      {
         return difficulty >= maxDiffCount && curLayer > maxLayer;
      }
      
      public function getNodeInfoById(param1:int) : RedemptionRoadNodeInfo
      {
         for each(var _loc2_:RedemptionRoadNodeInfo in nodeDic)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function get isCding() : Boolean
      {
         return cdEndTime.time > PlayerManager.instance.currentPlayerModel.sysCurtime.time;
      }
   }
}

