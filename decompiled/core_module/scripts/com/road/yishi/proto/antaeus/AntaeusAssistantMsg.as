package com.road.yishi.proto.antaeus
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AntaeusAssistantMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var order$field:int;
      
      private var power$field:int;
      
      private var assists$field:int;
      
      private var showData$field:AssistantDataMsg;
      
      public function AntaeusAssistantMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967293;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 2;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      public function removePower() : void
      {
         hasField$0 &= 4294967291;
         power$field = new int();
      }
      
      public function get hasPower() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set power(param1:int) : void
      {
         hasField$0 |= 4;
         power$field = param1;
      }
      
      public function get power() : int
      {
         return power$field;
      }
      
      public function removeAssists() : void
      {
         hasField$0 &= 4294967287;
         assists$field = new int();
      }
      
      public function get hasAssists() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set assists(param1:int) : void
      {
         hasField$0 |= 8;
         assists$field = param1;
      }
      
      public function get assists() : int
      {
         return assists$field;
      }
      
      public function removeShowData() : void
      {
         showData$field = null;
      }
      
      public function get hasShowData() : Boolean
      {
         return showData$field != null;
      }
      
      public function set showData(param1:AssistantDataMsg) : void
      {
         showData$field = param1;
      }
      
      public function get showData() : AssistantDataMsg
      {
         return showData$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
         if(hasPower)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,power$field);
         }
         if(hasAssists)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,assists$field);
         }
         if(hasShowData)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,showData$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusAssistantMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusAssistantMsg.order cannot be set twice.");
                  }
                  _loc4_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusAssistantMsg.power cannot be set twice.");
                  }
                  _loc5_++;
                  power = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusAssistantMsg.assists cannot be set twice.");
                  }
                  _loc3_++;
                  assists = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AntaeusAssistantMsg.showData cannot be set twice.");
                  }
                  _loc8_++;
                  showData = new AssistantDataMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,showData);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

