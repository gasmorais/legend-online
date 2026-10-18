package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerEnchantMsg extends Message implements IExternalizable
   {
      
      private var skillId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var skillGrade$field:int;
      
      private var skillProficiency$field:int;
      
      private var pos$field:int;
      
      private var objectId$field:int;
      
      private var bagType$field:int;
      
      public function PlayerEnchantMsg()
      {
         super();
      }
      
      public function removeSkillId() : void
      {
         hasField$0 &= 4294967294;
         skillId$field = new int();
      }
      
      public function get hasSkillId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set skillId(param1:int) : void
      {
         hasField$0 |= 1;
         skillId$field = param1;
      }
      
      public function get skillId() : int
      {
         return skillId$field;
      }
      
      public function removeSkillGrade() : void
      {
         hasField$0 &= 4294967293;
         skillGrade$field = new int();
      }
      
      public function get hasSkillGrade() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set skillGrade(param1:int) : void
      {
         hasField$0 |= 2;
         skillGrade$field = param1;
      }
      
      public function get skillGrade() : int
      {
         return skillGrade$field;
      }
      
      public function removeSkillProficiency() : void
      {
         hasField$0 &= 4294967291;
         skillProficiency$field = new int();
      }
      
      public function get hasSkillProficiency() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set skillProficiency(param1:int) : void
      {
         hasField$0 |= 4;
         skillProficiency$field = param1;
      }
      
      public function get skillProficiency() : int
      {
         return skillProficiency$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967287;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 8;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeObjectId() : void
      {
         hasField$0 &= 4294967279;
         objectId$field = new int();
      }
      
      public function get hasObjectId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set objectId(param1:int) : void
      {
         hasField$0 |= 16;
         objectId$field = param1;
      }
      
      public function get objectId() : int
      {
         return objectId$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967263;
         bagType$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 32;
         bagType$field = param1;
      }
      
      public function get bagType() : int
      {
         return bagType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSkillId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,skillId$field);
         }
         if(hasSkillGrade)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,skillGrade$field);
         }
         if(hasSkillProficiency)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,skillProficiency$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasObjectId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,objectId$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,bagType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerEnchantMsg.skillId cannot be set twice.");
                  }
                  _loc4_++;
                  skillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerEnchantMsg.skillGrade cannot be set twice.");
                  }
                  _loc9_++;
                  skillGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerEnchantMsg.skillProficiency cannot be set twice.");
                  }
                  _loc5_++;
                  skillProficiency = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerEnchantMsg.pos cannot be set twice.");
                  }
                  _loc6_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerEnchantMsg.objectId cannot be set twice.");
                  }
                  _loc7_++;
                  objectId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerEnchantMsg.bagType cannot be set twice.");
                  }
                  _loc3_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

