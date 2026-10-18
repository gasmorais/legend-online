package com.road.yishi.proto.gamebox
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DitchNpcInfoListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.gamebox.DitchNpcInfoMsg")]
      public var ditchNpcInfo:Array = [];
      
      private var rounds$field:int;
      
      private var hasField$0:uint = 0;
      
      private var leftSecond$field:int;
      
      public function DitchNpcInfoListMsg()
      {
         super();
      }
      
      public function removeRounds() : void
      {
         hasField$0 &= 4294967294;
         rounds$field = new int();
      }
      
      public function get hasRounds() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rounds(param1:int) : void
      {
         hasField$0 |= 1;
         rounds$field = param1;
      }
      
      public function get rounds() : int
      {
         return rounds$field;
      }
      
      public function removeLeftSecond() : void
      {
         hasField$0 &= 4294967293;
         leftSecond$field = new int();
      }
      
      public function get hasLeftSecond() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set leftSecond(param1:int) : void
      {
         hasField$0 |= 2;
         leftSecond$field = param1;
      }
      
      public function get leftSecond() : int
      {
         return leftSecond$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < ditchNpcInfo.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ditchNpcInfo[_loc2_]);
            _loc2_++;
         }
         if(hasRounds)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rounds$field);
         }
         if(hasLeftSecond)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,leftSecond$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:DitchNpcInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc6_ = new DitchNpcInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  ditchNpcInfo.push(_loc6_);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoListMsg.rounds cannot be set twice.");
                  }
                  _loc4_++;
                  rounds = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DitchNpcInfoListMsg.leftSecond cannot be set twice.");
                  }
                  _loc3_++;
                  leftSecond = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

