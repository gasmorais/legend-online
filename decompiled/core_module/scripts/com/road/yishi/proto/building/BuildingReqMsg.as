package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BuildingReqMsg extends Message implements IExternalizable
   {
      
      private var order_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var position$field:String;
      
      private var index$field:int;
      
      private var user_id$field:int;
      
      public function BuildingReqMsg()
      {
         super();
      }
      
      public function removeOrderId() : void
      {
         hasField$0 &= 4294967294;
         order_id$field = new int();
      }
      
      public function get hasOrderId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set orderId(param1:int) : void
      {
         hasField$0 |= 1;
         order_id$field = param1;
      }
      
      public function get orderId() : int
      {
         return order_id$field;
      }
      
      public function removePosition() : void
      {
         position$field = null;
      }
      
      public function get hasPosition() : Boolean
      {
         return position$field != null;
      }
      
      public function set position(param1:String) : void
      {
         position$field = param1;
      }
      
      public function get position() : String
      {
         return position$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967293;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 2;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOrderId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,order_id$field);
         }
         if(hasPosition)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,position$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingReqMsg.orderId cannot be set twice.");
                  }
                  _loc6_++;
                  orderId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingReqMsg.position cannot be set twice.");
                  }
                  _loc4_++;
                  position = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingReqMsg.index cannot be set twice.");
                  }
                  _loc3_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingReqMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

