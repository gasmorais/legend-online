package com.road.yishi.proto.pet
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TableActNotifyMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("int")]
      public var action:Array = [];
      
      private var minBet$field:int;
      
      private var hasField$0:uint = 0;
      
      private var currentBet$field:int;
      
      public function TableActNotifyMsg()
      {
         super();
      }
      
      public function removeMinBet() : void
      {
         hasField$0 &= 4294967294;
         minBet$field = new int();
      }
      
      public function get hasMinBet() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set minBet(param1:int) : void
      {
         hasField$0 |= 1;
         minBet$field = param1;
      }
      
      public function get minBet() : int
      {
         return minBet$field;
      }
      
      public function removeCurrentBet() : void
      {
         hasField$0 &= 4294967293;
         currentBet$field = new int();
      }
      
      public function get hasCurrentBet() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentBet(param1:int) : void
      {
         hasField$0 |= 2;
         currentBet$field = param1;
      }
      
      public function get currentBet() : int
      {
         return currentBet$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < action.length)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,action[_loc2_]);
            _loc2_++;
         }
         if(hasMinBet)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,minBet$field);
         }
         if(hasCurrentBet)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,currentBet$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_ENUM,action);
                  }
                  else
                  {
                     action.push(ReadUtils.read$TYPE_ENUM(param1));
                  }
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TableActNotifyMsg.minBet cannot be set twice.");
                  }
                  _loc4_++;
                  minBet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TableActNotifyMsg.currentBet cannot be set twice.");
                  }
                  _loc3_++;
                  currentBet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

