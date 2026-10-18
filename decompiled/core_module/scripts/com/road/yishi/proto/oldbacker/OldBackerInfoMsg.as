package com.road.yishi.proto.oldbacker
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class OldBackerInfoMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateName$field:String;
      
      private var rewardTypes$field:int;
      
      private var rewardLevel$field:int;
      
      private var needPoints$field:int;
      
      private var needGrades$field:int;
      
      private var needLoginDay$field:int;
      
      private var needCounts$field:int;
      
      [ArrayElementType("com.road.yishi.proto.oldbacker.OldBackerItemMsg")]
      public var rewardItems:Array = [];
      
      private var description$field:String;
      
      private var rewardState$field:int;
      
      public function OldBackerInfoMsg()
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
      
      public function removeRewardTypes() : void
      {
         hasField$0 &= 4294967293;
         rewardTypes$field = new int();
      }
      
      public function get hasRewardTypes() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardTypes(param1:int) : void
      {
         hasField$0 |= 2;
         rewardTypes$field = param1;
      }
      
      public function get rewardTypes() : int
      {
         return rewardTypes$field;
      }
      
      public function removeRewardLevel() : void
      {
         hasField$0 &= 4294967291;
         rewardLevel$field = new int();
      }
      
      public function get hasRewardLevel() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rewardLevel(param1:int) : void
      {
         hasField$0 |= 4;
         rewardLevel$field = param1;
      }
      
      public function get rewardLevel() : int
      {
         return rewardLevel$field;
      }
      
      public function removeNeedPoints() : void
      {
         hasField$0 &= 4294967287;
         needPoints$field = new int();
      }
      
      public function get hasNeedPoints() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set needPoints(param1:int) : void
      {
         hasField$0 |= 8;
         needPoints$field = param1;
      }
      
      public function get needPoints() : int
      {
         return needPoints$field;
      }
      
      public function removeNeedGrades() : void
      {
         hasField$0 &= 4294967279;
         needGrades$field = new int();
      }
      
      public function get hasNeedGrades() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set needGrades(param1:int) : void
      {
         hasField$0 |= 16;
         needGrades$field = param1;
      }
      
      public function get needGrades() : int
      {
         return needGrades$field;
      }
      
      public function removeNeedLoginDay() : void
      {
         hasField$0 &= 4294967263;
         needLoginDay$field = new int();
      }
      
      public function get hasNeedLoginDay() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set needLoginDay(param1:int) : void
      {
         hasField$0 |= 32;
         needLoginDay$field = param1;
      }
      
      public function get needLoginDay() : int
      {
         return needLoginDay$field;
      }
      
      public function removeNeedCounts() : void
      {
         hasField$0 &= 4294967231;
         needCounts$field = new int();
      }
      
      public function get hasNeedCounts() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set needCounts(param1:int) : void
      {
         hasField$0 |= 64;
         needCounts$field = param1;
      }
      
      public function get needCounts() : int
      {
         return needCounts$field;
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
      
      public function removeRewardState() : void
      {
         hasField$0 &= 4294967167;
         rewardState$field = new int();
      }
      
      public function get hasRewardState() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set rewardState(param1:int) : void
      {
         hasField$0 |= 128;
         rewardState$field = param1;
      }
      
      public function get rewardState() : int
      {
         return rewardState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasTemplateName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,templateName$field);
         }
         if(hasRewardTypes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rewardTypes$field);
         }
         if(hasRewardLevel)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rewardLevel$field);
         }
         if(hasNeedPoints)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,needPoints$field);
         }
         if(hasNeedGrades)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,needGrades$field);
         }
         if(hasNeedLoginDay)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,needLoginDay$field);
         }
         if(hasNeedCounts)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,needCounts$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewardItems.length)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardItems[_loc2_]);
            _loc2_++;
         }
         if(hasDescription)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,description$field);
         }
         if(hasRewardState)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,rewardState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc8_:OldBackerItemMsg = null;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.templateId cannot be set twice.");
                  }
                  _loc3_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.templateName cannot be set twice.");
                  }
                  _loc10_++;
                  templateName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.rewardTypes cannot be set twice.");
                  }
                  _loc11_++;
                  rewardTypes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.rewardLevel cannot be set twice.");
                  }
                  _loc6_++;
                  rewardLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.needPoints cannot be set twice.");
                  }
                  _loc4_++;
                  needPoints = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.needGrades cannot be set twice.");
                  }
                  _loc9_++;
                  needGrades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.needLoginDay cannot be set twice.");
                  }
                  _loc7_++;
                  needLoginDay = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.needCounts cannot be set twice.");
                  }
                  _loc14_++;
                  needCounts = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  _loc8_ = new OldBackerItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewardItems.push(_loc8_);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.description cannot be set twice.");
                  }
                  _loc12_++;
                  description = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: OldBackerInfoMsg.rewardState cannot be set twice.");
                  }
                  _loc5_++;
                  rewardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

