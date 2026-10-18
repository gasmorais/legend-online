package com.road.yishi.proto.vip
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VipRouletteMsg extends Message implements IExternalizable
   {
      
      private var left_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var need_vipItem$field:int;
      
      [ArrayElementType("int")]
      public var openIndex:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.vip.VipItemInfoMsg")]
      public var leftItem:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.vip.VipItemInfoMsg")]
      public var takeItem:Array = [];
      
      private var is_start$field:Boolean;
      
      private var op_type$field:int;
      
      public function VipRouletteMsg()
      {
         super();
      }
      
      public function removeLeftCount() : void
      {
         hasField$0 &= 4294967294;
         left_count$field = new int();
      }
      
      public function get hasLeftCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set leftCount(param1:int) : void
      {
         hasField$0 |= 1;
         left_count$field = param1;
      }
      
      public function get leftCount() : int
      {
         return left_count$field;
      }
      
      public function removeNeedVipItem() : void
      {
         hasField$0 &= 4294967293;
         need_vipItem$field = new int();
      }
      
      public function get hasNeedVipItem() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set needVipItem(param1:int) : void
      {
         hasField$0 |= 2;
         need_vipItem$field = param1;
      }
      
      public function get needVipItem() : int
      {
         return need_vipItem$field;
      }
      
      public function removeIsStart() : void
      {
         hasField$0 &= 4294967291;
         is_start$field = new Boolean();
      }
      
      public function get hasIsStart() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isStart(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_start$field = param1;
      }
      
      public function get isStart() : Boolean
      {
         return is_start$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967287;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 8;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:* = 0;
         if(hasLeftCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,left_count$field);
         }
         if(hasNeedVipItem)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,need_vipItem$field);
         }
         _loc3_ = 0;
         while(_loc3_ < openIndex.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,openIndex[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < leftItem.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,leftItem[_loc4_]);
            _loc4_++;
         }
         _loc2_ = 0;
         while(_loc2_ < takeItem.length)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,takeItem[_loc2_]);
            _loc2_++;
         }
         if(hasIsStart)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,is_start$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:VipItemInfoMsg = null;
         var _loc6_:VipItemInfoMsg = null;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VipRouletteMsg.leftCount cannot be set twice.");
                  }
                  _loc9_++;
                  leftCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: VipRouletteMsg.needVipItem cannot be set twice.");
                  }
                  _loc4_++;
                  needVipItem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,openIndex);
                  }
                  else
                  {
                     openIndex.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  _loc7_ = new VipItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  leftItem.push(_loc7_);
                  break;
               case 4:
                  _loc6_ = new VipItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  takeItem.push(_loc6_);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VipRouletteMsg.isStart cannot be set twice.");
                  }
                  _loc5_++;
                  isStart = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VipRouletteMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

