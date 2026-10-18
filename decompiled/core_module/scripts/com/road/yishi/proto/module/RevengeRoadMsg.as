package com.road.yishi.proto.module
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RevengeRoadMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nodeId$field:int;
      
      private var revengeHeart$field:int;
      
      private var buyCount$field:int;
      
      private var updateTime$field:String;
      
      private var boxState$field:String;
      
      [ArrayElementType("com.road.yishi.proto.module.RevengeRoadNodeMsg")]
      public var nodeList:Array = [];
      
      public function RevengeRoadMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967293;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 2;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeRevengeHeart() : void
      {
         hasField$0 &= 4294967291;
         revengeHeart$field = new int();
      }
      
      public function get hasRevengeHeart() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set revengeHeart(param1:int) : void
      {
         hasField$0 |= 4;
         revengeHeart$field = param1;
      }
      
      public function get revengeHeart() : int
      {
         return revengeHeart$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967287;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 8;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeUpdateTime() : void
      {
         updateTime$field = null;
      }
      
      public function get hasUpdateTime() : Boolean
      {
         return updateTime$field != null;
      }
      
      public function set updateTime(param1:String) : void
      {
         updateTime$field = param1;
      }
      
      public function get updateTime() : String
      {
         return updateTime$field;
      }
      
      public function removeBoxState() : void
      {
         boxState$field = null;
      }
      
      public function get hasBoxState() : Boolean
      {
         return boxState$field != null;
      }
      
      public function set boxState(param1:String) : void
      {
         boxState$field = param1;
      }
      
      public function get boxState() : String
      {
         return boxState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasRevengeHeart)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,revengeHeart$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasUpdateTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,updateTime$field);
         }
         if(hasBoxState)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,boxState$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeList.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:RevengeRoadNodeMsg = null;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadMsg.revengeHeart cannot be set twice.");
                  }
                  _loc10_++;
                  revengeHeart = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadMsg.buyCount cannot be set twice.");
                  }
                  _loc6_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadMsg.updateTime cannot be set twice.");
                  }
                  _loc4_++;
                  updateTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadMsg.boxState cannot be set twice.");
                  }
                  _loc7_++;
                  boxState = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  _loc5_ = new RevengeRoadNodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  nodeList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

