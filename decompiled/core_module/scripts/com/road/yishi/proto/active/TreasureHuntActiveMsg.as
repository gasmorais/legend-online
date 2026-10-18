package com.road.yishi.proto.active
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TreasureHuntActiveMsg extends Message implements IExternalizable
   {
      
      private var active_id$field:String;
      
      private var begin_date$field:String;
      
      private var end_date$field:String;
      
      private var isOpen$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var joinInfo$field:PlayerJoinInfoMsg;
      
      [ArrayElementType("com.road.yishi.proto.active.RewardInfoMsg")]
      public var rewards:Array = [];
      
      public function TreasureHuntActiveMsg()
      {
         super();
      }
      
      public function removeActiveId() : void
      {
         active_id$field = null;
      }
      
      public function get hasActiveId() : Boolean
      {
         return active_id$field != null;
      }
      
      public function set activeId(param1:String) : void
      {
         active_id$field = param1;
      }
      
      public function get activeId() : String
      {
         return active_id$field;
      }
      
      public function removeBeginDate() : void
      {
         begin_date$field = null;
      }
      
      public function get hasBeginDate() : Boolean
      {
         return begin_date$field != null;
      }
      
      public function set beginDate(param1:String) : void
      {
         begin_date$field = param1;
      }
      
      public function get beginDate() : String
      {
         return begin_date$field;
      }
      
      public function removeEndDate() : void
      {
         end_date$field = null;
      }
      
      public function get hasEndDate() : Boolean
      {
         return end_date$field != null;
      }
      
      public function set endDate(param1:String) : void
      {
         end_date$field = param1;
      }
      
      public function get endDate() : String
      {
         return end_date$field;
      }
      
      public function removeIsOpen() : void
      {
         hasField$0 &= 4294967294;
         isOpen$field = new Boolean();
      }
      
      public function get hasIsOpen() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set isOpen(param1:Boolean) : void
      {
         hasField$0 |= 1;
         isOpen$field = param1;
      }
      
      public function get isOpen() : Boolean
      {
         return isOpen$field;
      }
      
      public function removeJoinInfo() : void
      {
         joinInfo$field = null;
      }
      
      public function get hasJoinInfo() : Boolean
      {
         return joinInfo$field != null;
      }
      
      public function set joinInfo(param1:PlayerJoinInfoMsg) : void
      {
         joinInfo$field = param1;
      }
      
      public function get joinInfo() : PlayerJoinInfoMsg
      {
         return joinInfo$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasActiveId)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,active_id$field);
         }
         if(hasBeginDate)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,begin_date$field);
         }
         if(hasEndDate)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,end_date$field);
         }
         if(hasIsOpen)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,isOpen$field);
         }
         if(hasJoinInfo)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_MESSAGE(param1,joinInfo$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rewards.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,rewards[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc8_:RewardInfoMsg = null;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TreasureHuntActiveMsg.activeId cannot be set twice.");
                  }
                  _loc3_++;
                  activeId = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TreasureHuntActiveMsg.beginDate cannot be set twice.");
                  }
                  _loc6_++;
                  beginDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TreasureHuntActiveMsg.endDate cannot be set twice.");
                  }
                  _loc9_++;
                  endDate = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TreasureHuntActiveMsg.isOpen cannot be set twice.");
                  }
                  _loc4_++;
                  isOpen = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TreasureHuntActiveMsg.joinInfo cannot be set twice.");
                  }
                  _loc5_++;
                  joinInfo = new PlayerJoinInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,joinInfo);
                  break;
               case 5:
                  _loc8_ = new RewardInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewards.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

