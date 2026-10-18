package com.road.yishi.proto.simple
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FriendRelationList extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.simple.RelationPlayerMsg")]
      public var relationList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.simple.FriendGroupMsg")]
      public var group:Array = [];
      
      private var max_page$field:int;
      
      private var hasField$0:uint = 0;
      
      private var cur_page$field:int;
      
      public function FriendRelationList()
      {
         super();
      }
      
      public function removeMaxPage() : void
      {
         hasField$0 &= 4294967294;
         max_page$field = new int();
      }
      
      public function get hasMaxPage() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set maxPage(param1:int) : void
      {
         hasField$0 |= 1;
         max_page$field = param1;
      }
      
      public function get maxPage() : int
      {
         return max_page$field;
      }
      
      public function removeCurPage() : void
      {
         hasField$0 &= 4294967293;
         cur_page$field = new int();
      }
      
      public function get hasCurPage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curPage(param1:int) : void
      {
         hasField$0 |= 2;
         cur_page$field = param1;
      }
      
      public function get curPage() : int
      {
         return cur_page$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < relationList.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,relationList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < group.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,group[_loc3_]);
            _loc3_++;
         }
         if(hasMaxPage)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,max_page$field);
         }
         if(hasCurPage)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,cur_page$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc7_:RelationPlayerMsg = null;
         var _loc4_:FriendGroupMsg = null;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  _loc7_ = new RelationPlayerMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  relationList.push(_loc7_);
                  break;
               case 1:
                  _loc4_ = new FriendGroupMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  group.push(_loc4_);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationList.maxPage cannot be set twice.");
                  }
                  _loc6_++;
                  maxPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FriendRelationList.curPage cannot be set twice.");
                  }
                  _loc5_++;
                  curPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
      }
   }
}

