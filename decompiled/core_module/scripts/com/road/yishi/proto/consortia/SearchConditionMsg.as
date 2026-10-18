package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SearchConditionMsg extends Message implements IExternalizable
   {
      
      private var page_index$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortia_name$field:String;
      
      private var is_newOpen$field:Boolean;
      
      public function SearchConditionMsg()
      {
         super();
      }
      
      public function removePageIndex() : void
      {
         hasField$0 &= 4294967294;
         page_index$field = new int();
      }
      
      public function get hasPageIndex() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set pageIndex(param1:int) : void
      {
         hasField$0 |= 1;
         page_index$field = param1;
      }
      
      public function get pageIndex() : int
      {
         return page_index$field;
      }
      
      public function removeConsortiaName() : void
      {
         consortia_name$field = null;
      }
      
      public function get hasConsortiaName() : Boolean
      {
         return consortia_name$field != null;
      }
      
      public function set consortiaName(param1:String) : void
      {
         consortia_name$field = param1;
      }
      
      public function get consortiaName() : String
      {
         return consortia_name$field;
      }
      
      public function removeIsNewOpen() : void
      {
         hasField$0 &= 4294967293;
         is_newOpen$field = new Boolean();
      }
      
      public function get hasIsNewOpen() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isNewOpen(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_newOpen$field = param1;
      }
      
      public function get isNewOpen() : Boolean
      {
         return is_newOpen$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPageIndex)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,page_index$field);
         }
         if(hasConsortiaName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,consortia_name$field);
         }
         if(hasIsNewOpen)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_newOpen$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SearchConditionMsg.pageIndex cannot be set twice.");
                  }
                  _loc3_++;
                  pageIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SearchConditionMsg.consortiaName cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SearchConditionMsg.isNewOpen cannot be set twice.");
                  }
                  _loc5_++;
                  isNewOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

