package com.road.yishi.proto.blackjack
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BlackJackDataMsg extends Message implements IExternalizable
   {
      
      private var board$field:BlackJackBoardMsg;
      
      private var score$field:int;
      
      private var hasField$0:uint = 0;
      
      private var op$field:int;
      
      private var param1$field:int;
      
      public function BlackJackDataMsg()
      {
         super();
      }
      
      public function removeBoard() : void
      {
         board$field = null;
      }
      
      public function get hasBoard() : Boolean
      {
         return board$field != null;
      }
      
      public function set board(param1:BlackJackBoardMsg) : void
      {
         board$field = param1;
      }
      
      public function get board() : BlackJackBoardMsg
      {
         return board$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967294;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 1;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967293;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 2;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967291;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 4;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBoard)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,board$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackDataMsg.board cannot be set twice.");
                  }
                  _loc5_++;
                  board = new BlackJackBoardMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,board);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackDataMsg.score cannot be set twice.");
                  }
                  _loc6_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackDataMsg.op cannot be set twice.");
                  }
                  _loc7_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BlackJackDataMsg.param1 cannot be set twice.");
                  }
                  _loc3_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

