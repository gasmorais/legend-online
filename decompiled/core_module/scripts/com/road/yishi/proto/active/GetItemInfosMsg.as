package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GetItemInfosMsg extends Message implements IExternalizable
   {
      
      private var interval$field:int;
      
      private var hasField$0:uint = 0;
      
      private var times$field:int;
      
      [ArrayElementType("com.road.yishi.proto.active.GItemInfoMsg")]
      public var itemInfo:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.active.GItemInfoMsg")]
      public var itemInfo2:Array = [];
      
      public function GetItemInfosMsg()
      {
         super();
      }
      
      public function removeInterval() : void
      {
         hasField$0 &= 4294967294;
         interval$field = new int();
      }
      
      public function get hasInterval() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set interval(param1:int) : void
      {
         hasField$0 |= 1;
         interval$field = param1;
      }
      
      public function get interval() : int
      {
         return interval$field;
      }
      
      public function removeTimes() : void
      {
         hasField$0 &= 4294967293;
         times$field = new int();
      }
      
      public function get hasTimes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set times(param1:int) : void
      {
         hasField$0 |= 2;
         times$field = param1;
      }
      
      public function get times() : int
      {
         return times$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasInterval)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,interval$field);
         }
         if(hasTimes)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,times$field);
         }
         _loc3_ = 0;
         while(_loc3_ < itemInfo.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,itemInfo[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < itemInfo2.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,itemInfo2[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc7_:GItemInfoMsg = null;
         var _loc3_:GItemInfoMsg = null;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GetItemInfosMsg.interval cannot be set twice.");
                  }
                  _loc4_++;
                  interval = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GetItemInfosMsg.times cannot be set twice.");
                  }
                  _loc6_++;
                  times = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc7_ = new GItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  itemInfo.push(_loc7_);
                  break;
               case 3:
                  _loc3_ = new GItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  itemInfo2.push(_loc3_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

