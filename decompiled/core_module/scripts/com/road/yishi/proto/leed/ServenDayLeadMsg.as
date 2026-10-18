package com.road.yishi.proto.leed
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ServenDayLeadMsg extends Message implements IExternalizable
   {
      
      private var beginTime$field:String;
      
      private var statu$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.leed.SingleDayMsg")]
      public var singleDay:Array = [];
      
      public function ServenDayLeadMsg()
      {
         super();
      }
      
      public function removeBeginTime() : void
      {
         beginTime$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return beginTime$field != null;
      }
      
      public function set beginTime(param1:String) : void
      {
         beginTime$field = param1;
      }
      
      public function get beginTime() : String
      {
         return beginTime$field;
      }
      
      public function removeStatu() : void
      {
         hasField$0 &= 4294967294;
         statu$field = new int();
      }
      
      public function get hasStatu() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set statu(param1:int) : void
      {
         hasField$0 |= 1;
         statu$field = param1;
      }
      
      public function get statu() : int
      {
         return statu$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,beginTime$field);
         }
         if(hasStatu)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,statu$field);
         }
         _loc2_ = 0;
         while(_loc2_ < singleDay.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,singleDay[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:SingleDayMsg = null;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ServenDayLeadMsg.beginTime cannot be set twice.");
                  }
                  _loc6_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ServenDayLeadMsg.statu cannot be set twice.");
                  }
                  _loc4_++;
                  statu = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc3_ = new SingleDayMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  singleDay.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

