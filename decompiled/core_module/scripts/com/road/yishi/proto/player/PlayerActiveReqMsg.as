package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerActiveReqMsg extends Message implements IExternalizable
   {
      
      private var key$field:String;
      
      private var activeId$field:String;
      
      public function PlayerActiveReqMsg()
      {
         super();
      }
      
      public function removeKey() : void
      {
         key$field = null;
      }
      
      public function get hasKey() : Boolean
      {
         return key$field != null;
      }
      
      public function set key(param1:String) : void
      {
         key$field = param1;
      }
      
      public function get key() : String
      {
         return key$field;
      }
      
      public function removeActiveId() : void
      {
         activeId$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return activeId$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         activeId$field = param1;
      }
      
      public function get activeId() : String
      {
         return activeId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasKey)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,key$field);
         }
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,activeId$field);
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
                     throw new IOError("Bad data format: PlayerActiveReqMsg.key cannot be set twice.");
                  }
                  _loc3_++;
                  key = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerActiveReqMsg.activeId cannot be set twice.");
                  }
                  _loc4_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

