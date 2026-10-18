package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarLogMsg extends Message implements IExternalizable
   {
      
      private var win_team_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var red_user_ids$field:String;
      
      private var blue_user_ids$field:String;
      
      private var blue_socre$field:int;
      
      private var red_score$field:int;
      
      private var blue_size$field:int;
      
      private var red_size$field:int;
      
      private var campaign_id$field:int;
      
      private var start_millis$field:Int64;
      
      public function WarLogMsg()
      {
         super();
      }
      
      public function removeWinTeamId() : void
      {
         hasField$0 &= 4294967294;
         win_team_id$field = new int();
      }
      
      public function get hasWinTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set winTeamId(param1:int) : void
      {
         hasField$0 |= 1;
         win_team_id$field = param1;
      }
      
      public function get winTeamId() : int
      {
         return win_team_id$field;
      }
      
      public function removeRedUserIds() : void
      {
         red_user_ids$field = null;
      }
      
      public function get hasRedUserIds() : Boolean
      {
         return red_user_ids$field != null;
      }
      
      public function set redUserIds(param1:String) : void
      {
         red_user_ids$field = param1;
      }
      
      public function get redUserIds() : String
      {
         return red_user_ids$field;
      }
      
      public function removeBlueUserIds() : void
      {
         blue_user_ids$field = null;
      }
      
      public function get hasBlueUserIds() : Boolean
      {
         return blue_user_ids$field != null;
      }
      
      public function set blueUserIds(param1:String) : void
      {
         blue_user_ids$field = param1;
      }
      
      public function get blueUserIds() : String
      {
         return blue_user_ids$field;
      }
      
      public function removeBlueSocre() : void
      {
         hasField$0 &= 4294967293;
         blue_socre$field = new int();
      }
      
      public function get hasBlueSocre() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set blueSocre(param1:int) : void
      {
         hasField$0 |= 2;
         blue_socre$field = param1;
      }
      
      public function get blueSocre() : int
      {
         return blue_socre$field;
      }
      
      public function removeRedScore() : void
      {
         hasField$0 &= 4294967291;
         red_score$field = new int();
      }
      
      public function get hasRedScore() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set redScore(param1:int) : void
      {
         hasField$0 |= 4;
         red_score$field = param1;
      }
      
      public function get redScore() : int
      {
         return red_score$field;
      }
      
      public function removeBlueSize() : void
      {
         hasField$0 &= 4294967287;
         blue_size$field = new int();
      }
      
      public function get hasBlueSize() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set blueSize(param1:int) : void
      {
         hasField$0 |= 8;
         blue_size$field = param1;
      }
      
      public function get blueSize() : int
      {
         return blue_size$field;
      }
      
      public function removeRedSize() : void
      {
         hasField$0 &= 4294967279;
         red_size$field = new int();
      }
      
      public function get hasRedSize() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set redSize(param1:int) : void
      {
         hasField$0 |= 16;
         red_size$field = param1;
      }
      
      public function get redSize() : int
      {
         return red_size$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967263;
         campaign_id$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 32;
         campaign_id$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaign_id$field;
      }
      
      public function removeStartMillis() : void
      {
         start_millis$field = null;
      }
      
      public function get hasStartMillis() : Boolean
      {
         return start_millis$field != null;
      }
      
      public function set startMillis(param1:Int64) : void
      {
         start_millis$field = param1;
      }
      
      public function get startMillis() : Int64
      {
         return start_millis$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasWinTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,win_team_id$field);
         }
         if(hasRedUserIds)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,red_user_ids$field);
         }
         if(hasBlueUserIds)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,blue_user_ids$field);
         }
         if(hasBlueSocre)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,blue_socre$field);
         }
         if(hasRedScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,red_score$field);
         }
         if(hasBlueSize)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,blue_size$field);
         }
         if(hasRedSize)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,red_size$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,campaign_id$field);
         }
         if(hasStartMillis)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,start_millis$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.winTeamId cannot be set twice.");
                  }
                  _loc5_++;
                  winTeamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.redUserIds cannot be set twice.");
                  }
                  _loc10_++;
                  redUserIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.blueUserIds cannot be set twice.");
                  }
                  _loc6_++;
                  blueUserIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.blueSocre cannot be set twice.");
                  }
                  _loc12_++;
                  blueSocre = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.redScore cannot be set twice.");
                  }
                  _loc11_++;
                  redScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.blueSize cannot be set twice.");
                  }
                  _loc3_++;
                  blueSize = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.redSize cannot be set twice.");
                  }
                  _loc7_++;
                  redSize = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.campaignId cannot be set twice.");
                  }
                  _loc4_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: WarLogMsg.startMillis cannot be set twice.");
                  }
                  _loc9_++;
                  startMillis = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
      }
   }
}

