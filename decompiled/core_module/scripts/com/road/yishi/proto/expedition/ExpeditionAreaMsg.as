package com.road.yishi.proto.expedition
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExpeditionAreaMsg extends Message implements IExternalizable
   {
      
      private var areaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var passNodeId$field:int;
      
      public function ExpeditionAreaMsg()
      {
         super();
      }
      
      public function removeAreaId() : void
      {
         hasField$0 &= 4294967294;
         areaId$field = new int();
      }
      
      public function get hasAreaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set areaId(param1:int) : void
      {
         hasField$0 |= 1;
         areaId$field = param1;
      }
      
      public function get areaId() : int
      {
         return areaId$field;
      }
      
      public function removePassNodeId() : void
      {
         hasField$0 &= 4294967293;
         passNodeId$field = new int();
      }
      
      public function get hasPassNodeId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set passNodeId(param1:int) : void
      {
         hasField$0 |= 2;
         passNodeId$field = param1;
      }
      
      public function get passNodeId() : int
      {
         return passNodeId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAreaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,areaId$field);
         }
         if(hasPassNodeId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,passNodeId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc4_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionAreaMsg.areaId cannot be set twice.");
                  }
                  _loc3_++;
                  areaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ExpeditionAreaMsg.passNodeId cannot be set twice.");
                  }
                  _loc5_++;
                  passNodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
            }
         }
      }
   }
}

