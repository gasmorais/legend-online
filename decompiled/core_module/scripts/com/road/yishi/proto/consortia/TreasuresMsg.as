package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TreasuresMsg extends Message implements IExternalizable
   {
      
      private var treasureId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var treasureTemplateId$field:int;
      
      public function TreasuresMsg()
      {
         super();
      }
      
      public function removeTreasureId() : void
      {
         hasField$0 &= 4294967294;
         treasureId$field = new int();
      }
      
      public function get hasTreasureId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set treasureId(param1:int) : void
      {
         hasField$0 |= 1;
         treasureId$field = param1;
      }
      
      public function get treasureId() : int
      {
         return treasureId$field;
      }
      
      public function removeTreasureTemplateId() : void
      {
         hasField$0 &= 4294967293;
         treasureTemplateId$field = new int();
      }
      
      public function get hasTreasureTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set treasureTemplateId(param1:int) : void
      {
         hasField$0 |= 2;
         treasureTemplateId$field = param1;
      }
      
      public function get treasureTemplateId() : int
      {
         return treasureTemplateId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTreasureId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,treasureId$field);
         }
         if(hasTreasureTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,treasureTemplateId$field);
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
                     throw new IOError("Bad data format: TreasuresMsg.treasureId cannot be set twice.");
                  }
                  _loc3_++;
                  treasureId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TreasuresMsg.treasureTemplateId cannot be set twice.");
                  }
                  _loc4_++;
                  treasureTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

