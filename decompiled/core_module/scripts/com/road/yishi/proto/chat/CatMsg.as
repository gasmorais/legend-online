package com.road.yishi.proto.chat
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CatMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var userId$field:int;
      
      private var templateId$field:int;
      
      private var rotatePos$field:int;
      
      private var state$field:int;
      
      private var cdTime$field:String;
      
      private var catTemplateId$field:int;
      
      private var catTemplateId1$field:int;
      
      private var catTemplateId2$field:int;
      
      private var catTemplateId3$field:int;
      
      private var catTemplateId4$field:int;
      
      private var profitState$field:Boolean;
      
      private var useCount$field:int;
      
      private var num$field:int;
      
      public function CatMsg()
      {
         super();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new int();
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set id(param1:int) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function get id() : int
      {
         return id$field;
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967291;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 4;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeRotatePos() : void
      {
         hasField$0 &= 4294967287;
         rotatePos$field = new int();
      }
      
      public function get hasRotatePos() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set rotatePos(param1:int) : void
      {
         hasField$0 |= 8;
         rotatePos$field = param1;
      }
      
      public function get rotatePos() : int
      {
         return rotatePos$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeCdTime() : void
      {
         cdTime$field = null;
      }
      
      public function get hasCdTime() : Boolean
      {
         return cdTime$field != null;
      }
      
      public function set cdTime(param1:String) : void
      {
         cdTime$field = param1;
      }
      
      public function get cdTime() : String
      {
         return cdTime$field;
      }
      
      public function removeCatTemplateId() : void
      {
         hasField$0 &= 4294967263;
         catTemplateId$field = new int();
      }
      
      public function get hasCatTemplateId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set catTemplateId(param1:int) : void
      {
         hasField$0 |= 32;
         catTemplateId$field = param1;
      }
      
      public function get catTemplateId() : int
      {
         return catTemplateId$field;
      }
      
      public function removeCatTemplateId1() : void
      {
         hasField$0 &= 4294967231;
         catTemplateId1$field = new int();
      }
      
      public function get hasCatTemplateId1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set catTemplateId1(param1:int) : void
      {
         hasField$0 |= 64;
         catTemplateId1$field = param1;
      }
      
      public function get catTemplateId1() : int
      {
         return catTemplateId1$field;
      }
      
      public function removeCatTemplateId2() : void
      {
         hasField$0 &= 4294967167;
         catTemplateId2$field = new int();
      }
      
      public function get hasCatTemplateId2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set catTemplateId2(param1:int) : void
      {
         hasField$0 |= 128;
         catTemplateId2$field = param1;
      }
      
      public function get catTemplateId2() : int
      {
         return catTemplateId2$field;
      }
      
      public function removeCatTemplateId3() : void
      {
         hasField$0 &= 4294967039;
         catTemplateId3$field = new int();
      }
      
      public function get hasCatTemplateId3() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set catTemplateId3(param1:int) : void
      {
         hasField$0 |= 256;
         catTemplateId3$field = param1;
      }
      
      public function get catTemplateId3() : int
      {
         return catTemplateId3$field;
      }
      
      public function removeCatTemplateId4() : void
      {
         hasField$0 &= 4294966783;
         catTemplateId4$field = new int();
      }
      
      public function get hasCatTemplateId4() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set catTemplateId4(param1:int) : void
      {
         hasField$0 |= 512;
         catTemplateId4$field = param1;
      }
      
      public function get catTemplateId4() : int
      {
         return catTemplateId4$field;
      }
      
      public function removeProfitState() : void
      {
         hasField$0 &= 4294966271;
         profitState$field = new Boolean();
      }
      
      public function get hasProfitState() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set profitState(param1:Boolean) : void
      {
         hasField$0 |= 1024;
         profitState$field = param1;
      }
      
      public function get profitState() : Boolean
      {
         return profitState$field;
      }
      
      public function removeUseCount() : void
      {
         hasField$0 &= 4294965247;
         useCount$field = new int();
      }
      
      public function get hasUseCount() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set useCount(param1:int) : void
      {
         hasField$0 |= 2048;
         useCount$field = param1;
      }
      
      public function get useCount() : int
      {
         return useCount$field;
      }
      
      public function removeNum() : void
      {
         hasField$0 &= 4294963199;
         num$field = new int();
      }
      
      public function get hasNum() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set num(param1:int) : void
      {
         hasField$0 |= 4096;
         num$field = param1;
      }
      
      public function get num() : int
      {
         return num$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasRotatePos)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,rotatePos$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,cdTime$field);
         }
         if(hasCatTemplateId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId$field);
         }
         if(hasCatTemplateId1)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId1$field);
         }
         if(hasCatTemplateId2)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId2$field);
         }
         if(hasCatTemplateId3)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId3$field);
         }
         if(hasCatTemplateId4)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId4$field);
         }
         if(hasProfitState)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_BOOL(param1,profitState$field);
         }
         if(hasUseCount)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,useCount$field);
         }
         if(hasNum)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,num$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc15_:* = 0;
         var _loc4_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc16_:uint = 0;
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc15_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.userId cannot be set twice.");
                  }
                  _loc10_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.templateId cannot be set twice.");
                  }
                  _loc5_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.rotatePos cannot be set twice.");
                  }
                  _loc11_++;
                  rotatePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.state cannot be set twice.");
                  }
                  _loc13_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.cdTime cannot be set twice.");
                  }
                  _loc7_++;
                  cdTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.catTemplateId cannot be set twice.");
                  }
                  _loc14_++;
                  catTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.catTemplateId1 cannot be set twice.");
                  }
                  _loc16_++;
                  catTemplateId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.catTemplateId2 cannot be set twice.");
                  }
                  _loc6_++;
                  catTemplateId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.catTemplateId3 cannot be set twice.");
                  }
                  _loc8_++;
                  catTemplateId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.catTemplateId4 cannot be set twice.");
                  }
                  _loc12_++;
                  catTemplateId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.profitState cannot be set twice.");
                  }
                  _loc9_++;
                  profitState = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 12:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.useCount cannot be set twice.");
                  }
                  _loc3_++;
                  useCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CatMsg.num cannot be set twice.");
                  }
                  _loc17_++;
                  num = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc15_ & 7);
            }
         }
      }
   }
}

