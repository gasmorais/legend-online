package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ConsortiaContributeMsg extends Message implements IExternalizable
   {
      
      private var nick_name$field:String;
      
      private var total_offer$field:int;
      
      private var hasField$0:uint = 0;
      
      private var today_offer$field:int;
      
      private var today_spirit$field:Int64;
      
      private var total_spirit$field:Int64;
      
      public function ConsortiaContributeMsg()
      {
         super();
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeTotalOffer() : void
      {
         hasField$0 &= 4294967294;
         total_offer$field = new int();
      }
      
      public function get hasTotalOffer() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set totalOffer(param1:int) : void
      {
         hasField$0 |= 1;
         total_offer$field = param1;
      }
      
      public function get totalOffer() : int
      {
         return total_offer$field;
      }
      
      public function removeTodayOffer() : void
      {
         hasField$0 &= 4294967293;
         today_offer$field = new int();
      }
      
      public function get hasTodayOffer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set todayOffer(param1:int) : void
      {
         hasField$0 |= 2;
         today_offer$field = param1;
      }
      
      public function get todayOffer() : int
      {
         return today_offer$field;
      }
      
      public function removeTodaySpirit() : void
      {
         today_spirit$field = null;
      }
      
      public function get hasTodaySpirit() : Boolean
      {
         return today_spirit$field != null;
      }
      
      public function set todaySpirit(param1:Int64) : void
      {
         today_spirit$field = param1;
      }
      
      public function get todaySpirit() : Int64
      {
         return today_spirit$field;
      }
      
      public function removeTotalSpirit() : void
      {
         total_spirit$field = null;
      }
      
      public function get hasTotalSpirit() : Boolean
      {
         return total_spirit$field != null;
      }
      
      public function set totalSpirit(param1:Int64) : void
      {
         total_spirit$field = param1;
      }
      
      public function get totalSpirit() : Int64
      {
         return total_spirit$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasTotalOffer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,total_offer$field);
         }
         if(hasTodayOffer)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,today_offer$field);
         }
         if(hasTodaySpirit)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT64(param1,today_spirit$field);
         }
         if(hasTotalSpirit)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT64(param1,total_spirit$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeMsg.totalOffer cannot be set twice.");
                  }
                  _loc6_++;
                  totalOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeMsg.todayOffer cannot be set twice.");
                  }
                  _loc8_++;
                  todayOffer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeMsg.todaySpirit cannot be set twice.");
                  }
                  _loc3_++;
                  todaySpirit = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 4:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ConsortiaContributeMsg.totalSpirit cannot be set twice.");
                  }
                  _loc4_++;
                  totalSpirit = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

