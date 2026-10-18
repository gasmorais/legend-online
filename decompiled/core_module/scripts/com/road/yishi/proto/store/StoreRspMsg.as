package com.road.yishi.proto.store
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class StoreRspMsg extends Message implements IExternalizable
   {
      
      private var compose_result$field:Boolean;
      
      private var hasField$0:uint = 0;
      
      private var compose_templateId$field:int;
      
      private var streng_result$field:Boolean;
      
      private var strengthenGrade$field:int;
      
      private var pos$field:int;
      
      private var objectId$field:int;
      
      private var bagType$field:int;
      
      private var strBlessValue$field:int;
      
      private var gp$field:int;
      
      public function StoreRspMsg()
      {
         super();
      }
      
      public function removeComposeResult() : void
      {
         hasField$0 &= 4294967294;
         compose_result$field = new Boolean();
      }
      
      public function get hasComposeResult() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set composeResult(param1:Boolean) : void
      {
         hasField$0 |= 1;
         compose_result$field = param1;
      }
      
      public function get composeResult() : Boolean
      {
         return compose_result$field;
      }
      
      public function removeComposeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         compose_templateId$field = new int();
      }
      
      public function get hasComposeTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set composeTemplateId(param1:int) : void
      {
         hasField$0 |= 2;
         compose_templateId$field = param1;
      }
      
      public function get composeTemplateId() : int
      {
         return compose_templateId$field;
      }
      
      public function removeStrengResult() : void
      {
         hasField$0 &= 4294967291;
         streng_result$field = new Boolean();
      }
      
      public function get hasStrengResult() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set strengResult(param1:Boolean) : void
      {
         hasField$0 |= 4;
         streng_result$field = param1;
      }
      
      public function get strengResult() : Boolean
      {
         return streng_result$field;
      }
      
      public function removeStrengthenGrade() : void
      {
         hasField$0 &= 4294967287;
         strengthenGrade$field = new int();
      }
      
      public function get hasStrengthenGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set strengthenGrade(param1:int) : void
      {
         hasField$0 |= 8;
         strengthenGrade$field = param1;
      }
      
      public function get strengthenGrade() : int
      {
         return strengthenGrade$field;
      }
      
      public function removePos() : void
      {
         hasField$0 &= 4294967279;
         pos$field = new int();
      }
      
      public function get hasPos() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set pos(param1:int) : void
      {
         hasField$0 |= 16;
         pos$field = param1;
      }
      
      public function get pos() : int
      {
         return pos$field;
      }
      
      public function removeObjectId() : void
      {
         hasField$0 &= 4294967263;
         objectId$field = new int();
      }
      
      public function get hasObjectId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set objectId(param1:int) : void
      {
         hasField$0 |= 32;
         objectId$field = param1;
      }
      
      public function get objectId() : int
      {
         return objectId$field;
      }
      
      public function removeBagType() : void
      {
         hasField$0 &= 4294967231;
         bagType$field = new int();
      }
      
      public function get hasBagType() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set bagType(param1:int) : void
      {
         hasField$0 |= 64;
         bagType$field = param1;
      }
      
      public function get bagType() : int
      {
         return bagType$field;
      }
      
      public function removeStrBlessValue() : void
      {
         hasField$0 &= 4294967167;
         strBlessValue$field = new int();
      }
      
      public function get hasStrBlessValue() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set strBlessValue(param1:int) : void
      {
         hasField$0 |= 128;
         strBlessValue$field = param1;
      }
      
      public function get strBlessValue() : int
      {
         return strBlessValue$field;
      }
      
      public function removeGp() : void
      {
         hasField$0 &= 4294967039;
         gp$field = new int();
      }
      
      public function get hasGp() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set gp(param1:int) : void
      {
         hasField$0 |= 256;
         gp$field = param1;
      }
      
      public function get gp() : int
      {
         return gp$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasComposeResult)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_BOOL(param1,compose_result$field);
         }
         if(hasComposeTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,compose_templateId$field);
         }
         if(hasStrengResult)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,streng_result$field);
         }
         if(hasStrengthenGrade)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,strengthenGrade$field);
         }
         if(hasPos)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,pos$field);
         }
         if(hasObjectId)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,objectId$field);
         }
         if(hasBagType)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,bagType$field);
         }
         if(hasStrBlessValue)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,strBlessValue$field);
         }
         if(hasGp)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,gp$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:* = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc10_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.composeResult cannot be set twice.");
                  }
                  _loc5_++;
                  composeResult = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.composeTemplateId cannot be set twice.");
                  }
                  _loc6_++;
                  composeTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.strengResult cannot be set twice.");
                  }
                  _loc3_++;
                  strengResult = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.strengthenGrade cannot be set twice.");
                  }
                  _loc11_++;
                  strengthenGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.pos cannot be set twice.");
                  }
                  _loc8_++;
                  pos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.objectId cannot be set twice.");
                  }
                  _loc9_++;
                  objectId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.bagType cannot be set twice.");
                  }
                  _loc4_++;
                  bagType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.strBlessValue cannot be set twice.");
                  }
                  _loc7_++;
                  strBlessValue = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: StoreRspMsg.gp cannot be set twice.");
                  }
                  _loc12_++;
                  gp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
            }
         }
      }
   }
}

