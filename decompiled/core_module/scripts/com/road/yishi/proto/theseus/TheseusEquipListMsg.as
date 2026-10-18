package com.road.yishi.proto.theseus
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TheseusEquipListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.theseus.TheseusEquipMsg")]
      public var theseusEquips:Array = [];
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      public function TheseusEquipListMsg()
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < theseusEquips.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,theseusEquips[_loc2_]);
            _loc2_++;
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:TheseusEquipMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new TheseusEquipMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  theseusEquips.push(_loc4_);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TheseusEquipListMsg.op cannot be set twice.");
                  }
                  _loc5_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

