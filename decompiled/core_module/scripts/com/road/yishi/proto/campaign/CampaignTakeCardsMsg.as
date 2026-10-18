package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignTakeCardsMsg extends Message implements IExternalizable
   {
      
      private var player_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var name$field:String;
      
      private var pay$field:Boolean;
      
      private var index$field:int;
      
      private var template_id$field:int;
      
      private var count$field:int;
      
      private var bind$field:Boolean;
      
      private var random_skill_1$field:int;
      
      private var random_skill_2$field:int;
      
      private var random_skill_3$field:int;
      
      private var random_skill_4$field:int;
      
      private var random_skill_5$field:int;
      
      public function CampaignTakeCardsMsg()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      public function get name() : String
      {
         return name$field;
      }
      
      public function removePay() : void
      {
         hasField$0 &= 4294967293;
         pay$field = new Boolean();
      }
      
      public function get hasPay() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set pay(param1:Boolean) : void
      {
         hasField$0 |= 2;
         pay$field = param1;
      }
      
      public function get pay() : Boolean
      {
         return pay$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967291;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 4;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967279;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 16;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeBind() : void
      {
         hasField$0 &= 4294967263;
         bind$field = new Boolean();
      }
      
      public function get hasBind() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set bind(param1:Boolean) : void
      {
         hasField$0 |= 32;
         bind$field = param1;
      }
      
      public function get bind() : Boolean
      {
         return bind$field;
      }
      
      public function removeRandomSkill_1() : void
      {
         hasField$0 &= 4294967231;
         random_skill_1$field = new int();
      }
      
      public function get hasRandomSkill_1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set randomSkill_1(param1:int) : void
      {
         hasField$0 |= 64;
         random_skill_1$field = param1;
      }
      
      public function get randomSkill_1() : int
      {
         return random_skill_1$field;
      }
      
      public function removeRandomSkill_2() : void
      {
         hasField$0 &= 4294967167;
         random_skill_2$field = new int();
      }
      
      public function get hasRandomSkill_2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set randomSkill_2(param1:int) : void
      {
         hasField$0 |= 128;
         random_skill_2$field = param1;
      }
      
      public function get randomSkill_2() : int
      {
         return random_skill_2$field;
      }
      
      public function removeRandomSkill_3() : void
      {
         hasField$0 &= 4294967039;
         random_skill_3$field = new int();
      }
      
      public function get hasRandomSkill_3() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set randomSkill_3(param1:int) : void
      {
         hasField$0 |= 256;
         random_skill_3$field = param1;
      }
      
      public function get randomSkill_3() : int
      {
         return random_skill_3$field;
      }
      
      public function removeRandomSkill_4() : void
      {
         hasField$0 &= 4294966783;
         random_skill_4$field = new int();
      }
      
      public function get hasRandomSkill_4() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set randomSkill_4(param1:int) : void
      {
         hasField$0 |= 512;
         random_skill_4$field = param1;
      }
      
      public function get randomSkill_4() : int
      {
         return random_skill_4$field;
      }
      
      public function removeRandomSkill_5() : void
      {
         hasField$0 &= 4294966271;
         random_skill_5$field = new int();
      }
      
      public function get hasRandomSkill_5() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set randomSkill_5(param1:int) : void
      {
         hasField$0 |= 1024;
         random_skill_5$field = param1;
      }
      
      public function get randomSkill_5() : int
      {
         return random_skill_5$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
         if(hasPay)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,pay$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasBind)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,bind$field);
         }
         if(hasRandomSkill_1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,random_skill_1$field);
         }
         if(hasRandomSkill_2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,random_skill_2$field);
         }
         if(hasRandomSkill_3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,random_skill_3$field);
         }
         if(hasRandomSkill_4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,random_skill_4$field);
         }
         if(hasRandomSkill_5)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,random_skill_5$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc11_:uint = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc7_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.playerId cannot be set twice.");
                  }
                  _loc5_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.name cannot be set twice.");
                  }
                  _loc8_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.pay cannot be set twice.");
                  }
                  _loc11_++;
                  pay = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.index cannot be set twice.");
                  }
                  _loc9_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.templateId cannot be set twice.");
                  }
                  _loc12_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.bind cannot be set twice.");
                  }
                  _loc14_++;
                  bind = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.randomSkill_1 cannot be set twice.");
                  }
                  _loc7_++;
                  randomSkill_1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.randomSkill_2 cannot be set twice.");
                  }
                  _loc10_++;
                  randomSkill_2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.randomSkill_3 cannot be set twice.");
                  }
                  _loc15_++;
                  randomSkill_3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.randomSkill_4 cannot be set twice.");
                  }
                  _loc6_++;
                  randomSkill_4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignTakeCardsMsg.randomSkill_5 cannot be set twice.");
                  }
                  _loc3_++;
                  randomSkill_5 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

