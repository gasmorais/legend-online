package com.road.yishi.proto.achievementtask
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AchievementTaskMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var data$field:int;
      
      private var isCompleted$field:Boolean;
      
      private var isPopout$field:Boolean;
      
      private var isReward$field:Boolean;
      
      public function AchievementTaskMsg()
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
      
      public function removeData() : void
      {
         hasField$0 &= 4294967293;
         data$field = new int();
      }
      
      public function get hasData() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set data(param1:int) : void
      {
         hasField$0 |= 2;
         data$field = param1;
      }
      
      public function get data() : int
      {
         return data$field;
      }
      
      public function removeIsCompleted() : void
      {
         hasField$0 &= 4294967291;
         isCompleted$field = new Boolean();
      }
      
      public function get hasIsCompleted() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isCompleted(param1:Boolean) : void
      {
         hasField$0 |= 4;
         isCompleted$field = param1;
      }
      
      public function get isCompleted() : Boolean
      {
         return isCompleted$field;
      }
      
      public function removeIsPopout() : void
      {
         hasField$0 &= 4294967287;
         isPopout$field = new Boolean();
      }
      
      public function get hasIsPopout() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set isPopout(param1:Boolean) : void
      {
         hasField$0 |= 8;
         isPopout$field = param1;
      }
      
      public function get isPopout() : Boolean
      {
         return isPopout$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967279;
         isReward$field = new Boolean();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isReward(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isReward$field = param1;
      }
      
      public function get isReward() : Boolean
      {
         return isReward$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasData)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,data$field);
         }
         if(hasIsCompleted)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,isCompleted$field);
         }
         if(hasIsPopout)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isPopout$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,isReward$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskMsg.data cannot be set twice.");
                  }
                  _loc8_++;
                  data = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskMsg.isCompleted cannot be set twice.");
                  }
                  _loc4_++;
                  isCompleted = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskMsg.isPopout cannot be set twice.");
                  }
                  _loc3_++;
                  isPopout = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AchievementTaskMsg.isReward cannot be set twice.");
                  }
                  _loc5_++;
                  isReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

