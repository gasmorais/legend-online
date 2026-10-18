package com.road.yishi.proto.active.anniversary
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveRewardMsg extends Message implements IExternalizable
   {
      
      private var templateId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templatecount$field:int;
      
      private var templateshow$field:int;
      
      private var item_type$field:int;
      
      private var original_price$field:String;
      
      private var now_price$field:String;
      
      private var limit_times$field:String;
      
      private var can_buy$field:Boolean;
      
      public function ActiveRewardMsg()
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
      
      public function removeTemplatecount() : void
      {
         hasField$0 &= 4294967293;
         templatecount$field = new int();
      }
      
      public function get hasTemplatecount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templatecount(param1:int) : void
      {
         hasField$0 |= 2;
         templatecount$field = param1;
      }
      
      public function get templatecount() : int
      {
         return templatecount$field;
      }
      
      public function removeTemplateshow() : void
      {
         hasField$0 &= 4294967291;
         templateshow$field = new int();
      }
      
      public function get hasTemplateshow() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateshow(param1:int) : void
      {
         hasField$0 |= 4;
         templateshow$field = param1;
      }
      
      public function get templateshow() : int
      {
         return templateshow$field;
      }
      
      public function removeItemType() : void
      {
         hasField$0 &= 4294967287;
         item_type$field = new int();
      }
      
      public function get hasItemType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemType(param1:int) : void
      {
         hasField$0 |= 8;
         item_type$field = param1;
      }
      
      public function get itemType() : int
      {
         return item_type$field;
      }
      
      public function removeOriginalPrice() : void
      {
         original_price$field = null;
      }
      
      public function get hasOriginalPrice() : Boolean
      {
         return original_price$field != null;
      }
      
      public function set originalPrice(param1:String) : void
      {
         original_price$field = param1;
      }
      
      public function get originalPrice() : String
      {
         return original_price$field;
      }
      
      public function removeNowPrice() : void
      {
         now_price$field = null;
      }
      
      public function get hasNowPrice() : Boolean
      {
         return now_price$field != null;
      }
      
      public function set nowPrice(param1:String) : void
      {
         now_price$field = param1;
      }
      
      public function get nowPrice() : String
      {
         return now_price$field;
      }
      
      public function removeLimitTimes() : void
      {
         limit_times$field = null;
      }
      
      public function get hasLimitTimes() : Boolean
      {
         return limit_times$field != null;
      }
      
      public function set limitTimes(param1:String) : void
      {
         limit_times$field = param1;
      }
      
      public function get limitTimes() : String
      {
         return limit_times$field;
      }
      
      public function removeCanBuy() : void
      {
         hasField$0 &= 4294967279;
         can_buy$field = new Boolean();
      }
      
      public function get hasCanBuy() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set canBuy(param1:Boolean) : void
      {
         hasField$0 |= 16;
         can_buy$field = param1;
      }
      
      public function get canBuy() : Boolean
      {
         return can_buy$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasTemplatecount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templatecount$field);
         }
         if(hasTemplateshow)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,templateshow$field);
         }
         if(hasItemType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,item_type$field);
         }
         if(hasOriginalPrice)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,original_price$field);
         }
         if(hasNowPrice)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,now_price$field);
         }
         if(hasLimitTimes)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,limit_times$field);
         }
         if(hasCanBuy)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,can_buy$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.templatecount cannot be set twice.");
                  }
                  _loc3_++;
                  templatecount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.templateshow cannot be set twice.");
                  }
                  _loc5_++;
                  templateshow = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.itemType cannot be set twice.");
                  }
                  _loc11_++;
                  itemType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.originalPrice cannot be set twice.");
                  }
                  _loc6_++;
                  originalPrice = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.nowPrice cannot be set twice.");
                  }
                  _loc4_++;
                  nowPrice = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.limitTimes cannot be set twice.");
                  }
                  _loc7_++;
                  limitTimes = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveRewardMsg.canBuy cannot be set twice.");
                  }
                  _loc9_++;
                  canBuy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

