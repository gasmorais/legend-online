package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TimeZoneMsg extends Message implements IExternalizable
   {
      
      private var grand_world_id$field:String;
      
      private var grand_world_offset$field:int;
      
      private var hasField$0:uint = 0;
      
      private var castle_id$field:String;
      
      private var castle_offset$field:int;
      
      public function TimeZoneMsg()
      {
         super();
      }
      
      public function removeGrandWorldId() : void
      {
         grand_world_id$field = null;
      }
      
      public function get hasGrandWorldId() : Boolean
      {
         return grand_world_id$field != null;
      }
      
      public function set grandWorldId(param1:String) : void
      {
         grand_world_id$field = param1;
      }
      
      public function get grandWorldId() : String
      {
         return grand_world_id$field;
      }
      
      public function removeGrandWorldOffset() : void
      {
         hasField$0 &= 4294967294;
         grand_world_offset$field = new int();
      }
      
      public function get hasGrandWorldOffset() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set grandWorldOffset(param1:int) : void
      {
         hasField$0 |= 1;
         grand_world_offset$field = param1;
      }
      
      public function get grandWorldOffset() : int
      {
         return grand_world_offset$field;
      }
      
      public function removeCastleId() : void
      {
         castle_id$field = null;
      }
      
      public function get hasCastleId() : Boolean
      {
         return castle_id$field != null;
      }
      
      public function set castleId(param1:String) : void
      {
         castle_id$field = param1;
      }
      
      public function get castleId() : String
      {
         return castle_id$field;
      }
      
      public function removeCastleOffset() : void
      {
         hasField$0 &= 4294967293;
         castle_offset$field = new int();
      }
      
      public function get hasCastleOffset() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set castleOffset(param1:int) : void
      {
         hasField$0 |= 2;
         castle_offset$field = param1;
      }
      
      public function get castleOffset() : int
      {
         return castle_offset$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasGrandWorldId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,grand_world_id$field);
         }
         if(hasGrandWorldOffset)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_SINT32(param1,grand_world_offset$field);
         }
         if(hasCastleId)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,castle_id$field);
         }
         if(hasCastleOffset)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_SINT32(param1,castle_offset$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TimeZoneMsg.grandWorldId cannot be set twice.");
                  }
                  _loc4_++;
                  grandWorldId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TimeZoneMsg.grandWorldOffset cannot be set twice.");
                  }
                  _loc6_++;
                  grandWorldOffset = ReadUtils.read$TYPE_SINT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TimeZoneMsg.castleId cannot be set twice.");
                  }
                  _loc3_++;
                  castleId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TimeZoneMsg.castleOffset cannot be set twice.");
                  }
                  _loc7_++;
                  castleOffset = ReadUtils.read$TYPE_SINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

