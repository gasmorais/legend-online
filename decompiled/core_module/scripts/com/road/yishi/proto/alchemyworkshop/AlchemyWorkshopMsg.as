package com.road.yishi.proto.alchemyworkshop
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class AlchemyWorkshopMsg extends Message implements IExternalizable
   {
      
      private var op$field:int;
      
      private var hasField$0:uint = 0;
      
      private var opResult$field:int;
      
      private var mineId$field:int;
      
      private var formulaId$field:int;
      
      private var shareUid$field:int;
      
      private var isAddCatalyst$field:Boolean;
      
      private var childIndex$field:int;
      
      private var payType$field:int;
      
      private var speedTimes$field:int;
      
      private var score$field:int;
      
      private var cycleScore$field:int;
      
      [ArrayElementType("com.road.yishi.proto.alchemyworkshop.MineMsg")]
      public var mine:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.alchemyworkshop.SharedFormulaMsg")]
      public var sharedFormula:Array = [];
      
      [ArrayElementType("com.road.yishi.proto.alchemyworkshop.AlchemyItem")]
      public var alchemyItem:Array = [];
      
      public function AlchemyWorkshopMsg()
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
      
      public function removeOpResult() : void
      {
         hasField$0 &= 4294967293;
         opResult$field = new int();
      }
      
      public function get hasOpResult() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set opResult(param1:int) : void
      {
         hasField$0 |= 2;
         opResult$field = param1;
      }
      
      public function get opResult() : int
      {
         return opResult$field;
      }
      
      public function removeMineId() : void
      {
         hasField$0 &= 4294967291;
         mineId$field = new int();
      }
      
      public function get hasMineId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set mineId(param1:int) : void
      {
         hasField$0 |= 4;
         mineId$field = param1;
      }
      
      public function get mineId() : int
      {
         return mineId$field;
      }
      
      public function removeFormulaId() : void
      {
         hasField$0 &= 4294967287;
         formulaId$field = new int();
      }
      
      public function get hasFormulaId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set formulaId(param1:int) : void
      {
         hasField$0 |= 8;
         formulaId$field = param1;
      }
      
      public function get formulaId() : int
      {
         return formulaId$field;
      }
      
      public function removeShareUid() : void
      {
         hasField$0 &= 4294967279;
         shareUid$field = new int();
      }
      
      public function get hasShareUid() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set shareUid(param1:int) : void
      {
         hasField$0 |= 16;
         shareUid$field = param1;
      }
      
      public function get shareUid() : int
      {
         return shareUid$field;
      }
      
      public function removeIsAddCatalyst() : void
      {
         hasField$0 &= 4294967263;
         isAddCatalyst$field = new Boolean();
      }
      
      public function get hasIsAddCatalyst() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set isAddCatalyst(param1:Boolean) : void
      {
         hasField$0 |= 32;
         isAddCatalyst$field = param1;
      }
      
      public function get isAddCatalyst() : Boolean
      {
         return isAddCatalyst$field;
      }
      
      public function removeChildIndex() : void
      {
         hasField$0 &= 4294967231;
         childIndex$field = new int();
      }
      
      public function get hasChildIndex() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set childIndex(param1:int) : void
      {
         hasField$0 |= 64;
         childIndex$field = param1;
      }
      
      public function get childIndex() : int
      {
         return childIndex$field;
      }
      
      public function removePayType() : void
      {
         hasField$0 &= 4294967167;
         payType$field = new int();
      }
      
      public function get hasPayType() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set payType(param1:int) : void
      {
         hasField$0 |= 128;
         payType$field = param1;
      }
      
      public function get payType() : int
      {
         return payType$field;
      }
      
      public function removeSpeedTimes() : void
      {
         hasField$0 &= 4294967039;
         speedTimes$field = new int();
      }
      
      public function get hasSpeedTimes() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set speedTimes(param1:int) : void
      {
         hasField$0 |= 256;
         speedTimes$field = param1;
      }
      
      public function get speedTimes() : int
      {
         return speedTimes$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294966783;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 512;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeCycleScore() : void
      {
         hasField$0 &= 4294966271;
         cycleScore$field = new int();
      }
      
      public function get hasCycleScore() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set cycleScore(param1:int) : void
      {
         hasField$0 |= 1024;
         cycleScore$field = param1;
      }
      
      public function get cycleScore() : int
      {
         return cycleScore$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = 0;
         var _loc4_:* = 0;
         if(hasOp)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_ENUM(param1,op$field);
         }
         if(hasOpResult)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_ENUM(param1,opResult$field);
         }
         if(hasMineId)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,mineId$field);
         }
         if(hasFormulaId)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,formulaId$field);
         }
         if(hasShareUid)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,shareUid$field);
         }
         if(hasIsAddCatalyst)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_BOOL(param1,isAddCatalyst$field);
         }
         if(hasChildIndex)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,childIndex$field);
         }
         if(hasPayType)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,payType$field);
         }
         if(hasSpeedTimes)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,speedTimes$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasCycleScore)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,cycleScore$field);
         }
         _loc3_ = 0;
         while(_loc3_ < mine.length)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_MESSAGE(param1,mine[_loc3_]);
            _loc3_++;
         }
         _loc2_ = 0;
         while(_loc2_ < sharedFormula.length)
         {
            WriteUtils.writeTag(param1,2,13);
            WriteUtils.write$TYPE_MESSAGE(param1,sharedFormula[_loc2_]);
            _loc2_++;
         }
         _loc4_ = 0;
         while(_loc4_ < alchemyItem.length)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_MESSAGE(param1,alchemyItem[_loc4_]);
            _loc4_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:* = 0;
         var _loc8_:MineMsg = null;
         var _loc7_:SharedFormulaMsg = null;
         var _loc4_:AlchemyItem = null;
         var _loc16_:uint = 0;
         var _loc5_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc11_:uint = 0;
         var _loc6_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc9_:uint = 0;
         var _loc15_:uint = 0;
         var _loc17_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc14_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.op cannot be set twice.");
                  }
                  _loc16_++;
                  op = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 1:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.opResult cannot be set twice.");
                  }
                  _loc5_++;
                  opResult = ReadUtils.read$TYPE_ENUM(param1);
                  break;
               case 2:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.mineId cannot be set twice.");
                  }
                  _loc3_++;
                  mineId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.formulaId cannot be set twice.");
                  }
                  _loc12_++;
                  formulaId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.shareUid cannot be set twice.");
                  }
                  _loc11_++;
                  shareUid = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.isAddCatalyst cannot be set twice.");
                  }
                  _loc6_++;
                  isAddCatalyst = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.childIndex cannot be set twice.");
                  }
                  _loc10_++;
                  childIndex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.payType cannot be set twice.");
                  }
                  _loc13_++;
                  payType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.speedTimes cannot be set twice.");
                  }
                  _loc9_++;
                  speedTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.score cannot be set twice.");
                  }
                  _loc15_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: AlchemyWorkshopMsg.cycleScore cannot be set twice.");
                  }
                  _loc17_++;
                  cycleScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  _loc8_ = new MineMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  mine.push(_loc8_);
                  break;
               case 12:
                  _loc7_ = new SharedFormulaMsg();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  sharedFormula.push(_loc7_);
                  break;
               case 13:
                  _loc4_ = new AlchemyItem();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  alchemyItem.push(_loc4_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
            }
         }
      }
   }
}

