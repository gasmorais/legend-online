package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PassItem extends Message implements IExternalizable
   {
      
      private var level$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_name$field:String;
      
      private var server_name$field:String;
      
      private var reward_type$field:int;
      
      private var egg_type$field:int;
      
      public function PassItem()
      {
         super();
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967294;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 1;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeUserName() : void
      {
         user_name$field = null;
      }
      
      public function get hasUserName() : Boolean
      {
         return user_name$field != null;
      }
      
      public function set userName(param1:String) : void
      {
         user_name$field = param1;
      }
      
      public function get userName() : String
      {
         return user_name$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeRewardType() : void
      {
         hasField$0 &= 4294967293;
         reward_type$field = new int();
      }
      
      public function get hasRewardType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardType(param1:int) : void
      {
         hasField$0 |= 2;
         reward_type$field = param1;
      }
      
      public function get rewardType() : int
      {
         return reward_type$field;
      }
      
      public function removeEggType() : void
      {
         hasField$0 &= 4294967291;
         egg_type$field = new int();
      }
      
      public function get hasEggType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set eggType(param1:int) : void
      {
         hasField$0 |= 4;
         egg_type$field = param1;
      }
      
      public function get eggType() : int
      {
         return egg_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasUserName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,user_name$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasRewardType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,reward_type$field);
         }
         if(hasEggType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,egg_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PassItem.level cannot be set twice.");
                  }
                  _loc4_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PassItem.userName cannot be set twice.");
                  }
                  _loc5_++;
                  userName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PassItem.serverName cannot be set twice.");
                  }
                  _loc8_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PassItem.rewardType cannot be set twice.");
                  }
                  _loc6_++;
                  rewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PassItem.eggType cannot be set twice.");
                  }
                  _loc3_++;
                  eggType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

