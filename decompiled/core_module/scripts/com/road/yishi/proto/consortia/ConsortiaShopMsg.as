package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaShopMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var consortia_stocked_count$field:int;
      
      private var user_bought_total_count$field:int;
      
      public function ConsortiaShopMsg()
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
      
      public function removeConsortiaStockedCount() : void
      {
         hasField$0 &= 4294967293;
         consortia_stocked_count$field = new int();
      }
      
      public function get hasConsortiaStockedCount() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set consortiaStockedCount(param1:int) : void
      {
         hasField$0 |= 2;
         consortia_stocked_count$field = param1;
      }
      
      public function get consortiaStockedCount() : int
      {
         return consortia_stocked_count$field;
      }
      
      public function removeUserBoughtTotalCount() : void
      {
         hasField$0 &= 4294967291;
         user_bought_total_count$field = new int();
      }
      
      public function get hasUserBoughtTotalCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userBoughtTotalCount(param1:int) : void
      {
         hasField$0 |= 4;
         user_bought_total_count$field = param1;
      }
      
      public function get userBoughtTotalCount() : int
      {
         return user_bought_total_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasConsortiaStockedCount)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,consortia_stocked_count$field);
         }
         if(hasUserBoughtTotalCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_bought_total_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc5_:* = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc5_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaShopMsg.templateId cannot be set twice.");
                  }
                  _loc4_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaShopMsg.consortiaStockedCount cannot be set twice.");
                  }
                  _loc6_++;
                  consortiaStockedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaShopMsg.userBoughtTotalCount cannot be set twice.");
                  }
                  _loc3_++;
                  userBoughtTotalCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc5_ & 7);
            }
         }
      }
   }
}

