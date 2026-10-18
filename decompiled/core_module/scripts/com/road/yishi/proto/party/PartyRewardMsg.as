package com.road.yishi.proto.party
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PartyRewardMsg extends Message implements IExternalizable
   {
      
      private var uUid$field:String;
      
      private var rewardType$field:int;
      
      private var hasField$0:uint = 0;
      
      private var rewardLevel$field:int;
      
      private var needValue1$field:int;
      
      private var needOrder1$field:int;
      
      private var needOrder2$field:int;
      
      private var rewardScore$field:int;
      
      private var templateIds1$field:String;
      
      private var templateIds2$field:String;
      
      private var templateIds3$field:String;
      
      private var templateIds4$field:String;
      
      private var templateIds5$field:String;
      
      private var templateIds6$field:String;
      
      private var rewardState$field:int;
      
      public function PartyRewardMsg()
      {
         super();
      }
      
      public function removeUUid() : void
      {
         uUid$field = null;
      }
      
      public function get hasUUid() : Boolean
      {
         return uUid$field != null;
      }
      
      public function set uUid(param1:String) : void
      {
         uUid$field = param1;
      }
      
      public function get uUid() : String
      {
         return uUid$field;
      }
      
      public function removeRewardType() : void
      {
         hasField$0 &= 4294967294;
         rewardType$field = new int();
      }
      
      public function get hasRewardType() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set rewardType(param1:int) : void
      {
         hasField$0 |= 1;
         rewardType$field = param1;
      }
      
      public function get rewardType() : int
      {
         return rewardType$field;
      }
      
      public function removeRewardLevel() : void
      {
         hasField$0 &= 4294967293;
         rewardLevel$field = new int();
      }
      
      public function get hasRewardLevel() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set rewardLevel(param1:int) : void
      {
         hasField$0 |= 2;
         rewardLevel$field = param1;
      }
      
      public function get rewardLevel() : int
      {
         return rewardLevel$field;
      }
      
      public function removeNeedValue1() : void
      {
         hasField$0 &= 4294967291;
         needValue1$field = new int();
      }
      
      public function get hasNeedValue1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set needValue1(param1:int) : void
      {
         hasField$0 |= 4;
         needValue1$field = param1;
      }
      
      public function get needValue1() : int
      {
         return needValue1$field;
      }
      
      public function removeNeedOrder1() : void
      {
         hasField$0 &= 4294967287;
         needOrder1$field = new int();
      }
      
      public function get hasNeedOrder1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set needOrder1(param1:int) : void
      {
         hasField$0 |= 8;
         needOrder1$field = param1;
      }
      
      public function get needOrder1() : int
      {
         return needOrder1$field;
      }
      
      public function removeNeedOrder2() : void
      {
         hasField$0 &= 4294967279;
         needOrder2$field = new int();
      }
      
      public function get hasNeedOrder2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set needOrder2(param1:int) : void
      {
         hasField$0 |= 16;
         needOrder2$field = param1;
      }
      
      public function get needOrder2() : int
      {
         return needOrder2$field;
      }
      
      public function removeRewardScore() : void
      {
         hasField$0 &= 4294967263;
         rewardScore$field = new int();
      }
      
      public function get hasRewardScore() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set rewardScore(param1:int) : void
      {
         hasField$0 |= 32;
         rewardScore$field = param1;
      }
      
      public function get rewardScore() : int
      {
         return rewardScore$field;
      }
      
      public function removeTemplateIds1() : void
      {
         templateIds1$field = null;
      }
      
      public function get hasTemplateIds1() : Boolean
      {
         return templateIds1$field != null;
      }
      
      public function set templateIds1(param1:String) : void
      {
         templateIds1$field = param1;
      }
      
      public function get templateIds1() : String
      {
         return templateIds1$field;
      }
      
      public function removeTemplateIds2() : void
      {
         templateIds2$field = null;
      }
      
      public function get hasTemplateIds2() : Boolean
      {
         return templateIds2$field != null;
      }
      
      public function set templateIds2(param1:String) : void
      {
         templateIds2$field = param1;
      }
      
      public function get templateIds2() : String
      {
         return templateIds2$field;
      }
      
      public function removeTemplateIds3() : void
      {
         templateIds3$field = null;
      }
      
      public function get hasTemplateIds3() : Boolean
      {
         return templateIds3$field != null;
      }
      
      public function set templateIds3(param1:String) : void
      {
         templateIds3$field = param1;
      }
      
      public function get templateIds3() : String
      {
         return templateIds3$field;
      }
      
      public function removeTemplateIds4() : void
      {
         templateIds4$field = null;
      }
      
      public function get hasTemplateIds4() : Boolean
      {
         return templateIds4$field != null;
      }
      
      public function set templateIds4(param1:String) : void
      {
         templateIds4$field = param1;
      }
      
      public function get templateIds4() : String
      {
         return templateIds4$field;
      }
      
      public function removeTemplateIds5() : void
      {
         templateIds5$field = null;
      }
      
      public function get hasTemplateIds5() : Boolean
      {
         return templateIds5$field != null;
      }
      
      public function set templateIds5(param1:String) : void
      {
         templateIds5$field = param1;
      }
      
      public function get templateIds5() : String
      {
         return templateIds5$field;
      }
      
      public function removeTemplateIds6() : void
      {
         templateIds6$field = null;
      }
      
      public function get hasTemplateIds6() : Boolean
      {
         return templateIds6$field != null;
      }
      
      public function set templateIds6(param1:String) : void
      {
         templateIds6$field = param1;
      }
      
      public function get templateIds6() : String
      {
         return templateIds6$field;
      }
      
      public function removeRewardState() : void
      {
         hasField$0 &= 4294967231;
         rewardState$field = new int();
      }
      
      public function get hasRewardState() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rewardState(param1:int) : void
      {
         hasField$0 |= 64;
         rewardState$field = param1;
      }
      
      public function get rewardState() : int
      {
         return rewardState$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUUid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uUid$field);
         }
         if(hasRewardType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,rewardType$field);
         }
         if(hasRewardLevel)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rewardLevel$field);
         }
         if(hasNeedValue1)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,needValue1$field);
         }
         if(hasNeedOrder1)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,needOrder1$field);
         }
         if(hasNeedOrder2)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,needOrder2$field);
         }
         if(hasRewardScore)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,rewardScore$field);
         }
         if(hasTemplateIds1)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,templateIds1$field);
         }
         if(hasTemplateIds2)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,templateIds2$field);
         }
         if(hasTemplateIds3)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,templateIds3$field);
         }
         if(hasTemplateIds4)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,templateIds4$field);
         }
         if(hasTemplateIds5)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,templateIds5$field);
         }
         if(hasTemplateIds6)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_STRING(param1,templateIds6$field);
         }
         if(hasRewardState)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,rewardState$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc17_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc16_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.uUid cannot be set twice.");
                  }
                  _loc9_++;
                  uUid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.rewardType cannot be set twice.");
                  }
                  _loc4_++;
                  rewardType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.rewardLevel cannot be set twice.");
                  }
                  _loc7_++;
                  rewardLevel = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.needValue1 cannot be set twice.");
                  }
                  _loc5_++;
                  needValue1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.needOrder1 cannot be set twice.");
                  }
                  _loc10_++;
                  needOrder1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.needOrder2 cannot be set twice.");
                  }
                  _loc17_++;
                  needOrder2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.rewardScore cannot be set twice.");
                  }
                  _loc8_++;
                  rewardScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.templateIds1 cannot be set twice.");
                  }
                  _loc15_++;
                  templateIds1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.templateIds2 cannot be set twice.");
                  }
                  _loc12_++;
                  templateIds2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.templateIds3 cannot be set twice.");
                  }
                  _loc11_++;
                  templateIds3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.templateIds4 cannot be set twice.");
                  }
                  _loc13_++;
                  templateIds4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.templateIds5 cannot be set twice.");
                  }
                  _loc16_++;
                  templateIds5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.templateIds6 cannot be set twice.");
                  }
                  _loc3_++;
                  templateIds6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PartyRewardMsg.rewardState cannot be set twice.");
                  }
                  _loc6_++;
                  rewardState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

