package com.road.yishi.proto.apex
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ApexBetPlayerListMsg extends Message implements IExternalizable
   {
      
      private var page$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalpage$field:int;
      
      [ArrayElementType("com.road.yishi.proto.apex.ApexBetPlayerMsg")]
      public var list:Array = [];
      
      private var stamp$field:int;
      
      public function ApexBetPlayerListMsg()
      {
         super();
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294967294;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 1;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeTotalpage() : void
      {
         hasField$0 &= 4294967293;
         totalpage$field = new int();
      }
      
      public function get hasTotalpage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalpage(param1:int) : void
      {
         hasField$0 |= 2;
         totalpage$field = param1;
      }
      
      public function get totalpage() : int
      {
         return totalpage$field;
      }
      
      public function removeStamp() : void
      {
         hasField$0 &= 4294967291;
         stamp$field = new int();
      }
      
      public function get hasStamp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set stamp(param1:int) : void
      {
         hasField$0 |= 4;
         stamp$field = param1;
      }
      
      public function get stamp() : int
      {
         return stamp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasTotalpage)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,totalpage$field);
         }
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,list[_loc2_]);
            _loc2_++;
         }
         if(hasStamp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,stamp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:ApexBetPlayerMsg = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetPlayerListMsg.page cannot be set twice.");
                  }
                  _loc3_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetPlayerListMsg.totalpage cannot be set twice.");
                  }
                  _loc4_++;
                  totalpage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new ApexBetPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  list.push(_loc5_);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ApexBetPlayerListMsg.stamp cannot be set twice.");
                  }
                  _loc7_++;
                  stamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

