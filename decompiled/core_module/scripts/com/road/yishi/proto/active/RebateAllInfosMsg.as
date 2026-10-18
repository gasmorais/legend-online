package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RebateAllInfosMsg extends Message implements IExternalizable
   {
      
      private var cur_PayPoint$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cur_level$field:int;
      
      private var pay_count$field:int;
      
      private var get_count$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.PayInfoMsg")]
      public var payInfos:Array = [];
      
      public function RebateAllInfosMsg()
      {
         super();
      }
      
      public function removeCur_PayPoint() : void
      {
         hasField$0 &= 4294967294;
         cur_PayPoint$field = new int();
      }
      
      public function get hasCur_PayPoint() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set cur_PayPoint(param1:int) : void
      {
         hasField$0 |= 1;
         cur_PayPoint$field = param1;
      }
      
      public function get cur_PayPoint() : int
      {
         return cur_PayPoint$field;
      }
      
      public function removeCurLevel() : void
      {
         hasField$0 &= 4294967293;
         cur_level$field = new int();
      }
      
      public function get hasCurLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curLevel(param1:int) : void
      {
         hasField$0 |= 2;
         cur_level$field = param1;
      }
      
      public function get curLevel() : int
      {
         return cur_level$field;
      }
      
      public function removePayCount() : void
      {
         hasField$0 &= 4294967291;
         pay_count$field = new int();
      }
      
      public function get hasPayCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set payCount(param1:int) : void
      {
         hasField$0 |= 4;
         pay_count$field = param1;
      }
      
      public function get payCount() : int
      {
         return pay_count$field;
      }
      
      public function removeGetCount() : void
      {
         hasField$0 &= 4294967287;
         get_count$field = new int();
      }
      
      public function get hasGetCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set getCount(param1:int) : void
      {
         hasField$0 |= 8;
         get_count$field = param1;
      }
      
      public function get getCount() : int
      {
         return get_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCur_PayPoint)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,cur_PayPoint$field);
         }
         if(hasCurLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,cur_level$field);
         }
         if(hasPayCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_count$field);
         }
         if(hasGetCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,get_count$field);
         }
         _loc2_ = 0;
         while(_loc2_ < payInfos.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,payInfos[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:PayInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RebateAllInfosMsg.cur_PayPoint cannot be set twice.");
                  }
                  _loc3_++;
                  cur_PayPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RebateAllInfosMsg.curLevel cannot be set twice.");
                  }
                  _loc5_++;
                  curLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RebateAllInfosMsg.payCount cannot be set twice.");
                  }
                  _loc8_++;
                  payCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RebateAllInfosMsg.getCount cannot be set twice.");
                  }
                  _loc7_++;
                  getCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc4_ = new PayInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  payInfos.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

