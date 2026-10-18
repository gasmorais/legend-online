package com.road.yishi.proto.item
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class EquipLookDataMsg extends Message implements IExternalizable
   {
      
      private var other_id$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.item.ItemInfoMsg")]
      public var item:Array = [];
      
      public function EquipLookDataMsg()
      {
         super();
      }
      
      public function removeOtherId() : void
      {
         hasField$0 &= 4294967294;
         other_id$field = new int();
      }
      
      public function get hasOtherId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set otherId(param1:int) : void
      {
         hasField$0 |= 1;
         other_id$field = param1;
      }
      
      public function get otherId() : int
      {
         return other_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOtherId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,other_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:ItemInfoMsg = null;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: EquipLookDataMsg.otherId cannot be set twice.");
                  }
                  _loc5_++;
                  otherId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new ItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  item.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

