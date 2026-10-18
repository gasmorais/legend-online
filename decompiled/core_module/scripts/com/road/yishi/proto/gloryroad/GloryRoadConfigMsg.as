package com.road.yishi.proto.gloryroad
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GloryRoadConfigMsg extends Message implements IExternalizable
   {
      
      private var baseScore$field:int;
      
      private var hasField$0:uint = 0;
      
      private var baseGloryScore$field:int;
      
      private var baseBuffStar$field:int;
      
      private var resurgenceTimes$field:int;
      
      private var resetTimes$field:int;
      
      private var openBoxTimes$field:int;
      
      private var openBoxPoint$field:int;
      
      private var resurgencePoint$field:int;
      
      private var resurgenceChildPoint$field:int;
      
      private var normalFactor$field:Number;
      
      private var nightmareFactor$field:Number;
      
      private var hellFactor$field:Number;
      
      public function GloryRoadConfigMsg()
      {
         super();
      }
      
      public function removeBaseScore() : void
      {
         hasField$0 &= 4294967294;
         baseScore$field = new int();
      }
      
      public function get hasBaseScore() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set baseScore(param1:int) : void
      {
         hasField$0 |= 1;
         baseScore$field = param1;
      }
      
      public function get baseScore() : int
      {
         return baseScore$field;
      }
      
      public function removeBaseGloryScore() : void
      {
         hasField$0 &= 4294967293;
         baseGloryScore$field = new int();
      }
      
      public function get hasBaseGloryScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set baseGloryScore(param1:int) : void
      {
         hasField$0 |= 2;
         baseGloryScore$field = param1;
      }
      
      public function get baseGloryScore() : int
      {
         return baseGloryScore$field;
      }
      
      public function removeBaseBuffStar() : void
      {
         hasField$0 &= 4294967291;
         baseBuffStar$field = new int();
      }
      
      public function get hasBaseBuffStar() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set baseBuffStar(param1:int) : void
      {
         hasField$0 |= 4;
         baseBuffStar$field = param1;
      }
      
      public function get baseBuffStar() : int
      {
         return baseBuffStar$field;
      }
      
      public function removeResurgenceTimes() : void
      {
         hasField$0 &= 4294967287;
         resurgenceTimes$field = new int();
      }
      
      public function get hasResurgenceTimes() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set resurgenceTimes(param1:int) : void
      {
         hasField$0 |= 8;
         resurgenceTimes$field = param1;
      }
      
      public function get resurgenceTimes() : int
      {
         return resurgenceTimes$field;
      }
      
      public function removeResetTimes() : void
      {
         hasField$0 &= 4294967279;
         resetTimes$field = new int();
      }
      
      public function get hasResetTimes() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set resetTimes(param1:int) : void
      {
         hasField$0 |= 16;
         resetTimes$field = param1;
      }
      
      public function get resetTimes() : int
      {
         return resetTimes$field;
      }
      
      public function removeOpenBoxTimes() : void
      {
         hasField$0 &= 4294967263;
         openBoxTimes$field = new int();
      }
      
      public function get hasOpenBoxTimes() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set openBoxTimes(param1:int) : void
      {
         hasField$0 |= 32;
         openBoxTimes$field = param1;
      }
      
      public function get openBoxTimes() : int
      {
         return openBoxTimes$field;
      }
      
      public function removeOpenBoxPoint() : void
      {
         hasField$0 &= 4294967231;
         openBoxPoint$field = new int();
      }
      
      public function get hasOpenBoxPoint() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set openBoxPoint(param1:int) : void
      {
         hasField$0 |= 64;
         openBoxPoint$field = param1;
      }
      
      public function get openBoxPoint() : int
      {
         return openBoxPoint$field;
      }
      
      public function removeResurgencePoint() : void
      {
         hasField$0 &= 4294967167;
         resurgencePoint$field = new int();
      }
      
      public function get hasResurgencePoint() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set resurgencePoint(param1:int) : void
      {
         hasField$0 |= 128;
         resurgencePoint$field = param1;
      }
      
      public function get resurgencePoint() : int
      {
         return resurgencePoint$field;
      }
      
      public function removeResurgenceChildPoint() : void
      {
         hasField$0 &= 4294967039;
         resurgenceChildPoint$field = new int();
      }
      
      public function get hasResurgenceChildPoint() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set resurgenceChildPoint(param1:int) : void
      {
         hasField$0 |= 256;
         resurgenceChildPoint$field = param1;
      }
      
      public function get resurgenceChildPoint() : int
      {
         return resurgenceChildPoint$field;
      }
      
      public function removeNormalFactor() : void
      {
         hasField$0 &= 4294966783;
         normalFactor$field = new Number();
      }
      
      public function get hasNormalFactor() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set normalFactor(param1:Number) : void
      {
         hasField$0 |= 512;
         normalFactor$field = param1;
      }
      
      public function get normalFactor() : Number
      {
         return normalFactor$field;
      }
      
      public function removeNightmareFactor() : void
      {
         hasField$0 &= 4294966271;
         nightmareFactor$field = new Number();
      }
      
      public function get hasNightmareFactor() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set nightmareFactor(param1:Number) : void
      {
         hasField$0 |= 1024;
         nightmareFactor$field = param1;
      }
      
      public function get nightmareFactor() : Number
      {
         return nightmareFactor$field;
      }
      
      public function removeHellFactor() : void
      {
         hasField$0 &= 4294965247;
         hellFactor$field = new Number();
      }
      
      public function get hasHellFactor() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set hellFactor(param1:Number) : void
      {
         hasField$0 |= 2048;
         hellFactor$field = param1;
      }
      
      public function get hellFactor() : Number
      {
         return hellFactor$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBaseScore)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,baseScore$field);
         }
         if(hasBaseGloryScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,baseGloryScore$field);
         }
         if(hasBaseBuffStar)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,baseBuffStar$field);
         }
         if(hasResurgenceTimes)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,resurgenceTimes$field);
         }
         if(hasResetTimes)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,resetTimes$field);
         }
         if(hasOpenBoxTimes)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,openBoxTimes$field);
         }
         if(hasOpenBoxPoint)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,openBoxPoint$field);
         }
         if(hasResurgencePoint)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,resurgencePoint$field);
         }
         if(hasResurgenceChildPoint)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,resurgenceChildPoint$field);
         }
         if(hasNormalFactor)
         {
            WriteUtils.writeTag(param1,5,10);
            WriteUtils.write$TYPE_FLOAT(param1,normalFactor$field);
         }
         if(hasNightmareFactor)
         {
            WriteUtils.writeTag(param1,5,11);
            WriteUtils.write$TYPE_FLOAT(param1,nightmareFactor$field);
         }
         if(hasHellFactor)
         {
            WriteUtils.writeTag(param1,5,12);
            WriteUtils.write$TYPE_FLOAT(param1,hellFactor$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc3_:uint = 0;
         var _loc10_:uint = 0;
         var _loc8_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc4_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.baseScore cannot be set twice.");
                  }
                  _loc7_++;
                  baseScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.baseGloryScore cannot be set twice.");
                  }
                  _loc6_++;
                  baseGloryScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.baseBuffStar cannot be set twice.");
                  }
                  _loc5_++;
                  baseBuffStar = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.resurgenceTimes cannot be set twice.");
                  }
                  _loc11_++;
                  resurgenceTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.resetTimes cannot be set twice.");
                  }
                  _loc14_++;
                  resetTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.openBoxTimes cannot be set twice.");
                  }
                  _loc3_++;
                  openBoxTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.openBoxPoint cannot be set twice.");
                  }
                  _loc10_++;
                  openBoxPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.resurgencePoint cannot be set twice.");
                  }
                  _loc8_++;
                  resurgencePoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.resurgenceChildPoint cannot be set twice.");
                  }
                  _loc15_++;
                  resurgenceChildPoint = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.normalFactor cannot be set twice.");
                  }
                  _loc9_++;
                  normalFactor = ReadUtils.read$TYPE_FLOAT(param1);
                  break;
               case 10:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.nightmareFactor cannot be set twice.");
                  }
                  _loc4_++;
                  nightmareFactor = ReadUtils.read$TYPE_FLOAT(param1);
                  break;
               case 11:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GloryRoadConfigMsg.hellFactor cannot be set twice.");
                  }
                  _loc12_++;
                  hellFactor = ReadUtils.read$TYPE_FLOAT(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

