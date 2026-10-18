package com.road.yishi.proto.storehouse
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StoreHouseFightMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var curLevel$field:int;
      
      private var chapterId$field:int;
      
      private var mapId$field:int;
      
      private var equipSkills$field:String;
      
      [ArrayElementType("int")]
      public var allSkills:Array = [];
      
      private var addSkill$field:int;
      
      public function StoreHouseFightMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeCurLevel() : void
      {
         hasField$0 &= 4294967293;
         curLevel$field = new int();
      }
      
      public function get hasCurLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set curLevel(param1:int) : void
      {
         hasField$0 |= 2;
         curLevel$field = param1;
      }
      
      public function get curLevel() : int
      {
         return curLevel$field;
      }
      
      public function removeChapterId() : void
      {
         hasField$0 &= 4294967291;
         chapterId$field = new int();
      }
      
      public function get hasChapterId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set chapterId(param1:int) : void
      {
         hasField$0 |= 4;
         chapterId$field = param1;
      }
      
      public function get chapterId() : int
      {
         return chapterId$field;
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967287;
         mapId$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 8;
         mapId$field = param1;
      }
      
      public function get mapId() : int
      {
         return mapId$field;
      }
      
      public function removeEquipSkills() : void
      {
         equipSkills$field = null;
      }
      
      public function get hasEquipSkills() : Boolean
      {
         return equipSkills$field != null;
      }
      
      public function set equipSkills(param1:String) : void
      {
         equipSkills$field = param1;
      }
      
      public function get equipSkills() : String
      {
         return equipSkills$field;
      }
      
      public function removeAddSkill() : void
      {
         hasField$0 &= 4294967279;
         addSkill$field = new int();
      }
      
      public function get hasAddSkill() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set addSkill(param1:int) : void
      {
         hasField$0 |= 16;
         addSkill$field = param1;
      }
      
      public function get addSkill() : int
      {
         return addSkill$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasCurLevel)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,curLevel$field);
         }
         if(hasChapterId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,chapterId$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,mapId$field);
         }
         if(hasEquipSkills)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,equipSkills$field);
         }
         _loc2_ = 0;
         while(_loc2_ < allSkills.length)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,allSkills[_loc2_]);
            _loc2_++;
         }
         if(hasAddSkill)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,addSkill$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseFightMsg.type cannot be set twice.");
                  }
                  _loc7_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseFightMsg.curLevel cannot be set twice.");
                  }
                  _loc5_++;
                  curLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseFightMsg.chapterId cannot be set twice.");
                  }
                  _loc3_++;
                  chapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseFightMsg.mapId cannot be set twice.");
                  }
                  _loc9_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseFightMsg.equipSkills cannot be set twice.");
                  }
                  _loc4_++;
                  equipSkills = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if((_loc8_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,allSkills);
                  }
                  else
                  {
                     allSkills.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StoreHouseFightMsg.addSkill cannot be set twice.");
                  }
                  _loc6_++;
                  addSkill = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

