package com.road.yishi.proto.worldmap
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RouteStateMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var user_state$field:int;
      
      [ArrayElementType("com.road.yishi.proto.worldmap.RouteMsg")]
      public var path:Array = [];
      
      public function RouteStateMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeUserState() : void
      {
         hasField$0 &= 4294967293;
         user_state$field = new int();
      }
      
      public function get hasUserState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userState(param1:int) : void
      {
         hasField$0 |= 2;
         user_state$field = param1;
      }
      
      public function get userState() : int
      {
         return user_state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasUserState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,user_state$field);
         }
         _loc2_ = 0;
         while(_loc2_ < path.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,path[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:RouteMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RouteStateMsg.userId cannot be set twice.");
                  }
                  _loc3_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RouteStateMsg.userState cannot be set twice.");
                  }
                  _loc6_++;
                  userState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new RouteMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  path.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

