package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class RollDiceMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var point$field:int;
      
      private var normal_point$field:int;
      
      private var special_point$field:int;
      
      private var war_flag$field:int;
      
      private var result_point$field:int;
      
      private var position$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.NodeMsg")]
      public var nodeInfo:Array = [];
      
      private var last_buy_special_point$field:int;
      
      private var last_buy_war_flag$field:int;
      
      private var campaign_count$field:int;
      
      public function RollDiceMsg()
      {
         super();
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967294;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 1;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removePoint() : void
      {
         hasField$0 &= 4294967293;
         point$field = new int();
      }
      
      public function get hasPoint() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set point(param1:int) : void
      {
         hasField$0 |= 2;
         point$field = param1;
      }
      
      public function get point() : int
      {
         return point$field;
      }
      
      public function removeNormalPoint() : void
      {
         hasField$0 &= 4294967291;
         normal_point$field = new int();
      }
      
      public function get hasNormalPoint() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set normalPoint(param1:int) : void
      {
         hasField$0 |= 4;
         normal_point$field = param1;
      }
      
      public function get normalPoint() : int
      {
         return normal_point$field;
      }
      
      public function removeSpecialPoint() : void
      {
         hasField$0 &= 4294967287;
         special_point$field = new int();
      }
      
      public function get hasSpecialPoint() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set specialPoint(param1:int) : void
      {
         hasField$0 |= 8;
         special_point$field = param1;
      }
      
      public function get specialPoint() : int
      {
         return special_point$field;
      }
      
      public function removeWarFlag() : void
      {
         hasField$0 &= 4294967279;
         war_flag$field = new int();
      }
      
      public function get hasWarFlag() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set warFlag(param1:int) : void
      {
         hasField$0 |= 16;
         war_flag$field = param1;
      }
      
      public function get warFlag() : int
      {
         return war_flag$field;
      }
      
      public function removeResultPoint() : void
      {
         hasField$0 &= 4294967263;
         result_point$field = new int();
      }
      
      public function get hasResultPoint() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set resultPoint(param1:int) : void
      {
         hasField$0 |= 32;
         result_point$field = param1;
      }
      
      public function get resultPoint() : int
      {
         return result_point$field;
      }
      
      public function removePosition() : void
      {
         hasField$0 &= 4294967231;
         position$field = new int();
      }
      
      public function get hasPosition() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set position(param1:int) : void
      {
         hasField$0 |= 64;
         position$field = param1;
      }
      
      public function get position() : int
      {
         return position$field;
      }
      
      public function removeLastBuySpecialPoint() : void
      {
         hasField$0 &= 4294967167;
         last_buy_special_point$field = new int();
      }
      
      public function get hasLastBuySpecialPoint() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set lastBuySpecialPoint(param1:int) : void
      {
         hasField$0 |= 128;
         last_buy_special_point$field = param1;
      }
      
      public function get lastBuySpecialPoint() : int
      {
         return last_buy_special_point$field;
      }
      
      public function removeLastBuyWarFlag() : void
      {
         hasField$0 &= 4294967039;
         last_buy_war_flag$field = new int();
      }
      
      public function get hasLastBuyWarFlag() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set lastBuyWarFlag(param1:int) : void
      {
         hasField$0 |= 256;
         last_buy_war_flag$field = param1;
      }
      
      public function get lastBuyWarFlag() : int
      {
         return last_buy_war_flag$field;
      }
      
      public function removeCampaignCount() : void
      {
         hasField$0 &= 4294966783;
         campaign_count$field = new int();
      }
      
      public function get hasCampaignCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set campaignCount(param1:int) : void
      {
         hasField$0 |= 512;
         campaign_count$field = param1;
      }
      
      public function get campaignCount() : int
      {
         return campaign_count$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasPoint)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,point$field);
         }
         if(hasNormalPoint)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,normal_point$field);
         }
         if(hasSpecialPoint)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,special_point$field);
         }
         if(hasWarFlag)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,war_flag$field);
         }
         if(hasResultPoint)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,result_point$field);
         }
         if(hasPosition)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,position$field);
         }
         _loc2_ = 0;
         while(_loc2_ < nodeInfo.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,nodeInfo[_loc2_]);
            _loc2_++;
         }
         if(hasLastBuySpecialPoint)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,last_buy_special_point$field);
         }
         if(hasLastBuyWarFlag)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,last_buy_war_flag$field);
         }
         if(hasCampaignCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,campaign_count$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc10_:NodeMsg = null;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.type cannot be set twice.");
                  }
                  _loc5_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.point cannot be set twice.");
                  }
                  _loc12_++;
                  point = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.normalPoint cannot be set twice.");
                  }
                  _loc11_++;
                  normalPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.specialPoint cannot be set twice.");
                  }
                  _loc9_++;
                  specialPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.warFlag cannot be set twice.");
                  }
                  _loc7_++;
                  warFlag = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.resultPoint cannot be set twice.");
                  }
                  _loc14_++;
                  resultPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.position cannot be set twice.");
                  }
                  _loc3_++;
                  position = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc10_ = new NodeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc10_);
                  nodeInfo.push(_loc10_);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.lastBuySpecialPoint cannot be set twice.");
                  }
                  _loc4_++;
                  lastBuySpecialPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.lastBuyWarFlag cannot be set twice.");
                  }
                  _loc6_++;
                  lastBuyWarFlag = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: RollDiceMsg.campaignCount cannot be set twice.");
                  }
                  _loc8_++;
                  campaignCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

