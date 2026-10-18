package com.road.yishi.proto.pvp
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PvpCampaignMsg extends Message implements IExternalizable
   {
      
      private var site1$field:String;
      
      private var teamId1$field:int;
      
      private var hasField$0:uint = 0;
      
      private var liveCount1$field:int;
      
      private var totalCount1$field:int;
      
      private var site2$field:String;
      
      private var teamId2$field:int;
      
      private var liveCount2$field:int;
      
      private var totalCount2$field:int;
      
      public function PvpCampaignMsg()
      {
         super();
      }
      
      public function removeSite1() : void
      {
         site1$field = null;
      }
      
      public function get hasSite1() : Boolean
      {
         return site1$field != null;
      }
      
      public function set site1(param1:String) : void
      {
         site1$field = param1;
      }
      
      public function get site1() : String
      {
         return site1$field;
      }
      
      public function removeTeamId1() : void
      {
         hasField$0 &= 4294967294;
         teamId1$field = new int();
      }
      
      public function get hasTeamId1() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set teamId1(param1:int) : void
      {
         hasField$0 |= 1;
         teamId1$field = param1;
      }
      
      public function get teamId1() : int
      {
         return teamId1$field;
      }
      
      public function removeLiveCount1() : void
      {
         hasField$0 &= 4294967293;
         liveCount1$field = new int();
      }
      
      public function get hasLiveCount1() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set liveCount1(param1:int) : void
      {
         hasField$0 |= 2;
         liveCount1$field = param1;
      }
      
      public function get liveCount1() : int
      {
         return liveCount1$field;
      }
      
      public function removeTotalCount1() : void
      {
         hasField$0 &= 4294967291;
         totalCount1$field = new int();
      }
      
      public function get hasTotalCount1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set totalCount1(param1:int) : void
      {
         hasField$0 |= 4;
         totalCount1$field = param1;
      }
      
      public function get totalCount1() : int
      {
         return totalCount1$field;
      }
      
      public function removeSite2() : void
      {
         site2$field = null;
      }
      
      public function get hasSite2() : Boolean
      {
         return site2$field != null;
      }
      
      public function set site2(param1:String) : void
      {
         site2$field = param1;
      }
      
      public function get site2() : String
      {
         return site2$field;
      }
      
      public function removeTeamId2() : void
      {
         hasField$0 &= 4294967287;
         teamId2$field = new int();
      }
      
      public function get hasTeamId2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set teamId2(param1:int) : void
      {
         hasField$0 |= 8;
         teamId2$field = param1;
      }
      
      public function get teamId2() : int
      {
         return teamId2$field;
      }
      
      public function removeLiveCount2() : void
      {
         hasField$0 &= 4294967279;
         liveCount2$field = new int();
      }
      
      public function get hasLiveCount2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set liveCount2(param1:int) : void
      {
         hasField$0 |= 16;
         liveCount2$field = param1;
      }
      
      public function get liveCount2() : int
      {
         return liveCount2$field;
      }
      
      public function removeTotalCount2() : void
      {
         hasField$0 &= 4294967263;
         totalCount2$field = new int();
      }
      
      public function get hasTotalCount2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set totalCount2(param1:int) : void
      {
         hasField$0 |= 32;
         totalCount2$field = param1;
      }
      
      public function get totalCount2() : int
      {
         return totalCount2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasSite1)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,site1$field);
         }
         if(hasTeamId1)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,teamId1$field);
         }
         if(hasLiveCount1)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,liveCount1$field);
         }
         if(hasTotalCount1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,totalCount1$field);
         }
         if(hasSite2)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,site2$field);
         }
         if(hasTeamId2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,teamId2$field);
         }
         if(hasLiveCount2)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,liveCount2$field);
         }
         if(hasTotalCount2)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,totalCount2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.site1 cannot be set twice.");
                  }
                  _loc11_++;
                  site1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.teamId1 cannot be set twice.");
                  }
                  _loc6_++;
                  teamId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.liveCount1 cannot be set twice.");
                  }
                  _loc9_++;
                  liveCount1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.totalCount1 cannot be set twice.");
                  }
                  _loc4_++;
                  totalCount1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.site2 cannot be set twice.");
                  }
                  _loc5_++;
                  site2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.teamId2 cannot be set twice.");
                  }
                  _loc10_++;
                  teamId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.liveCount2 cannot be set twice.");
                  }
                  _loc3_++;
                  liveCount2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PvpCampaignMsg.totalCount2 cannot be set twice.");
                  }
                  _loc7_++;
                  totalCount2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

