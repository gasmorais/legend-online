package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GetTreasuryMsg extends Message implements IExternalizable
   {
      
      private var get_hour$field:int;
      
      private var hasField$0:uint = 0;
      
      private var temp_id$field:int;
      
      private var type$field:int;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      public function GetTreasuryMsg()
      {
         super();
      }
      
      public function removeGetHour() : void
      {
         hasField$0 &= 4294967294;
         get_hour$field = new int();
      }
      
      public function get hasGetHour() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set getHour(param1:int) : void
      {
         hasField$0 |= 1;
         get_hour$field = param1;
      }
      
      public function get getHour() : int
      {
         return get_hour$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967293;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 2;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967287;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 8;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967279;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 16;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGetHour)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,get_hour$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GetTreasuryMsg.getHour cannot be set twice.");
                  }
                  _loc4_++;
                  getHour = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GetTreasuryMsg.tempId cannot be set twice.");
                  }
                  _loc7_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GetTreasuryMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GetTreasuryMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GetTreasuryMsg.param2 cannot be set twice.");
                  }
                  _loc8_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

