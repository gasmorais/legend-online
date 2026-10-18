package mvc.module.outyard
{
   import com.road.yishi.proto.stackhead.StackHeadExploreDiceMsg;
   import com.road.yishi.proto.stackhead.StackHeadExploreNodeMsg;
   import com.road.yishi.proto.stackhead.StackHeadExploreRawNodeMsg;
   import com.road.yishi.proto.stackhead.StackHeadExploreResMsg;
   import flash.utils.Dictionary;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.OutyardManager;
   
   public class OutyardAreaModel
   {
      
      public static const EVENT_BOX:int = 1;
      
      public static const EVENT_NEST:int = 2;
      
      public static const EVENT_RANDOM_MOVE:int = 3;
      
      public static const EVENT_TRAP:int = 4;
      
      private var _nodeDic:Dictionary;
      
      private var _diceDic:Dictionary;
      
      public var curPos:String;
      
      public var exploreNum:int;
      
      public var enterLandId:int;
      
      public var isWalking:Boolean = false;
      
      public var rowNum:int;
      
      public var colNum:int;
      
      public var prePoint:AreaPoint;
      
      public var personAngle:Number;
      
      public function OutyardAreaModel()
      {
         super();
         _nodeDic = new Dictionary();
         _diceDic = new Dictionary();
      }
      
      public function exploreResHandler(param1:StackHeadExploreResMsg) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:AreaPoint = null;
         var _loc10_:Object = null;
         var _loc4_:Dictionary = null;
         var _loc7_:StackHeadExploreNodeMsg = null;
         var _loc6_:StackHeadExploreDiceMsg = null;
         var _loc12_:StackHeadExploreRawNodeMsg = null;
         var _loc5_:Array = null;
         var _loc11_:Array = null;
         if(param1.op == 0 || param1.op == 5)
         {
            if(!param1.result)
            {
               return;
            }
            if(param1.op == 5)
            {
               enterLandId = param1.context.id;
            }
            _nodeDic = new Dictionary();
            _diceDic = new Dictionary();
            _loc4_ = new Dictionary();
            _loc12_ = param1.context.rawNode;
            _loc5_ = _loc12_.node;
            colNum = _loc12_.col;
            rowNum = _loc12_.row;
            _loc8_ = 0;
            while(_loc8_ < _loc5_.length)
            {
               if(_loc5_[_loc8_])
               {
                  _loc10_ = {};
                  _loc10_.col = int(_loc8_ % colNum);
                  _loc10_.row = int(_loc8_ / colNum);
                  _loc10_.id = _loc10_.row + "#" + _loc10_.col;
                  _loc4_[_loc10_.id] = _loc10_;
               }
               _loc8_++;
            }
            _loc11_ = param1.context.node;
            _loc8_ = 0;
            while(_loc8_ < _loc11_.length)
            {
               _loc7_ = _loc11_[_loc8_] as StackHeadExploreNodeMsg;
               _loc2_ = new AreaPoint();
               _loc2_.id = _loc7_.name;
               _loc2_.col = _loc7_.name.split("#")[1];
               _loc2_.row = _loc7_.name.split("#")[0];
               if(_loc4_[_loc2_.row + "#" + (_loc2_.col - 1)])
               {
                  _loc2_.lineArr.push(_loc2_.row + "#" + (_loc2_.col - 1));
               }
               if(_loc4_[_loc2_.row + "#" + (_loc2_.col + 1)])
               {
                  _loc2_.lineArr.push(_loc2_.row + "#" + (_loc2_.col + 1));
               }
               if(_loc4_[_loc2_.row - 1 + "#" + _loc2_.col])
               {
                  _loc2_.lineArr.push(_loc2_.row - 1 + "#" + _loc2_.col);
               }
               if(_loc4_[_loc2_.row + 1 + "#" + _loc2_.col])
               {
                  _loc2_.lineArr.push(_loc2_.row + 1 + "#" + _loc2_.col);
               }
               _loc2_.type = _loc7_.type;
               _loc2_.eventId = _loc7_.eventId;
               _loc2_.eventType = _loc7_.eventType;
               _loc2_.triggered = _loc7_.triggered;
               _nodeDic[_loc2_.id] = _loc2_;
               _loc8_++;
            }
            curPos = param1.explorePlayer.currentPoint;
            _loc3_ = param1.explorePlayer.dice;
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc6_ = _loc3_[_loc8_] as StackHeadExploreDiceMsg;
               _diceDic[_loc6_.id] = _loc6_;
               _loc8_++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("CLICK_AREA_VIEW"));
         }
         else if(param1.op == 1)
         {
            curPos = param1.explorePlayer.currentPoint;
            _loc3_ = param1.explorePlayer.dice;
            OutyardManager.instance.areaModel.isWalking = false;
            if(param1.result)
            {
               _loc8_ = 0;
               while(_loc8_ < _loc3_.length)
               {
                  _loc6_ = _loc3_[_loc8_] as StackHeadExploreDiceMsg;
                  _diceDic[_loc6_.id] = _loc6_;
                  _loc8_++;
               }
               if(!_nodeDic[curPos].triggered)
               {
                  OutyardManager.instance.OperateArea(2);
               }
               NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_AREA_DICE"));
            }
            else
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_AREA_ADJUST",param1));
            }
         }
         else if(param1.op == 2)
         {
            if(param1.result)
            {
               curPos = param1.explorePlayer.currentPoint;
               _loc2_ = _nodeDic[param1.updatedNode.name];
               _loc2_.triggered = param1.updatedNode.triggered;
               NotificationManager.instance.dispatchEvent(new NotificationEvent("UPDATE_AREA_TRIGGER",_loc2_));
            }
         }
         else if(param1.op == 3)
         {
            OutyardManager.instance.areaModel.enterLandId = 0;
         }
         else if(param1.op == 4)
         {
         }
      }
      
      public function get nodeDic() : Dictionary
      {
         return _nodeDic;
      }
      
      public function get diceDic() : Dictionary
      {
         return _diceDic;
      }
      
      public function get myAreaPoint() : AreaPoint
      {
         return _nodeDic[curPos];
      }
   }
}

