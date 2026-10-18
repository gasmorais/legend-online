package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AvaterMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var arm_tempId$field:int;
      
      private var cloth_tempId$field:int;
      
      private var fashion_armTempId$field:int;
      
      private var fashion_clothTempId$field:int;
      
      private var fashion_wingTempId$field:int;
      
      private var fashion_headTempId$field:int;
      
      public function AvaterMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeArmTempId() : void
      {
         hasField$0 &= 4294967293;
         arm_tempId$field = new int();
      }
      
      public function get hasArmTempId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set armTempId(param1:int) : void
      {
         hasField$0 |= 2;
         arm_tempId$field = param1;
      }
      
      public function get armTempId() : int
      {
         return arm_tempId$field;
      }
      
      public function removeClothTempId() : void
      {
         hasField$0 &= 4294967291;
         cloth_tempId$field = new int();
      }
      
      public function get hasClothTempId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set clothTempId(param1:int) : void
      {
         hasField$0 |= 4;
         cloth_tempId$field = param1;
      }
      
      public function get clothTempId() : int
      {
         return cloth_tempId$field;
      }
      
      public function removeFashionArmTempId() : void
      {
         hasField$0 &= 4294967287;
         fashion_armTempId$field = new int();
      }
      
      public function get hasFashionArmTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fashionArmTempId(param1:int) : void
      {
         hasField$0 |= 8;
         fashion_armTempId$field = param1;
      }
      
      public function get fashionArmTempId() : int
      {
         return fashion_armTempId$field;
      }
      
      public function removeFashionClothTempId() : void
      {
         hasField$0 &= 4294967279;
         fashion_clothTempId$field = new int();
      }
      
      public function get hasFashionClothTempId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fashionClothTempId(param1:int) : void
      {
         hasField$0 |= 16;
         fashion_clothTempId$field = param1;
      }
      
      public function get fashionClothTempId() : int
      {
         return fashion_clothTempId$field;
      }
      
      public function removeFashionWingTempId() : void
      {
         hasField$0 &= 4294967263;
         fashion_wingTempId$field = new int();
      }
      
      public function get hasFashionWingTempId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set fashionWingTempId(param1:int) : void
      {
         hasField$0 |= 32;
         fashion_wingTempId$field = param1;
      }
      
      public function get fashionWingTempId() : int
      {
         return fashion_wingTempId$field;
      }
      
      public function removeFashionHeadTempId() : void
      {
         hasField$0 &= 4294967231;
         fashion_headTempId$field = new int();
      }
      
      public function get hasFashionHeadTempId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set fashionHeadTempId(param1:int) : void
      {
         hasField$0 |= 64;
         fashion_headTempId$field = param1;
      }
      
      public function get fashionHeadTempId() : int
      {
         return fashion_headTempId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasArmTempId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,arm_tempId$field);
         }
         if(hasClothTempId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,cloth_tempId$field);
         }
         if(hasFashionArmTempId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fashion_armTempId$field);
         }
         if(hasFashionClothTempId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,fashion_clothTempId$field);
         }
         if(hasFashionWingTempId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,fashion_wingTempId$field);
         }
         if(hasFashionHeadTempId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,fashion_headTempId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.userId cannot be set twice.");
                  }
                  _loc5_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.armTempId cannot be set twice.");
                  }
                  _loc10_++;
                  armTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.clothTempId cannot be set twice.");
                  }
                  _loc9_++;
                  clothTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.fashionArmTempId cannot be set twice.");
                  }
                  _loc4_++;
                  fashionArmTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.fashionClothTempId cannot be set twice.");
                  }
                  _loc3_++;
                  fashionClothTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.fashionWingTempId cannot be set twice.");
                  }
                  _loc8_++;
                  fashionWingTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AvaterMsg.fashionHeadTempId cannot be set twice.");
                  }
                  _loc6_++;
                  fashionHeadTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

