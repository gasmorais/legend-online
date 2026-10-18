package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialOrderInfoMsg extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var nickName$field:String;
      
      private var svrsName$field:String;
      
      private var daysMinute$field:int;
      
      private var hasField$0:uint = 0;
      
      private var weekMinute$field:int;
      
      private var daysOrder$field:int;
      
      private var weekOrder$field:int;
      
      private var isReward$field:int;
      
      private var orderType$field:int;
      
      public function SkyTrialOrderInfoMsg()
      {
         super();
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeSvrsName() : void
      {
         svrsName$field = null;
      }
      
      public function get hasSvrsName() : Boolean
      {
         return svrsName$field != null;
      }
      
      public function set svrsName(param1:String) : void
      {
         svrsName$field = param1;
      }
      
      public function get svrsName() : String
      {
         return svrsName$field;
      }
      
      public function removeDaysMinute() : void
      {
         hasField$0 &= 4294967294;
         daysMinute$field = new int();
      }
      
      public function get hasDaysMinute() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set daysMinute(param1:int) : void
      {
         hasField$0 |= 1;
         daysMinute$field = param1;
      }
      
      public function get daysMinute() : int
      {
         return daysMinute$field;
      }
      
      public function removeWeekMinute() : void
      {
         hasField$0 &= 4294967293;
         weekMinute$field = new int();
      }
      
      public function get hasWeekMinute() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set weekMinute(param1:int) : void
      {
         hasField$0 |= 2;
         weekMinute$field = param1;
      }
      
      public function get weekMinute() : int
      {
         return weekMinute$field;
      }
      
      public function removeDaysOrder() : void
      {
         hasField$0 &= 4294967291;
         daysOrder$field = new int();
      }
      
      public function get hasDaysOrder() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set daysOrder(param1:int) : void
      {
         hasField$0 |= 4;
         daysOrder$field = param1;
      }
      
      public function get daysOrder() : int
      {
         return daysOrder$field;
      }
      
      public function removeWeekOrder() : void
      {
         hasField$0 &= 4294967287;
         weekOrder$field = new int();
      }
      
      public function get hasWeekOrder() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set weekOrder(param1:int) : void
      {
         hasField$0 |= 8;
         weekOrder$field = param1;
      }
      
      public function get weekOrder() : int
      {
         return weekOrder$field;
      }
      
      public function removeIsReward() : void
      {
         hasField$0 &= 4294967279;
         isReward$field = new int();
      }
      
      public function get hasIsReward() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isReward(param1:int) : void
      {
         hasField$0 |= 16;
         isReward$field = param1;
      }
      
      public function get isReward() : int
      {
         return isReward$field;
      }
      
      public function removeOrderType() : void
      {
         hasField$0 &= 4294967263;
         orderType$field = new int();
      }
      
      public function get hasOrderType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set orderType(param1:int) : void
      {
         hasField$0 |= 32;
         orderType$field = param1;
      }
      
      public function get orderType() : int
      {
         return orderType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasSvrsName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,svrsName$field);
         }
         if(hasDaysMinute)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,daysMinute$field);
         }
         if(hasWeekMinute)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,weekMinute$field);
         }
         if(hasDaysOrder)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,daysOrder$field);
         }
         if(hasWeekOrder)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,weekOrder$field);
         }
         if(hasIsReward)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,isReward$field);
         }
         if(hasOrderType)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,orderType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.uuid cannot be set twice.");
                  }
                  _loc4_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.nickName cannot be set twice.");
                  }
                  _loc8_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.svrsName cannot be set twice.");
                  }
                  _loc5_++;
                  svrsName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.daysMinute cannot be set twice.");
                  }
                  _loc9_++;
                  daysMinute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.weekMinute cannot be set twice.");
                  }
                  _loc11_++;
                  weekMinute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.daysOrder cannot be set twice.");
                  }
                  _loc6_++;
                  daysOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.weekOrder cannot be set twice.");
                  }
                  _loc7_++;
                  weekOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.isReward cannot be set twice.");
                  }
                  _loc10_++;
                  isReward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialOrderInfoMsg.orderType cannot be set twice.");
                  }
                  _loc3_++;
                  orderType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

