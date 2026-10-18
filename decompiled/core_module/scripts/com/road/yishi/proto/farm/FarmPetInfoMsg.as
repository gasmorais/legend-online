package com.road.yishi.proto.farm
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FarmPetInfoMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var pet_id$field:int;
      
      private var pos$field:int;
      
      private var begin_time$field:String;
      
      private var end_time$field:String;
      
      private var pet_template_id$field:int;
      
      private var state$field:int;
      
      private var pet_name$field:String;
      
      private var quality$field:int;
      
      public function FarmPetInfoMsg()
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
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967293;
         pet_id$field = new int();
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set petId(param1:int) : void
      {
         hasField$0 |= 2;
         pet_id$field = param1;
      }
      
      public function get petId() : int
      {
         return pet_id$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967291;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 4;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeBeginTime() : void
      {
         begin_time$field = null;
      }
      
      public function get hasBeginTime() : Boolean
      {
         return begin_time$field != null;
      }
      
      public function set beginTime(param1:String) : void
      {
         begin_time$field = param1;
      }
      
      public function get beginTime() : String
      {
         return begin_time$field;
      }
      
      public function removeEndTime() : void
      {
         end_time$field = null;
      }
      
      public function get hasEndTime() : Boolean
      {
         return end_time$field != null;
      }
      
      public function set endTime(param1:String) : void
      {
         end_time$field = param1;
      }
      
      public function get endTime() : String
      {
         return end_time$field;
      }
      
      public function removePetTemplateId() : void
      {
         hasField$0 &= 4294967287;
         pet_template_id$field = new int();
      }
      
      public function get hasPetTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set petTemplateId(param1:int) : void
      {
         hasField$0 |= 8;
         pet_template_id$field = param1;
      }
      
      public function get petTemplateId() : int
      {
         return pet_template_id$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removePetName() : void
      {
         pet_name$field = null;
      }
      
      public function get hasPetName() : Boolean
      {
         return pet_name$field != null;
      }
      
      public function set petName(param1:String) : void
      {
         pet_name$field = param1;
      }
      
      public function get petName() : String
      {
         return pet_name$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 4294967263;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 32;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,pet_id$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasBeginTime)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,begin_time$field);
         }
         if(hasEndTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,end_time$field);
         }
         if(hasPetTemplateId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,pet_template_id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.userId cannot be set twice.");
                  }
                  _loc8_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.petId cannot be set twice.");
                  }
                  _loc9_++;
                  petId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.pos cannot be set twice.");
                  }
                  _loc11_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.beginTime cannot be set twice.");
                  }
                  _loc4_++;
                  beginTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.endTime cannot be set twice.");
                  }
                  _loc6_++;
                  endTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.petTemplateId cannot be set twice.");
                  }
                  _loc5_++;
                  petTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.state cannot be set twice.");
                  }
                  _loc10_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.petName cannot be set twice.");
                  }
                  _loc7_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FarmPetInfoMsg.quality cannot be set twice.");
                  }
                  _loc3_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

