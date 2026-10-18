package map.campaign.data
{
   public class FantasyMatrixModel
   {
      
      public static const BOX_TEMP_ID:int = 2131515;
      
      public var isStart:Boolean;
      
      public var leftTime:int;
      
      public var curScore:int;
      
      public var hasBoxCount:int;
      
      public var skillAttackUpCount:int;
      
      public var skillScoreUpCount:int;
      
      public var skillAddScoreCount:int;
      
      public var nodeArr:Array;
      
      public function FantasyMatrixModel()
      {
         super();
         nodeArr = [];
      }
      
      public function getNodeInfoByXY(param1:int, param2:int) : FantasyMatrixNodeInfo
      {
         for each(var _loc3_:FantasyMatrixNodeInfo in nodeArr)
         {
            if(param1 == _loc3_.posX && param2 == _loc3_.posY)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

