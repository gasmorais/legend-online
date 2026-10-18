package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FightOverMoiveMsg extends Message implements IExternalizable
   {
      
      private var gp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gold$field:int;
      
      private var strategy$field:int;
      
      public function FightOverMoiveMsg()
      {
         super();
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967294;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 1;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeGold() : void
      {
         hasField$0 &= 4294967293;
         gold$field = new int();
      }
      
      public function get hasGold() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set gold(param1:int) : void
      {
         hasField$0 |= 2;
         gold$field = param1;
      }
      
      public function get gold() : int
      {
         return gold$field;
      }
      
      public function removeStrategy() : void
      {
         hasField$0 &= 4294967291;
         strategy$field = new int();
      }
      
      public function get hasStrategy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set strategy(param1:int) : void
      {
         hasField$0 |= 4;
         strategy$field = param1;
      }
      
      public function get strategy() : int
      {
         return strategy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasGold)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,gold$field);
         }
         if(hasStrategy)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,strategy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FightOverMoiveMsg.gp cannot be set twice.");
                  }
                  _loc6_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FightOverMoiveMsg.gold cannot be set twice.");
                  }
                  _loc4_++;
                  gold = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FightOverMoiveMsg.strategy cannot be set twice.");
                  }
                  _loc3_++;
                  strategy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

