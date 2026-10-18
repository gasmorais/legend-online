package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnsRspMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var data$field:String;
      
      private var md5$field:String;
      
      public function SnsRspMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeData() : void
      {
         data$field = null;
      }
      
      public function get hasData() : Boolean
      {
         return data$field != null;
      }
      
      public function set data(param1:String) : void
      {
         data$field = param1;
      }
      
      public function get data() : String
      {
         return data$field;
      }
      
      public function removeMd5() : void
      {
         md5$field = null;
      }
      
      public function get hasMd5() : Boolean
      {
         return md5$field != null;
      }
      
      public function set md5(param1:String) : void
      {
         md5$field = param1;
      }
      
      public function get md5() : String
      {
         return md5$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasData)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,data$field);
         }
         if(hasMd5)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,md5$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SnsRspMsg.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SnsRspMsg.data cannot be set twice.");
                  }
                  _loc6_++;
                  data = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SnsRspMsg.md5 cannot be set twice.");
                  }
                  _loc3_++;
                  md5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

