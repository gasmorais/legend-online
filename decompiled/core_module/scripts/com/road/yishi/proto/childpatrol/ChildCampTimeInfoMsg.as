package com.road.yishi.proto.childpatrol
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ChildCampTimeInfoMsg extends Message implements IExternalizable
   {
      
      private var ChildId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var OverTime$field:Int64;
      
      public function ChildCampTimeInfoMsg()
      {
         super();
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967294;
         ChildId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 1;
         ChildId$field = param1;
      }
      
      public function get childId() : int
      {
         return ChildId$field;
      }
      
      public function removeOverTime() : void
      {
         OverTime$field = null;
      }
      
      public function get hasOverTime() : Boolean
      {
         return OverTime$field != null;
      }
      
      public function set overTime(param1:Int64) : void
      {
         OverTime$field = param1;
      }
      
      public function get overTime() : Int64
      {
         return OverTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,ChildId$field);
         }
         if(hasOverTime)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT64(param1,OverTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampTimeInfoMsg.childId cannot be set twice.");
                  }
                  _loc4_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ChildCampTimeInfoMsg.overTime cannot be set twice.");
                  }
                  _loc3_++;
                  overTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

