package com.road.yishi.proto.skytrial
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SkyTrialRequestMsg extends Message implements IExternalizable
   {
      
      public var op:int;
      
      private var need_help$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var pay_type$field:int;
      
      private var buy_skill_id$field:int;
      
      private var portal_id$field:int;
      
      private var layNumId$field:int;
      
      private var posIndex$field:int;
      
      public function SkyTrialRequestMsg()
      {
         super();
      }
      
      public function removeNeedHelp() : void
      {
         hasField$0 &= 4294967294;
         need_help$field = new Boolean();
      }
      
      public function get hasNeedHelp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set needHelp(param1:Boolean) : void
      {
         hasField$0 |= 1;
         need_help$field = param1;
      }
      
      public function get needHelp() : Boolean
      {
         return need_help$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967293;
         pay_type$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 2;
         pay_type$field = param1;
      }
      
      public function get payType() : int
      {
         return pay_type$field;
      }
      
      public function removeBuySkillId() : void
      {
         hasField$0 &= 4294967291;
         buy_skill_id$field = new int();
      }
      
      public function get hasBuySkillId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set buySkillId(param1:int) : void
      {
         hasField$0 |= 4;
         buy_skill_id$field = param1;
      }
      
      public function get buySkillId() : int
      {
         return buy_skill_id$field;
      }
      
      public function removePortalId() : void
      {
         hasField$0 &= 4294967287;
         portal_id$field = new int();
      }
      
      public function get hasPortalId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set portalId(param1:int) : void
      {
         hasField$0 |= 8;
         portal_id$field = param1;
      }
      
      public function get portalId() : int
      {
         return portal_id$field;
      }
      
      public function removeLayNumId() : void
      {
         hasField$0 &= 4294967279;
         layNumId$field = new int();
      }
      
      public function get hasLayNumId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set layNumId(param1:int) : void
      {
         hasField$0 |= 16;
         layNumId$field = param1;
      }
      
      public function get layNumId() : int
      {
         return layNumId$field;
      }
      
      public function removePosIndex() : void
      {
         hasField$0 &= 4294967263;
         posIndex$field = new int();
      }
      
      public function get hasPosIndex() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set posIndex(param1:int) : void
      {
         hasField$0 |= 32;
         posIndex$field = param1;
      }
      
      public function get posIndex() : int
      {
         return posIndex$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         WriteUtils.writeTag(param1,0,1);
         WriteUtils.write$TYPE_INT32(param1,op);
         if(hasNeedHelp)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_BOOL(param1,need_help$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pay_type$field);
         }
         if(hasBuySkillId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,buy_skill_id$field);
         }
         if(hasPortalId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,portal_id$field);
         }
         if(hasLayNumId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,layNumId$field);
         }
         if(hasPosIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,posIndex$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:* = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc9_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc8_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.op cannot be set twice.");
                  }
                  _loc10_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.needHelp cannot be set twice.");
                  }
                  _loc5_++;
                  needHelp = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.payType cannot be set twice.");
                  }
                  _loc9_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.buySkillId cannot be set twice.");
                  }
                  _loc6_++;
                  buySkillId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.portalId cannot be set twice.");
                  }
                  _loc3_++;
                  portalId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.layNumId cannot be set twice.");
                  }
                  _loc4_++;
                  layNumId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SkyTrialRequestMsg.posIndex cannot be set twice.");
                  }
                  _loc7_++;
                  posIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
            }
         }
         if(_loc10_ != 1)
         {
            throw new IOError("Bad data format: SkyTrialRequestMsg.op must be set.");
         }
      }
   }
}

