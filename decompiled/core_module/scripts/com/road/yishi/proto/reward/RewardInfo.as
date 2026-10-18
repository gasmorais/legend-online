package com.road.yishi.proto.reward
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RewardInfo extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var is_complete$field:Boolean;
      
      private var condition_1$field:int;
      
      private var condition_2$field:int;
      
      private var condition_3$field:int;
      
      private var condition_4$field:int;
      
      private var completed_date$field:String;
      
      private var repeat_finish$field:int;
      
      private var is_accept$field:Boolean;
      
      private var is_select$field:Boolean;
      
      private var quality$field:int;
      
      public function RewardInfo()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeIsComplete() : void
      {
         hasField$0 &= 4294967293;
         is_complete$field = new Boolean();
      }
      
      public function get hasIsComplete() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isComplete(param1:Boolean) : void
      {
         hasField$0 |= 2;
         is_complete$field = param1;
      }
      
      public function get isComplete() : Boolean
      {
         return is_complete$field;
      }
      
      public function removeCondition_1() : void
      {
         hasField$0 &= 4294967291;
         condition_1$field = new int();
      }
      
      public function get hasCondition_1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set condition_1(param1:int) : void
      {
         hasField$0 |= 4;
         condition_1$field = param1;
      }
      
      public function get condition_1() : int
      {
         return condition_1$field;
      }
      
      public function removeCondition_2() : void
      {
         hasField$0 &= 4294967287;
         condition_2$field = new int();
      }
      
      public function get hasCondition_2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set condition_2(param1:int) : void
      {
         hasField$0 |= 8;
         condition_2$field = param1;
      }
      
      public function get condition_2() : int
      {
         return condition_2$field;
      }
      
      public function removeCondition_3() : void
      {
         hasField$0 &= 4294967279;
         condition_3$field = new int();
      }
      
      public function get hasCondition_3() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set condition_3(param1:int) : void
      {
         hasField$0 |= 16;
         condition_3$field = param1;
      }
      
      public function get condition_3() : int
      {
         return condition_3$field;
      }
      
      public function removeCondition_4() : void
      {
         hasField$0 &= 4294967263;
         condition_4$field = new int();
      }
      
      public function get hasCondition_4() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set condition_4(param1:int) : void
      {
         hasField$0 |= 32;
         condition_4$field = param1;
      }
      
      public function get condition_4() : int
      {
         return condition_4$field;
      }
      
      public function removeCompletedDate() : void
      {
         completed_date$field = null;
      }
      
      public function get hasCompletedDate() : Boolean
      {
         return completed_date$field != null;
      }
      
      public function set completedDate(param1:String) : void
      {
         completed_date$field = param1;
      }
      
      public function get completedDate() : String
      {
         return completed_date$field;
      }
      
      public function removeRepeatFinish() : void
      {
         hasField$0 &= 4294967231;
         repeat_finish$field = new int();
      }
      
      public function get hasRepeatFinish() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set repeatFinish(param1:int) : void
      {
         hasField$0 |= 64;
         repeat_finish$field = param1;
      }
      
      public function get repeatFinish() : int
      {
         return repeat_finish$field;
      }
      
      public function removeIsAccept() : void
      {
         hasField$0 &= 4294967167;
         is_accept$field = new Boolean();
      }
      
      public function get hasIsAccept() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isAccept(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_accept$field = param1;
      }
      
      public function get isAccept() : Boolean
      {
         return is_accept$field;
      }
      
      public function removeIsSelect() : void
      {
         hasField$0 &= 4294967039;
         is_select$field = new Boolean();
      }
      
      public function get hasIsSelect() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_select$field = param1;
      }
      
      public function get isSelect() : Boolean
      {
         return is_select$field;
      }
      
      public function removeQuality() : void
      {
         hasField$0 &= 4294966783;
         quality$field = new int();
      }
      
      public function get hasQuality() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set quality(param1:int) : void
      {
         hasField$0 |= 512;
         quality$field = param1;
      }
      
      public function get quality() : int
      {
         return quality$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasIsComplete)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,is_complete$field);
         }
         if(hasCondition_1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,condition_1$field);
         }
         if(hasCondition_2)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,condition_2$field);
         }
         if(hasCondition_3)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,condition_3$field);
         }
         if(hasCondition_4)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,condition_4$field);
         }
         if(hasCompletedDate)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,completed_date$field);
         }
         if(hasRepeatFinish)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,repeat_finish$field);
         }
         if(hasIsAccept)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,is_accept$field);
         }
         if(hasIsSelect)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,is_select$field);
         }
         if(hasQuality)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,quality$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.templateId cannot be set twice.");
                  }
                  _loc11_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.isComplete cannot be set twice.");
                  }
                  _loc8_++;
                  isComplete = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.condition_1 cannot be set twice.");
                  }
                  _loc4_++;
                  condition_1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.condition_2 cannot be set twice.");
                  }
                  _loc10_++;
                  condition_2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.condition_3 cannot be set twice.");
                  }
                  _loc14_++;
                  condition_3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.condition_4 cannot be set twice.");
                  }
                  _loc9_++;
                  condition_4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.completedDate cannot be set twice.");
                  }
                  _loc7_++;
                  completedDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.repeatFinish cannot be set twice.");
                  }
                  _loc6_++;
                  repeatFinish = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.isAccept cannot be set twice.");
                  }
                  _loc12_++;
                  isAccept = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.isSelect cannot be set twice.");
                  }
                  _loc5_++;
                  isSelect = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RewardInfo.quality cannot be set twice.");
                  }
                  _loc3_++;
                  quality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

