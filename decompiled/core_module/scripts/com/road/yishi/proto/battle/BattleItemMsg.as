package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BattleItemMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var battleId$field:String;
      
      private var server_name$field:String;
      
      private var uItemId$field:int;
      
      private var count$field:int;
      
      private var tempId$field:int;
      
      private var bagPos$field:int;
      
      private var skillTempId$field:int;
      
      private var sonType$field:int;
      
      public function BattleItemMsg()
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
      
      public function removeBattleId() : void
      {
         battleId$field = null;
      }
      
      public function get hasBattleId() : Boolean
      {
         return battleId$field != null;
      }
      
      public function set battleId(param1:String) : void
      {
         battleId$field = param1;
      }
      
      public function get battleId() : String
      {
         return battleId$field;
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
      
      public function removeUItemId() : void
      {
         hasField$0 &= 4294967293;
         uItemId$field = new int();
      }
      
      public function get hasUItemId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set uItemId(param1:int) : void
      {
         hasField$0 |= 2;
         uItemId$field = param1;
      }
      
      public function get uItemId() : int
      {
         return uItemId$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967287;
         tempId$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 8;
         tempId$field = param1;
      }
      
      public function get tempId() : int
      {
         return tempId$field;
      }
      
      public function removeBagPos() : void
      {
         hasField$0 &= 4294967279;
         bagPos$field = new int();
      }
      
      public function get hasBagPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set bagPos(param1:int) : void
      {
         hasField$0 |= 16;
         bagPos$field = param1;
      }
      
      public function get bagPos() : int
      {
         return bagPos$field;
      }
      
      public function removeSkillTempId() : void
      {
         hasField$0 &= 4294967263;
         skillTempId$field = new int();
      }
      
      public function get hasSkillTempId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set skillTempId(param1:int) : void
      {
         hasField$0 |= 32;
         skillTempId$field = param1;
      }
      
      public function get skillTempId() : int
      {
         return skillTempId$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967231;
         sonType$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 64;
         sonType$field = param1;
      }
      
      public function get sonType() : int
      {
         return sonType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasBattleId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,battleId$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasUItemId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,uItemId$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,tempId$field);
         }
         if(hasBagPos)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,bagPos$field);
         }
         if(hasSkillTempId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,skillTempId$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,sonType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.userId cannot be set twice.");
                  }
                  _loc8_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.battleId cannot be set twice.");
                  }
                  _loc10_++;
                  battleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.serverName cannot be set twice.");
                  }
                  _loc11_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.uItemId cannot be set twice.");
                  }
                  _loc12_++;
                  uItemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.tempId cannot be set twice.");
                  }
                  _loc5_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.bagPos cannot be set twice.");
                  }
                  _loc7_++;
                  bagPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.skillTempId cannot be set twice.");
                  }
                  _loc6_++;
                  skillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BattleItemMsg.sonType cannot be set twice.");
                  }
                  _loc3_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

