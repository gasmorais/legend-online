package com.road.yishi.proto.farm
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FarmInfoRspMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var grades$field:int;
      
      private var land_grades$field:int;
      
      private var gp$field:int;
      
      private var total_gp$field:int;
      
      private var today_from_friend_gp$field:int;
      
      [ArrayElementType("com.road.yishi.proto.farm.FarmLandInfoMsg")]
      public var farmLandInfo:Array = [];
      
      private var tree_info$field:TreeInfoMsg;
      
      private var today_stolen_count$field:int;
      
      private var today_feed_count$field:int;
      
      private var today_help_reap_livestock$field:int;
      
      [ArrayElementType("com.road.yishi.proto.farm.FarmPetInfoMsg")]
      public var petInfo:Array = [];
      
      private var guard_pet_info$field:FarmPetInfoMsg;
      
      private var marriage_tree$field:MarriageTreeMsg;
      
      public function FarmInfoRspMsg()
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
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
      }
      
      public function removeGrades() : void
      {
         hasField$0 &= 4294967293;
         grades$field = new int();
      }
      
      public function get hasGrades() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set grades(param1:int) : void
      {
         hasField$0 |= 2;
         grades$field = param1;
      }
      
      public function get grades() : int
      {
         return grades$field;
      }
      
      public function removeLandGrades() : void
      {
         hasField$0 &= 4294967291;
         land_grades$field = new int();
      }
      
      public function get hasLandGrades() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set landGrades(param1:int) : void
      {
         hasField$0 |= 4;
         land_grades$field = param1;
      }
      
      public function get landGrades() : int
      {
         return land_grades$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967287;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 8;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      public function removeTotalGp() : void
      {
         hasField$0 &= 4294967279;
         total_gp$field = new int();
      }
      
      public function get hasTotalGp() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set totalGp(param1:int) : void
      {
         hasField$0 |= 16;
         total_gp$field = param1;
      }
      
      public function get totalGp() : int
      {
         return total_gp$field;
      }
      
      public function removeTodayFromFriendGp() : void
      {
         hasField$0 &= 4294967263;
         today_from_friend_gp$field = new int();
      }
      
      public function get hasTodayFromFriendGp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set todayFromFriendGp(param1:int) : void
      {
         hasField$0 |= 32;
         today_from_friend_gp$field = param1;
      }
      
      public function get todayFromFriendGp() : int
      {
         return today_from_friend_gp$field;
      }
      
      public function removeTreeInfo() : void
      {
         tree_info$field = null;
      }
      
      public function get hasTreeInfo() : Boolean
      {
         return tree_info$field != null;
      }
      
      public function set treeInfo(param1:TreeInfoMsg) : void
      {
         tree_info$field = param1;
      }
      
      public function get treeInfo() : TreeInfoMsg
      {
         return tree_info$field;
      }
      
      public function removeTodayStolenCount() : void
      {
         hasField$0 &= 4294967231;
         today_stolen_count$field = new int();
      }
      
      public function get hasTodayStolenCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set todayStolenCount(param1:int) : void
      {
         hasField$0 |= 64;
         today_stolen_count$field = param1;
      }
      
      public function get todayStolenCount() : int
      {
         return today_stolen_count$field;
      }
      
      public function removeTodayFeedCount() : void
      {
         hasField$0 &= 4294967167;
         today_feed_count$field = new int();
      }
      
      public function get hasTodayFeedCount() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set todayFeedCount(param1:int) : void
      {
         hasField$0 |= 128;
         today_feed_count$field = param1;
      }
      
      public function get todayFeedCount() : int
      {
         return today_feed_count$field;
      }
      
      public function removeTodayHelpReapLivestock() : void
      {
         hasField$0 &= 4294967039;
         today_help_reap_livestock$field = new int();
      }
      
      public function get hasTodayHelpReapLivestock() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set todayHelpReapLivestock(param1:int) : void
      {
         hasField$0 |= 256;
         today_help_reap_livestock$field = param1;
      }
      
      public function get todayHelpReapLivestock() : int
      {
         return today_help_reap_livestock$field;
      }
      
      public function removeGuardPetInfo() : void
      {
         guard_pet_info$field = null;
      }
      
      public function get hasGuardPetInfo() : Boolean
      {
         return guard_pet_info$field != null;
      }
      
      public function set guardPetInfo(param1:FarmPetInfoMsg) : void
      {
         guard_pet_info$field = param1;
      }
      
      public function get guardPetInfo() : FarmPetInfoMsg
      {
         return guard_pet_info$field;
      }
      
      public function removeMarriageTree() : void
      {
         marriage_tree$field = null;
      }
      
      public function get hasMarriageTree() : Boolean
      {
         return marriage_tree$field != null;
      }
      
      public function set marriageTree(param1:MarriageTreeMsg) : void
      {
         marriage_tree$field = param1;
      }
      
      public function get marriageTree() : MarriageTreeMsg
      {
         return marriage_tree$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
         }
         if(hasGrades)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,grades$field);
         }
         if(hasLandGrades)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,land_grades$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
         if(hasTotalGp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,total_gp$field);
         }
         if(hasTodayFromFriendGp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,today_from_friend_gp$field);
         }
         _loc2_ = 0;
         while(_loc2_ < farmLandInfo.length)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_MESSAGE(param1,farmLandInfo[_loc2_]);
            _loc2_++;
         }
         if(hasTreeInfo)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_MESSAGE(param1,tree_info$field);
         }
         if(hasTodayStolenCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,today_stolen_count$field);
         }
         if(hasTodayFeedCount)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,today_feed_count$field);
         }
         if(hasTodayHelpReapLivestock)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,today_help_reap_livestock$field);
         }
         _loc3_ = 0;
         while(_loc3_ < petInfo.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,petInfo[_loc3_]);
            _loc3_++;
         }
         if(hasGuardPetInfo)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,guard_pet_info$field);
         }
         if(hasMarriageTree)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_MESSAGE(param1,marriage_tree$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc7_:FarmLandInfoMsg = null;
         var _loc11_:FarmPetInfoMsg = null;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc18_:uint = 0;
         var _loc8_:uint = 0;
         var _loc14_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc17_:uint = 0;
         var _loc16_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.nickName cannot be set twice.");
                  }
                  _loc3_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.grades cannot be set twice.");
                  }
                  _loc18_++;
                  grades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.landGrades cannot be set twice.");
                  }
                  _loc8_++;
                  landGrades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.gp cannot be set twice.");
                  }
                  _loc14_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.totalGp cannot be set twice.");
                  }
                  _loc9_++;
                  totalGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.todayFromFriendGp cannot be set twice.");
                  }
                  _loc15_++;
                  todayFromFriendGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  _loc7_ = new FarmLandInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  farmLandInfo.push(_loc7_);
                  break;
               case 8:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.treeInfo cannot be set twice.");
                  }
                  _loc4_++;
                  treeInfo = new TreeInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,treeInfo);
                  break;
               case 9:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.todayStolenCount cannot be set twice.");
                  }
                  _loc6_++;
                  todayStolenCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.todayFeedCount cannot be set twice.");
                  }
                  _loc5_++;
                  todayFeedCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.todayHelpReapLivestock cannot be set twice.");
                  }
                  _loc12_++;
                  todayHelpReapLivestock = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  _loc11_ = new FarmPetInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  petInfo.push(_loc11_);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.guardPetInfo cannot be set twice.");
                  }
                  _loc17_++;
                  guardPetInfo = new FarmPetInfoMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,guardPetInfo);
                  break;
               case 14:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: FarmInfoRspMsg.marriageTree cannot be set twice.");
                  }
                  _loc16_++;
                  marriageTree = new MarriageTreeMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,marriageTree);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

