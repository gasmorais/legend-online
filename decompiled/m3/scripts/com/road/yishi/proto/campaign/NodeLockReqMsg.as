package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class NodeLockReqMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var lock$field:Boolean;
      
      public function NodeLockReqMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeLock() : void
      {
         hasField$0 &= 4294967293;
         lock$field = new Boolean();
      }
      
      public function get hasLock() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set lock(param1:Boolean) : void
      {
         hasField$0 |= 2;
         lock$field = param1;
      }
      
      public function get lock() : Boolean
      {
         return lock$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasLock)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,lock$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = uint(ReadUtils.read$TYPE_UINT32(param1))) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: NodeLockReqMsg.nodeId cannot be set twice.");
                  }
                  _loc4_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: NodeLockReqMsg.lock cannot be set twice.");
                  }
                  _loc3_++;
                  lock = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

