package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadGuildMsg extends Message implements IExternalizable
   {
      
      private var battle_field_uid$field:String;
      
      private var force_index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var guild_uid$field:String;
      
      private var site$field:String;
      
      private var server_name$field:String;
      
      private var guild_name$field:String;
      
      private var total_fight_capacity$field:Int64;
      
      [ArrayElementType("com.road.yishi.proto.hugehead.HugeHeadUserMsg")]
      public var userList:Array = [];
      
      public function HugeHeadGuildMsg()
      {
         super();
      }
      
      public function removeBattleFieldUid() : void
      {
         battle_field_uid$field = null;
      }
      
      public function get hasBattleFieldUid() : Boolean
      {
         return battle_field_uid$field != null;
      }
      
      public function set battleFieldUid(param1:String) : void
      {
         battle_field_uid$field = param1;
      }
      
      public function get battleFieldUid() : String
      {
         return battle_field_uid$field;
      }
      
      public function removeForceIndex() : void
      {
         hasField$0 &= 4294967294;
         force_index$field = new int();
      }
      
      public function get hasForceIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set forceIndex(param1:int) : void
      {
         hasField$0 |= 1;
         force_index$field = param1;
      }
      
      public function get forceIndex() : int
      {
         return force_index$field;
      }
      
      public function removeGuildUid() : void
      {
         guild_uid$field = null;
      }
      
      public function get hasGuildUid() : Boolean
      {
         return guild_uid$field != null;
      }
      
      public function set guildUid(param1:String) : void
      {
         guild_uid$field = param1;
      }
      
      public function get guildUid() : String
      {
         return guild_uid$field;
      }
      
      public function removeSite() : void
      {
         site$field = null;
      }
      
      public function get hasSite() : Boolean
      {
         return site$field != null;
      }
      
      public function set site(param1:String) : void
      {
         site$field = param1;
      }
      
      public function get site() : String
      {
         return site$field;
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
      
      public function removeGuildName() : void
      {
         guild_name$field = null;
      }
      
      public function get hasGuildName() : Boolean
      {
         return guild_name$field != null;
      }
      
      public function set guildName(param1:String) : void
      {
         guild_name$field = param1;
      }
      
      public function get guildName() : String
      {
         return guild_name$field;
      }
      
      public function removeTotalFightCapacity() : void
      {
         total_fight_capacity$field = null;
      }
      
      public function get hasTotalFightCapacity() : Boolean
      {
         return total_fight_capacity$field != null;
      }
      
      public function set totalFightCapacity(param1:Int64) : void
      {
         total_fight_capacity$field = param1;
      }
      
      public function get totalFightCapacity() : Int64
      {
         return total_fight_capacity$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBattleFieldUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,battle_field_uid$field);
         }
         if(hasForceIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,force_index$field);
         }
         if(hasGuildUid)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,guild_uid$field);
         }
         if(hasSite)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,site$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasGuildName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,guild_name$field);
         }
         if(hasTotalFightCapacity)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,total_fight_capacity$field);
         }
         _loc2_ = 0;
         while(_loc2_ < userList.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,userList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:HugeHeadUserMsg = null;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.battleFieldUid cannot be set twice.");
                  }
                  _loc6_++;
                  battleFieldUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.forceIndex cannot be set twice.");
                  }
                  _loc8_++;
                  forceIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.guildUid cannot be set twice.");
                  }
                  _loc10_++;
                  guildUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.site cannot be set twice.");
                  }
                  _loc3_++;
                  site = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.serverName cannot be set twice.");
                  }
                  _loc9_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.guildName cannot be set twice.");
                  }
                  _loc4_++;
                  guildName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadGuildMsg.totalFightCapacity cannot be set twice.");
                  }
                  _loc11_++;
                  totalFightCapacity = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 7:
                  _loc5_ = new HugeHeadUserMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  userList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

