package com.road.yishi.proto.room
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RoomCreatedMsg extends Message implements IExternalizable
   {
      
      private var created_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var room$field:RoomMsg;
      
      private var is_cross$field:Boolean;
      
      private var campignId$field:int;
      
      public function RoomCreatedMsg()
      {
         super();
      }
      
      public function removeCreatedType() : void
      {
         hasField$0 &= 4294967294;
         created_type$field = new int();
      }
      
      public function get hasCreatedType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set createdType(param1:int) : void
      {
         hasField$0 |= 1;
         created_type$field = param1;
      }
      
      public function get createdType() : int
      {
         return created_type$field;
      }
      
      public function removeRoom() : void
      {
         room$field = null;
      }
      
      public function get hasRoom() : Boolean
      {
         return room$field != null;
      }
      
      public function set room(param1:RoomMsg) : void
      {
         room$field = param1;
      }
      
      public function get room() : RoomMsg
      {
         return room$field;
      }
      
      public function removeIsCross() : void
      {
         hasField$0 &= 4294967293;
         is_cross$field = new Boolean();
      }
      
      public function get hasIsCross() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isCross(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_cross$field = param1;
      }
      
      public function get isCross() : Boolean
      {
         return is_cross$field;
      }
      
      public function removeCampignId() : void
      {
         hasField$0 &= 4294967291;
         campignId$field = new int();
      }
      
      public function get hasCampignId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set campignId(param1:int) : void
      {
         hasField$0 |= 4;
         campignId$field = param1;
      }
      
      public function get campignId() : int
      {
         return campignId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCreatedType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,created_type$field);
         }
         if(hasRoom)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_MESSAGE(param1,room$field);
         }
         if(hasIsCross)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_cross$field);
         }
         if(hasCampignId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,campignId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RoomCreatedMsg.createdType cannot be set twice.");
                  }
                  _loc6_++;
                  createdType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RoomCreatedMsg.room cannot be set twice.");
                  }
                  _loc4_++;
                  room = new RoomMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,room);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RoomCreatedMsg.isCross cannot be set twice.");
                  }
                  _loc7_++;
                  isCross = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RoomCreatedMsg.campignId cannot be set twice.");
                  }
                  _loc3_++;
                  campignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

