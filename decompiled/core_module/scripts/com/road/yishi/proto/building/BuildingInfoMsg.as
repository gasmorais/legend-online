package com.road.yishi.proto.building
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BuildingInfoMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var building_id$field:int;
      
      private var castle_id$field:int;
      
      private var created_date$field:String;
      
      private var is_exist$field:Boolean;
      
      private var template_id$field:int;
      
      private var son_type$field:int;
      
      private var propterty1$field:int;
      
      private var propterty2$field:int;
      
      public function BuildingInfoMsg()
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
      
      public function removeBuildingId() : void
      {
         hasField$0 &= 4294967293;
         building_id$field = new int();
      }
      
      public function get hasBuildingId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set buildingId(param1:int) : void
      {
         hasField$0 |= 2;
         building_id$field = param1;
      }
      
      public function get buildingId() : int
      {
         return building_id$field;
      }
      
      public function removeCastleId() : void
      {
         hasField$0 &= 4294967291;
         castle_id$field = new int();
      }
      
      public function get hasCastleId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set castleId(param1:int) : void
      {
         hasField$0 |= 4;
         castle_id$field = param1;
      }
      
      public function get castleId() : int
      {
         return castle_id$field;
      }
      
      public function removeCreatedDate() : void
      {
         created_date$field = null;
      }
      
      public function get hasCreatedDate() : Boolean
      {
         return created_date$field != null;
      }
      
      public function set createdDate(param1:String) : void
      {
         created_date$field = param1;
      }
      
      public function get createdDate() : String
      {
         return created_date$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967287;
         is_exist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 8;
         is_exist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return is_exist$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967279;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 16;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967263;
         son_type$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 32;
         son_type$field = param1;
      }
      
      public function get sonType() : int
      {
         return son_type$field;
      }
      
      public function removePropterty1() : void
      {
         hasField$0 &= 4294967231;
         propterty1$field = new int();
      }
      
      public function get hasPropterty1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set propterty1(param1:int) : void
      {
         hasField$0 |= 64;
         propterty1$field = param1;
      }
      
      public function get propterty1() : int
      {
         return propterty1$field;
      }
      
      public function removePropterty2() : void
      {
         hasField$0 &= 4294967167;
         propterty2$field = new int();
      }
      
      public function get hasPropterty2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set propterty2(param1:int) : void
      {
         hasField$0 |= 128;
         propterty2$field = param1;
      }
      
      public function get propterty2() : int
      {
         return propterty2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasBuildingId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,building_id$field);
         }
         if(hasCastleId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,castle_id$field);
         }
         if(hasCreatedDate)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,created_date$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_exist$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,son_type$field);
         }
         if(hasPropterty1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,propterty1$field);
         }
         if(hasPropterty2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,propterty2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.buildingId cannot be set twice.");
                  }
                  _loc5_++;
                  buildingId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.castleId cannot be set twice.");
                  }
                  _loc7_++;
                  castleId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.createdDate cannot be set twice.");
                  }
                  _loc6_++;
                  createdDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.isExist cannot be set twice.");
                  }
                  _loc8_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.templateId cannot be set twice.");
                  }
                  _loc11_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.sonType cannot be set twice.");
                  }
                  _loc4_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.propterty1 cannot be set twice.");
                  }
                  _loc3_++;
                  propterty1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BuildingInfoMsg.propterty2 cannot be set twice.");
                  }
                  _loc9_++;
                  propterty2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

