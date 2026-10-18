package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class TimeVortexInfoMsg extends Message implements IExternalizable
   {
      
      private var campaignId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var uuid$field:String;
      
      private var userId$field:int;
      
      private var nickName$field:String;
      
      private var serverName$field:String;
      
      private var occupyTime$field:String;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var param3$field:String;
      
      private var param4$field:int;
      
      private var param5$field:int;
      
      private var param6$field:int;
      
      private var fashionArm$field:String;
      
      private var fashionWing$field:String;
      
      private var fashionCloth$field:String;
      
      private var fashionHair$field:String;
      
      private var fashionHat$field:String;
      
      private var arm$field:String;
      
      private var templateId$field:int;
      
      private var job$field:int;
      
      private var sexJob$field:int;
      
      public function TimeVortexInfoMsg()
      {
         super();
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967294;
         campaignId$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 1;
         campaignId$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaignId$field;
      }
      
      public function removeUuid() : void
      {
         uuid$field = null;
      }
      
      public function get hasUuid() : Boolean
      {
         return uuid$field != null;
      }
      
      public function set uuid(param1:String) : void
      {
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967293;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 2;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
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
      
      public function removeServerName() : void
      {
         serverName$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return serverName$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         serverName$field = param1;
      }
      
      public function get serverName() : String
      {
         return serverName$field;
      }
      
      public function removeOccupyTime() : void
      {
         occupyTime$field = null;
      }
      
      public function get hasOccupyTime() : Boolean
      {
         return occupyTime$field != null;
      }
      
      public function set occupyTime(param1:String) : void
      {
         occupyTime$field = param1;
      }
      
      public function get occupyTime() : String
      {
         return occupyTime$field;
      }
      
      public function removeParam1() : void
      {
         param1$field = null;
      }
      
      public function get hasParam1() : Boolean
      {
         return param1$field != null;
      }
      
      public function set param1(param1:String) : void
      {
         param1$field = param1;
      }
      
      public function get param1() : String
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         param2$field = null;
      }
      
      public function get hasParam2() : Boolean
      {
         return param2$field != null;
      }
      
      public function set param2(param1:String) : void
      {
         param2$field = param1;
      }
      
      public function get param2() : String
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         hasField$0 &= 4294967291;
         param4$field = new int();
      }
      
      public function get hasParam4() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set param4(param1:int) : void
      {
         hasField$0 |= 4;
         param4$field = param1;
      }
      
      public function get param4() : int
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         hasField$0 &= 4294967287;
         param5$field = new int();
      }
      
      public function get hasParam5() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set param5(param1:int) : void
      {
         hasField$0 |= 8;
         param5$field = param1;
      }
      
      public function get param5() : int
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         hasField$0 &= 4294967279;
         param6$field = new int();
      }
      
      public function get hasParam6() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set param6(param1:int) : void
      {
         hasField$0 |= 16;
         param6$field = param1;
      }
      
      public function get param6() : int
      {
         return param6$field;
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967263;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 32;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967231;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 64;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeSexJob() : void
      {
         hasField$0 &= 4294967167;
         sexJob$field = new int();
      }
      
      public function get hasSexJob() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set sexJob(param1:int) : void
      {
         hasField$0 |= 128;
         sexJob$field = param1;
      }
      
      public function get sexJob() : int
      {
         return sexJob$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,serverName$field);
         }
         if(hasOccupyTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,occupyTime$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,param6$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionWing)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,fashionWing$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasFashionHair)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,fashionHair$field);
         }
         if(hasFashionHat)
         {
            WriteUtils.writeTag(param1,2,17);
            WriteUtils.write$TYPE_STRING(param1,fashionHat$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasSexJob)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,sexJob$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc22_:* = 0;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc24_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc15_:uint = 0;
         var _loc23_:uint = 0;
         var _loc21_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc19_:uint = 0;
         var _loc7_:uint = 0;
         var _loc20_:uint = 0;
         var _loc18_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc22_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.campaignId cannot be set twice.");
                  }
                  _loc12_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.uuid cannot be set twice.");
                  }
                  _loc13_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.nickName cannot be set twice.");
                  }
                  _loc17_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.serverName cannot be set twice.");
                  }
                  _loc14_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.occupyTime cannot be set twice.");
                  }
                  _loc3_++;
                  occupyTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.param1 cannot be set twice.");
                  }
                  _loc6_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.param2 cannot be set twice.");
                  }
                  _loc24_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.param3 cannot be set twice.");
                  }
                  _loc8_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.param4 cannot be set twice.");
                  }
                  _loc11_++;
                  param4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.param5 cannot be set twice.");
                  }
                  _loc15_++;
                  param5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.param6 cannot be set twice.");
                  }
                  _loc23_++;
                  param6 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.fashionArm cannot be set twice.");
                  }
                  _loc21_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.fashionWing cannot be set twice.");
                  }
                  _loc9_++;
                  fashionWing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.fashionCloth cannot be set twice.");
                  }
                  _loc4_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.fashionHair cannot be set twice.");
                  }
                  _loc16_++;
                  fashionHair = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.fashionHat cannot be set twice.");
                  }
                  _loc5_++;
                  fashionHat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 18:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.arm cannot be set twice.");
                  }
                  _loc19_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.job cannot be set twice.");
                  }
                  _loc20_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: TimeVortexInfoMsg.sexJob cannot be set twice.");
                  }
                  _loc18_++;
                  sexJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc22_ & 7);
            }
         }
      }
   }
}

