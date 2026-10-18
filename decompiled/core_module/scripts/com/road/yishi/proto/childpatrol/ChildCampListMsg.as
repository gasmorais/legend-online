package com.road.yishi.proto.childpatrol
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildCampListMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.childpatrol.ChildCampInfoMsg")]
      public var campList:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.childpatrol.ChildCampTimeInfoMsg")]
      public var childList:Array = [];
      
      public function ChildCampListMsg()
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         _loc2_ = 0;
         while(_loc2_ < campList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,campList[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < childList.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,childList[_loc3_]);
            _loc3_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:ChildCampInfoMsg = null;
         var _loc4_:ChildCampTimeInfoMsg = null;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampListMsg.op cannot be set twice.");
                  }
                  _loc6_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc3_ = new ChildCampInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  campList.push(_loc3_);
                  break;
               case 2:
                  _loc4_ = new ChildCampTimeInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  childList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

