package com.road.yishi.proto.module
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RevengeRoadNodeMsg extends Message implements IExternalizable
   {
      
      private var nodeId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var attackCount$field:int;
      
      private var buyCount$field:int;
      
      public function RevengeRoadNodeMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeAttackCount() : void
      {
         hasField$0 &= 4294967293;
         attackCount$field = new int();
      }
      
      public function get hasAttackCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set attackCount(param1:int) : void
      {
         hasField$0 |= 2;
         attackCount$field = param1;
      }
      
      public function get attackCount() : int
      {
         return attackCount$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967291;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 4;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasAttackCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,attackCount$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadNodeMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadNodeMsg.attackCount cannot be set twice.");
                  }
                  _loc5_++;
                  attackCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RevengeRoadNodeMsg.buyCount cannot be set twice.");
                  }
                  _loc4_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

