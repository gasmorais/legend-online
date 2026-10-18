package com.road.yishi.proto.gloryroad
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryRoadDataMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var layer$field:int;
      
      private var jumpLayer$field:int;
      
      private var resetTimes$field:int;
      
      private var resurgenceTimes$field:int;
      
      private var remainHp$field:Int64;
      
      private var childId$field:int;
      
      private var childPetId$field:int;
      
      private var childRemainHp$field:Int64;
      
      private var score$field:int;
      
      private var totalScore$field:int;
      
      private var gloryScore$field:int;
      
      private var buffStar$field:int;
      
      private var buyBufferTimes$field:int;
      
      [ArrayElementType("int")]
      public var allBuffers:Array = [];
      
      [ArrayElementType("int")]
      public var canBuyBuffers:Array = [];
      
      [ArrayElementType("int")]
      public var hasBuyBuffers:Array = [];
      
      [ArrayElementType("int")]
      public var scoreRewards:Array = [];
      
      private var canGetBox$field:Boolean;
      
      private var boxTimes$field:String;
      
      private var tag$field:int;
      
      private var difficulty$field:int;
      
      private var config$field:GloryRoadConfigMsg;
      
      public function GloryRoadDataMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeLayer() : void
      {
         hasField$0 &= 4294967293;
         layer$field = new int();
      }
      
      public function get hasLayer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set layer(param1:int) : void
      {
         hasField$0 |= 2;
         layer$field = param1;
      }
      
      public function get layer() : int
      {
         return layer$field;
      }
      
      public function removeJumpLayer() : void
      {
         hasField$0 &= 4294967291;
         jumpLayer$field = new int();
      }
      
      public function get hasJumpLayer() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set jumpLayer(param1:int) : void
      {
         hasField$0 |= 4;
         jumpLayer$field = param1;
      }
      
      public function get jumpLayer() : int
      {
         return jumpLayer$field;
      }
      
      public function removeResetTimes() : void
      {
         hasField$0 &= 4294967287;
         resetTimes$field = new int();
      }
      
      public function get hasResetTimes() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set resetTimes(param1:int) : void
      {
         hasField$0 |= 8;
         resetTimes$field = param1;
      }
      
      public function get resetTimes() : int
      {
         return resetTimes$field;
      }
      
      public function removeResurgenceTimes() : void
      {
         hasField$0 &= 4294967279;
         resurgenceTimes$field = new int();
      }
      
      public function get hasResurgenceTimes() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set resurgenceTimes(param1:int) : void
      {
         hasField$0 |= 16;
         resurgenceTimes$field = param1;
      }
      
      public function get resurgenceTimes() : int
      {
         return resurgenceTimes$field;
      }
      
      public function removeRemainHp() : void
      {
         remainHp$field = null;
      }
      
      public function get hasRemainHp() : Boolean
      {
         return remainHp$field != null;
      }
      
      public function set remainHp(param1:Int64) : void
      {
         remainHp$field = param1;
      }
      
      public function get remainHp() : Int64
      {
         return remainHp$field;
      }
      
      public function removeChildId() : void
      {
         hasField$0 &= 4294967263;
         childId$field = new int();
      }
      
      public function get hasChildId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set childId(param1:int) : void
      {
         hasField$0 |= 32;
         childId$field = param1;
      }
      
      public function get childId() : int
      {
         return childId$field;
      }
      
      public function removeChildPetId() : void
      {
         hasField$0 &= 4294967231;
         childPetId$field = new int();
      }
      
      public function get hasChildPetId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set childPetId(param1:int) : void
      {
         hasField$0 |= 64;
         childPetId$field = param1;
      }
      
      public function get childPetId() : int
      {
         return childPetId$field;
      }
      
      public function removeChildRemainHp() : void
      {
         childRemainHp$field = null;
      }
      
      public function get hasChildRemainHp() : Boolean
      {
         return childRemainHp$field != null;
      }
      
      public function set childRemainHp(param1:Int64) : void
      {
         childRemainHp$field = param1;
      }
      
      public function get childRemainHp() : Int64
      {
         return childRemainHp$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967167;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 128;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeTotalScore() : void
      {
         hasField$0 &= 4294967039;
         totalScore$field = new int();
      }
      
      public function get hasTotalScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set totalScore(param1:int) : void
      {
         hasField$0 |= 256;
         totalScore$field = param1;
      }
      
      public function get totalScore() : int
      {
         return totalScore$field;
      }
      
      public function removeGloryScore() : void
      {
         hasField$0 &= 4294966783;
         gloryScore$field = new int();
      }
      
      public function get hasGloryScore() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set gloryScore(param1:int) : void
      {
         hasField$0 |= 512;
         gloryScore$field = param1;
      }
      
      public function get gloryScore() : int
      {
         return gloryScore$field;
      }
      
      public function removeBuffStar() : void
      {
         hasField$0 &= 4294966271;
         buffStar$field = new int();
      }
      
      public function get hasBuffStar() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set buffStar(param1:int) : void
      {
         hasField$0 |= 1024;
         buffStar$field = param1;
      }
      
      public function get buffStar() : int
      {
         return buffStar$field;
      }
      
      public function removeBuyBufferTimes() : void
      {
         hasField$0 &= 4294965247;
         buyBufferTimes$field = new int();
      }
      
      public function get hasBuyBufferTimes() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set buyBufferTimes(param1:int) : void
      {
         hasField$0 |= 2048;
         buyBufferTimes$field = param1;
      }
      
      public function get buyBufferTimes() : int
      {
         return buyBufferTimes$field;
      }
      
      public function removeCanGetBox() : void
      {
         hasField$0 &= 4294963199;
         canGetBox$field = new Boolean();
      }
      
      public function get hasCanGetBox() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set canGetBox(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         canGetBox$field = param1;
      }
      
      public function get canGetBox() : Boolean
      {
         return canGetBox$field;
      }
      
      public function removeBoxTimes() : void
      {
         boxTimes$field = null;
      }
      
      public function get hasBoxTimes() : Boolean
      {
         return boxTimes$field != null;
      }
      
      public function set boxTimes(param1:String) : void
      {
         boxTimes$field = param1;
      }
      
      public function get boxTimes() : String
      {
         return boxTimes$field;
      }
      
      public function removeTag() : void
      {
         hasField$0 &= 4294959103;
         tag$field = new int();
      }
      
      public function get hasTag() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set tag(param1:int) : void
      {
         hasField$0 |= 8192;
         tag$field = param1;
      }
      
      public function get tag() : int
      {
         return tag$field;
      }
      
      public function removeDifficulty() : void
      {
         hasField$0 &= 4294950911;
         difficulty$field = new int();
      }
      
      public function get hasDifficulty() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set difficulty(param1:int) : void
      {
         hasField$0 |= 16384;
         difficulty$field = param1;
      }
      
      public function get difficulty() : int
      {
         return difficulty$field;
      }
      
      public function removeConfig() : void
      {
         config$field = null;
      }
      
      public function get hasConfig() : Boolean
      {
         return config$field != null;
      }
      
      public function set config(param1:GloryRoadConfigMsg) : void
      {
         config$field = param1;
      }
      
      public function get config() : GloryRoadConfigMsg
      {
         return config$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasLayer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,layer$field);
         }
         if(hasJumpLayer)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,jumpLayer$field);
         }
         if(hasResetTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,resetTimes$field);
         }
         if(hasResurgenceTimes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,resurgenceTimes$field);
         }
         if(hasRemainHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,remainHp$field);
         }
         if(hasChildId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,childId$field);
         }
         if(hasChildPetId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,childPetId$field);
         }
         if(hasChildRemainHp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT64(param1,childRemainHp$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasTotalScore)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,totalScore$field);
         }
         if(hasGloryScore)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,gloryScore$field);
         }
         if(hasBuffStar)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,buffStar$field);
         }
         if(hasBuyBufferTimes)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,buyBufferTimes$field);
         }
         _loc2_ = 0;
         while(_loc2_ < allBuffers.length)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,allBuffers[_loc2_]);
            _loc2_++;
         }
         _loc3_ = 0;
         while(_loc3_ < canBuyBuffers.length)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,canBuyBuffers[_loc3_]);
            _loc3_++;
         }
         _loc4_ = 0;
         while(_loc4_ < hasBuyBuffers.length)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,hasBuyBuffers[_loc4_]);
            _loc4_++;
         }
         _loc5_ = 0;
         while(_loc5_ < scoreRewards.length)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,scoreRewards[_loc5_]);
            _loc5_++;
         }
         if(hasCanGetBox)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_BOOL(param1,canGetBox$field);
         }
         if(hasBoxTimes)
         {
            WriteUtils.writeTag(param1,2,20);
            WriteUtils.write$TYPE_STRING(param1,boxTimes$field);
         }
         if(hasTag)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,tag$field);
         }
         if(hasDifficulty)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,difficulty$field);
         }
         if(hasConfig)
         {
            WriteUtils.writeTag(param1,2,23);
            WriteUtils.write$TYPE_MESSAGE(param1,config$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc19_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc17_:uint = 0;
         var _loc16_:uint = 0;
         var _loc21_:uint = 0;
         var _loc20_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc22_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.userId cannot be set twice.");
                  }
                  _loc8_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.layer cannot be set twice.");
                  }
                  _loc6_++;
                  layer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.jumpLayer cannot be set twice.");
                  }
                  _loc13_++;
                  jumpLayer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.resetTimes cannot be set twice.");
                  }
                  _loc19_++;
                  resetTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.resurgenceTimes cannot be set twice.");
                  }
                  _loc14_++;
                  resurgenceTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.remainHp cannot be set twice.");
                  }
                  _loc15_++;
                  remainHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 7:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.childId cannot be set twice.");
                  }
                  _loc17_++;
                  childId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.childPetId cannot be set twice.");
                  }
                  _loc16_++;
                  childPetId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.childRemainHp cannot be set twice.");
                  }
                  _loc21_++;
                  childRemainHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 10:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.score cannot be set twice.");
                  }
                  _loc20_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.totalScore cannot be set twice.");
                  }
                  _loc5_++;
                  totalScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.gloryScore cannot be set twice.");
                  }
                  _loc7_++;
                  gloryScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.buffStar cannot be set twice.");
                  }
                  _loc3_++;
                  buffStar = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.buyBufferTimes cannot be set twice.");
                  }
                  _loc12_++;
                  buyBufferTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if((_loc18_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,allBuffers);
                  }
                  else
                  {
                     allBuffers.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 16:
                  if((_loc18_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,canBuyBuffers);
                  }
                  else
                  {
                     canBuyBuffers.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 17:
                  if((_loc18_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,hasBuyBuffers);
                  }
                  else
                  {
                     hasBuyBuffers.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 18:
                  if((_loc18_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,scoreRewards);
                  }
                  else
                  {
                     scoreRewards.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 19:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.canGetBox cannot be set twice.");
                  }
                  _loc10_++;
                  canGetBox = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 20:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.boxTimes cannot be set twice.");
                  }
                  _loc4_++;
                  boxTimes = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 21:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.tag cannot be set twice.");
                  }
                  _loc9_++;
                  _loc18_ = uint(ReadUtils.read$TYPE_INT32(param1));
                  break;
               case 22:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.difficulty cannot be set twice.");
                  }
                  _loc22_++;
                  difficulty = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadDataMsg.config cannot be set twice.");
                  }
                  _loc11_++;
                  config = new GloryRoadConfigMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,config);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

