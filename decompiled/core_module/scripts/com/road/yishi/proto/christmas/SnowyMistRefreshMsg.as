package com.road.yishi.proto.christmas
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SnowyMistRefreshMsg extends Message implements IExternalizable
   {
      
      private var opType$field:int;
      
      private var hasField$0:uint = 0;
      
      [ArrayElementType("com.road.yishi.proto.christmas.SnowyMistMsg")]
      public var snowyMistList:Array = [];
      
      public function SnowyMistRefreshMsg()
      {
         super();
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294967294;
         opType$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 1;
         opType$field = param1;
      }
      
      public function get opType() : int
      {
         return opType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,opType$field);
         }
         _loc2_ = 0;
         while(_loc2_ < snowyMistList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,snowyMistList[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:SnowyMistMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SnowyMistRefreshMsg.opType cannot be set twice.");
                  }
                  _loc3_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  _loc4_ = new SnowyMistMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  snowyMistList.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

