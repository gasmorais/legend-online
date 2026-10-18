package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class LotoReqMsg extends Message implements IExternalizable
   {
      
      private var optype$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bet_phase$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.LotoInfoMsg")]
      public var betInfo:Array = [];
      
      public function LotoReqMsg()
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
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
         _loc2_ = 0;
         while(_loc2_ < betInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,betInfo[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:LotoInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: LotoReqMsg.optype cannot be set twice.");
                  }
                  _loc4_++;
                  optype = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: LotoReqMsg.betPhase cannot be set twice.");
                  }
                  _loc5_++;
                  betPhase = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new LotoInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  betInfo.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

