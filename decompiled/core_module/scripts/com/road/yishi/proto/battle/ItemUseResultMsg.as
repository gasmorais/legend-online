package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ItemUseResultMsg extends Message implements IExternalizable
   {
      
      private var uItemId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var bagPos$field:int;
      
      private var count$field:int;
      
      private var result$field:int;
      
      private var living_id$field:int;
      
      private var temp_id$field:int;
      
      private var type$field:int;
      
      public function ItemUseResultMsg()
      {
         super();
      }
      
      public function removeUItemId() : void
      {
         hasField$0 &= 4294967294;
         uItemId$field = new int();
      }
      
      public function get hasUItemId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set uItemId(param1:int) : void
      {
         hasField$0 |= 1;
         uItemId$field = param1;
      }
      
      public function get uItemId() : int
      {
         return uItemId$field;
      }
      
      public function removeBagPos() : void
      {
         hasField$0 &= 4294967293;
         bagPos$field = new int();
      }
      
      public function get hasBagPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set bagPos(param1:int) : void
      {
         hasField$0 |= 2;
         bagPos$field = param1;
      }
      
      public function get bagPos() : int
      {
         return bagPos$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967291;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 4;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967287;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 8;
         result$field = param1;
      }
      
      public function get result() : int
      {
         return result$field;
      }
      
      public function removeLivingId() : void
      {
         hasField$0 &= 4294967279;
         living_id$field = new int();
      }
      
      public function get hasLivingId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set livingId(param1:int) : void
      {
         hasField$0 |= 16;
         living_id$field = param1;
      }
      
      public function get livingId() : int
      {
         return living_id$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967263;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 32;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967231;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 64;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUItemId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,uItemId$field);
         }
         if(hasBagPos)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,bagPos$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasLivingId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,living_id$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.uItemId cannot be set twice.");
                  }
                  _loc8_++;
                  uItemId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.bagPos cannot be set twice.");
                  }
                  _loc4_++;
                  bagPos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.count cannot be set twice.");
                  }
                  _loc3_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.result cannot be set twice.");
                  }
                  _loc5_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.livingId cannot be set twice.");
                  }
                  _loc9_++;
                  livingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.tempId cannot be set twice.");
                  }
                  _loc10_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ItemUseResultMsg.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

