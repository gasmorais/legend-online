package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaAltarOpenReqMsg extends Message implements IExternalizable
   {
      
      private var altar_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var wave_num$field:int;
      
      public function ConsortiaAltarOpenReqMsg()
      {
         super();
      }
      
      public function removeAltarType() : void
      {
         hasField$0 &= 4294967294;
         altar_type$field = new int();
      }
      
      public function get hasAltarType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set altarType(param1:int) : void
      {
         hasField$0 |= 1;
         altar_type$field = param1;
      }
      
      public function get altarType() : int
      {
         return altar_type$field;
      }
      
      public function removeWaveNum() : void
      {
         hasField$0 &= 4294967293;
         wave_num$field = new int();
      }
      
      public function get hasWaveNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set waveNum(param1:int) : void
      {
         hasField$0 |= 2;
         wave_num$field = param1;
      }
      
      public function get waveNum() : int
      {
         return wave_num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAltarType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,altar_type$field);
         }
         if(hasWaveNum)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,wave_num$field);
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
                     throw new IOError("Bad data format: ConsortiaAltarOpenReqMsg.altarType cannot be set twice.");
                  }
                  _loc4_++;
                  altarType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaAltarOpenReqMsg.waveNum cannot be set twice.");
                  }
                  _loc3_++;
                  waveNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

