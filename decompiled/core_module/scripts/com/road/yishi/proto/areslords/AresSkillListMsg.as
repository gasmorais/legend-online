package com.road.yishi.proto.areslords
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AresSkillListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.areslords.AresSkillInfoMsg")]
      public var info:Array = [];
      
      private var freeCount$field:int;
      
      private var hasField$0:uint = 0;
      
      public function AresSkillListMsg()
      {
         super();
      }
      
      public function removeFreeCount() : void
      {
         hasField$0 &= 4294967294;
         freeCount$field = new int();
      }
      
      public function get hasFreeCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set freeCount(param1:int) : void
      {
         hasField$0 |= 1;
         freeCount$field = param1;
      }
      
      public function get freeCount() : int
      {
         return freeCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
         if(hasFreeCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,freeCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:AresSkillInfoMsg = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  _loc4_ = new AresSkillInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  info.push(_loc4_);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AresSkillListMsg.freeCount cannot be set twice.");
                  }
                  _loc3_++;
                  freeCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

