package com.road.yishi.proto.friend
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendRelationGraphMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.friend.SimpleGlobalPlayerMsg")]
      public var friend:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.friend.SimpleGlobalPlayerMsg")]
      public var stranger:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.friend.SimpleGlobalPlayerMsg")]
      public var blacklist:Array = [];
      
      private var stamp$field:int;
      
      private var hasField$0:uint = 0;
      
      private var currentPage$field:int;
      
      private var totalPage$field:int;
      
      public function FriendRelationGraphMsg()
      {
         super();
      }
      
      public function removeStamp() : void
      {
         hasField$0 &= 4294967294;
         stamp$field = new int();
      }
      
      public function get hasStamp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set stamp(param1:int) : void
      {
         hasField$0 |= 1;
         stamp$field = param1;
      }
      
      public function get stamp() : int
      {
         return stamp$field;
      }
      
      public function removeCurrentPage() : void
      {
         hasField$0 &= 4294967293;
         currentPage$field = new int();
      }
      
      public function get hasCurrentPage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set currentPage(param1:int) : void
      {
         hasField$0 |= 2;
         currentPage$field = param1;
      }
      
      public function get currentPage() : int
      {
         return currentPage$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294967291;
         totalPage$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 4;
         totalPage$field = param1;
      }
      
      public function get totalPage() : int
      {
         return totalPage$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         _loc3_ = 0;
         while(_loc3_ < friend.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,friend[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < stranger.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,stranger[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < blacklist.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,blacklist[_loc4_]);
            _loc4_++;
         }
         if(hasStamp)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,stamp$field);
         }
         if(hasCurrentPage)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,currentPage$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,totalPage$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc4_:SimpleGlobalPlayerMsg = null;
         var _loc7_:SimpleGlobalPlayerMsg = null;
         var _loc8_:SimpleGlobalPlayerMsg = null;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new SimpleGlobalPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  friend.push(_loc4_);
                  break;
               case 1:
                  _loc7_ = new SimpleGlobalPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  stranger.push(_loc7_);
                  break;
               case 2:
                  _loc8_ = new SimpleGlobalPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  blacklist.push(_loc8_);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationGraphMsg.stamp cannot be set twice.");
                  }
                  _loc9_++;
                  stamp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationGraphMsg.currentPage cannot be set twice.");
                  }
                  _loc3_++;
                  currentPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationGraphMsg.totalPage cannot be set twice.");
                  }
                  _loc5_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

