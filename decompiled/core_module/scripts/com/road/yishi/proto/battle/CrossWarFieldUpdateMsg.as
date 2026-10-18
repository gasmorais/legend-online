package com.road.yishi.proto.battle
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CrossWarFieldUpdateMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var geste$field:int;
      
      private var type$field:int;
      
      [ArrayElementType("com.road.yishi.proto.battle.BattleItemMsg")]
      public var item:Array = [];
      
      private var score$field:int;
      
      private var is_add$field:Boolean;
      
      private var war_campaign_id$field:int;
      
      private var last_fail$field:int;
      
      private var result$field:Boolean;
      
      private var cross_score$field:int;
      
      private var server_id$field:int;
      
      private var server_name$field:String;
      
      private var port$field:int;
      
      private var address$field:String;
      
      private var isFire$field:Boolean;
      
      private var isEnergy$field:Boolean;
      
      private var param1$field:int;
      
      private var param2$field:String;
      
      private var param3$field:int;
      
      private var addGp$field:int;
      
      public function CrossWarFieldUpdateMsg()
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
      
      public function removeGeste() : void
      {
         hasField$0 &= 4294967293;
         geste$field = new int();
      }
      
      public function get hasGeste() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set geste(param1:int) : void
      {
         hasField$0 |= 2;
         geste$field = param1;
      }
      
      public function get geste() : int
      {
         return geste$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeIsAdd() : void
      {
         hasField$0 &= 4294967279;
         is_add$field = new Boolean();
      }
      
      public function get hasIsAdd() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isAdd(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_add$field = param1;
      }
      
      public function get isAdd() : Boolean
      {
         return is_add$field;
      }
      
      public function removeWarCampaignId() : void
      {
         hasField$0 &= 4294967263;
         war_campaign_id$field = new int();
      }
      
      public function get hasWarCampaignId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set warCampaignId(param1:int) : void
      {
         hasField$0 |= 32;
         war_campaign_id$field = param1;
      }
      
      public function get warCampaignId() : int
      {
         return war_campaign_id$field;
      }
      
      public function removeLastFail() : void
      {
         hasField$0 &= 4294967231;
         last_fail$field = new int();
      }
      
      public function get hasLastFail() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set lastFail(param1:int) : void
      {
         hasField$0 |= 64;
         last_fail$field = param1;
      }
      
      public function get lastFail() : int
      {
         return last_fail$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294967167;
         result$field = new Boolean();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set result(param1:Boolean) : void
      {
         hasField$0 |= 128;
         result$field = param1;
      }
      
      public function get result() : Boolean
      {
         return result$field;
      }
      
      public function removeCrossScore() : void
      {
         hasField$0 &= 4294967039;
         cross_score$field = new int();
      }
      
      public function get hasCrossScore() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set crossScore(param1:int) : void
      {
         hasField$0 |= 256;
         cross_score$field = param1;
      }
      
      public function get crossScore() : int
      {
         return cross_score$field;
      }
      
      public function removeServerId() : void
      {
         hasField$0 &= 4294966783;
         server_id$field = new int();
      }
      
      public function get hasServerId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set serverId(param1:int) : void
      {
         hasField$0 |= 512;
         server_id$field = param1;
      }
      
      public function get serverId() : int
      {
         return server_id$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removePort() : void
      {
         hasField$0 &= 4294966271;
         port$field = new int();
      }
      
      public function get hasPort() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set port(param1:int) : void
      {
         hasField$0 |= 1024;
         port$field = param1;
      }
      
      public function get port() : int
      {
         return port$field;
      }
      
      public function removeAddress() : void
      {
         address$field = null;
      }
      
      public function get hasAddress() : Boolean
      {
         return address$field != null;
      }
      
      public function set address(param1:String) : void
      {
         address$field = param1;
      }
      
      public function get address() : String
      {
         return address$field;
      }
      
      public function removeIsFire() : void
      {
         hasField$0 &= 4294965247;
         isFire$field = new Boolean();
      }
      
      public function get hasIsFire() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isFire(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         isFire$field = param1;
      }
      
      public function get isFire() : Boolean
      {
         return isFire$field;
      }
      
      public function removeIsEnergy() : void
      {
         hasField$0 &= 4294963199;
         isEnergy$field = new Boolean();
      }
      
      public function get hasIsEnergy() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isEnergy(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         isEnergy$field = param1;
      }
      
      public function get isEnergy() : Boolean
      {
         return isEnergy$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4294959103;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 8192;
         param1$field = param1;
      }
      
      public function get param1() : int
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
         hasField$0 &= 4294950911;
         param3$field = new int();
      }
      
      public function get hasParam3() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set param3(param1:int) : void
      {
         hasField$0 |= 16384;
         param3$field = param1;
      }
      
      public function get param3() : int
      {
         return param3$field;
      }
      
      public function removeAddGp() : void
      {
         hasField$0 &= 4294934527;
         addGp$field = new int();
      }
      
      public function get hasAddGp() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set addGp(param1:int) : void
      {
         hasField$0 |= 32768;
         addGp$field = param1;
      }
      
      public function get addGp() : int
      {
         return addGp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasGeste)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,geste$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         _loc2_ = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasIsAdd)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,is_add$field);
         }
         if(hasWarCampaignId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,war_campaign_id$field);
         }
         if(hasLastFail)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,last_fail$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,result$field);
         }
         if(hasCrossScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,cross_score$field);
         }
         if(hasServerId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,server_id$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasPort)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,port$field);
         }
         if(hasAddress)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,address$field);
         }
         if(hasIsFire)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,isFire$field);
         }
         if(hasIsEnergy)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,isEnergy$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,18);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,param3$field);
         }
         if(hasAddGp)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,addGp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:* = 0;
         var _loc6_:BattleItemMsg = null;
         var _loc18_:uint = 0;
         var _loc22_:uint = 0;
         var _loc11_:uint = 0;
         var _loc21_:uint = 0;
         var _loc17_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc13_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc19_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc23_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc20_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.userId cannot be set twice.");
                  }
                  _loc18_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.geste cannot be set twice.");
                  }
                  _loc22_++;
                  geste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.type cannot be set twice.");
                  }
                  _loc11_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  _loc6_ = new BattleItemMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc6_);
                  item.push(_loc6_);
                  break;
               case 5:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.score cannot be set twice.");
                  }
                  _loc21_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.isAdd cannot be set twice.");
                  }
                  _loc17_++;
                  isAdd = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.warCampaignId cannot be set twice.");
                  }
                  _loc14_++;
                  warCampaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.lastFail cannot be set twice.");
                  }
                  _loc7_++;
                  lastFail = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.result cannot be set twice.");
                  }
                  _loc10_++;
                  result = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.crossScore cannot be set twice.");
                  }
                  _loc12_++;
                  crossScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.serverId cannot be set twice.");
                  }
                  _loc3_++;
                  serverId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.serverName cannot be set twice.");
                  }
                  _loc13_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.port cannot be set twice.");
                  }
                  _loc15_++;
                  port = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.address cannot be set twice.");
                  }
                  _loc4_++;
                  address = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.isFire cannot be set twice.");
                  }
                  _loc19_++;
                  isFire = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.isEnergy cannot be set twice.");
                  }
                  _loc16_++;
                  isEnergy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.param1 cannot be set twice.");
                  }
                  _loc8_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.param2 cannot be set twice.");
                  }
                  _loc23_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 19:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.param3 cannot be set twice.");
                  }
                  _loc9_++;
                  param3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CrossWarFieldUpdateMsg.addGp cannot be set twice.");
                  }
                  _loc5_++;
                  addGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc20_ & 7);
            }
         }
      }
   }
}

