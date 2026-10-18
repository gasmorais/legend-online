package com.road.yishi.proto.perkinlab
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PerkinLabSelfMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.perkinlab.PerkinLabKengMsg")]
      public var kengList:Array = [];
      
      private var rob_count$field:int;
      
      public function PerkinLabSelfMsg()
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
      
      public function removeRobCount() : void
      {
         hasField$0 &= 4294967293;
         rob_count$field = new int();
      }
      
      public function get hasRobCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set robCount(param1:int) : void
      {
         hasField$0 |= 2;
         rob_count$field = param1;
      }
      
      public function get robCount() : int
      {
         return rob_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc2_ = 0;
         while(_loc2_ < kengList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,kengList[_loc2_]);
            _loc2_++;
         }
         if(hasRobCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rob_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc6_:PerkinLabKengMsg = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabSelfMsg.op cannot be set twice.");
                  }
                  _loc4_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc6_ = new PerkinLabKengMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  kengList.push(_loc6_);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PerkinLabSelfMsg.robCount cannot be set twice.");
                  }
                  _loc5_++;
                  robCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

