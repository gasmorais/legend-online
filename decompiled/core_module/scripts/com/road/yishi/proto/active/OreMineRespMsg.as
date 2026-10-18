package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OreMineRespMsg extends Message implements IExternalizable
   {
      
      private var passType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var count$field:int;
      
      [ArrayElementType("int")]
      public var floors:Array = [];
      
      [ArrayElementType("String")]
      public var infos:Array = [];
      
      public function OreMineRespMsg()
      {
         super();
      }
      
      public function removePassType() : void
      {
         hasField$0 &= 4294967294;
         passType$field = new int();
      }
      
      public function get hasPassType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set passType(param1:int) : void
      {
         hasField$0 |= 1;
         passType$field = param1;
      }
      
      public function get passType() : int
      {
         return passType$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967293;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 2;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         if(hasPassType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,passType$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         _loc3_ = 0;
         while(_loc3_ < floors.length)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,floors[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < infos.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,infos[_loc2_]);
            _loc2_++;
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
                     throw new IOError("Bad data format: OreMineRespMsg.passType cannot be set twice.");
                  }
                  _loc3_++;
                  passType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OreMineRespMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if((_loc5_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,floors);
                  }
                  else
                  {
                     floors.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 3:
                  infos.push(ReadUtils.read$TYPE_STRING(param1));
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

