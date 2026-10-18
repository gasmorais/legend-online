package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTreasureExchangeActivePB extends Message implements IExternalizable
   {
      
      private var active_id$field:String;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.cccactive.ExchangeItemPB")]
      public var items:Array = [];
      
      public function SkyTreasureExchangeActivePB()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         hasField$0 &= 4294967294;
         active_id$field = new String();
      }
      
      public function get hasActiveId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set activeId(param1:String) : void
      {
         hasField$0 |= 1;
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         _loc2_ = 0;
         while(_loc2_ < items.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,items[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:ExchangeItemPB = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTreasureExchangeActivePB.activeId cannot be set twice.");
                  }
                  _loc3_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  _loc5_ = new ExchangeItemPB();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  items.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

