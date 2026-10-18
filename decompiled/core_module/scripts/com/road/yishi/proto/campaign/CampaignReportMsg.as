package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignReportMsg extends Message implements IExternalizable
   {
      
      private var failed_count$field:int;
      
      private var hasField$0:uint = 0;
      
      private var failed_appraisal$field:int;
      
      private var endBossTime$field:int;
      
      private var endBossAppraisal$field:int;
      
      private var total_appraisal$field:int;
      
      private var batter$field:int;
      
      private var teamJoin$field:int;
      
      private var friendJoin$field:int;
      
      private var vipJoin$field:int;
      
      private var propJoin$field:int;
      
      private var otherJoin$field:int;
      
      private var total_gp$field:int;
      
      private var pet_gp$field:int;
      
      public function CampaignReportMsg()
      {
         super();
      }
      
      public function removeFailedCount() : void
      {
         hasField$0 &= 4294967294;
         failed_count$field = new int();
      }
      
      public function get hasFailedCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set failedCount(param1:int) : void
      {
         hasField$0 |= 1;
         failed_count$field = param1;
      }
      
      public function get failedCount() : int
      {
         return failed_count$field;
      }
      
      public function removeFailedAppraisal() : void
      {
         hasField$0 &= 4294967293;
         failed_appraisal$field = new int();
      }
      
      public function get hasFailedAppraisal() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set failedAppraisal(param1:int) : void
      {
         hasField$0 |= 2;
         failed_appraisal$field = param1;
      }
      
      public function get failedAppraisal() : int
      {
         return failed_appraisal$field;
      }
      
      public function removeEndBossTime() : void
      {
         hasField$0 &= 4294967291;
         endBossTime$field = new int();
      }
      
      public function get hasEndBossTime() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set endBossTime(param1:int) : void
      {
         hasField$0 |= 4;
         endBossTime$field = param1;
      }
      
      public function get endBossTime() : int
      {
         return endBossTime$field;
      }
      
      public function removeEndBossAppraisal() : void
      {
         hasField$0 &= 4294967287;
         endBossAppraisal$field = new int();
      }
      
      public function get hasEndBossAppraisal() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set endBossAppraisal(param1:int) : void
      {
         hasField$0 |= 8;
         endBossAppraisal$field = param1;
      }
      
      public function get endBossAppraisal() : int
      {
         return endBossAppraisal$field;
      }
      
      public function removeTotalAppraisal() : void
      {
         hasField$0 &= 4294967279;
         total_appraisal$field = new int();
      }
      
      public function get hasTotalAppraisal() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set totalAppraisal(param1:int) : void
      {
         hasField$0 |= 16;
         total_appraisal$field = param1;
      }
      
      public function get totalAppraisal() : int
      {
         return total_appraisal$field;
      }
      
      public function removeBatter() : void
      {
         hasField$0 &= 4294967263;
         batter$field = new int();
      }
      
      public function get hasBatter() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set batter(param1:int) : void
      {
         hasField$0 |= 32;
         batter$field = param1;
      }
      
      public function get batter() : int
      {
         return batter$field;
      }
      
      public function removeTeamJoin() : void
      {
         hasField$0 &= 4294967231;
         teamJoin$field = new int();
      }
      
      public function get hasTeamJoin() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set teamJoin(param1:int) : void
      {
         hasField$0 |= 64;
         teamJoin$field = param1;
      }
      
      public function get teamJoin() : int
      {
         return teamJoin$field;
      }
      
      public function removeFriendJoin() : void
      {
         hasField$0 &= 4294967167;
         friendJoin$field = new int();
      }
      
      public function get hasFriendJoin() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set friendJoin(param1:int) : void
      {
         hasField$0 |= 128;
         friendJoin$field = param1;
      }
      
      public function get friendJoin() : int
      {
         return friendJoin$field;
      }
      
      public function removeVipJoin() : void
      {
         hasField$0 &= 4294967039;
         vipJoin$field = new int();
      }
      
      public function get hasVipJoin() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set vipJoin(param1:int) : void
      {
         hasField$0 |= 256;
         vipJoin$field = param1;
      }
      
      public function get vipJoin() : int
      {
         return vipJoin$field;
      }
      
      public function removePropJoin() : void
      {
         hasField$0 &= 4294966783;
         propJoin$field = new int();
      }
      
      public function get hasPropJoin() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set propJoin(param1:int) : void
      {
         hasField$0 |= 512;
         propJoin$field = param1;
      }
      
      public function get propJoin() : int
      {
         return propJoin$field;
      }
      
      public function removeOtherJoin() : void
      {
         hasField$0 &= 4294966271;
         otherJoin$field = new int();
      }
      
      public function get hasOtherJoin() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set otherJoin(param1:int) : void
      {
         hasField$0 |= 1024;
         otherJoin$field = param1;
      }
      
      public function get otherJoin() : int
      {
         return otherJoin$field;
      }
      
      public function removeTotalGp() : void
      {
         hasField$0 &= 4294965247;
         total_gp$field = new int();
      }
      
      public function get hasTotalGp() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set totalGp(param1:int) : void
      {
         hasField$0 |= 2048;
         total_gp$field = param1;
      }
      
      public function get totalGp() : int
      {
         return total_gp$field;
      }
      
      public function removePetGp() : void
      {
         hasField$0 &= 4294963199;
         pet_gp$field = new int();
      }
      
      public function get hasPetGp() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set petGp(param1:int) : void
      {
         hasField$0 |= 4096;
         pet_gp$field = param1;
      }
      
      public function get petGp() : int
      {
         return pet_gp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasFailedCount)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,failed_count$field);
         }
         if(hasFailedAppraisal)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,failed_appraisal$field);
         }
         if(hasEndBossTime)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,endBossTime$field);
         }
         if(hasEndBossAppraisal)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,endBossAppraisal$field);
         }
         if(hasTotalAppraisal)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,total_appraisal$field);
         }
         if(hasBatter)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,batter$field);
         }
         if(hasTeamJoin)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,teamJoin$field);
         }
         if(hasFriendJoin)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,friendJoin$field);
         }
         if(hasVipJoin)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,vipJoin$field);
         }
         if(hasPropJoin)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,propJoin$field);
         }
         if(hasOtherJoin)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,otherJoin$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,total_gp$field);
         }
         if(hasPetGp)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,pet_gp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc6_:uint = 0;
         var _loc16_:uint = 0;
         var _loc4_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.failedCount cannot be set twice.");
                  }
                  _loc6_++;
                  failedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.failedAppraisal cannot be set twice.");
                  }
                  _loc16_++;
                  failedAppraisal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.endBossTime cannot be set twice.");
                  }
                  _loc4_++;
                  endBossTime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.endBossAppraisal cannot be set twice.");
                  }
                  _loc11_++;
                  endBossAppraisal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.totalAppraisal cannot be set twice.");
                  }
                  _loc14_++;
                  totalAppraisal = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.batter cannot be set twice.");
                  }
                  _loc8_++;
                  batter = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.teamJoin cannot be set twice.");
                  }
                  _loc9_++;
                  teamJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.friendJoin cannot be set twice.");
                  }
                  _loc15_++;
                  friendJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.vipJoin cannot be set twice.");
                  }
                  _loc5_++;
                  vipJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.propJoin cannot be set twice.");
                  }
                  _loc3_++;
                  propJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.otherJoin cannot be set twice.");
                  }
                  _loc10_++;
                  otherJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.totalGp cannot be set twice.");
                  }
                  _loc7_++;
                  totalGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignReportMsg.petGp cannot be set twice.");
                  }
                  _loc13_++;
                  petGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

