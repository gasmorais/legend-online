package com.road.yishi.proto.player
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerOpMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var type$field:int;
      
      private var payType$field:int;
      
      private var count$field:int;
      
      private var id$field:int;
      
      private var index$field:int;
      
      private var userId$field:int;
      
      private var templateId$field:int;
      
      private var campaignId$field:int;
      
      private var nodeId$field:int;
      
      private var chapterId$field:int;
      
      private var uuid$field:String;
      
      private var value1$field:int;
      
      private var value2$field:int;
      
      private var param1$field:String;
      
      private var param2$field:String;
      
      private var flag1$field:Boolean;
      
      private var flag2$field:Boolean;
      
      private var pos$field:int;
      
      [ArrayElementType("int")]
      public var ids:Array = [];
      
      public function PlayerOpMsg()
      {
         super();
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294967294;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 1;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
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
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967291;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 4;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967287;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 8;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967279;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 16;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
      }
      
      public function removeIndex() : void
      {
         hasField$0 &= 4294967263;
         index$field = new int();
      }
      
      public function get hasIndex() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set index(param1:int) : void
      {
         hasField$0 |= 32;
         index$field = param1;
      }
      
      public function get index() : int
      {
         return index$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967231;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 64;
         userId$field = param1;
      }
      
      public function get userId() : int
      {
         return userId$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967167;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 128;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeCampaignId() : void
      {
         hasField$0 &= 4294967039;
         campaignId$field = new int();
      }
      
      public function get hasCampaignId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set campaignId(param1:int) : void
      {
         hasField$0 |= 256;
         campaignId$field = param1;
      }
      
      public function get campaignId() : int
      {
         return campaignId$field;
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294966783;
         nodeId$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 512;
         nodeId$field = param1;
      }
      
      public function get nodeId() : int
      {
         return nodeId$field;
      }
      
      public function removeChapterId() : void
      {
         hasField$0 &= 4294966271;
         chapterId$field = new int();
      }
      
      public function get hasChapterId() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set chapterId(param1:int) : void
      {
         hasField$0 |= 1024;
         chapterId$field = param1;
      }
      
      public function get chapterId() : int
      {
         return chapterId$field;
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
      
      public function removeValue1() : void
      {
         hasField$0 &= 4294965247;
         value1$field = new int();
      }
      
      public function get hasValue1() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set value1(param1:int) : void
      {
         hasField$0 |= 2048;
         value1$field = param1;
      }
      
      public function get value1() : int
      {
         return value1$field;
      }
      
      public function removeValue2() : void
      {
         hasField$0 &= 4294963199;
         value2$field = new int();
      }
      
      public function get hasValue2() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set value2(param1:int) : void
      {
         hasField$0 |= 4096;
         value2$field = param1;
      }
      
      public function get value2() : int
      {
         return value2$field;
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
      
      public function removeFlag1() : void
      {
         hasField$0 &= 4294959103;
         flag1$field = new Boolean();
      }
      
      public function get hasFlag1() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set flag1(param1:Boolean) : void
      {
         hasField$0 |= 8192;
         flag1$field = param1;
      }
      
      public function get flag1() : Boolean
      {
         return flag1$field;
      }
      
      public function removeFlag2() : void
      {
         hasField$0 &= 4294950911;
         flag2$field = new Boolean();
      }
      
      public function get hasFlag2() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set flag2(param1:Boolean) : void
      {
         hasField$0 |= 16384;
         flag2$field = param1;
      }
      
      public function get flag2() : Boolean
      {
         return flag2$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294934527;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 32768;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasIndex)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,index$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasCampaignId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,campaignId$field);
         }
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,nodeId$field);
         }
         if(hasChapterId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,chapterId$field);
         }
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasValue1)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,value1$field);
         }
         if(hasValue2)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,value2$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,param2$field);
         }
         if(hasFlag1)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,flag1$field);
         }
         if(hasFlag2)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_BOOL(param1,flag2$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         _loc2_ = 0;
         while(_loc2_ < ids.length)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,ids[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc20_:uint = 0;
         var _loc10_:uint = 0;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc14_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc13_:uint = 0;
         var _loc4_:uint = 0;
         var _loc19_:uint = 0;
         var _loc8_:uint = 0;
         var _loc22_:uint = 0;
         var _loc17_:uint = 0;
         var _loc21_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.op cannot be set twice.");
                  }
                  _loc20_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.type cannot be set twice.");
                  }
                  _loc10_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.payType cannot be set twice.");
                  }
                  _loc16_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.count cannot be set twice.");
                  }
                  _loc5_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.index cannot be set twice.");
                  }
                  _loc14_++;
                  index = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.userId cannot be set twice.");
                  }
                  _loc11_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.templateId cannot be set twice.");
                  }
                  _loc7_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.campaignId cannot be set twice.");
                  }
                  _loc12_++;
                  campaignId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.nodeId cannot be set twice.");
                  }
                  _loc3_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.chapterId cannot be set twice.");
                  }
                  _loc15_++;
                  chapterId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.uuid cannot be set twice.");
                  }
                  _loc13_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.value1 cannot be set twice.");
                  }
                  _loc4_++;
                  value1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.value2 cannot be set twice.");
                  }
                  _loc19_++;
                  value2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.param1 cannot be set twice.");
                  }
                  _loc8_++;
                  param1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.param2 cannot be set twice.");
                  }
                  _loc22_++;
                  param2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.flag1 cannot be set twice.");
                  }
                  _loc17_++;
                  flag1 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.flag2 cannot be set twice.");
                  }
                  _loc21_++;
                  flag2 = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 19:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerOpMsg.pos cannot be set twice.");
                  }
                  _loc9_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if((_loc18_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,ids);
                  }
                  else
                  {
                     ids.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

