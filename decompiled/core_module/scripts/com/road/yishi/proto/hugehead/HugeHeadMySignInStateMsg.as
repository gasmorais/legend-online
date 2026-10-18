package com.road.yishi.proto.hugehead
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HugeHeadMySignInStateMsg extends Message implements IExternalizable
   {
      
      private var guild_sign_in$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var guild_join$field:Boolean;
      
      private var self_join$field:Boolean;
      
      private var force_index$field:int;
      
      private var my_guild_uid$field:String;
      
      private var dig_today_remain_count$field:int;
      
      private var dig_extra_count$field:int;
      
      public function HugeHeadMySignInStateMsg()
      {
         super();
      }
      
      public function removeGuildSignIn() : void
      {
         hasField$0 &= 4294967294;
         guild_sign_in$field = new Boolean();
      }
      
      public function get hasGuildSignIn() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set guildSignIn(param1:Boolean) : void
      {
         hasField$0 |= 1;
         guild_sign_in$field = param1;
      }
      
      public function get guildSignIn() : Boolean
      {
         return guild_sign_in$field;
      }
      
      public function removeGuildJoin() : void
      {
         hasField$0 &= 4294967293;
         guild_join$field = new Boolean();
      }
      
      public function get hasGuildJoin() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set guildJoin(param1:Boolean) : void
      {
         hasField$0 |= 2;
         guild_join$field = param1;
      }
      
      public function get guildJoin() : Boolean
      {
         return guild_join$field;
      }
      
      public function removeSelfJoin() : void
      {
         hasField$0 &= 4294967291;
         self_join$field = new Boolean();
      }
      
      public function get hasSelfJoin() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set selfJoin(param1:Boolean) : void
      {
         hasField$0 |= 4;
         self_join$field = param1;
      }
      
      public function get selfJoin() : Boolean
      {
         return self_join$field;
      }
      
      public function removeForceIndex() : void
      {
         hasField$0 &= 4294967287;
         force_index$field = new int();
      }
      
      public function get hasForceIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set forceIndex(param1:int) : void
      {
         hasField$0 |= 8;
         force_index$field = param1;
      }
      
      public function get forceIndex() : int
      {
         return force_index$field;
      }
      
      public function removeMyGuildUid() : void
      {
         my_guild_uid$field = null;
      }
      
      public function get hasMyGuildUid() : Boolean
      {
         return my_guild_uid$field != null;
      }
      
      public function set myGuildUid(param1:String) : void
      {
         my_guild_uid$field = param1;
      }
      
      public function get myGuildUid() : String
      {
         return my_guild_uid$field;
      }
      
      public function removeDigTodayRemainCount() : void
      {
         hasField$0 &= 4294967279;
         dig_today_remain_count$field = new int();
      }
      
      public function get hasDigTodayRemainCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set digTodayRemainCount(param1:int) : void
      {
         hasField$0 |= 16;
         dig_today_remain_count$field = param1;
      }
      
      public function get digTodayRemainCount() : int
      {
         return dig_today_remain_count$field;
      }
      
      public function removeDigExtraCount() : void
      {
         hasField$0 &= 4294967263;
         dig_extra_count$field = new int();
      }
      
      public function get hasDigExtraCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set digExtraCount(param1:int) : void
      {
         hasField$0 |= 32;
         dig_extra_count$field = param1;
      }
      
      public function get digExtraCount() : int
      {
         return dig_extra_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGuildSignIn)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,guild_sign_in$field);
         }
         if(hasGuildJoin)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,guild_join$field);
         }
         if(hasSelfJoin)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,self_join$field);
         }
         if(hasForceIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,force_index$field);
         }
         if(hasMyGuildUid)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,my_guild_uid$field);
         }
         if(hasDigTodayRemainCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,dig_today_remain_count$field);
         }
         if(hasDigExtraCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,dig_extra_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.guildSignIn cannot be set twice.");
                  }
                  _loc4_++;
                  guildSignIn = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.guildJoin cannot be set twice.");
                  }
                  _loc9_++;
                  guildJoin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.selfJoin cannot be set twice.");
                  }
                  _loc5_++;
                  selfJoin = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.forceIndex cannot be set twice.");
                  }
                  _loc8_++;
                  forceIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.myGuildUid cannot be set twice.");
                  }
                  _loc3_++;
                  myGuildUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.digTodayRemainCount cannot be set twice.");
                  }
                  _loc6_++;
                  digTodayRemainCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HugeHeadMySignInStateMsg.digExtraCount cannot be set twice.");
                  }
                  _loc10_++;
                  digExtraCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

