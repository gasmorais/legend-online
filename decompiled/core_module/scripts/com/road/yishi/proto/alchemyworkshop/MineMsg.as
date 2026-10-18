package com.road.yishi.proto.alchemyworkshop
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MineMsg extends Message implements IExternalizable
   {
      
      private var mineId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var startTime$field:String;
      
      public function MineMsg()
      {
         super();
      }
      
      public function removeMineId() : void
      {
         hasField$0 &= 4294967294;
         mineId$field = new int();
      }
      
      public function get hasMineId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mineId(param1:int) : void
      {
         hasField$0 |= 1;
         mineId$field = param1;
      }
      
      public function get mineId() : int
      {
         return mineId$field;
      }
      
      public function removeStartTime() : void
      {
         startTime$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return startTime$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         startTime$field = param1;
      }
      
      public function get startTime() : String
      {
         return startTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMineId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mineId$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,startTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MineMsg.mineId cannot be set twice.");
                  }
                  _loc3_++;
                  mineId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MineMsg.startTime cannot be set twice.");
                  }
                  _loc4_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

