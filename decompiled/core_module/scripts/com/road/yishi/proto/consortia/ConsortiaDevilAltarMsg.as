package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaDevilAltarMsg extends Message implements IExternalizable
   {
      
      private var blessGrade$field:int;
      
      private var hasField$0:uint = 0;
      
      private var leftNpcCount$field:int;
      
      private var killBossCount$field:int;
      
      private var leftTimeMillis$field:int;
      
      private var killNpcCount$field:int;
      
      private var blessSkillTempId$field:int;
      
      [ArrayElementType("int")]
      public var userIds:Array = [];
      
      public function ConsortiaDevilAltarMsg()
      {
         super();
      }
      
      public function removeBlessGrade() : void
      {
         hasField$0 &= 4294967294;
         blessGrade$field = new int();
      }
      
      public function get hasBlessGrade() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set blessGrade(param1:int) : void
      {
         hasField$0 |= 1;
         blessGrade$field = param1;
      }
      
      public function get blessGrade() : int
      {
         return blessGrade$field;
      }
      
      public function removeLeftNpcCount() : void
      {
         hasField$0 &= 4294967293;
         leftNpcCount$field = new int();
      }
      
      public function get hasLeftNpcCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftNpcCount(param1:int) : void
      {
         hasField$0 |= 2;
         leftNpcCount$field = param1;
      }
      
      public function get leftNpcCount() : int
      {
         return leftNpcCount$field;
      }
      
      public function removeKillBossCount() : void
      {
         hasField$0 &= 4294967291;
         killBossCount$field = new int();
      }
      
      public function get hasKillBossCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set killBossCount(param1:int) : void
      {
         hasField$0 |= 4;
         killBossCount$field = param1;
      }
      
      public function get killBossCount() : int
      {
         return killBossCount$field;
      }
      
      public function removeLeftTimeMillis() : void
      {
         hasField$0 &= 4294967287;
         leftTimeMillis$field = new int();
      }
      
      public function get hasLeftTimeMillis() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftTimeMillis(param1:int) : void
      {
         hasField$0 |= 8;
         leftTimeMillis$field = param1;
      }
      
      public function get leftTimeMillis() : int
      {
         return leftTimeMillis$field;
      }
      
      public function removeKillNpcCount() : void
      {
         hasField$0 &= 4294967279;
         killNpcCount$field = new int();
      }
      
      public function get hasKillNpcCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set killNpcCount(param1:int) : void
      {
         hasField$0 |= 16;
         killNpcCount$field = param1;
      }
      
      public function get killNpcCount() : int
      {
         return killNpcCount$field;
      }
      
      public function removeBlessSkillTempId() : void
      {
         hasField$0 &= 4294967263;
         blessSkillTempId$field = new int();
      }
      
      public function get hasBlessSkillTempId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set blessSkillTempId(param1:int) : void
      {
         hasField$0 |= 32;
         blessSkillTempId$field = param1;
      }
      
      public function get blessSkillTempId() : int
      {
         return blessSkillTempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBlessGrade)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,blessGrade$field);
         }
         if(hasLeftNpcCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,leftNpcCount$field);
         }
         if(hasKillBossCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,killBossCount$field);
         }
         if(hasLeftTimeMillis)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,leftTimeMillis$field);
         }
         if(hasKillNpcCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,killNpcCount$field);
         }
         if(hasBlessSkillTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,blessSkillTempId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < userIds.length)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,userIds[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDevilAltarMsg.blessGrade cannot be set twice.");
                  }
                  _loc4_++;
                  blessGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDevilAltarMsg.leftNpcCount cannot be set twice.");
                  }
                  _loc5_++;
                  leftNpcCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDevilAltarMsg.killBossCount cannot be set twice.");
                  }
                  _loc6_++;
                  killBossCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDevilAltarMsg.leftTimeMillis cannot be set twice.");
                  }
                  _loc3_++;
                  leftTimeMillis = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDevilAltarMsg.killNpcCount cannot be set twice.");
                  }
                  _loc7_++;
                  killNpcCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaDevilAltarMsg.blessSkillTempId cannot be set twice.");
                  }
                  _loc8_++;
                  blessSkillTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if((_loc9_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,userIds);
                  }
                  else
                  {
                     userIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

