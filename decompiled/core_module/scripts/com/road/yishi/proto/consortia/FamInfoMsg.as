package com.road.yishi.proto.consortia
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class FamInfoMsg extends Message implements IExternalizable
   {
      
      private var consortiaId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var tree_grades$field:int;
      
      private var tree_gp$field:int;
      
      private var tree_waterCount$field:int;
      
      private var tree_state$field:int;
      
      private var person_num$field:int;
      
      private var rate$field:Number;
      
      private var opreate$field:int;
      
      private var state$field:int;
      
      private var count_down$field:int;
      
      private var collect_rate$field:Number;
      
      public function FamInfoMsg()
      {
         super();
      }
      
      public function removeConsortiaId() : void
      {
         hasField$0 &= 4294967294;
         consortiaId$field = new int();
      }
      
      public function get hasConsortiaId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set consortiaId(param1:int) : void
      {
         hasField$0 |= 1;
         consortiaId$field = param1;
      }
      
      public function get consortiaId() : int
      {
         return consortiaId$field;
      }
      
      public function removeTreeGrades() : void
      {
         hasField$0 &= 4294967293;
         tree_grades$field = new int();
      }
      
      public function get hasTreeGrades() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set treeGrades(param1:int) : void
      {
         hasField$0 |= 2;
         tree_grades$field = param1;
      }
      
      public function get treeGrades() : int
      {
         return tree_grades$field;
      }
      
      public function removeTreeGp() : void
      {
         hasField$0 &= 4294967291;
         tree_gp$field = new int();
      }
      
      public function get hasTreeGp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set treeGp(param1:int) : void
      {
         hasField$0 |= 4;
         tree_gp$field = param1;
      }
      
      public function get treeGp() : int
      {
         return tree_gp$field;
      }
      
      public function removeTreeWaterCount() : void
      {
         hasField$0 &= 4294967287;
         tree_waterCount$field = new int();
      }
      
      public function get hasTreeWaterCount() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set treeWaterCount(param1:int) : void
      {
         hasField$0 |= 8;
         tree_waterCount$field = param1;
      }
      
      public function get treeWaterCount() : int
      {
         return tree_waterCount$field;
      }
      
      public function removeTreeState() : void
      {
         hasField$0 &= 4294967279;
         tree_state$field = new int();
      }
      
      public function get hasTreeState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set treeState(param1:int) : void
      {
         hasField$0 |= 16;
         tree_state$field = param1;
      }
      
      public function get treeState() : int
      {
         return tree_state$field;
      }
      
      public function removePersonNum() : void
      {
         hasField$0 &= 4294967263;
         person_num$field = new int();
      }
      
      public function get hasPersonNum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set personNum(param1:int) : void
      {
         hasField$0 |= 32;
         person_num$field = param1;
      }
      
      public function get personNum() : int
      {
         return person_num$field;
      }
      
      public function removeRate() : void
      {
         hasField$0 &= 4294967231;
         rate$field = new Number();
      }
      
      public function get hasRate() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set rate(param1:Number) : void
      {
         hasField$0 |= 64;
         rate$field = param1;
      }
      
      public function get rate() : Number
      {
         return rate$field;
      }
      
      public function removeOpreate() : void
      {
         hasField$0 &= 4294967167;
         opreate$field = new int();
      }
      
      public function get hasOpreate() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set opreate(param1:int) : void
      {
         hasField$0 |= 128;
         opreate$field = param1;
      }
      
      public function get opreate() : int
      {
         return opreate$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967039;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 256;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294966783;
         count_down$field = new int();
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set countDown(param1:int) : void
      {
         hasField$0 |= 512;
         count_down$field = param1;
      }
      
      public function get countDown() : int
      {
         return count_down$field;
      }
      
      public function removeCollectRate() : void
      {
         hasField$0 &= 4294966271;
         collect_rate$field = new Number();
      }
      
      public function get hasCollectRate() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set collectRate(param1:Number) : void
      {
         hasField$0 |= 1024;
         collect_rate$field = param1;
      }
      
      public function get collectRate() : Number
      {
         return collect_rate$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasConsortiaId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,consortiaId$field);
         }
         if(hasTreeGrades)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,tree_grades$field);
         }
         if(hasTreeGp)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,tree_gp$field);
         }
         if(hasTreeWaterCount)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,tree_waterCount$field);
         }
         if(hasTreeState)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,tree_state$field);
         }
         if(hasPersonNum)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,person_num$field);
         }
         if(hasRate)
         {
            WriteUtils.writeTag(param1,5,7);
            WriteUtils.write$TYPE_FLOAT(param1,rate$field);
         }
         if(hasOpreate)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,opreate$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,count_down$field);
         }
         if(hasCollectRate)
         {
            WriteUtils.writeTag(param1,5,11);
            WriteUtils.write$TYPE_FLOAT(param1,collect_rate$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:* = 0;
         var _loc7_:uint = 0;
         var _loc14_:uint = 0;
         var _loc4_:uint = 0;
         var _loc9_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc13_:uint = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc12_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.consortiaId cannot be set twice.");
                  }
                  _loc7_++;
                  consortiaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.treeGrades cannot be set twice.");
                  }
                  _loc14_++;
                  treeGrades = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.treeGp cannot be set twice.");
                  }
                  _loc4_++;
                  treeGp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.treeWaterCount cannot be set twice.");
                  }
                  _loc9_++;
                  treeWaterCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.treeState cannot be set twice.");
                  }
                  _loc5_++;
                  treeState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.personNum cannot be set twice.");
                  }
                  _loc11_++;
                  personNum = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.rate cannot be set twice.");
                  }
                  _loc13_++;
                  rate = ReadUtils.read$TYPE_FLOAT(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.opreate cannot be set twice.");
                  }
                  _loc8_++;
                  opreate = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.state cannot be set twice.");
                  }
                  _loc10_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.countDown cannot be set twice.");
                  }
                  _loc3_++;
                  countDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: FamInfoMsg.collectRate cannot be set twice.");
                  }
                  _loc6_++;
                  collectRate = ReadUtils.read$TYPE_FLOAT(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
            }
         }
      }
   }
}

