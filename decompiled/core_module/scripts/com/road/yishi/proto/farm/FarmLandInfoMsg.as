package com.road.yishi.proto.farm
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FarmLandInfoMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var pos$field:int;
      
      private var item_template_id$field:int;
      
      private var add_time$field:String;
      
      private var feed_time$field:String;
      
      private var mature_time$field:String;
      
      private var crop_state$field:int;
      
      private var accelerate_count$field:int;
      
      private var stolen_count$field:int;
      
      private var is_worm$field:Boolean;
      
      private var is_grass$field:Boolean;
      
      private var is_gloomy$field:Boolean;
      
      private var is_ill$field:Boolean;
      
      private var is_can_reap$field:Boolean;
      
      private var is_hunger$field:Boolean;
      
      [ArrayElementType("int")]
      public var stolenUsers:Array = [];
      
      private var reward_count$field:int;
      
      private var op_type$field:int;
      
      private var result$field:int;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      public function FarmLandInfoMsg()
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
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967291;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 4;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeItemTemplateId() : void
      {
         hasField$0 &= 4294967287;
         item_template_id$field = new int();
      }
      
      public function get hasItemTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set itemTemplateId(param1:int) : void
      {
         hasField$0 |= 8;
         item_template_id$field = param1;
      }
      
      public function get itemTemplateId() : int
      {
         return item_template_id$field;
      }
      
      public function removeAddTime() : void
      {
         add_time$field = null;
      }
      
      public function get hasAddTime() : Boolean
      {
         return add_time$field != null;
      }
      
      public function set addTime(param1:String) : void
      {
         add_time$field = param1;
      }
      
      public function get addTime() : String
      {
         return add_time$field;
      }
      
      public function removeFeedTime() : void
      {
         feed_time$field = null;
      }
      
      public function get hasFeedTime() : Boolean
      {
         return feed_time$field != null;
      }
      
      public function set feedTime(param1:String) : void
      {
         feed_time$field = param1;
      }
      
      public function get feedTime() : String
      {
         return feed_time$field;
      }
      
      public function removeMatureTime() : void
      {
         mature_time$field = null;
      }
      
      public function get hasMatureTime() : Boolean
      {
         return mature_time$field != null;
      }
      
      public function set matureTime(param1:String) : void
      {
         mature_time$field = param1;
      }
      
      public function get matureTime() : String
      {
         return mature_time$field;
      }
      
      public function removeCropState() : void
      {
         hasField$0 &= 4294967279;
         crop_state$field = new int();
      }
      
      public function get hasCropState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set cropState(param1:int) : void
      {
         hasField$0 |= 16;
         crop_state$field = param1;
      }
      
      public function get cropState() : int
      {
         return crop_state$field;
      }
      
      public function removeAccelerateCount() : void
      {
         hasField$0 &= 4294967263;
         accelerate_count$field = new int();
      }
      
      public function get hasAccelerateCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set accelerateCount(param1:int) : void
      {
         hasField$0 |= 32;
         accelerate_count$field = param1;
      }
      
      public function get accelerateCount() : int
      {
         return accelerate_count$field;
      }
      
      public function removeStolenCount() : void
      {
         hasField$0 &= 4294967231;
         stolen_count$field = new int();
      }
      
      public function get hasStolenCount() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set stolenCount(param1:int) : void
      {
         hasField$0 |= 64;
         stolen_count$field = param1;
      }
      
      public function get stolenCount() : int
      {
         return stolen_count$field;
      }
      
      public function removeIsWorm() : void
      {
         hasField$0 &= 4294967167;
         is_worm$field = new Boolean();
      }
      
      public function get hasIsWorm() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isWorm(param1:Boolean) : void
      {
         hasField$0 |= 128;
         is_worm$field = param1;
      }
      
      public function get isWorm() : Boolean
      {
         return is_worm$field;
      }
      
      public function removeIsGrass() : void
      {
         hasField$0 &= 4294967039;
         is_grass$field = new Boolean();
      }
      
      public function get hasIsGrass() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isGrass(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_grass$field = param1;
      }
      
      public function get isGrass() : Boolean
      {
         return is_grass$field;
      }
      
      public function removeIsGloomy() : void
      {
         hasField$0 &= 4294966783;
         is_gloomy$field = new Boolean();
      }
      
      public function get hasIsGloomy() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set isGloomy(param1:Boolean) : void
      {
         hasField$0 |= 512;
         is_gloomy$field = param1;
      }
      
      public function get isGloomy() : Boolean
      {
         return is_gloomy$field;
      }
      
      public function removeIsIll() : void
      {
         hasField$0 &= 4294966271;
         is_ill$field = new Boolean();
      }
      
      public function get hasIsIll() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set isIll(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         is_ill$field = param1;
      }
      
      public function get isIll() : Boolean
      {
         return is_ill$field;
      }
      
      public function removeIsCanReap() : void
      {
         hasField$0 &= 4294965247;
         is_can_reap$field = new Boolean();
      }
      
      public function get hasIsCanReap() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isCanReap(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         is_can_reap$field = param1;
      }
      
      public function get isCanReap() : Boolean
      {
         return is_can_reap$field;
      }
      
      public function removeIsHunger() : void
      {
         hasField$0 &= 4294963199;
         is_hunger$field = new Boolean();
      }
      
      public function get hasIsHunger() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set isHunger(param1:Boolean) : void
      {
         hasField$0 |= 4096;
         is_hunger$field = param1;
      }
      
      public function get isHunger() : Boolean
      {
         return is_hunger$field;
      }
      
      public function removeRewardCount() : void
      {
         hasField$0 &= 4294959103;
         reward_count$field = new int();
      }
      
      public function get hasRewardCount() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set rewardCount(param1:int) : void
      {
         hasField$0 |= 8192;
         reward_count$field = param1;
      }
      
      public function get rewardCount() : int
      {
         return reward_count$field;
      }
      
      public function removeOpType() : void
      {
         hasField$0 &= 4294950911;
         op_type$field = new int();
      }
      
      public function get hasOpType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set opType(param1:int) : void
      {
         hasField$0 |= 16384;
         op_type$field = param1;
      }
      
      public function get opType() : int
      {
         return op_type$field;
      }
      
      public function removeResult() : void
      {
         hasField$0 &= 4294934527;
         result$field = new int();
      }
      
      public function get hasResult() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set result(param1:int) : void
      {
         hasField$0 |= 32768;
         result$field = param1;
      }
      
      public function get result() : int
      {
         if(!hasResult)
         {
            return 2;
         }
         return result$field;
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
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasItemTemplateId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,item_template_id$field);
         }
         if(hasAddTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,add_time$field);
         }
         if(hasFeedTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,feed_time$field);
         }
         if(hasMatureTime)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,mature_time$field);
         }
         if(hasCropState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,crop_state$field);
         }
         if(hasAccelerateCount)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,accelerate_count$field);
         }
         if(hasStolenCount)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,stolen_count$field);
         }
         if(hasIsWorm)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_BOOL(param1,is_worm$field);
         }
         if(hasIsGrass)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,is_grass$field);
         }
         if(hasIsGloomy)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_BOOL(param1,is_gloomy$field);
         }
         if(hasIsIll)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_BOOL(param1,is_ill$field);
         }
         if(hasIsCanReap)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,is_can_reap$field);
         }
         if(hasIsHunger)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,is_hunger$field);
         }
         _loc2_ = 0;
         while(_loc2_ < stolenUsers.length)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,stolenUsers[_loc2_]);
            _loc2_++;
         }
         if(hasRewardCount)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,reward_count$field);
         }
         if(hasOpType)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,op_type$field);
         }
         if(hasResult)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,result$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,21);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc18_:uint = 0;
         var _loc13_:uint = 0;
         var _loc11_:uint = 0;
         var _loc22_:uint = 0;
         var _loc8_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         var _loc6_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc15_:uint = 0;
         var _loc23_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc14_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         var _loc24_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.userId cannot be set twice.");
                  }
                  _loc18_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.type cannot be set twice.");
                  }
                  _loc13_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.pos cannot be set twice.");
                  }
                  _loc11_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.itemTemplateId cannot be set twice.");
                  }
                  _loc22_++;
                  itemTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.addTime cannot be set twice.");
                  }
                  _loc8_++;
                  addTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.feedTime cannot be set twice.");
                  }
                  _loc20_++;
                  feedTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.matureTime cannot be set twice.");
                  }
                  _loc21_++;
                  matureTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.cropState cannot be set twice.");
                  }
                  _loc3_++;
                  cropState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.accelerateCount cannot be set twice.");
                  }
                  _loc17_++;
                  accelerateCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.stolenCount cannot be set twice.");
                  }
                  _loc6_++;
                  stolenCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.isWorm cannot be set twice.");
                  }
                  _loc9_++;
                  isWorm = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.isGrass cannot be set twice.");
                  }
                  _loc4_++;
                  isGrass = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 13:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.isGloomy cannot be set twice.");
                  }
                  _loc15_++;
                  isGloomy = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 14:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.isIll cannot be set twice.");
                  }
                  _loc23_++;
                  isIll = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.isCanReap cannot be set twice.");
                  }
                  _loc5_++;
                  isCanReap = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.isHunger cannot be set twice.");
                  }
                  _loc10_++;
                  isHunger = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 17:
                  if((_loc19_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,stolenUsers);
                  }
                  else
                  {
                     stolenUsers.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 18:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.rewardCount cannot be set twice.");
                  }
                  _loc14_++;
                  rewardCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.opType cannot be set twice.");
                  }
                  _loc16_++;
                  opType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.result cannot be set twice.");
                  }
                  _loc12_++;
                  result = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.param1 cannot be set twice.");
                  }
                  _loc7_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 22:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: FarmLandInfoMsg.param2 cannot be set twice.");
                  }
                  _loc24_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

