package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AltarCampaignSkillMsg extends Message implements IExternalizable
   {
      
      private var template_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var CD_timer$field:int;
      
      private var userId$field:int;
      
      private var nickName$field:String;
      
      private var consortiaId$field:int;
      
      public function AltarCampaignSkillMsg()
      {
         super();
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967294;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 1;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeCDTimer() : void
      {
         hasField$0 &= 4294967293;
         CD_timer$field = new int();
      }
      
      public function get hasCDTimer() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set cDTimer(param1:int) : void
      {
         hasField$0 |= 2;
         CD_timer$field = param1;
      }
      
      public function get cDTimer() : int
      {
         return CD_timer$field;
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967291;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 4;
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
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967287;
         consortiaId$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 8;
         consortiaId$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortiaId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasCDTimer)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,CD_timer$field);
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
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,consortiaId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:uint = 0;
         var _loc8_:uint = 0;
         var _loc6_:uint = 0;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc7_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignSkillMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignSkillMsg.cDTimer cannot be set twice.");
                  }
                  _loc8_++;
                  cDTimer = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignSkillMsg.userId cannot be set twice.");
                  }
                  _loc6_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignSkillMsg.nickName cannot be set twice.");
                  }
                  _loc4_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AltarCampaignSkillMsg.consortiaId cannot be set twice.");
                  }
                  _loc3_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
            }
         }
      }
   }
}

