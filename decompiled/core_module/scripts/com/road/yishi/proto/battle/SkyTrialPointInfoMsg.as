package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialPointInfoMsg extends Message implements IExternalizable
   {
      
      private var layNumId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var posIndex$field:int;
      
      private var occpUuid$field:String;
      
      private var occpUserId$field:int;
      
      private var nickName$field:String;
      
      private var svrsName$field:String;
      
      private var occpDateStr$field:String;
      
      private var occpMinute$field:int;
      
      private var isSendTimeReward1$field:Boolean;
      
      private var isSendTimeReward2$field:Boolean;
      
      private var isSendTimeReward3$field:Boolean;
      
      private var fashionArm$field:String;
      
      private var fashionWing$field:String;
      
      private var fashionCloth$field:String;
      
      private var fashionHair$field:String;
      
      private var fashionHat$field:String;
      
      private var arm$field:String;
      
      private var job$field:int;
      
      private var sexJob$field:int;
      
      public function SkyTrialPointInfoMsg()
      {
         super();
      }
      
      public function removeLayNumId() : void
      {
         hasField$0 &= 4294967294;
         layNumId$field = new int();
      }
      
      public function get hasLayNumId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set layNumId(param1:int) : void
      {
         hasField$0 |= 1;
         layNumId$field = param1;
      }
      
      public function get layNumId() : int
      {
         return layNumId$field;
      }
      
      public function removePosIndex() : void
      {
         hasField$0 &= 4294967293;
         posIndex$field = new int();
      }
      
      public function get hasPosIndex() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set posIndex(param1:int) : void
      {
         hasField$0 |= 2;
         posIndex$field = param1;
      }
      
      public function get posIndex() : int
      {
         return posIndex$field;
      }
      
      public function removeOccpUuid() : void
      {
         occpUuid$field = null;
      }
      
      public function get hasOccpUuid() : Boolean
      {
         return occpUuid$field != null;
      }
      
      public function set occpUuid(param1:String) : void
      {
         occpUuid$field = param1;
      }
      
      public function get occpUuid() : String
      {
         return occpUuid$field;
      }
      
      public function removeOccpUserId() : void
      {
         hasField$0 &= 4294967291;
         occpUserId$field = new int();
      }
      
      public function get hasOccpUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set occpUserId(param1:int) : void
      {
         hasField$0 |= 4;
         occpUserId$field = param1;
      }
      
      public function get occpUserId() : int
      {
         return occpUserId$field;
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
      
      public function removeSvrsName() : void
      {
         svrsName$field = null;
      }
      
      public function get hasSvrsName() : Boolean
      {
         return svrsName$field != null;
      }
      
      public function set svrsName(param1:String) : void
      {
         svrsName$field = param1;
      }
      
      public function get svrsName() : String
      {
         return svrsName$field;
      }
      
      public function removeOccpDateStr() : void
      {
         occpDateStr$field = null;
      }
      
      public function get hasOccpDateStr() : Boolean
      {
         return occpDateStr$field != null;
      }
      
      public function set occpDateStr(param1:String) : void
      {
         occpDateStr$field = param1;
      }
      
      public function get occpDateStr() : String
      {
         return occpDateStr$field;
      }
      
      public function removeOccpMinute() : void
      {
         hasField$0 &= 4294967287;
         occpMinute$field = new int();
      }
      
      public function get hasOccpMinute() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set occpMinute(param1:int) : void
      {
         hasField$0 |= 8;
         occpMinute$field = param1;
      }
      
      public function get occpMinute() : int
      {
         return occpMinute$field;
      }
      
      public function removeIsSendTimeReward1() : void
      {
         hasField$0 &= 4294967279;
         isSendTimeReward1$field = new Boolean();
      }
      
      public function get hasIsSendTimeReward1() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isSendTimeReward1(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isSendTimeReward1$field = param1;
      }
      
      public function get isSendTimeReward1() : Boolean
      {
         return isSendTimeReward1$field;
      }
      
      public function removeIsSendTimeReward2() : void
      {
         hasField$0 &= 4294967263;
         isSendTimeReward2$field = new Boolean();
      }
      
      public function get hasIsSendTimeReward2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isSendTimeReward2(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isSendTimeReward2$field = param1;
      }
      
      public function get isSendTimeReward2() : Boolean
      {
         return isSendTimeReward2$field;
      }
      
      public function removeIsSendTimeReward3() : void
      {
         hasField$0 &= 4294967231;
         isSendTimeReward3$field = new Boolean();
      }
      
      public function get hasIsSendTimeReward3() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isSendTimeReward3(param1:Boolean) : void
      {
         hasField$0 |= 64;
         isSendTimeReward3$field = param1;
      }
      
      public function get isSendTimeReward3() : Boolean
      {
         return isSendTimeReward3$field;
      }
      
      public function removeFashionArm() : void
      {
         fashionArm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashionArm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashionArm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashionArm$field;
      }
      
      public function removeFashionWing() : void
      {
         fashionWing$field = null;
      }
      
      public function get hasFashionWing() : Boolean
      {
         return fashionWing$field != null;
      }
      
      public function set fashionWing(param1:String) : void
      {
         fashionWing$field = param1;
      }
      
      public function get fashionWing() : String
      {
         return fashionWing$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashionCloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashionCloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashionCloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashionCloth$field;
      }
      
      public function removeFashionHair() : void
      {
         fashionHair$field = null;
      }
      
      public function get hasFashionHair() : Boolean
      {
         return fashionHair$field != null;
      }
      
      public function set fashionHair(param1:String) : void
      {
         fashionHair$field = param1;
      }
      
      public function get fashionHair() : String
      {
         return fashionHair$field;
      }
      
      public function removeFashionHat() : void
      {
         fashionHat$field = null;
      }
      
      public function get hasFashionHat() : Boolean
      {
         return fashionHat$field != null;
      }
      
      public function set fashionHat(param1:String) : void
      {
         fashionHat$field = param1;
      }
      
      public function get fashionHat() : String
      {
         return fashionHat$field;
      }
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967167;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 128;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeSexJob() : void
      {
         hasField$0 &= 4294967039;
         sexJob$field = new int();
      }
      
      public function get hasSexJob() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set sexJob(param1:int) : void
      {
         hasField$0 |= 256;
         sexJob$field = param1;
      }
      
      public function get sexJob() : int
      {
         return sexJob$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasLayNumId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,layNumId$field);
         }
         if(hasPosIndex)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,posIndex$field);
         }
         if(hasOccpUuid)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,occpUuid$field);
         }
         if(hasOccpUserId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,occpUserId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasSvrsName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,svrsName$field);
         }
         if(hasOccpDateStr)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,occpDateStr$field);
         }
         if(hasOccpMinute)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,occpMinute$field);
         }
         if(hasIsSendTimeReward1)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,isSendTimeReward1$field);
         }
         if(hasIsSendTimeReward2)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_BOOL(param1,isSendTimeReward2$field);
         }
         if(hasIsSendTimeReward3)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,isSendTimeReward3$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionWing)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,fashionWing$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasFashionHair)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,fashionHair$field);
         }
         if(hasFashionHat)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,fashionHat$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasSexJob)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,sexJob$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc21_:* = 0;
         var _loc4_:uint = 0;
         var _loc18_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc13_:uint = 0;
         var _loc5_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         var _loc22_:uint = 0;
         var _loc16_:uint = 0;
         var _loc10_:uint = 0;
         var _loc20_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc19_:uint = 0;
         var _loc15_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc21_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.layNumId cannot be set twice.");
                  }
                  _loc4_++;
                  layNumId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.posIndex cannot be set twice.");
                  }
                  _loc18_++;
                  posIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.occpUuid cannot be set twice.");
                  }
                  _loc8_++;
                  occpUuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.occpUserId cannot be set twice.");
                  }
                  _loc7_++;
                  occpUserId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.nickName cannot be set twice.");
                  }
                  _loc13_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.svrsName cannot be set twice.");
                  }
                  _loc5_++;
                  svrsName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.occpDateStr cannot be set twice.");
                  }
                  _loc12_++;
                  occpDateStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.occpMinute cannot be set twice.");
                  }
                  _loc14_++;
                  occpMinute = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.isSendTimeReward1 cannot be set twice.");
                  }
                  _loc22_++;
                  isSendTimeReward1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.isSendTimeReward2 cannot be set twice.");
                  }
                  _loc16_++;
                  isSendTimeReward2 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.isSendTimeReward3 cannot be set twice.");
                  }
                  _loc10_++;
                  isSendTimeReward3 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 11:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.fashionArm cannot be set twice.");
                  }
                  _loc20_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.fashionWing cannot be set twice.");
                  }
                  _loc9_++;
                  fashionWing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.fashionCloth cannot be set twice.");
                  }
                  _loc3_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.fashionHair cannot be set twice.");
                  }
                  _loc11_++;
                  fashionHair = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.fashionHat cannot be set twice.");
                  }
                  _loc6_++;
                  fashionHat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.arm cannot be set twice.");
                  }
                  _loc17_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.job cannot be set twice.");
                  }
                  _loc19_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialPointInfoMsg.sexJob cannot be set twice.");
                  }
                  _loc15_++;
                  sexJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc21_ & 7);
            }
         }
      }
   }
}

