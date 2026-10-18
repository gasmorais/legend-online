package com.road.yishi.proto.active
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveInfoMsg extends Message implements IExternalizable
   {
      
      private var active_id$field:String;
      
      private var state$field:int;
      
      private var hasField$0:uint = 0;
      
      public function ActiveInfoMsg()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         active_id$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return active_id$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967294;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 1;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,state$field);
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
                     throw new IOError("Bad data format: ActiveInfoMsg.activeId cannot be set twice.");
                  }
                  _loc3_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveInfoMsg.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

