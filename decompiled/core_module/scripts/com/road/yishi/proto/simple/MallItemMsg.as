package com.road.yishi.proto.simple
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class MallItemMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var user_id$field:int;
      
      private var nick_name$field:String;
      
      private var point$field:int;
      
      private var fix_point$field:int;
      
      private var hour$field:int;
      
      private var item_from$field:int;
      
      private var start_time$field:String;
      
      private var max_auction_id$field:int;
      
      private var item_info$field:SimpleItemInfoMsg;
      
      public function MallItemMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
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
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967287;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 8;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeFixPoint() : void
      {
         hasField$0 &= 4294967279;
         fix_point$field = new int();
      }
      
      public function get hasFixPoint() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set fixPoint(param1:int) : void
      {
         hasField$0 |= 16;
         fix_point$field = param1;
      }
      
      public function get fixPoint() : int
      {
         return fix_point$field;
      }
      
      public function removeHour() : void
      {
         hasField$0 &= 4294967263;
         hour$field = new int();
      }
      
      public function get hasHour() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set hour(param1:int) : void
      {
         hasField$0 |= 32;
         hour$field = param1;
      }
      
      public function get hour() : int
      {
         return hour$field;
      }
      
      public function removeItemFrom() : void
      {
         hasField$0 &= 4294967231;
         item_from$field = new int();
      }
      
      public function get hasItemFrom() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set itemFrom(param1:int) : void
      {
         hasField$0 |= 64;
         item_from$field = param1;
      }
      
      public function get itemFrom() : int
      {
         return item_from$field;
      }
      
      public function removeStartTime() : void
      {
         start_time$field = null;
      }
      
      public function get hasStartTime() : Boolean
      {
         return start_time$field != null;
      }
      
      public function set startTime(param1:String) : void
      {
         start_time$field = param1;
      }
      
      public function get startTime() : String
      {
         return start_time$field;
      }
      
      public function removeMaxAuctionId() : void
      {
         hasField$0 &= 4294967167;
         max_auction_id$field = new int();
      }
      
      public function get hasMaxAuctionId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set maxAuctionId(param1:int) : void
      {
         hasField$0 |= 128;
         max_auction_id$field = param1;
      }
      
      public function get maxAuctionId() : int
      {
         return max_auction_id$field;
      }
      
      public function removeItemInfo() : void
      {
         item_info$field = null;
      }
      
      public function get hasItemInfo() : Boolean
      {
         return item_info$field != null;
      }
      
      public function set itemInfo(param1:SimpleItemInfoMsg) : void
      {
         item_info$field = param1;
      }
      
      public function get itemInfo() : SimpleItemInfoMsg
      {
         return item_info$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasFixPoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,fix_point$field);
         }
         if(hasHour)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,hour$field);
         }
         if(hasItemFrom)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,item_from$field);
         }
         if(hasStartTime)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,start_time$field);
         }
         if(hasMaxAuctionId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,max_auction_id$field);
         }
         if(hasItemInfo)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_MESSAGE(param1,item_info$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.id cannot be set twice.");
                  }
                  _loc5_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.templateId cannot be set twice.");
                  }
                  _loc12_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.point cannot be set twice.");
                  }
                  _loc11_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.fixPoint cannot be set twice.");
                  }
                  _loc7_++;
                  fixPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.hour cannot be set twice.");
                  }
                  _loc6_++;
                  hour = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.itemFrom cannot be set twice.");
                  }
                  _loc8_++;
                  itemFrom = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.startTime cannot be set twice.");
                  }
                  _loc4_++;
                  startTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.maxAuctionId cannot be set twice.");
                  }
                  _loc9_++;
                  maxAuctionId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: MallItemMsg.itemInfo cannot be set twice.");
                  }
                  _loc14_++;
                  itemInfo = new SimpleItemInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,itemInfo);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

