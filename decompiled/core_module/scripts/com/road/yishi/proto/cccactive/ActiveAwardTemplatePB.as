package com.road.yishi.proto.cccactive
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class ActiveAwardTemplatePB extends Message implements IExternalizable
   {
      
      private var uuid$field:String;
      
      private var hasField$0:uint = 0;
      
      private var template_id$field:int;
      
      private var template_type$field:int;
      
      private var template_count$field:int;
      
      private var template_show$field:int;
      
      private var is_bind$field:int;
      
      private var is_notice$field:int;
      
      private var remain_1$field:String;
      
      private var remain_2$field:String;
      
      private var remain_3$field:String;
      
      private var remain_4$field:String;
      
      public function ActiveAwardTemplatePB()
      {
         super();
      }
      
      public function removeUuid() : void
      {
         hasField$0 &= 4294967294;
         uuid$field = new String();
      }
      
      public function get hasUuid() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set uuid(param1:String) : void
      {
         hasField$0 |= 1;
         uuid$field = param1;
      }
      
      public function get uuid() : String
      {
         return uuid$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeTemplateType() : void
      {
         hasField$0 &= 4294967291;
         template_type$field = new int();
      }
      
      public function get hasTemplateType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateType(param1:int) : void
      {
         hasField$0 |= 4;
         template_type$field = param1;
      }
      
      public function get templateType() : int
      {
         return template_type$field;
      }
      
      public function removeTemplateCount() : void
      {
         hasField$0 &= 4294967287;
         template_count$field = new int();
      }
      
      public function get hasTemplateCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateCount(param1:int) : void
      {
         hasField$0 |= 8;
         template_count$field = param1;
      }
      
      public function get templateCount() : int
      {
         return template_count$field;
      }
      
      public function removeTemplateShow() : void
      {
         hasField$0 &= 4294967279;
         template_show$field = new int();
      }
      
      public function get hasTemplateShow() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templateShow(param1:int) : void
      {
         hasField$0 |= 16;
         template_show$field = param1;
      }
      
      public function get templateShow() : int
      {
         return template_show$field;
      }
      
      public function removeIsBind() : void
      {
         hasField$0 &= 4294967263;
         is_bind$field = new int();
      }
      
      public function get hasIsBind() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isBind(param1:int) : void
      {
         hasField$0 |= 32;
         is_bind$field = param1;
      }
      
      public function get isBind() : int
      {
         return is_bind$field;
      }
      
      public function removeIsNotice() : void
      {
         hasField$0 &= 4294967231;
         is_notice$field = new int();
      }
      
      public function get hasIsNotice() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isNotice(param1:int) : void
      {
         hasField$0 |= 64;
         is_notice$field = param1;
      }
      
      public function get isNotice() : int
      {
         return is_notice$field;
      }
      
      public function removeRemain1() : void
      {
         hasField$0 &= 4294967167;
         remain_1$field = new String();
      }
      
      public function get hasRemain1() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set remain1(param1:String) : void
      {
         hasField$0 |= 128;
         remain_1$field = param1;
      }
      
      public function get remain1() : String
      {
         return remain_1$field;
      }
      
      public function removeRemain2() : void
      {
         hasField$0 &= 4294967039;
         remain_2$field = new String();
      }
      
      public function get hasRemain2() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set remain2(param1:String) : void
      {
         hasField$0 |= 256;
         remain_2$field = param1;
      }
      
      public function get remain2() : String
      {
         return remain_2$field;
      }
      
      public function removeRemain3() : void
      {
         hasField$0 &= 4294966783;
         remain_3$field = new String();
      }
      
      public function get hasRemain3() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set remain3(param1:String) : void
      {
         hasField$0 |= 512;
         remain_3$field = param1;
      }
      
      public function get remain3() : String
      {
         return remain_3$field;
      }
      
      public function removeRemain4() : void
      {
         hasField$0 &= 4294966271;
         remain_4$field = new String();
      }
      
      public function get hasRemain4() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set remain4(param1:String) : void
      {
         hasField$0 |= 1024;
         remain_4$field = param1;
      }
      
      public function get remain4() : String
      {
         return remain_4$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUuid)
         {
            WriteUtils.writeTag(param1,2,1);
            WriteUtils.write$TYPE_STRING(param1,uuid$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasTemplateType)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,template_type$field);
         }
         if(hasTemplateCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,template_count$field);
         }
         if(hasTemplateShow)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,template_show$field);
         }
         if(hasIsBind)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,is_bind$field);
         }
         if(hasIsNotice)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,is_notice$field);
         }
         if(hasRemain1)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,remain_1$field);
         }
         if(hasRemain2)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,remain_2$field);
         }
         if(hasRemain3)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,remain_3$field);
         }
         if(hasRemain4)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,remain_4$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc9_:uint = 0;
         var _loc12_:uint = 0;
         var _loc5_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc11_:uint = 0;
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.uuid cannot be set twice.");
                  }
                  _loc9_++;
                  uuid = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 1:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.templateId cannot be set twice.");
                  }
                  _loc12_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.templateType cannot be set twice.");
                  }
                  _loc5_++;
                  templateType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.templateCount cannot be set twice.");
                  }
                  _loc10_++;
                  templateCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.templateShow cannot be set twice.");
                  }
                  _loc8_++;
                  templateShow = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.isBind cannot be set twice.");
                  }
                  _loc4_++;
                  isBind = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.isNotice cannot be set twice.");
                  }
                  _loc6_++;
                  isNotice = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.remain1 cannot be set twice.");
                  }
                  _loc11_++;
                  remain1 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.remain2 cannot be set twice.");
                  }
                  _loc7_++;
                  remain2 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.remain3 cannot be set twice.");
                  }
                  _loc3_++;
                  remain3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 10:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: ActiveAwardTemplatePB.remain4 cannot be set twice.");
                  }
                  _loc14_++;
                  remain4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

