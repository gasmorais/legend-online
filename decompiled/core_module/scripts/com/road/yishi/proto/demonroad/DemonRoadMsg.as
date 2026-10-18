package com.road.yishi.proto.demonroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DemonRoadMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var energy$field:int;
      
      private var level$field:int;
      
      private var index$field:int;
      
      private var buyCount$field:int;
      
      [ArrayElementType("com.road.yishi.proto.demonroad.DemonRoadBossMsg")]
      public var bossInfos:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.demonroad.DemonRoadRewardMsg")]
      public var items:Array = [];
      
      public function DemonRoadMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeEnergy() : void
      {
         hasField$0 &= 4294967293;
         energy$field = new int();
      }
      
      public function get hasEnergy() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set energy(param1:int) : void
      {
         hasField$0 |= 2;
         energy$field = param1;
      }
      
      public function get energy() : int
      {
         return energy$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294967291;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 4;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967287;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 8;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasEnergy)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,energy$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasBuyCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,buyCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < bossInfos.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,bossInfos[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < items.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc7_:DemonRoadBossMsg = null;
         var _loc10_:DemonRoadRewardMsg = null;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadMsg.op cannot be set twice.");
                  }
                  _loc9_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadMsg.energy cannot be set twice.");
                  }
                  _loc8_++;
                  energy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadMsg.level cannot be set twice.");
                  }
                  _loc3_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadMsg.index cannot be set twice.");
                  }
                  _loc4_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: DemonRoadMsg.buyCount cannot be set twice.");
                  }
                  _loc5_++;
                  buyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc7_ = new DemonRoadBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  bossInfos.push(_loc7_);
                  break;
               case 6:
                  _loc10_ = new DemonRoadRewardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  items.push(_loc10_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

