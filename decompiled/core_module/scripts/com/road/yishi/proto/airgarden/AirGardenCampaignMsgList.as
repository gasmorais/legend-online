package com.road.yishi.proto.airgarden
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AirGardenCampaignMsgList extends Message implements IExternalizable
   {
      
      private var page$field:int;
      
      private var hasField$0:uint = 0;
      
      private var totalPage$field:int;
      
      [ArrayElementType("com.road.yishi.proto.airgarden.AirGardenCampaignMsg")]
      public var list:Array = [];
      
      public function AirGardenCampaignMsgList()
      {
         super();
      }
      
      public function removePage() : void
      {
         hasField$0 &= 4294967294;
         page$field = new int();
      }
      
      public function get hasPage() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set page(param1:int) : void
      {
         hasField$0 |= 1;
         page$field = param1;
      }
      
      public function get page() : int
      {
         return page$field;
      }
      
      public function removeTotalPage() : void
      {
         hasField$0 &= 4294967293;
         totalPage$field = new int();
      }
      
      public function get hasTotalPage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set totalPage(param1:int) : void
      {
         hasField$0 |= 2;
         totalPage$field = param1;
      }
      
      public function get totalPage() : int
      {
         return totalPage$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasPage)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,page$field);
         }
         if(hasTotalPage)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,totalPage$field);
         }
         _loc2_ = 0;
         while(_loc2_ < list.length)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_MESSAGE(param1,list[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:* = 0;
         var _loc5_:AirGardenCampaignMsg = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc6_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsgList.page cannot be set twice.");
                  }
                  _loc4_++;
                  page = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsgList.totalPage cannot be set twice.");
                  }
                  _loc3_++;
                  totalPage = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  _loc5_ = new AirGardenCampaignMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  list.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
            }
         }
      }
   }
}

