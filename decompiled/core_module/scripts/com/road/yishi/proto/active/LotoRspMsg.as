package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotoRspMsg extends Message implements IExternalizable
   {
      
      private var optype$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bet_phase$field:int;
      
      private var self_bet$field:LotoInfoMsg;
      
      private var last_bet$field:LotoInfoMsg;
      
      private var last_opened$field:LotoInfoMsg;
      
      public function LotoRspMsg()
      {
         super();
      }
      
      public function removeOptype() : void
      {
         hasField$0 &= 4294967294;
         optype$field = new int();
      }
      
      public function get hasOptype() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set optype(param1:int) : void
      {
         hasField$0 |= 1;
         optype$field = param1;
      }
      
      public function get optype() : int
      {
         return optype$field;
      }
      
      public function removeBetPhase() : void
      {
         hasField$0 &= 4294967293;
         bet_phase$field = new int();
      }
      
      public function get hasBetPhase() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set betPhase(param1:int) : void
      {
         hasField$0 |= 2;
         bet_phase$field = param1;
      }
      
      public function get betPhase() : int
      {
         return bet_phase$field;
      }
      
      public function removeSelfBet() : void
      {
         self_bet$field = null;
      }
      
      public function get hasSelfBet() : Boolean
      {
         return self_bet$field != null;
      }
      
      public function set selfBet(param1:LotoInfoMsg) : void
      {
         self_bet$field = param1;
      }
      
      public function get selfBet() : LotoInfoMsg
      {
         return self_bet$field;
      }
      
      public function removeLastBet() : void
      {
         last_bet$field = null;
      }
      
      public function get hasLastBet() : Boolean
      {
         return last_bet$field != null;
      }
      
      public function set lastBet(param1:LotoInfoMsg) : void
      {
         last_bet$field = param1;
      }
      
      public function get lastBet() : LotoInfoMsg
      {
         return last_bet$field;
      }
      
      public function removeLastOpened() : void
      {
         last_opened$field = null;
      }
      
      public function get hasLastOpened() : Boolean
      {
         return last_opened$field != null;
      }
      
      public function set lastOpened(param1:LotoInfoMsg) : void
      {
         last_opened$field = param1;
      }
      
      public function get lastOpened() : LotoInfoMsg
      {
         return last_opened$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasOptype)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,optype$field);
         }
         if(hasBetPhase)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bet_phase$field);
         }
         if(hasSelfBet)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,self_bet$field);
         }
         if(hasLastBet)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,last_bet$field);
         }
         if(hasLastOpened)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,last_opened$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotoRspMsg.optype cannot be set twice.");
                  }
                  _loc4_++;
                  optype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LotoRspMsg.betPhase cannot be set twice.");
                  }
                  _loc5_++;
                  betPhase = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: LotoRspMsg.selfBet cannot be set twice.");
                  }
                  _loc8_++;
                  selfBet = new LotoInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,selfBet);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: LotoRspMsg.lastBet cannot be set twice.");
                  }
                  _loc3_++;
                  lastBet = new LotoInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,lastBet);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: LotoRspMsg.lastOpened cannot be set twice.");
                  }
                  _loc7_++;
                  lastOpened = new LotoInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,lastOpened);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

