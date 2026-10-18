package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ExtraFieldInfoMsg extends Message implements IExternalizable
   {
      
      public var fieldId:int;
      
      public var field_Type:int;
      
      public var userId:int;
      
      public var value:String;
      
      public function ExtraFieldInfoMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,fieldId);
         WriteUtils.writeTag(param1,0,2);
         WriteUtils.write$TYPE_INT32(param1,field_Type);
         WriteUtils.writeTag(param1,0,3);
         WriteUtils.write$TYPE_INT32(param1,userId);
         WriteUtils.writeTag(param1,2,4);
         WriteUtils.write$TYPE_STRING(param1,value);
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ExtraFieldInfoMsg.fieldId cannot be set twice.");
                  }
                  _loc3_++;
                  fieldId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ExtraFieldInfoMsg.field_Type cannot be set twice.");
                  }
                  _loc6_++;
                  field_Type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ExtraFieldInfoMsg.userId cannot be set twice.");
                  }
                  _loc4_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ExtraFieldInfoMsg.value cannot be set twice.");
                  }
                  _loc7_++;
                  value = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
         if(_loc3_ != 1)
         {
            throw new IOError("Bad data format: ExtraFieldInfoMsg.fieldId must be set.");
         }
         if(_loc6_ != 1)
         {
            throw new IOError("Bad data format: ExtraFieldInfoMsg.field_Type must be set.");
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: ExtraFieldInfoMsg.userId must be set.");
         }
         if(_loc7_ != 1)
         {
            throw new IOError("Bad data format: ExtraFieldInfoMsg.value must be set.");
         }
      }
   }
}

