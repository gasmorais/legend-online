package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PropertyUpdatedMsg extends Message implements IExternalizable
   {
      
      private var property_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var value$field:int;
      
      public function PropertyUpdatedMsg()
      {
         super();
      }
      
      public function removePropertyType() : void
      {
         hasField$0 &= 4294967294;
         property_type$field = new int();
      }
      
      public function get hasPropertyType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set propertyType(param1:int) : void
      {
         hasField$0 |= 1;
         property_type$field = param1;
      }
      
      public function get propertyType() : int
      {
         return property_type$field;
      }
      
      public function removeValue() : void
      {
         hasField$0 &= 4294967293;
         value$field = new int();
      }
      
      public function get hasValue() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set value(param1:int) : void
      {
         hasField$0 |= 2;
         value$field = param1;
      }
      
      public function get value() : int
      {
         return value$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPropertyType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,property_type$field);
         }
         if(hasValue)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,value$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyUpdatedMsg.propertyType cannot be set twice.");
                  }
                  _loc5_++;
                  propertyType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PropertyUpdatedMsg.value cannot be set twice.");
                  }
                  _loc4_++;
                  value = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

