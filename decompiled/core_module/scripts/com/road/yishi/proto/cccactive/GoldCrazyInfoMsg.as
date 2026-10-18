package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoldCrazyInfoMsg extends Message implements IExternalizable
   {
      
      private var uUID$field:String;
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var serverName$field:String;
      
      private var nickName$field:String;
      
      private var totalConsumPoint$field:int;
      
      private var oneConsumePoint$field:int;
      
      private var order$field:int;
      
      public function GoldCrazyInfoMsg()
      {
         super();
      }
      
      public function removeUUID() : void
      {
         uUID$field = null;
      }
      
      public function get hasUUID() : Boolean
      {
         return uUID$field != null;
      }
      
      public function set uUID(param1:String) : void
      {
         uUID$field = param1;
      }
      
      public function get uUID() : String
      {
         return uUID$field;
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
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeTotalConsumPoint() : void
      {
         hasField$0 &= 4294967293;
         totalConsumPoint$field = new int();
      }
      
      public function get hasTotalConsumPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalConsumPoint(param1:int) : void
      {
         hasField$0 |= 2;
         totalConsumPoint$field = param1;
      }
      
      public function get totalConsumPoint() : int
      {
         return totalConsumPoint$field;
      }
      
      public function removeOneConsumePoint() : void
      {
         hasField$0 &= 4294967291;
         oneConsumePoint$field = new int();
      }
      
      public function get hasOneConsumePoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set oneConsumePoint(param1:int) : void
      {
         hasField$0 |= 4;
         oneConsumePoint$field = param1;
      }
      
      public function get oneConsumePoint() : int
      {
         return oneConsumePoint$field;
      }
      
      public function removeOrder() : void
      {
         hasField$0 &= 4294967287;
         order$field = new int();
      }
      
      public function get hasOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set order(param1:int) : void
      {
         hasField$0 |= 8;
         order$field = param1;
      }
      
      public function get order() : int
      {
         return order$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUUID)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uUID$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasTotalConsumPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,totalConsumPoint$field);
         }
         if(hasOneConsumePoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,oneConsumePoint$field);
         }
         if(hasOrder)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,order$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.uUID cannot be set twice.");
                  }
                  _loc8_++;
                  uUID = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.userId cannot be set twice.");
                  }
                  _loc9_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.totalConsumPoint cannot be set twice.");
                  }
                  _loc7_++;
                  totalConsumPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.oneConsumePoint cannot be set twice.");
                  }
                  _loc5_++;
                  oneConsumePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoldCrazyInfoMsg.order cannot be set twice.");
                  }
                  _loc6_++;
                  order = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

