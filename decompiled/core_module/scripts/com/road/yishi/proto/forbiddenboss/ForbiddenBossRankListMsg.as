package com.road.yishi.proto.forbiddenboss
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ForbiddenBossRankListMsg extends Message implements IExternalizable
   {
      
      private var bossId$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.forbiddenboss.ForbiddenBossRankMsg")]
      public var rankList:Array = [];
      
      private var maxHp$field:Int64;
      
      private var consortiaId$field:int;
      
      public function ForbiddenBossRankListMsg()
      {
         super();
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967294;
         bossId$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 1;
         bossId$field = param1;
      }
      
      public function get bossId() : int
      {
         return bossId$field;
      }
      
      public function removeMaxHp() : void
      {
         maxHp$field = null;
      }
      
      public function get hasMaxHp() : Boolean
      {
         return maxHp$field != null;
      }
      
      public function set maxHp(param1:Int64) : void
      {
         maxHp$field = param1;
      }
      
      public function get maxHp() : Int64
      {
         return maxHp$field;
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967293;
         consortiaId$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 2;
         consortiaId$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortiaId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bossId$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rankList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,rankList[_loc2_]);
            _loc2_++;
         }
         if(hasMaxHp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT64(param1,maxHp$field);
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,consortiaId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc4_:ForbiddenBossRankMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossRankListMsg.bossId cannot be set twice.");
                  }
                  _loc3_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new ForbiddenBossRankMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  rankList.push(_loc4_);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossRankListMsg.maxHp cannot be set twice.");
                  }
                  _loc6_++;
                  maxHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossRankListMsg.consortiaId cannot be set twice.");
                  }
                  _loc5_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

