package com.road.yishi.proto.guardpve
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GuardPVERspMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.guardpve.GuardBossMsg")]
      public var bossInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.guardpve.GuardPosMsg")]
      public var guardPos:Array = [];
      
      private var skills$field:String;
      
      private var wantedOrder$field:int;
      
      private var maxBossId$field:int;
      
      public function GuardPVERspMsg()
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
      
      public function removeSkills() : void
      {
         skills$field = null;
      }
      
      public function get hasSkills() : Boolean
      {
         return skills$field != null;
      }
      
      public function set skills(param1:String) : void
      {
         skills$field = param1;
      }
      
      public function get skills() : String
      {
         return skills$field;
      }
      
      public function removeWantedOrder() : void
      {
         hasField$0 &= 4294967293;
         wantedOrder$field = new int();
      }
      
      public function get hasWantedOrder() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set wantedOrder(param1:int) : void
      {
         hasField$0 |= 2;
         wantedOrder$field = param1;
      }
      
      public function get wantedOrder() : int
      {
         return wantedOrder$field;
      }
      
      public function removeMaxBossId() : void
      {
         hasField$0 &= 4294967291;
         maxBossId$field = new int();
      }
      
      public function get hasMaxBossId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set maxBossId(param1:int) : void
      {
         hasField$0 |= 4;
         maxBossId$field = param1;
      }
      
      public function get maxBossId() : int
      {
         return maxBossId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         _loc3_ = 0;
         while(_loc3_ < bossInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,bossInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < guardPos.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,guardPos[_loc2_]);
            _loc2_++;
         }
         if(hasSkills)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,skills$field);
         }
         if(hasWantedOrder)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,wantedOrder$field);
         }
         if(hasMaxBossId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,maxBossId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc3_:GuardBossMsg = null;
         var _loc9_:GuardPosMsg = null;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPVERspMsg.opType cannot be set twice.");
                  }
                  _loc4_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new GuardBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  bossInfo.push(_loc3_);
                  break;
               case 2:
                  _loc9_ = new GuardPosMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  guardPos.push(_loc9_);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPVERspMsg.skills cannot be set twice.");
                  }
                  _loc8_++;
                  skills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPVERspMsg.wantedOrder cannot be set twice.");
                  }
                  _loc5_++;
                  wantedOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GuardPVERspMsg.maxBossId cannot be set twice.");
                  }
                  _loc6_++;
                  maxBossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

