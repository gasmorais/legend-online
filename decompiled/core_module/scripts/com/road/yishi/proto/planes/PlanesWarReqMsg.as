package com.road.yishi.proto.planes
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlanesWarReqMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      [ArrayElementType("int")]
      public var param:Array = [];
      
      [ArrayElementType("String")]
      public var paramStr:Array = [];
      
      public function PlanesWarReqMsg()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         _loc3_ = 0;
         while(_loc3_ < param.length)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,param[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < paramStr.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,paramStr[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:* = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = ReadUtils.read$TYPE_UINT32(param1);
            switch((_loc3_ >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlanesWarReqMsg.op cannot be set twice.");
                  }
                  _loc4_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if((_loc3_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,param);
                  }
                  else
                  {
                     param.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 2:
                  paramStr.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
            }
         }
         if(_loc4_ != 1)
         {
            throw new IOError("Bad data format: PlanesWarReqMsg.op must be set.");
         }
      }
   }
}

