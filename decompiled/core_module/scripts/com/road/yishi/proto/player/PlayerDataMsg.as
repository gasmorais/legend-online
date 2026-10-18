package com.road.yishi.proto.player
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerDataMsg extends Message implements IExternalizable
   {
      
      private var user$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var castle$field:Boolean;
      
      private var army$field:Boolean;
      
      private var quest$field:Boolean;
      
      private var build$field:Boolean;
      
      private var tree$field:Boolean;
      
      private var aas$field:Boolean;
      
      private var smith$field:Boolean;
      
      private var bag$field:Boolean;
      
      private var leed$field:Boolean;
      
      private var star$field:Boolean;
      
      private var friend$field:Boolean;
      
      private var effect$field:Boolean;
      
      private var sys$field:Boolean;
      
      private var offline$field:Boolean;
      
      private var reward$field:Boolean;
      
      private var tower$field:Boolean;
      
      private var shop$field:Boolean;
      
      private var chall_reward$field:Boolean;
      
      private var sns_req$field:Boolean;
      
      private var active$field:Boolean;
      
      private var switches$field:Boolean;
      
      private var sweep$field:Boolean;
      
      private var questionnarie$field:Boolean;
      
      private var king_contract$field:Boolean;
      
      private var rebate_charge$field:Boolean;
      
      private var rebate_consum$field:Boolean;
      
      private var sum_active$field:Boolean;
      
      private var cross_score_reward$field:Boolean;
      
      private var appell$field:Boolean;
      
      private var bottle$field:Boolean;
      
      private var pet_challenge_reward$field:Boolean;
      
      private var powcard_info$field:Boolean;
      
      private var hasField$1:uint = 0;
      
      private var christmas$field:Boolean;
      
      public function PlayerDataMsg()
      {
         super();
      }
      
      public function removeUser() : void
      {
         hasField$0 &= 4294967294;
         user$field = new Boolean();
      }
      
      public function get hasUser() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set user(param1:Boolean) : void
      {
         hasField$0 |= 1;
         user$field = param1;
      }
      
      public function get user() : Boolean
      {
         return user$field;
      }
      
      public function removeCastle() : void
      {
         hasField$0 &= 4294967293;
         castle$field = new Boolean();
      }
      
      public function get hasCastle() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set castle(param1:Boolean) : void
      {
         hasField$0 |= 2;
         castle$field = param1;
      }
      
      public function get castle() : Boolean
      {
         return castle$field;
      }
      
      public function removeArmy() : void
      {
         hasField$0 &= 4294967291;
         army$field = new Boolean();
      }
      
      public function get hasArmy() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set army(param1:Boolean) : void
      {
         hasField$0 |= 4;
         army$field = param1;
      }
      
      public function get army() : Boolean
      {
         return army$field;
      }
      
      public function removeQuest() : void
      {
         hasField$0 &= 4294967287;
         quest$field = new Boolean();
      }
      
      public function get hasQuest() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set quest(param1:Boolean) : void
      {
         hasField$0 |= 8;
         quest$field = param1;
      }
      
      public function get quest() : Boolean
      {
         return quest$field;
      }
      
      public function removeBuild() : void
      {
         hasField$0 &= 4294967279;
         build$field = new Boolean();
      }
      
      public function get hasBuild() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set build(param1:Boolean) : void
      {
         hasField$0 |= 16;
         build$field = param1;
      }
      
      public function get build() : Boolean
      {
         return build$field;
      }
      
      public function removeTree() : void
      {
         hasField$0 &= 4294967263;
         tree$field = new Boolean();
      }
      
      public function get hasTree() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set tree(param1:Boolean) : void
      {
         hasField$0 |= 32;
         tree$field = param1;
      }
      
      public function get tree() : Boolean
      {
         return tree$field;
      }
      
      public function removeAas() : void
      {
         hasField$0 &= 4294967231;
         aas$field = new Boolean();
      }
      
      public function get hasAas() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set aas(param1:Boolean) : void
      {
         hasField$0 |= 64;
         aas$field = param1;
      }
      
      public function get aas() : Boolean
      {
         return aas$field;
      }
      
      public function removeSmith() : void
      {
         hasField$0 &= 4294967167;
         smith$field = new Boolean();
      }
      
      public function get hasSmith() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set smith(param1:Boolean) : void
      {
         hasField$0 |= 128;
         smith$field = param1;
      }
      
      public function get smith() : Boolean
      {
         return smith$field;
      }
      
      public function removeBag() : void
      {
         hasField$0 &= 4294967039;
         bag$field = new Boolean();
      }
      
      public function get hasBag() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set bag(param1:Boolean) : void
      {
         hasField$0 |= 256;
         bag$field = param1;
      }
      
      public function get bag() : Boolean
      {
         return bag$field;
      }
      
      public function removeLeed() : void
      {
         hasField$0 &= 4294966783;
         leed$field = new Boolean();
      }
      
      public function get hasLeed() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set leed(param1:Boolean) : void
      {
         hasField$0 |= 512;
         leed$field = param1;
      }
      
      public function get leed() : Boolean
      {
         return leed$field;
      }
      
      public function removeStar() : void
      {
         hasField$0 &= 4294966271;
         star$field = new Boolean();
      }
      
      public function get hasStar() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set star(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         star$field = param1;
      }
      
      public function get star() : Boolean
      {
         return star$field;
      }
      
      public function removeFriend() : void
      {
         hasField$0 &= 4294965247;
         friend$field = new Boolean();
      }
      
      public function get hasFriend() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set friend(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         friend$field = param1;
      }
      
      public function get friend() : Boolean
      {
         return friend$field;
      }
      
      public function removeEffect() : void
      {
         hasField$0 &= 4294963199;
         effect$field = new Boolean();
      }
      
      public function get hasEffect() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set effect(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         effect$field = param1;
      }
      
      public function get effect() : Boolean
      {
         return effect$field;
      }
      
      public function removeSys() : void
      {
         hasField$0 &= 4294959103;
         sys$field = new Boolean();
      }
      
      public function get hasSys() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set sys(param1:Boolean) : void
      {
         hasField$0 |= 8192;
         sys$field = param1;
      }
      
      public function get sys() : Boolean
      {
         return sys$field;
      }
      
      public function removeOffline() : void
      {
         hasField$0 &= 4294950911;
         offline$field = new Boolean();
      }
      
      public function get hasOffline() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set offline(param1:Boolean) : void
      {
         hasField$0 |= 16384;
         offline$field = param1;
      }
      
      public function get offline() : Boolean
      {
         return offline$field;
      }
      
      public function removeReward() : void
      {
         hasField$0 &= 4294934527;
         reward$field = new Boolean();
      }
      
      public function get hasReward() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set reward(param1:Boolean) : void
      {
         hasField$0 |= 32768;
         reward$field = param1;
      }
      
      public function get reward() : Boolean
      {
         return reward$field;
      }
      
      public function removeTower() : void
      {
         hasField$0 &= 4294901759;
         tower$field = new Boolean();
      }
      
      public function get hasTower() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set tower(param1:Boolean) : void
      {
         hasField$0 |= 65536;
         tower$field = param1;
      }
      
      public function get tower() : Boolean
      {
         return tower$field;
      }
      
      public function removeShop() : void
      {
         hasField$0 &= 4294836223;
         shop$field = new Boolean();
      }
      
      public function get hasShop() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set shop(param1:Boolean) : void
      {
         hasField$0 |= 131072;
         shop$field = param1;
      }
      
      public function get shop() : Boolean
      {
         return shop$field;
      }
      
      public function removeChallReward() : void
      {
         hasField$0 &= 4294705151;
         chall_reward$field = new Boolean();
      }
      
      public function get hasChallReward() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set challReward(param1:Boolean) : void
      {
         hasField$0 |= 262144;
         chall_reward$field = param1;
      }
      
      public function get challReward() : Boolean
      {
         return chall_reward$field;
      }
      
      public function removeSnsReq() : void
      {
         hasField$0 &= 4294443007;
         sns_req$field = new Boolean();
      }
      
      public function get hasSnsReq() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set snsReq(param1:Boolean) : void
      {
         hasField$0 |= 524288;
         sns_req$field = param1;
      }
      
      public function get snsReq() : Boolean
      {
         return sns_req$field;
      }
      
      public function removeActive() : void
      {
         hasField$0 &= 4293918719;
         active$field = new Boolean();
      }
      
      public function get hasActive() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set active(param1:Boolean) : void
      {
         hasField$0 |= 1048576;
         active$field = param1;
      }
      
      public function get active() : Boolean
      {
         return active$field;
      }
      
      public function removeSwitches() : void
      {
         hasField$0 &= 4292870143;
         switches$field = new Boolean();
      }
      
      public function get hasSwitches() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set switches(param1:Boolean) : void
      {
         hasField$0 |= 2097152;
         switches$field = param1;
      }
      
      public function get switches() : Boolean
      {
         return switches$field;
      }
      
      public function removeSweep() : void
      {
         hasField$0 &= 4290772991;
         sweep$field = new Boolean();
      }
      
      public function get hasSweep() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set sweep(param1:Boolean) : void
      {
         hasField$0 |= 4194304;
         sweep$field = param1;
      }
      
      public function get sweep() : Boolean
      {
         return sweep$field;
      }
      
      public function removeQuestionnarie() : void
      {
         hasField$0 &= 4286578687;
         questionnarie$field = new Boolean();
      }
      
      public function get hasQuestionnarie() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set questionnarie(param1:Boolean) : void
      {
         hasField$0 |= 8388608;
         questionnarie$field = param1;
      }
      
      public function get questionnarie() : Boolean
      {
         return questionnarie$field;
      }
      
      public function removeKingContract() : void
      {
         hasField$0 &= 4278190079;
         king_contract$field = new Boolean();
      }
      
      public function get hasKingContract() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set kingContract(param1:Boolean) : void
      {
         hasField$0 |= 16777216;
         king_contract$field = param1;
      }
      
      public function get kingContract() : Boolean
      {
         return king_contract$field;
      }
      
      public function removeRebateCharge() : void
      {
         hasField$0 &= 4261412863;
         rebate_charge$field = new Boolean();
      }
      
      public function get hasRebateCharge() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set rebateCharge(param1:Boolean) : void
      {
         hasField$0 |= 33554432;
         rebate_charge$field = param1;
      }
      
      public function get rebateCharge() : Boolean
      {
         return rebate_charge$field;
      }
      
      public function removeRebateConsum() : void
      {
         hasField$0 &= 4227858431;
         rebate_consum$field = new Boolean();
      }
      
      public function get hasRebateConsum() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set rebateConsum(param1:Boolean) : void
      {
         hasField$0 |= 67108864;
         rebate_consum$field = param1;
      }
      
      public function get rebateConsum() : Boolean
      {
         return rebate_consum$field;
      }
      
      public function removeSumActive() : void
      {
         hasField$0 &= 4160749567;
         sum_active$field = new Boolean();
      }
      
      public function get hasSumActive() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set sumActive(param1:Boolean) : void
      {
         hasField$0 |= 134217728;
         sum_active$field = param1;
      }
      
      public function get sumActive() : Boolean
      {
         return sum_active$field;
      }
      
      public function removeCrossScoreReward() : void
      {
         hasField$0 &= 4026531839;
         cross_score_reward$field = new Boolean();
      }
      
      public function get hasCrossScoreReward() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set crossScoreReward(param1:Boolean) : void
      {
         hasField$0 |= 268435456;
         cross_score_reward$field = param1;
      }
      
      public function get crossScoreReward() : Boolean
      {
         return cross_score_reward$field;
      }
      
      public function removeAppell() : void
      {
         hasField$0 &= 3758096383;
         appell$field = new Boolean();
      }
      
      public function get hasAppell() : Boolean
      {
         return (hasField$0 & 0x20000000) != 0;
      }
      
      public function set appell(param1:Boolean) : void
      {
         hasField$0 |= 536870912;
         appell$field = param1;
      }
      
      public function get appell() : Boolean
      {
         return appell$field;
      }
      
      public function removeBottle() : void
      {
         hasField$0 &= 3221225471;
         bottle$field = new Boolean();
      }
      
      public function get hasBottle() : Boolean
      {
         return (hasField$0 & 0x40000000) != 0;
      }
      
      public function set bottle(param1:Boolean) : void
      {
         hasField$0 |= 1073741824;
         bottle$field = param1;
      }
      
      public function get bottle() : Boolean
      {
         return bottle$field;
      }
      
      public function removePetChallengeReward() : void
      {
         hasField$0 &= 2147483647;
         pet_challenge_reward$field = new Boolean();
      }
      
      public function get hasPetChallengeReward() : Boolean
      {
         return (hasField$0 & 0x80000000) != 0;
      }
      
      public function set petChallengeReward(param1:Boolean) : void
      {
         hasField$0 |= 2147483648;
         pet_challenge_reward$field = param1;
      }
      
      public function get petChallengeReward() : Boolean
      {
         return pet_challenge_reward$field;
      }
      
      public function removePowcardInfo() : void
      {
         hasField$1 &= 4294967294;
         powcard_info$field = new Boolean();
      }
      
      public function get hasPowcardInfo() : Boolean
      {
         return (hasField$1 & 1) != 0;
      }
      
      public function set powcardInfo(param1:Boolean) : void
      {
         hasField$1 |= 1;
         powcard_info$field = param1;
      }
      
      public function get powcardInfo() : Boolean
      {
         return powcard_info$field;
      }
      
      public function removeChristmas() : void
      {
         hasField$1 &= 4294967293;
         christmas$field = new Boolean();
      }
      
      public function get hasChristmas() : Boolean
      {
         return (hasField$1 & 2) != 0;
      }
      
      public function set christmas(param1:Boolean) : void
      {
         hasField$1 |= 2;
         christmas$field = param1;
      }
      
      public function get christmas() : Boolean
      {
         return christmas$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUser)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,user$field);
         }
         if(hasCastle)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,castle$field);
         }
         if(hasArmy)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,army$field);
         }
         if(hasQuest)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_BOOL(param1,quest$field);
         }
         if(hasBuild)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,build$field);
         }
         if(hasTree)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,tree$field);
         }
         if(hasAas)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,aas$field);
         }
         if(hasSmith)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,smith$field);
         }
         if(hasBag)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,bag$field);
         }
         if(hasLeed)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,leed$field);
         }
         if(hasStar)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,star$field);
         }
         if(hasFriend)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,friend$field);
         }
         if(hasEffect)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,effect$field);
         }
         if(hasSys)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,sys$field);
         }
         if(hasOffline)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,offline$field);
         }
         if(hasReward)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,reward$field);
         }
         if(hasTower)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,tower$field);
         }
         if(hasShop)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,shop$field);
         }
         if(hasChallReward)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_BOOL(param1,chall_reward$field);
         }
         if(hasSnsReq)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_BOOL(param1,sns_req$field);
         }
         if(hasActive)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_BOOL(param1,active$field);
         }
         if(hasSwitches)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_BOOL(param1,switches$field);
         }
         if(hasSweep)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_BOOL(param1,sweep$field);
         }
         if(hasQuestionnarie)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_BOOL(param1,questionnarie$field);
         }
         if(hasKingContract)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_BOOL(param1,king_contract$field);
         }
         if(hasRebateCharge)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_BOOL(param1,rebate_charge$field);
         }
         if(hasRebateConsum)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_BOOL(param1,rebate_consum$field);
         }
         if(hasSumActive)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_BOOL(param1,sum_active$field);
         }
         if(hasCrossScoreReward)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_BOOL(param1,cross_score_reward$field);
         }
         if(hasAppell)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_BOOL(param1,appell$field);
         }
         if(hasBottle)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_BOOL(param1,bottle$field);
         }
         if(hasPetChallengeReward)
         {
            WriteUtils.writeTag(param1,0,32);
            WriteUtils.write$TYPE_BOOL(param1,pet_challenge_reward$field);
         }
         if(hasPowcardInfo)
         {
            WriteUtils.writeTag(param1,0,33);
            WriteUtils.write$TYPE_BOOL(param1,powcard_info$field);
         }
         if(hasChristmas)
         {
            WriteUtils.writeTag(param1,0,34);
            WriteUtils.write$TYPE_BOOL(param1,christmas$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc32_:uint = 0;
         var _loc25_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc27_:uint = 0;
         var _loc6_:uint = 0;
         var _loc35_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc36_:uint = 0;
         var _loc26_:uint = 0;
         var _loc11_:uint = 0;
         var _loc20_:uint = 0;
         var _loc33_:uint = 0;
         var _loc31_:uint = 0;
         var _loc37_:uint = 0;
         var _loc18_:uint = 0;
         var _loc12_:uint = 0;
         var _loc8_:uint = 0;
         var _loc30_:uint = 0;
         var _loc4_:uint = 0;
         var _loc24_:uint = 0;
         var _loc9_:uint = 0;
         var _loc16_:uint = 0;
         var _loc34_:uint = 0;
         var _loc28_:uint = 0;
         var _loc29_:uint = 0;
         var _loc23_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.user cannot be set twice.");
                  }
                  _loc32_++;
                  user = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.castle cannot be set twice.");
                  }
                  _loc25_++;
                  castle = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.army cannot be set twice.");
                  }
                  _loc21_++;
                  army = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.quest cannot be set twice.");
                  }
                  _loc22_++;
                  quest = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 5:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.build cannot be set twice.");
                  }
                  _loc27_++;
                  build = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.tree cannot be set twice.");
                  }
                  _loc6_++;
                  tree = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.aas cannot be set twice.");
                  }
                  _loc35_++;
                  aas = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.smith cannot be set twice.");
                  }
                  _loc17_++;
                  smith = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.bag cannot be set twice.");
                  }
                  _loc10_++;
                  bag = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.leed cannot be set twice.");
                  }
                  _loc14_++;
                  leed = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.star cannot be set twice.");
                  }
                  _loc13_++;
                  star = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.friend cannot be set twice.");
                  }
                  _loc7_++;
                  friend = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.effect cannot be set twice.");
                  }
                  _loc3_++;
                  effect = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.sys cannot be set twice.");
                  }
                  _loc15_++;
                  sys = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.offline cannot be set twice.");
                  }
                  _loc36_++;
                  offline = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.reward cannot be set twice.");
                  }
                  _loc26_++;
                  reward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.tower cannot be set twice.");
                  }
                  _loc11_++;
                  tower = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.shop cannot be set twice.");
                  }
                  _loc20_++;
                  shop = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 19:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.challReward cannot be set twice.");
                  }
                  _loc33_++;
                  challReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 20:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.snsReq cannot be set twice.");
                  }
                  _loc31_++;
                  snsReq = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 21:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.active cannot be set twice.");
                  }
                  _loc37_++;
                  active = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 22:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.switches cannot be set twice.");
                  }
                  _loc18_++;
                  switches = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 23:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.sweep cannot be set twice.");
                  }
                  _loc12_++;
                  sweep = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 24:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.questionnarie cannot be set twice.");
                  }
                  _loc8_++;
                  questionnarie = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 25:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.kingContract cannot be set twice.");
                  }
                  _loc30_++;
                  kingContract = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 26:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.rebateCharge cannot be set twice.");
                  }
                  _loc4_++;
                  rebateCharge = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 27:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.rebateConsum cannot be set twice.");
                  }
                  _loc24_++;
                  rebateConsum = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 28:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.sumActive cannot be set twice.");
                  }
                  _loc9_++;
                  sumActive = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 29:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.crossScoreReward cannot be set twice.");
                  }
                  _loc16_++;
                  crossScoreReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 30:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.appell cannot be set twice.");
                  }
                  _loc34_++;
                  appell = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 31:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.bottle cannot be set twice.");
                  }
                  _loc28_++;
                  bottle = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 32:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.petChallengeReward cannot be set twice.");
                  }
                  _loc29_++;
                  petChallengeReward = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 33:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.powcardInfo cannot be set twice.");
                  }
                  _loc23_++;
                  powcardInfo = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 34:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerDataMsg.christmas cannot be set twice.");
                  }
                  _loc5_++;
                  christmas = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

