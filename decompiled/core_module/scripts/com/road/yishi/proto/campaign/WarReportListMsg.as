package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class WarReportListMsg extends Message implements IExternalizable
   {
      
      private var one_teamId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var two_teamId$field:int;
      
      private var thd_temaId$field:int;
      
      private var temp_id$field:int;
      
      private var own_count$field:int;
      
      private var team_count$field:int;
      
      private var one_score$field:int;
      
      private var two_score$field:int;
      
      private var thd_score$field:int;
      
      [ArrayElementType("com.road.yishi.proto.campaign.WarReportMsg")]
      public var info:Array = [];
      
      public function WarReportListMsg()
      {
         super();
      }
      
      public function removeOneTeamId() : void
      {
         hasField$0 &= 4294967294;
         one_teamId$field = new int();
      }
      
      public function get hasOneTeamId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set oneTeamId(param1:int) : void
      {
         hasField$0 |= 1;
         one_teamId$field = param1;
      }
      
      public function get oneTeamId() : int
      {
         return one_teamId$field;
      }
      
      public function removeTwoTeamId() : void
      {
         hasField$0 &= 4294967293;
         two_teamId$field = new int();
      }
      
      public function get hasTwoTeamId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set twoTeamId(param1:int) : void
      {
         hasField$0 |= 2;
         two_teamId$field = param1;
      }
      
      public function get twoTeamId() : int
      {
         return two_teamId$field;
      }
      
      public function removeThdTemaId() : void
      {
         hasField$0 &= 4294967291;
         thd_temaId$field = new int();
      }
      
      public function get hasThdTemaId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set thdTemaId(param1:int) : void
      {
         hasField$0 |= 4;
         thd_temaId$field = param1;
      }
      
      public function get thdTemaId() : int
      {
         return thd_temaId$field;
      }
      
      public function removeTempId() : void
      {
         hasField$0 &= 4294967287;
         temp_id$field = new int();
      }
      
      public function get hasTempId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set tempId(param1:int) : void
      {
         hasField$0 |= 8;
         temp_id$field = param1;
      }
      
      public function get tempId() : int
      {
         return temp_id$field;
      }
      
      public function removeOwnCount() : void
      {
         hasField$0 &= 4294967279;
         own_count$field = new int();
      }
      
      public function get hasOwnCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set ownCount(param1:int) : void
      {
         hasField$0 |= 16;
         own_count$field = param1;
      }
      
      public function get ownCount() : int
      {
         return own_count$field;
      }
      
      public function removeTeamCount() : void
      {
         hasField$0 &= 4294967263;
         team_count$field = new int();
      }
      
      public function get hasTeamCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set teamCount(param1:int) : void
      {
         hasField$0 |= 32;
         team_count$field = param1;
      }
      
      public function get teamCount() : int
      {
         return team_count$field;
      }
      
      public function removeOneScore() : void
      {
         hasField$0 &= 4294967231;
         one_score$field = new int();
      }
      
      public function get hasOneScore() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set oneScore(param1:int) : void
      {
         hasField$0 |= 64;
         one_score$field = param1;
      }
      
      public function get oneScore() : int
      {
         return one_score$field;
      }
      
      public function removeTwoScore() : void
      {
         hasField$0 &= 4294967167;
         two_score$field = new int();
      }
      
      public function get hasTwoScore() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set twoScore(param1:int) : void
      {
         hasField$0 |= 128;
         two_score$field = param1;
      }
      
      public function get twoScore() : int
      {
         return two_score$field;
      }
      
      public function removeThdScore() : void
      {
         hasField$0 &= 4294967039;
         thd_score$field = new int();
      }
      
      public function get hasThdScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set thdScore(param1:int) : void
      {
         hasField$0 |= 256;
         thd_score$field = param1;
      }
      
      public function get thdScore() : int
      {
         return thd_score$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOneTeamId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,one_teamId$field);
         }
         if(hasTwoTeamId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,two_teamId$field);
         }
         if(hasThdTemaId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,thd_temaId$field);
         }
         if(hasTempId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,temp_id$field);
         }
         if(hasOwnCount)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,own_count$field);
         }
         if(hasTeamCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,team_count$field);
         }
         if(hasOneScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,one_score$field);
         }
         if(hasTwoScore)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,two_score$field);
         }
         if(hasThdScore)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,thd_score$field);
         }
         _loc2_ = 0;
         while(_loc2_ < info.length)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_MESSAGE(param1,info[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc9_:WarReportMsg = null;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.oneTeamId cannot be set twice.");
                  }
                  _loc6_++;
                  oneTeamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.twoTeamId cannot be set twice.");
                  }
                  _loc10_++;
                  twoTeamId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.thdTemaId cannot be set twice.");
                  }
                  _loc13_++;
                  thdTemaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.tempId cannot be set twice.");
                  }
                  _loc5_++;
                  tempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.ownCount cannot be set twice.");
                  }
                  _loc7_++;
                  ownCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.teamCount cannot be set twice.");
                  }
                  _loc11_++;
                  teamCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.oneScore cannot be set twice.");
                  }
                  _loc3_++;
                  oneScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.twoScore cannot be set twice.");
                  }
                  _loc4_++;
                  twoScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: WarReportListMsg.thdScore cannot be set twice.");
                  }
                  _loc8_++;
                  thdScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  _loc9_ = new WarReportMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc9_);
                  info.push(_loc9_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

