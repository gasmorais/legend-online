package mvc.module.treasurehunt
{
   import flash.geom.Point;
   import yishi.datas.ai.AIBaseInfo;
   
   public class HuntPointModel
   {
      
      public static const MAGIC_COIN_TEMPID:int = 2131019;
      
      public var seekCount:int;
      
      public var nextAddTime:Number;
      
      public var state:int;
      
      public var eventDesc:String;
      
      public var curNodeId:int;
      
      public var op:int;
      
      public var nodeList:Vector.<HuntPointData>;
      
      public var aiInfo:AIBaseInfo;
      
      public function HuntPointModel()
      {
         super();
         nodeList = new Vector.<HuntPointData>();
      }
      
      public function getPos() : Point
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < nodeList.length)
         {
            if(nodeList[_loc1_].nodeId == curNodeId)
            {
               return new Point(nodeList[_loc1_].pointX - 19,nodeList[_loc1_].pointY);
            }
            _loc1_++;
         }
         return null;
      }
      
      public function getNodeByNodeId() : HuntPointData
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < nodeList.length)
         {
            if(nodeList[_loc1_].nodeId == curNodeId)
            {
               return nodeList[_loc1_];
            }
            _loc1_++;
         }
         return null;
      }
   }
}

