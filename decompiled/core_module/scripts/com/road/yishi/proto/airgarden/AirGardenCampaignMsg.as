package com.road.yishi.proto.airgarden
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AirGardenCampaignMsg extends Message implements IExternalizable
   {
      
      private var masterUserId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var isParty$field:Boolean;
      
      private var upCount$field:int;
      
      [ArrayElementType("int")]
      public var gameRemainList:Array = [];
      
      private var totalScore$field:int;
      
      private var nickName$field:String;
      
      private var intro$field:String;
      
      private var headId$field:int;
      
      private var fightCapacity$field:int;
      
      private var hotCount$field:int;
      
      public function AirGardenCampaignMsg()
      {
         super();
      }
      
      public function removeMasterUserId() : void
      {
         hasField$0 &= 4294967294;
         masterUserId$field = new int();
      }
      
      public function get hasMasterUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set masterUserId(param1:int) : void
      {
         hasField$0 |= 1;
         masterUserId$field = param1;
      }
      
      public function get masterUserId() : int
      {
         return masterUserId$field;
      }
      
      public function removeIsParty() : void
      {
         hasField$0 &= 4294967293;
         isParty$field = new Boolean();
      }
      
      public function get hasIsParty() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set isParty(param1:Boolean) : void
      {
         hasField$0 |= 2;
         isParty$field = param1;
      }
      
      public function get isParty() : Boolean
      {
         return isParty$field;
      }
      
      public function removeUpCount() : void
      {
         hasField$0 &= 4294967291;
         upCount$field = new int();
      }
      
      public function get hasUpCount() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set upCount(param1:int) : void
      {
         hasField$0 |= 4;
         upCount$field = param1;
      }
      
      public function get upCount() : int
      {
         return upCount$field;
      }
      
      public function removeTotalScore() : void
      {
         hasField$0 &= 4294967287;
         totalScore$field = new int();
      }
      
      public function get hasTotalScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set totalScore(param1:int) : void
      {
         hasField$0 |= 8;
         totalScore$field = param1;
      }
      
      public function get totalScore() : int
      {
         return totalScore$field;
      }
      
      public function removeNickName() : void
      {
         nickName$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nickName$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nickName$field = param1;
      }
      
      public function get nickName() : String
      {
         return nickName$field;
      }
      
      public function removeIntro() : void
      {
         intro$field = null;
      }
      
      public function get hasIntro() : Boolean
      {
         return intro$field != null;
      }
      
      public function set intro(param1:String) : void
      {
         intro$field = param1;
      }
      
      public function get intro() : String
      {
         return intro$field;
      }
      
      public function removeHeadId() : void
      {
         hasField$0 &= 4294967279;
         headId$field = new int();
      }
      
      public function get hasHeadId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set headId(param1:int) : void
      {
         hasField$0 |= 16;
         headId$field = param1;
      }
      
      public function get headId() : int
      {
         return headId$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967263;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 32;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      public function removeHotCount() : void
      {
         hasField$0 &= 4294967231;
         hotCount$field = new int();
      }
      
      public function get hasHotCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set hotCount(param1:int) : void
      {
         hasField$0 |= 64;
         hotCount$field = param1;
      }
      
      public function get hotCount() : int
      {
         return hotCount$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasMasterUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,masterUserId$field);
         }
         if(hasIsParty)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,isParty$field);
         }
         if(hasUpCount)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,upCount$field);
         }
         _loc2_ = 0;
         while(_loc2_ < gameRemainList.length)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,gameRemainList[_loc2_]);
            _loc2_++;
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasIntro)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,intro$field);
         }
         if(hasHeadId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,headId$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
         if(hasHotCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,hotCount$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.masterUserId cannot be set twice.");
                  }
                  _loc12_++;
                  masterUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.isParty cannot be set twice.");
                  }
                  _loc7_++;
                  isParty = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.upCount cannot be set twice.");
                  }
                  _loc4_++;
                  upCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if((_loc10_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,gameRemainList);
                  }
                  else
                  {
                     gameRemainList.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.totalScore cannot be set twice.");
                  }
                  _loc6_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.nickName cannot be set twice.");
                  }
                  _loc5_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.intro cannot be set twice.");
                  }
                  _loc9_++;
                  intro = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.headId cannot be set twice.");
                  }
                  _loc8_++;
                  headId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.fightCapacity cannot be set twice.");
                  }
                  _loc11_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AirGardenCampaignMsg.hotCount cannot be set twice.");
                  }
                  _loc3_++;
                  hotCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

