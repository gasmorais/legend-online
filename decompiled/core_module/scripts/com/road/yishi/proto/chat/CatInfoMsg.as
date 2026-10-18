package com.road.yishi.proto.chat
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CatInfoMsg extends Message implements IExternalizable
   {
      
      private var refreshTime$field:Int64;
      
      [ArrayElementType("com.road.yishi.proto.chat.CatMsg")]
      public var catInfo:Array = [];
      
      private var count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var maxCount$field:int;
      
      public function CatInfoMsg()
      {
         super();
      }
      
      public function removeRefreshTime() : void
      {
         refreshTime$field = null;
      }
      
      public function get hasRefreshTime() : Boolean
      {
         return refreshTime$field != null;
      }
      
      public function set refreshTime(param1:Int64) : void
      {
         refreshTime$field = param1;
      }
      
      public function get refreshTime() : Int64
      {
         return refreshTime$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967294;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 1;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeMaxCount() : void
      {
         hasField$0 &= 4294967293;
         maxCount$field = new int();
      }
      
      public function get hasMaxCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set maxCount(param1:int) : void
      {
         hasField$0 |= 2;
         maxCount$field = param1;
      }
      
      public function get maxCount() : int
      {
         return maxCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasRefreshTime)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT64(param1,refreshTime$field);
         }
         _loc2_ = 0;
         while(_loc2_ < catInfo.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,catInfo[_loc2_]);
            _loc2_++;
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasMaxCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,maxCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:CatMsg = null;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CatInfoMsg.refreshTime cannot be set twice.");
                  }
                  _loc7_++;
                  refreshTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 1:
                  _loc4_ = new CatMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  catInfo.push(_loc4_);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CatInfoMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CatInfoMsg.maxCount cannot be set twice.");
                  }
                  _loc5_++;
                  maxCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

