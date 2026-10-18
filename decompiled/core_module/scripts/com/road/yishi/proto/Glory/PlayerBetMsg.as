package com.road.yishi.proto.Glory
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerBetMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var round$field:int;
      
      private var teamUid1$field:String;
      
      private var teamScore1$field:int;
      
      private var teamUid2$field:String;
      
      private var teamScore2$field:int;
      
      private var betTiem$field:Int64;
      
      public function PlayerBetMsg()
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
      
      public function removeRound() : void
      {
         hasField$0 &= 4294967293;
         round$field = new int();
      }
      
      public function get hasRound() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set round(param1:int) : void
      {
         hasField$0 |= 2;
         round$field = param1;
      }
      
      public function get round() : int
      {
         return round$field;
      }
      
      public function removeTeamUid1() : void
      {
         teamUid1$field = null;
      }
      
      public function get hasTeamUid1() : Boolean
      {
         return teamUid1$field != null;
      }
      
      public function set teamUid1(param1:String) : void
      {
         teamUid1$field = param1;
      }
      
      public function get teamUid1() : String
      {
         return teamUid1$field;
      }
      
      public function removeTeamScore1() : void
      {
         hasField$0 &= 4294967291;
         teamScore1$field = new int();
      }
      
      public function get hasTeamScore1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set teamScore1(param1:int) : void
      {
         hasField$0 |= 4;
         teamScore1$field = param1;
      }
      
      public function get teamScore1() : int
      {
         return teamScore1$field;
      }
      
      public function removeTeamUid2() : void
      {
         teamUid2$field = null;
      }
      
      public function get hasTeamUid2() : Boolean
      {
         return teamUid2$field != null;
      }
      
      public function set teamUid2(param1:String) : void
      {
         teamUid2$field = param1;
      }
      
      public function get teamUid2() : String
      {
         return teamUid2$field;
      }
      
      public function removeTeamScore2() : void
      {
         hasField$0 &= 4294967287;
         teamScore2$field = new int();
      }
      
      public function get hasTeamScore2() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set teamScore2(param1:int) : void
      {
         hasField$0 |= 8;
         teamScore2$field = param1;
      }
      
      public function get teamScore2() : int
      {
         return teamScore2$field;
      }
      
      public function removeBetTiem() : void
      {
         betTiem$field = null;
      }
      
      public function get hasBetTiem() : Boolean
      {
         return betTiem$field != null;
      }
      
      public function set betTiem(param1:Int64) : void
      {
         betTiem$field = param1;
      }
      
      public function get betTiem() : Int64
      {
         return betTiem$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasRound)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,round$field);
         }
         if(hasTeamUid1)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,teamUid1$field);
         }
         if(hasTeamScore1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,teamScore1$field);
         }
         if(hasTeamUid2)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,teamUid2$field);
         }
         if(hasTeamScore2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,teamScore2$field);
         }
         if(hasBetTiem)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,betTiem$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.round cannot be set twice.");
                  }
                  _loc5_++;
                  round = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.teamUid1 cannot be set twice.");
                  }
                  _loc8_++;
                  teamUid1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.teamScore1 cannot be set twice.");
                  }
                  _loc3_++;
                  teamScore1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.teamUid2 cannot be set twice.");
                  }
                  _loc10_++;
                  teamUid2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.teamScore2 cannot be set twice.");
                  }
                  _loc4_++;
                  teamScore2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerBetMsg.betTiem cannot be set twice.");
                  }
                  _loc7_++;
                  betTiem = ReadUtils.read$TYPE_INT64(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

