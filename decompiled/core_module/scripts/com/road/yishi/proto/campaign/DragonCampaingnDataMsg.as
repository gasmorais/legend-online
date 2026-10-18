package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class DragonCampaingnDataMsg extends Message implements IExternalizable
   {
      
      private var type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaignTm$field:int;
      
      private var stateTm$field:int;
      
      private var state$field:int;
      
      private var cur_round$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.RollInfoMsg")]
      public var rollInfos:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.campaign.BoxInfoMsg")]
      public var boxInfos:Array = [];
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      public function DragonCampaingnDataMsg()
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
      
      public function removeCampaignTm() : void
      {
         hasField$0 &= 4294967293;
         campaignTm$field = new int();
      }
      
      public function get hasCampaignTm() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set campaignTm(param1:int) : void
      {
         hasField$0 |= 2;
         campaignTm$field = param1;
      }
      
      public function get campaignTm() : int
      {
         return campaignTm$field;
      }
      
      public function removeStateTm() : void
      {
         hasField$0 &= 4294967291;
         stateTm$field = new int();
      }
      
      public function get hasStateTm() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set stateTm(param1:int) : void
      {
         hasField$0 |= 4;
         stateTm$field = param1;
      }
      
      public function get stateTm() : int
      {
         return stateTm$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeCurRound() : void
      {
         hasField$0 &= 4294967279;
         cur_round$field = new int();
      }
      
      public function get hasCurRound() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set curRound(param1:int) : void
      {
         hasField$0 |= 16;
         cur_round$field = param1;
      }
      
      public function get curRound() : int
      {
         return cur_round$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294967263;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 32;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4294967231;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 64;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasCampaignTm)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,campaignTm$field);
         }
         if(hasStateTm)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,stateTm$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasCurRound)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,cur_round$field);
         }
         _loc2_ = 0;
         while(_loc2_ < rollInfos.length)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_MESSAGE(param1,rollInfos[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < boxInfos.length)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_MESSAGE(param1,boxInfos[_loc3_]);
            _loc3_++;
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc8_:RollInfoMsg = null;
         var _loc5_:BoxInfoMsg = null;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.type cannot be set twice.");
                  }
                  _loc9_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.campaignTm cannot be set twice.");
                  }
                  _loc7_++;
                  campaignTm = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.stateTm cannot be set twice.");
                  }
                  _loc11_++;
                  stateTm = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.state cannot be set twice.");
                  }
                  _loc6_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.curRound cannot be set twice.");
                  }
                  _loc3_++;
                  curRound = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  _loc8_ = new RollInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rollInfos.push(_loc8_);
                  break;
               case 6:
                  _loc5_ = new BoxInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  boxInfos.push(_loc5_);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.param1 cannot be set twice.");
                  }
                  _loc4_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: DragonCampaingnDataMsg.param2 cannot be set twice.");
                  }
                  _loc12_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

