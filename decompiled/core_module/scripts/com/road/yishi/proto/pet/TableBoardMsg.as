package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TableBoardMsg extends Message implements IExternalizable
   {
      
      private var bet$field:int;
      
      private var hasField$0:uint = 0;
      
      private var min_bet$field:int;
      
      private var raises$field:int;
      
      [ArrayElementType("com.road.yishi.proto.pet.CardMsg")]
      public var card:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.pet.PotMsg")]
      public var pot:Array = [];
      
      public function TableBoardMsg()
      {
         super();
      }
      
      public function removeBet() : void
      {
         hasField$0 &= 4294967294;
         bet$field = new int();
      }
      
      public function get hasBet() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set bet(param1:int) : void
      {
         hasField$0 |= 1;
         bet$field = param1;
      }
      
      public function get bet() : int
      {
         return bet$field;
      }
      
      public function removeMinBet() : void
      {
         hasField$0 &= 4294967293;
         min_bet$field = new int();
      }
      
      public function get hasMinBet() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set minBet(param1:int) : void
      {
         hasField$0 |= 2;
         min_bet$field = param1;
      }
      
      public function get minBet() : int
      {
         return min_bet$field;
      }
      
      public function removeRaises() : void
      {
         hasField$0 &= 4294967291;
         raises$field = new int();
      }
      
      public function get hasRaises() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set raises(param1:int) : void
      {
         hasField$0 |= 4;
         raises$field = param1;
      }
      
      public function get raises() : int
      {
         return raises$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasBet)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,bet$field);
         }
         if(hasMinBet)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,min_bet$field);
         }
         if(hasRaises)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,raises$field);
         }
         _loc3_ = 0;
         while(_loc3_ < card.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,card[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < pot.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,pot[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc8_:CardMsg = null;
         var _loc4_:PotMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TableBoardMsg.bet cannot be set twice.");
                  }
                  _loc7_++;
                  bet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TableBoardMsg.minBet cannot be set twice.");
                  }
                  _loc3_++;
                  minBet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TableBoardMsg.raises cannot be set twice.");
                  }
                  _loc5_++;
                  raises = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc8_ = new CardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  card.push(_loc8_);
                  break;
               case 4:
                  _loc4_ = new PotMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  pot.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

