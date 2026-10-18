package com.road.yishi.proto.forbiddenboss
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ForbiddenBossListMsg extends Message implements IExternalizable
   {
      
      [ArrayElementType("com.road.yishi.proto.forbiddenboss.ForbiddenBossMsg")]
      public var bossList:Array = [];
      
      private var consortiaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bossId$field:int;
      
      public function ForbiddenBossListMsg()
      {
         super();
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortiaId$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortiaId$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortiaId$field;
      }
      
      public function removeBossId() : void
      {
         hasField$0 &= 4294967293;
         bossId$field = new int();
      }
      
      public function get hasBossId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bossId(param1:int) : void
      {
         hasField$0 |= 2;
         bossId$field = param1;
      }
      
      public function get bossId() : int
      {
         return bossId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < bossList.length)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,bossList[_loc2_]);
            _loc2_++;
         }
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,consortiaId$field);
         }
         if(hasBossId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,bossId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:ForbiddenBossMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 2)
            {
               case 0:
                  _loc6_ = new ForbiddenBossMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  bossList.push(_loc6_);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossListMsg.consortiaId cannot be set twice.");
                  }
                  _loc4_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ForbiddenBossListMsg.bossId cannot be set twice.");
                  }
                  _loc3_++;
                  bossId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

