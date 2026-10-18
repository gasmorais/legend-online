package com.road.yishi.proto.magiccard
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MagicCardInfoMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var grades$field:int;
      
      private var gp$field:int;
      
      private var pos$field:int;
      
      private var skillTempIds$field:String;
      
      private var types$field:int;
      
      private var templateName$field:String;
      
      private var isActive$field:Boolean;
      
      public function MagicCardInfoMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967293;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 2;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967291;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 4;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
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
      
      public function removeSkillTempIds() : void
      {
         skillTempIds$field = null;
      }
      
      public function get hasSkillTempIds() : Boolean
      {
         return skillTempIds$field != null;
      }
      
      public function set skillTempIds(param1:String) : void
      {
         skillTempIds$field = param1;
      }
      
      public function get skillTempIds() : String
      {
         return skillTempIds$field;
      }
      
      public function removeTypes() : void
      {
         hasField$0 &= 4294967279;
         types$field = new int();
      }
      
      public function get hasTypes() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set types(param1:int) : void
      {
         hasField$0 |= 16;
         types$field = param1;
      }
      
      public function get types() : int
      {
         return types$field;
      }
      
      public function removeTemplateName() : void
      {
         templateName$field = null;
      }
      
      public function get hasTemplateName() : Boolean
      {
         return templateName$field != null;
      }
      
      public function set templateName(param1:String) : void
      {
         templateName$field = param1;
      }
      
      public function get templateName() : String
      {
         return templateName$field;
      }
      
      public function removeIsActive() : void
      {
         hasField$0 &= 4294967263;
         isActive$field = new Boolean();
      }
      
      public function get hasIsActive() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isActive$field = param1;
      }
      
      public function get isActive() : Boolean
      {
         return isActive$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasSkillTempIds)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,skillTempIds$field);
         }
         if(hasTypes)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,types$field);
         }
         if(hasTemplateName)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,templateName$field);
         }
         if(hasIsActive)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isActive$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.grades cannot be set twice.");
                  }
                  _loc11_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.gp cannot be set twice.");
                  }
                  _loc10_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.pos cannot be set twice.");
                  }
                  _loc8_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.skillTempIds cannot be set twice.");
                  }
                  _loc3_++;
                  skillTempIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.types cannot be set twice.");
                  }
                  _loc5_++;
                  types = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.templateName cannot be set twice.");
                  }
                  _loc4_++;
                  templateName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MagicCardInfoMsg.isActive cannot be set twice.");
                  }
                  _loc6_++;
                  isActive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

