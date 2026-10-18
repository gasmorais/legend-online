package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerAttriUpdateMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var geste$field:int;
      
      private var type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.BattleItemMsg")]
      public var item:Array = [];
      
      private var score$field:int;
      
      private var is_add$field:Boolean;
      
      private var war_campaign_id$field:int;
      
      private var last_fail$field:int;
      
      private var result$field:Boolean;
      
      public function PlayerAttriUpdateMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294967293;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 2;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeIsAdd() : void
      {
         hasField$0 &= 4294967279;
         is_add$field = new Boolean();
      }
      
      public function get hasIsAdd() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isAdd(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_add$field = param1;
      }
      
      public function get isAdd() : Boolean
      {
         return is_add$field;
      }
      
      public function removeWarCampaignId() : void
      {
         hasField$0 &= 4294967263;
         war_campaign_id$field = new int();
      }
      
      public function get hasWarCampaignId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set warCampaignId(param1:int) : void
      {
         hasField$0 |= 32;
         war_campaign_id$field = param1;
      }
      
      public function get warCampaignId() : int
      {
         return war_campaign_id$field;
      }
      
      public function removeLastFail() : void
      {
         hasField$0 &= 4294967231;
         last_fail$field = new int();
      }
      
      public function get hasLastFail() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set lastFail(param1:int) : void
      {
         hasField$0 |= 64;
         last_fail$field = param1;
      }
      
      public function get lastFail() : int
      {
         return last_fail$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967167;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 128;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasIsAdd)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,is_add$field);
         }
         if(hasWarCampaignId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,war_campaign_id$field);
         }
         if(hasLastFail)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,last_fail$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc3_:BattleItemMsg = null;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.geste cannot be set twice.");
                  }
                  _loc12_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  _loc3_ = new BattleItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc3_);
                  item.push(_loc3_);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.score cannot be set twice.");
                  }
                  _loc10_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.isAdd cannot be set twice.");
                  }
                  _loc5_++;
                  isAdd = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.warCampaignId cannot be set twice.");
                  }
                  _loc11_++;
                  warCampaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.lastFail cannot be set twice.");
                  }
                  _loc4_++;
                  lastFail = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerAttriUpdateMsg.result cannot be set twice.");
                  }
                  _loc7_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

