package com.road.yishi.proto.vehicle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class VehicleCampaignDetailMsg extends Message implements IExternalizable
   {
      
      private var campaignId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var campaignName$field:String;
      
      private var redTeamScroe$field:int;
      
      private var blueTeamScroe$field:int;
      
      private var myScroe$field:int;
      
      private var remainsTiem$field:int;
      
      private var winner$field:int;
      
      [ArrayElementType("com.road.yishi.proto.vehicle.VehicleScroeListMsg")]
      public var scroeList:Array = [];
      
      private var my_order$field:int;
      
      private var my_userid$field:int;
      
      private var has_reward$field:Boolean;
      
      private var my_kill_count$field:int;
      
      private var campaignStartTime$field:String;
      
      public function VehicleCampaignDetailMsg()
      {
         super();
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967294;
         campaignId$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 1;
         campaignId$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaignId$field;
      }
      
      public function removeCampaignName() : void
      {
         campaignName$field = null;
      }
      
      public function get hasCampaignName() : Boolean
      {
         return campaignName$field != null;
      }
      
      public function set campaignName(param1:String) : void
      {
         campaignName$field = param1;
      }
      
      public function get campaignName() : String
      {
         return campaignName$field;
      }
      
      public function removeRedTeamScroe() : void
      {
         hasField$0 &= 4294967293;
         redTeamScroe$field = new int();
      }
      
      public function get hasRedTeamScroe() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set redTeamScroe(param1:int) : void
      {
         hasField$0 |= 2;
         redTeamScroe$field = param1;
      }
      
      public function get redTeamScroe() : int
      {
         return redTeamScroe$field;
      }
      
      public function removeBlueTeamScroe() : void
      {
         hasField$0 &= 4294967291;
         blueTeamScroe$field = new int();
      }
      
      public function get hasBlueTeamScroe() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set blueTeamScroe(param1:int) : void
      {
         hasField$0 |= 4;
         blueTeamScroe$field = param1;
      }
      
      public function get blueTeamScroe() : int
      {
         return blueTeamScroe$field;
      }
      
      public function removeMyScroe() : void
      {
         hasField$0 &= 4294967287;
         myScroe$field = new int();
      }
      
      public function get hasMyScroe() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set myScroe(param1:int) : void
      {
         hasField$0 |= 8;
         myScroe$field = param1;
      }
      
      public function get myScroe() : int
      {
         return myScroe$field;
      }
      
      public function removeRemainsTiem() : void
      {
         hasField$0 &= 4294967279;
         remainsTiem$field = new int();
      }
      
      public function get hasRemainsTiem() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set remainsTiem(param1:int) : void
      {
         hasField$0 |= 16;
         remainsTiem$field = param1;
      }
      
      public function get remainsTiem() : int
      {
         return remainsTiem$field;
      }
      
      public function removeWinner() : void
      {
         hasField$0 &= 4294967263;
         winner$field = new int();
      }
      
      public function get hasWinner() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set winner(param1:int) : void
      {
         hasField$0 |= 32;
         winner$field = param1;
      }
      
      public function get winner() : int
      {
         return winner$field;
      }
      
      public function removeMyOrder() : void
      {
         hasField$0 &= 4294967231;
         my_order$field = new int();
      }
      
      public function get hasMyOrder() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set myOrder(param1:int) : void
      {
         hasField$0 |= 64;
         my_order$field = param1;
      }
      
      public function get myOrder() : int
      {
         return my_order$field;
      }
      
      public function removeMyUserid() : void
      {
         hasField$0 &= 4294967167;
         my_userid$field = new int();
      }
      
      public function get hasMyUserid() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set myUserid(param1:int) : void
      {
         hasField$0 |= 128;
         my_userid$field = param1;
      }
      
      public function get myUserid() : int
      {
         return my_userid$field;
      }
      
      public function removeHasReward() : void
      {
         hasField$0 &= 4294967039;
         has_reward$field = new Boolean();
      }
      
      public function get hasHasReward() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set hasReward(param1:Boolean) : void
      {
         hasField$0 |= 256;
         has_reward$field = param1;
      }
      
      public function get hasReward() : Boolean
      {
         return has_reward$field;
      }
      
      public function removeMyKillCount() : void
      {
         hasField$0 &= 4294966783;
         my_kill_count$field = new int();
      }
      
      public function get hasMyKillCount() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set myKillCount(param1:int) : void
      {
         hasField$0 |= 512;
         my_kill_count$field = param1;
      }
      
      public function get myKillCount() : int
      {
         return my_kill_count$field;
      }
      
      public function removeCampaignStartTime() : void
      {
         campaignStartTime$field = null;
      }
      
      public function get hasCampaignStartTime() : Boolean
      {
         return campaignStartTime$field != null;
      }
      
      public function set campaignStartTime(param1:String) : void
      {
         campaignStartTime$field = param1;
      }
      
      public function get campaignStartTime() : String
      {
         return campaignStartTime$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasCampaignName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,campaignName$field);
         }
         if(hasRedTeamScroe)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,redTeamScroe$field);
         }
         if(hasBlueTeamScroe)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,blueTeamScroe$field);
         }
         if(hasMyScroe)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,myScroe$field);
         }
         if(hasRemainsTiem)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,remainsTiem$field);
         }
         if(hasWinner)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,winner$field);
         }
         _loc2_ = 0;
         while(_loc2_ < scroeList.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,scroeList[_loc2_]);
            _loc2_++;
         }
         if(hasMyOrder)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,my_order$field);
         }
         if(hasMyUserid)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,my_userid$field);
         }
         if(hasHasReward)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,has_reward$field);
         }
         if(hasMyKillCount)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,my_kill_count$field);
         }
         if(hasCampaignStartTime)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,campaignStartTime$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc4_:VehicleScroeListMsg = null;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc15_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.campaignId cannot be set twice.");
                  }
                  _loc12_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.campaignName cannot be set twice.");
                  }
                  _loc9_++;
                  campaignName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.redTeamScroe cannot be set twice.");
                  }
                  _loc7_++;
                  redTeamScroe = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.blueTeamScroe cannot be set twice.");
                  }
                  _loc5_++;
                  blueTeamScroe = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.myScroe cannot be set twice.");
                  }
                  _loc6_++;
                  myScroe = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.remainsTiem cannot be set twice.");
                  }
                  _loc15_++;
                  remainsTiem = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.winner cannot be set twice.");
                  }
                  _loc3_++;
                  winner = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc4_ = new VehicleScroeListMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  scroeList.push(_loc4_);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.myOrder cannot be set twice.");
                  }
                  _loc14_++;
                  myOrder = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.myUserid cannot be set twice.");
                  }
                  _loc8_++;
                  myUserid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.hasReward cannot be set twice.");
                  }
                  _loc10_++;
                  hasReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.myKillCount cannot be set twice.");
                  }
                  _loc13_++;
                  myKillCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: VehicleCampaignDetailMsg.campaignStartTime cannot be set twice.");
                  }
                  _loc11_++;
                  campaignStartTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

