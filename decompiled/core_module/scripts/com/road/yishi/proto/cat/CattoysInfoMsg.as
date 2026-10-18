package com.road.yishi.proto.cat
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CattoysInfoMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var templateId$field:int;
      
      private var rotatePos$field:int;
      
      private var state$field:int;
      
      private var profitState$field:int;
      
      private var count$field:int;
      
      private var num$field:int;
      
      private var isExist$field:Boolean;
      
      private var catTemplateId$field:int;
      
      private var catTemplateId1$field:int;
      
      private var catTemplateId2$field:int;
      
      private var catTemplateId3$field:int;
      
      private var catTemplateId4$field:int;
      
      private var op$field:int;
      
      private var posX$field:int;
      
      private var posY$field:int;
      
      private var cdTime$field:Int64;
      
      private var payType$field:int;
      
      public function CattoysInfoMsg()
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
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967293;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 2;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeRotatePos() : void
      {
         hasField$0 &= 4294967291;
         rotatePos$field = new int();
      }
      
      public function get hasRotatePos() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set rotatePos(param1:int) : void
      {
         hasField$0 |= 4;
         rotatePos$field = param1;
      }
      
      public function get rotatePos() : int
      {
         return rotatePos$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967287;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 8;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeProfitState() : void
      {
         hasField$0 &= 4294967279;
         profitState$field = new int();
      }
      
      public function get hasProfitState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set profitState(param1:int) : void
      {
         hasField$0 |= 16;
         profitState$field = param1;
      }
      
      public function get profitState() : int
      {
         return profitState$field;
      }
      
      public function removeCount() : void
      {
         hasField$0 &= 4294967263;
         count$field = new int();
      }
      
      public function get hasCount() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set count(param1:int) : void
      {
         hasField$0 |= 32;
         count$field = param1;
      }
      
      public function get count() : int
      {
         return count$field;
      }
      
      public function removeNum() : void
      {
         hasField$0 &= 4294967231;
         num$field = new int();
      }
      
      public function get hasNum() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set num(param1:int) : void
      {
         hasField$0 |= 64;
         num$field = param1;
      }
      
      public function get num() : int
      {
         return num$field;
      }
      
      public function removeIsExist() : void
      {
         hasField$0 &= 4294967167;
         isExist$field = new Boolean();
      }
      
      public function get hasIsExist() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set isExist(param1:Boolean) : void
      {
         hasField$0 |= 128;
         isExist$field = param1;
      }
      
      public function get isExist() : Boolean
      {
         return isExist$field;
      }
      
      public function removeCatTemplateId() : void
      {
         hasField$0 &= 4294967039;
         catTemplateId$field = new int();
      }
      
      public function get hasCatTemplateId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set catTemplateId(param1:int) : void
      {
         hasField$0 |= 256;
         catTemplateId$field = param1;
      }
      
      public function get catTemplateId() : int
      {
         return catTemplateId$field;
      }
      
      public function removeCatTemplateId1() : void
      {
         hasField$0 &= 4294966783;
         catTemplateId1$field = new int();
      }
      
      public function get hasCatTemplateId1() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set catTemplateId1(param1:int) : void
      {
         hasField$0 |= 512;
         catTemplateId1$field = param1;
      }
      
      public function get catTemplateId1() : int
      {
         return catTemplateId1$field;
      }
      
      public function removeCatTemplateId2() : void
      {
         hasField$0 &= 4294966271;
         catTemplateId2$field = new int();
      }
      
      public function get hasCatTemplateId2() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set catTemplateId2(param1:int) : void
      {
         hasField$0 |= 1024;
         catTemplateId2$field = param1;
      }
      
      public function get catTemplateId2() : int
      {
         return catTemplateId2$field;
      }
      
      public function removeCatTemplateId3() : void
      {
         hasField$0 &= 4294965247;
         catTemplateId3$field = new int();
      }
      
      public function get hasCatTemplateId3() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set catTemplateId3(param1:int) : void
      {
         hasField$0 |= 2048;
         catTemplateId3$field = param1;
      }
      
      public function get catTemplateId3() : int
      {
         return catTemplateId3$field;
      }
      
      public function removeCatTemplateId4() : void
      {
         hasField$0 &= 4294963199;
         catTemplateId4$field = new int();
      }
      
      public function get hasCatTemplateId4() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set catTemplateId4(param1:int) : void
      {
         hasField$0 |= 4096;
         catTemplateId4$field = param1;
      }
      
      public function get catTemplateId4() : int
      {
         return catTemplateId4$field;
      }
      
      public function removeOp() : void
      {
         hasField$0 &= 4294959103;
         op$field = new int();
      }
      
      public function get hasOp() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set op(param1:int) : void
      {
         hasField$0 |= 8192;
         op$field = param1;
      }
      
      public function get op() : int
      {
         return op$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294950911;
         posX$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 16384;
         posX$field = param1;
      }
      
      public function get posX() : int
      {
         return posX$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294934527;
         posY$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 32768;
         posY$field = param1;
      }
      
      public function get posY() : int
      {
         return posY$field;
      }
      
      public function removeCdTime() : void
      {
         cdTime$field = null;
      }
      
      public function get hasCdTime() : Boolean
      {
         return cdTime$field != null;
      }
      
      public function set cdTime(param1:Int64) : void
      {
         cdTime$field = param1;
      }
      
      public function get cdTime() : Int64
      {
         return cdTime$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294901759;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 65536;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasRotatePos)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,rotatePos$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasProfitState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,profitState$field);
         }
         if(hasCount)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,count$field);
         }
         if(hasNum)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,num$field);
         }
         if(hasIsExist)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isExist$field);
         }
         if(hasCatTemplateId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId$field);
         }
         if(hasCatTemplateId1)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId1$field);
         }
         if(hasCatTemplateId2)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId2$field);
         }
         if(hasCatTemplateId3)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId3$field);
         }
         if(hasCatTemplateId4)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,catTemplateId4$field);
         }
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,op$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,posX$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,posY$field);
         }
         if(hasCdTime)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT64(param1,cdTime$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc13_:uint = 0;
         var _loc16_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc20_:uint = 0;
         var _loc5_:uint = 0;
         var _loc17_:uint = 0;
         var _loc21_:uint = 0;
         var _loc9_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc19_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc15_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.id cannot be set twice.");
                  }
                  _loc7_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.templateId cannot be set twice.");
                  }
                  _loc8_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.rotatePos cannot be set twice.");
                  }
                  _loc13_++;
                  rotatePos = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.state cannot be set twice.");
                  }
                  _loc16_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.profitState cannot be set twice.");
                  }
                  _loc12_++;
                  profitState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.count cannot be set twice.");
                  }
                  _loc4_++;
                  count = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.num cannot be set twice.");
                  }
                  _loc20_++;
                  num = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.isExist cannot be set twice.");
                  }
                  _loc5_++;
                  isExist = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.catTemplateId cannot be set twice.");
                  }
                  _loc17_++;
                  catTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.catTemplateId1 cannot be set twice.");
                  }
                  _loc21_++;
                  catTemplateId1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.catTemplateId2 cannot be set twice.");
                  }
                  _loc9_++;
                  catTemplateId2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.catTemplateId3 cannot be set twice.");
                  }
                  _loc11_++;
                  catTemplateId3 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.catTemplateId4 cannot be set twice.");
                  }
                  _loc14_++;
                  catTemplateId4 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.op cannot be set twice.");
                  }
                  _loc19_++;
                  op = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.posX cannot be set twice.");
                  }
                  _loc3_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.posY cannot be set twice.");
                  }
                  _loc6_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.cdTime cannot be set twice.");
                  }
                  _loc10_++;
                  cdTime = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 17:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CattoysInfoMsg.payType cannot be set twice.");
                  }
                  _loc15_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

