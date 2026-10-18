package com.road.yishi.proto.consortiaplay
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChessPvpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var group$field:ChessPvpGroupMsg;
      
      [ArrayElementType("com.road.yishi.proto.consortiaplay.ChessPvpUserMsg")]
      public var userList:Array = [];
      
      public function ChessPvpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removeGroup() : void
      {
         group$field = null;
      }
      
      public function get hasGroup() : Boolean
      {
         return group$field != null;
      }
      
      public function set group(param1:ChessPvpGroupMsg) : void
      {
         group$field = param1;
      }
      
      public function get group() : ChessPvpGroupMsg
      {
         return group$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasGroup)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,group$field);
         }
         _loc2_ = 0;
         while(_loc2_ < userList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,userList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc5_:ChessPvpUserMsg = null;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpMsg.op cannot be set twice.");
                  }
                  _loc6_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChessPvpMsg.group cannot be set twice.");
                  }
                  _loc3_++;
                  group = new ChessPvpGroupMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,group);
                  break;
               case 2:
                  _loc5_ = new ChessPvpUserMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  userList.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

