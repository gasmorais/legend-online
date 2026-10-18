package com.road.yishi.proto.lucky
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerLuckyMsg extends Message implements IExternalizable
   {
      
      private var luckyCount$field:int;
      
      private var hasField$0:uint = 0;
      
      private var remainCount$field:int;
      
      private var lastReceive$field:ByteArray;
      
      private var point$field:int;
      
      private var gold$field:int;
      
      private var state$field:int;
      
      private var p$field:int;
      
      public function PlayerLuckyMsg()
      {
         super();
      }
      
      public function removeLuckyCount() : void
      {
         hasField$0 &= 4294967294;
         luckyCount$field = new int();
      }
      
      public function get hasLuckyCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set luckyCount(param1:int) : void
      {
         hasField$0 |= 1;
         luckyCount$field = param1;
      }
      
      public function get luckyCount() : int
      {
         return luckyCount$field;
      }
      
      public function removeRemainCount() : void
      {
         hasField$0 &= 4294967293;
         remainCount$field = new int();
      }
      
      public function get hasRemainCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set remainCount(param1:int) : void
      {
         hasField$0 |= 2;
         remainCount$field = param1;
      }
      
      public function get remainCount() : int
      {
         return remainCount$field;
      }
      
      public function removeLastReceive() : void
      {
         lastReceive$field = null;
      }
      
      public function get hasLastReceive() : Boolean
      {
         return lastReceive$field != null;
      }
      
      public function set lastReceive(param1:ByteArray) : void
      {
         lastReceive$field = param1;
      }
      
      public function get lastReceive() : ByteArray
      {
         return lastReceive$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967291;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 4;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeGold() : void
      {
         hasField$0 &= 4294967287;
         gold$field = new int();
      }
      
      public function get hasGold() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gold(param1:int) : void
      {
         hasField$0 |= 8;
         gold$field = param1;
      }
      
      public function get gold() : int
      {
         return gold$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeP() : void
      {
         hasField$0 &= 4294967263;
         p$field = new int();
      }
      
      public function get hasP() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set p(param1:int) : void
      {
         hasField$0 |= 32;
         p$field = param1;
      }
      
      public function get p() : int
      {
         return p$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLuckyCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,luckyCount$field);
         }
         if(hasRemainCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,remainCount$field);
         }
         if(hasLastReceive)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_BYTES(param1,lastReceive$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasGold)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,gold$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasP)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,p$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.luckyCount cannot be set twice.");
                  }
                  _loc5_++;
                  luckyCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.remainCount cannot be set twice.");
                  }
                  _loc3_++;
                  remainCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.lastReceive cannot be set twice.");
                  }
                  _loc6_++;
                  lastReceive = ReadUtils.read$TYPE_BYTES(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.point cannot be set twice.");
                  }
                  _loc9_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.gold cannot be set twice.");
                  }
                  _loc7_++;
                  gold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.state cannot be set twice.");
                  }
                  _loc8_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerLuckyMsg.p cannot be set twice.");
                  }
                  _loc4_++;
                  p = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

