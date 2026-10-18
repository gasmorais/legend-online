package com.road.yishi.proto.item
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemReqMsg extends Message implements IExternalizable
   {
      
      private var begin_bag_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var begin_obj_id$field:int;
      
      private var begin_pos$field:int;
      
      private var end_bag_type$field:int;
      
      private var end_obj_id$field:int;
      
      private var end_pos$field:int;
      
      private var count$field:int;
      
      private var object_id$field:int;
      
      public function ItemReqMsg()
      {
         super();
      }
      
      public function removeBeginBagType() : void
      {
         hasField$0 &= 4294967294;
         begin_bag_type$field = new int();
      }
      
      public function get hasBeginBagType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set beginBagType(param1:int) : void
      {
         hasField$0 |= 1;
         begin_bag_type$field = param1;
      }
      
      public function get beginBagType() : int
      {
         return begin_bag_type$field;
      }
      
      public function removeBeginObjId() : void
      {
         hasField$0 &= 4294967293;
         begin_obj_id$field = new int();
      }
      
      public function get hasBeginObjId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set beginObjId(param1:int) : void
      {
         hasField$0 |= 2;
         begin_obj_id$field = param1;
      }
      
      public function get beginObjId() : int
      {
         return begin_obj_id$field;
      }
      
      public function removeBeginPos() : void
      {
         hasField$0 &= 4294967291;
         begin_pos$field = new int();
      }
      
      public function get hasBeginPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set beginPos(param1:int) : void
      {
         hasField$0 |= 4;
         begin_pos$field = param1;
      }
      
      public function get beginPos() : int
      {
         return begin_pos$field;
      }
      
      public function removeEndBagType() : void
      {
         hasField$0 &= 4294967287;
         end_bag_type$field = new int();
      }
      
      public function get hasEndBagType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endBagType(param1:int) : void
      {
         hasField$0 |= 8;
         end_bag_type$field = param1;
      }
      
      public function get endBagType() : int
      {
         return end_bag_type$field;
      }
      
      public function removeEndObjId() : void
      {
         hasField$0 &= 4294967279;
         end_obj_id$field = new int();
      }
      
      public function get hasEndObjId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set endObjId(param1:int) : void
      {
         hasField$0 |= 16;
         end_obj_id$field = param1;
      }
      
      public function get endObjId() : int
      {
         return end_obj_id$field;
      }
      
      public function removeEndPos() : void
      {
         hasField$0 &= 4294967263;
         end_pos$field = new int();
      }
      
      public function get hasEndPos() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set endPos(param1:int) : void
      {
         hasField$0 |= 32;
         end_pos$field = param1;
      }
      
      public function get endPos() : int
      {
         return end_pos$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967231;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 64;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeObjectId() : void
      {
         hasField$0 &= 4294967167;
         object_id$field = new int();
      }
      
      public function get hasObjectId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set objectId(param1:int) : void
      {
         hasField$0 |= 128;
         object_id$field = param1;
      }
      
      public function get objectId() : int
      {
         return object_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBeginBagType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,begin_bag_type$field);
         }
         if(hasBeginObjId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,begin_obj_id$field);
         }
         if(hasBeginPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,begin_pos$field);
         }
         if(hasEndBagType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,end_bag_type$field);
         }
         if(hasEndObjId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,end_obj_id$field);
         }
         if(hasEndPos)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,end_pos$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasObjectId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,object_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.beginBagType cannot be set twice.");
                  }
                  _loc4_++;
                  beginBagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.beginObjId cannot be set twice.");
                  }
                  _loc11_++;
                  beginObjId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.beginPos cannot be set twice.");
                  }
                  _loc7_++;
                  beginPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.endBagType cannot be set twice.");
                  }
                  _loc5_++;
                  endBagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.endObjId cannot be set twice.");
                  }
                  _loc6_++;
                  endObjId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.endPos cannot be set twice.");
                  }
                  _loc8_++;
                  endPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ItemReqMsg.objectId cannot be set twice.");
                  }
                  _loc9_++;
                  objectId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

