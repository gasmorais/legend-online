package com.road.yishi.proto.army
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MapBossMsg extends Message implements IExternalizable
   {
      
      private var count1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count2$field:int;
      
      private var count3$field:int;
      
      [ArrayElementType("com.road.yishi.proto.army.BossMsg")]
      public var bosslist:Array = [];
      
      private var leftBossTime$field:int;
      
      private var leftFogTime$field:int;
      
      private var archaeologyKillCount$field:int;
      
      private var atchaeologyMonsterCount$field:int;
      
      public function MapBossMsg()
      {
         super();
      }
      
      public function removeCount1() : void
      {
         hasField$0 &= 4294967294;
         count1$field = new int();
      }
      
      public function get hasCount1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set count1(param1:int) : void
      {
         hasField$0 |= 1;
         count1$field = param1;
      }
      
      public function get count1() : int
      {
         return count1$field;
      }
      
      public function removeCount2() : void
      {
         hasField$0 &= 4294967293;
         count2$field = new int();
      }
      
      public function get hasCount2() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count2(param1:int) : void
      {
         hasField$0 |= 2;
         count2$field = param1;
      }
      
      public function get count2() : int
      {
         return count2$field;
      }
      
      public function removeCount3() : void
      {
         hasField$0 &= 4294967291;
         count3$field = new int();
      }
      
      public function get hasCount3() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count3(param1:int) : void
      {
         hasField$0 |= 4;
         count3$field = param1;
      }
      
      public function get count3() : int
      {
         return count3$field;
      }
      
      public function removeLeftBossTime() : void
      {
         hasField$0 &= 4294967287;
         leftBossTime$field = new int();
      }
      
      public function get hasLeftBossTime() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set leftBossTime(param1:int) : void
      {
         hasField$0 |= 8;
         leftBossTime$field = param1;
      }
      
      public function get leftBossTime() : int
      {
         return leftBossTime$field;
      }
      
      public function removeLeftFogTime() : void
      {
         hasField$0 &= 4294967279;
         leftFogTime$field = new int();
      }
      
      public function get hasLeftFogTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set leftFogTime(param1:int) : void
      {
         hasField$0 |= 16;
         leftFogTime$field = param1;
      }
      
      public function get leftFogTime() : int
      {
         return leftFogTime$field;
      }
      
      public function removeArchaeologyKillCount() : void
      {
         hasField$0 &= 4294967263;
         archaeologyKillCount$field = new int();
      }
      
      public function get hasArchaeologyKillCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set archaeologyKillCount(param1:int) : void
      {
         hasField$0 |= 32;
         archaeologyKillCount$field = param1;
      }
      
      public function get archaeologyKillCount() : int
      {
         return archaeologyKillCount$field;
      }
      
      public function removeAtchaeologyMonsterCount() : void
      {
         hasField$0 &= 4294967231;
         atchaeologyMonsterCount$field = new int();
      }
      
      public function get hasAtchaeologyMonsterCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set atchaeologyMonsterCount(param1:int) : void
      {
         hasField$0 |= 64;
         atchaeologyMonsterCount$field = param1;
      }
      
      public function get atchaeologyMonsterCount() : int
      {
         return atchaeologyMonsterCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCount1)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,count1$field);
         }
         if(hasCount2)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count2$field);
         }
         if(hasCount3)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count3$field);
         }
         _loc2_ = 0;
         while(_loc2_ < bosslist.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,bosslist[_loc2_]);
            _loc2_++;
         }
         if(hasLeftBossTime)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,leftBossTime$field);
         }
         if(hasLeftFogTime)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,leftFogTime$field);
         }
         if(hasArchaeologyKillCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,archaeologyKillCount$field);
         }
         if(hasAtchaeologyMonsterCount)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,atchaeologyMonsterCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc5_:BossMsg = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.count1 cannot be set twice.");
                  }
                  _loc6_++;
                  count1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.count2 cannot be set twice.");
                  }
                  _loc3_++;
                  count2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.count3 cannot be set twice.");
                  }
                  _loc11_++;
                  count3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc5_ = new BossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  bosslist.push(_loc5_);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.leftBossTime cannot be set twice.");
                  }
                  _loc8_++;
                  leftBossTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.leftFogTime cannot be set twice.");
                  }
                  _loc7_++;
                  leftFogTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.archaeologyKillCount cannot be set twice.");
                  }
                  _loc4_++;
                  archaeologyKillCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MapBossMsg.atchaeologyMonsterCount cannot be set twice.");
                  }
                  _loc10_++;
                  atchaeologyMonsterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

