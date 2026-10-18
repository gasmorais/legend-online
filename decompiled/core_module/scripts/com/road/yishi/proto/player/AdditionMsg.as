package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AdditionMsg extends Message implements IExternalizable
   {
      
      private var master_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var power$field:int;
      
      private var agility$field:int;
      
      private var intellect$field:int;
      
      private var physique$field:int;
      
      private var create_date$field:String;
      
      private var expirt_date$field:String;
      
      private var description$field:String;
      
      private var is_exist$field:Boolean;
      
      public function AdditionMsg()
      {
         super();
      }
      
      public function removeMasterType() : void
      {
         hasField$0 &= 4294967294;
         master_type$field = new int();
      }
      
      public function get hasMasterType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set masterType(param1:int) : void
      {
         hasField$0 |= 1;
         master_type$field = param1;
      }
      
      public function get masterType() : int
      {
         return master_type$field;
      }
      
      public function removePower() : void
      {
         hasField$0 &= 4294967293;
         power$field = new int();
      }
      
      public function get hasPower() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set power(param1:int) : void
      {
         hasField$0 |= 2;
         power$field = param1;
      }
      
      public function get power() : int
      {
         return power$field;
      }
      
      public function removeAgility() : void
      {
         hasField$0 &= 4294967291;
         agility$field = new int();
      }
      
      public function get hasAgility() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set agility(param1:int) : void
      {
         hasField$0 |= 4;
         agility$field = param1;
      }
      
      public function get agility() : int
      {
         return agility$field;
      }
      
      public function removeIntellect() : void
      {
         hasField$0 &= 4294967287;
         intellect$field = new int();
      }
      
      public function get hasIntellect() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set intellect(param1:int) : void
      {
         hasField$0 |= 8;
         intellect$field = param1;
      }
      
      public function get intellect() : int
      {
         return intellect$field;
      }
      
      public function removePhysique() : void
      {
         hasField$0 &= 4294967279;
         physique$field = new int();
      }
      
      public function get hasPhysique() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set physique(param1:int) : void
      {
         hasField$0 |= 16;
         physique$field = param1;
      }
      
      public function get physique() : int
      {
         return physique$field;
      }
      
      public function removeCreateDate() : void
      {
         create_date$field = null;
      }
      
      public function get hasCreateDate() : Boolean
      {
         return create_date$field != null;
      }
      
      public function set createDate(param1:String) : void
      {
         create_date$field = param1;
      }
      
      public function get createDate() : String
      {
         return create_date$field;
      }
      
      public function removeExpirtDate() : void
      {
         expirt_date$field = null;
      }
      
      public function get hasExpirtDate() : Boolean
      {
         return expirt_date$field != null;
      }
      
      public function set expirtDate(param1:String) : void
      {
         expirt_date$field = param1;
      }
      
      public function get expirtDate() : String
      {
         return expirt_date$field;
      }
      
      public function removeDescription() : void
      {
         description$field = null;
      }
      
      public function get hasDescription() : Boolean
      {
         return description$field != null;
      }
      
      public function set description(param1:String) : void
      {
         description$field = param1;
      }
      
      public function get description() : String
      {
         return description$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967263;
         is_exist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 32;
         is_exist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return is_exist$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMasterType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,master_type$field);
         }
         if(hasPower)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,power$field);
         }
         if(hasAgility)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,agility$field);
         }
         if(hasIntellect)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,intellect$field);
         }
         if(hasPhysique)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,physique$field);
         }
         if(hasCreateDate)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,create_date$field);
         }
         if(hasExpirtDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,expirt_date$field);
         }
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,is_exist$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:* = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc11_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.masterType cannot be set twice.");
                  }
                  _loc3_++;
                  masterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.power cannot be set twice.");
                  }
                  _loc5_++;
                  power = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.agility cannot be set twice.");
                  }
                  _loc8_++;
                  agility = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.intellect cannot be set twice.");
                  }
                  _loc12_++;
                  intellect = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.physique cannot be set twice.");
                  }
                  _loc10_++;
                  physique = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.createDate cannot be set twice.");
                  }
                  _loc9_++;
                  createDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.expirtDate cannot be set twice.");
                  }
                  _loc6_++;
                  expirtDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.description cannot be set twice.");
                  }
                  _loc7_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AdditionMsg.isExist cannot be set twice.");
                  }
                  _loc4_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
            }
         }
      }
   }
}

