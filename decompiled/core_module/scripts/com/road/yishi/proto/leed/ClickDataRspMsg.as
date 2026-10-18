package com.road.yishi.proto.leed
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ClickDataRspMsg extends Message implements IExternalizable
   {
      
      private var keys$field:String;
      
      private var keyData$field:int;
      
      private var hasField$0:uint = 0;
      
      private var changeTime$field:String;
      
      public function ClickDataRspMsg()
      {
         super();
      }
      
      public function removeKeys() : void
      {
         keys$field = null;
      }
      
      public function get hasKeys() : Boolean
      {
         return keys$field != null;
      }
      
      public function set keys(param1:String) : void
      {
         keys$field = param1;
      }
      
      public function get keys() : String
      {
         return keys$field;
      }
      
      public function removeKeyData() : void
      {
         hasField$0 &= 4294967294;
         keyData$field = new int();
      }
      
      public function get hasKeyData() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set keyData(param1:int) : void
      {
         hasField$0 |= 1;
         keyData$field = param1;
      }
      
      public function get keyData() : int
      {
         return keyData$field;
      }
      
      public function removeChangeTime() : void
      {
         changeTime$field = null;
      }
      
      public function get hasChangeTime() : Boolean
      {
         return changeTime$field != null;
      }
      
      public function set changeTime(param1:String) : void
      {
         changeTime$field = param1;
      }
      
      public function get changeTime() : String
      {
         return changeTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasKeys)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,keys$field);
         }
         if(hasKeyData)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,keyData$field);
         }
         if(hasChangeTime)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,changeTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ClickDataRspMsg.keys cannot be set twice.");
                  }
                  _loc6_++;
                  keys = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ClickDataRspMsg.keyData cannot be set twice.");
                  }
                  _loc4_++;
                  keyData = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ClickDataRspMsg.changeTime cannot be set twice.");
                  }
                  _loc3_++;
                  changeTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

