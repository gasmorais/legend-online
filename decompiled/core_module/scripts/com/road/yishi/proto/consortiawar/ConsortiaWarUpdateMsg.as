package com.road.yishi.proto.consortiawar
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaWarUpdateMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var towerData$field:ConsortiaWarTowerMsg;
      
      private var teamId$field:int;
      
      private var blood$field:int;
      
      private var spirit$field:int;
      
      private var buyCount$field:int;
      
      private var bufferCount$field:int;
      
      public function ConsortiaWarUpdateMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      public function removeTowerData() : void
      {
         towerData$field = null;
      }
      
      public function get hasTowerData() : Boolean
      {
         return towerData$field != null;
      }
      
      public function set towerData(param1:ConsortiaWarTowerMsg) : void
      {
         towerData$field = param1;
      }
      
      public function get towerData() : ConsortiaWarTowerMsg
      {
         return towerData$field;
      }
      
      public function removeTeamId() : void
      {
         hasField$0 &= 4294967293;
         teamId$field = new int();
      }
      
      public function get hasTeamId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set teamId(param1:int) : void
      {
         hasField$0 |= 2;
         teamId$field = param1;
      }
      
      public function get teamId() : int
      {
         return teamId$field;
      }
      
      public function removeBlood() : void
      {
         hasField$0 &= 4294967291;
         blood$field = new int();
      }
      
      public function get hasBlood() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set blood(param1:int) : void
      {
         hasField$0 |= 4;
         blood$field = param1;
      }
      
      public function get blood() : int
      {
         return blood$field;
      }
      
      public function removeSpirit() : void
      {
         hasField$0 &= 4294967287;
         spirit$field = new int();
      }
      
      public function get hasSpirit() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set spirit(param1:int) : void
      {
         hasField$0 |= 8;
         spirit$field = param1;
      }
      
      public function get spirit() : int
      {
         return spirit$field;
      }
      
      public function removeBuyCount() : void
      {
         hasField$0 &= 4294967279;
         buyCount$field = new int();
      }
      
      public function get hasBuyCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set buyCount(param1:int) : void
      {
         hasField$0 |= 16;
         buyCount$field = param1;
      }
      
      public function get buyCount() : int
      {
         return buyCount$field;
      }
      
      public function removeBufferCount() : void
      {
         hasField$0 &= 4294967263;
         bufferCount$field = new int();
      }
      
      public function get hasBufferCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bufferCount(param1:int) : void
      {
         hasField$0 |= 32;
         bufferCount$field = param1;
      }
      
      public function get bufferCount() : int
      {
         return bufferCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         if(hasTowerData)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,towerData$field);
         }
         if(hasTeamId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,teamId$field);
         }
         if(hasBlood)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,blood$field);
         }
         if(hasSpirit)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,spirit$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         if(hasBufferCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,bufferCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.towerData cannot be set twice.");
                  }
                  _loc8_++;
                  towerData = new ConsortiaWarTowerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,towerData);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.teamId cannot be set twice.");
                  }
                  _loc7_++;
                  teamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.blood cannot be set twice.");
                  }
                  _loc10_++;
                  blood = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.spirit cannot be set twice.");
                  }
                  _loc4_++;
                  spirit = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.buyCount cannot be set twice.");
                  }
                  _loc6_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaWarUpdateMsg.bufferCount cannot be set twice.");
                  }
                  _loc5_++;
                  bufferCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

