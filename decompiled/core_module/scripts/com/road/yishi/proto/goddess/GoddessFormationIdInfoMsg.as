package com.road.yishi.proto.goddess
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GoddessFormationIdInfoMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var formationId$field:int;
      
      private var templateId$field:int;
      
      private var grade$field:int;
      
      private var gradeGp$field:int;
      
      public function GoddessFormationIdInfoMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeFormationId() : void
      {
         hasField$0 &= 4294967293;
         formationId$field = new int();
      }
      
      public function get hasFormationId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set formationId(param1:int) : void
      {
         hasField$0 |= 2;
         formationId$field = param1;
      }
      
      public function get formationId() : int
      {
         return formationId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967291;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 4;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294967287;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 8;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeGradeGp() : void
      {
         hasField$0 &= 4294967279;
         gradeGp$field = new int();
      }
      
      public function get hasGradeGp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set gradeGp(param1:int) : void
      {
         hasField$0 |= 16;
         gradeGp$field = param1;
      }
      
      public function get gradeGp() : int
      {
         return gradeGp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasFormationId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,formationId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasGradeGp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,gradeGp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessFormationIdInfoMsg.userId cannot be set twice.");
                  }
                  _loc7_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessFormationIdInfoMsg.formationId cannot be set twice.");
                  }
                  _loc6_++;
                  formationId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessFormationIdInfoMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessFormationIdInfoMsg.grade cannot be set twice.");
                  }
                  _loc3_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GoddessFormationIdInfoMsg.gradeGp cannot be set twice.");
                  }
                  _loc4_++;
                  gradeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

