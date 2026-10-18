package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnowVehicleSimpleInfoMsg extends Message implements IExternalizable
   {
      
      private var matchOrCancel$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curNum$field:int;
      
      private var userId$field:int;
      
      private var groupId$field:String;
      
      private var serverName$field:String;
      
      public function SnowVehicleSimpleInfoMsg()
      {
         super();
      }
      
      public function removeMatchOrCancel() : void
      {
         hasField$0 &= 4294967294;
         matchOrCancel$field = new int();
      }
      
      public function get hasMatchOrCancel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set matchOrCancel(param1:int) : void
      {
         hasField$0 |= 1;
         matchOrCancel$field = param1;
      }
      
      public function get matchOrCancel() : int
      {
         return matchOrCancel$field;
      }
      
      public function removeCurNum() : void
      {
         hasField$0 &= 4294967293;
         curNum$field = new int();
      }
      
      public function get hasCurNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curNum(param1:int) : void
      {
         hasField$0 |= 2;
         curNum$field = param1;
      }
      
      public function get curNum() : int
      {
         return curNum$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeGroupId() : void
      {
         groupId$field = null;
      }
      
      public function get hasGroupId() : Boolean
      {
         return groupId$field != null;
      }
      
      public function set groupId(param1:String) : void
      {
         groupId$field = param1;
      }
      
      public function get groupId() : String
      {
         return groupId$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMatchOrCancel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,matchOrCancel$field);
         }
         if(hasCurNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curNum$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasGroupId)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,groupId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSimpleInfoMsg.matchOrCancel cannot be set twice.");
                  }
                  _loc4_++;
                  matchOrCancel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSimpleInfoMsg.curNum cannot be set twice.");
                  }
                  _loc7_++;
                  curNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSimpleInfoMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSimpleInfoMsg.groupId cannot be set twice.");
                  }
                  _loc8_++;
                  groupId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SnowVehicleSimpleInfoMsg.serverName cannot be set twice.");
                  }
                  _loc3_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

