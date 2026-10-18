package com.road.yishi.proto.secretexplore
{
   import com.netease.protobuf.Int64;
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SecretExploreInfoRspMsg extends Message implements IExternalizable
   {
      
      private var mapId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var levelId$field:int;
      
      private var remainingTimes$field:int;
      
      private var fight$field:int;
      
      private var remainTime$field:String;
      
      private var hp$field:Int64;
      
      private var initHp$field:Int64;
      
      private var isFirst$field:Boolean;
      
      private var passMapId$field:int;
      
      public function SecretExploreInfoRspMsg()
      {
         super();
      }
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967294;
         mapId$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 1;
         mapId$field = param1;
      }
      
      public function get mapId() : int
      {
         return mapId$field;
      }
      
      public function removeLevelId() : void
      {
         hasField$0 &= 4294967293;
         levelId$field = new int();
      }
      
      public function get hasLevelId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set levelId(param1:int) : void
      {
         hasField$0 |= 2;
         levelId$field = param1;
      }
      
      public function get levelId() : int
      {
         return levelId$field;
      }
      
      public function removeRemainingTimes() : void
      {
         hasField$0 &= 4294967291;
         remainingTimes$field = new int();
      }
      
      public function get hasRemainingTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set remainingTimes(param1:int) : void
      {
         hasField$0 |= 4;
         remainingTimes$field = param1;
      }
      
      public function get remainingTimes() : int
      {
         return remainingTimes$field;
      }
      
      public function removeFight() : void
      {
         hasField$0 &= 4294967287;
         fight$field = new int();
      }
      
      public function get hasFight() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set fight(param1:int) : void
      {
         hasField$0 |= 8;
         fight$field = param1;
      }
      
      public function get fight() : int
      {
         return fight$field;
      }
      
      public function removeRemainTime() : void
      {
         remainTime$field = null;
      }
      
      public function get hasRemainTime() : Boolean
      {
         return remainTime$field != null;
      }
      
      public function set remainTime(param1:String) : void
      {
         remainTime$field = param1;
      }
      
      public function get remainTime() : String
      {
         return remainTime$field;
      }
      
      public function removeHp() : void
      {
         hp$field = null;
      }
      
      public function get hasHp() : Boolean
      {
         return hp$field != null;
      }
      
      public function set hp(param1:Int64) : void
      {
         hp$field = param1;
      }
      
      public function get hp() : Int64
      {
         return hp$field;
      }
      
      public function removeInitHp() : void
      {
         initHp$field = null;
      }
      
      public function get hasInitHp() : Boolean
      {
         return initHp$field != null;
      }
      
      public function set initHp(param1:Int64) : void
      {
         initHp$field = param1;
      }
      
      public function get initHp() : Int64
      {
         return initHp$field;
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967279;
         isFirst$field = new Boolean();
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isFirst(param1:Boolean) : void
      {
         hasField$0 |= 16;
         isFirst$field = param1;
      }
      
      public function get isFirst() : Boolean
      {
         return isFirst$field;
      }
      
      public function removePassMapId() : void
      {
         hasField$0 &= 4294967263;
         passMapId$field = new int();
      }
      
      public function get hasPassMapId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set passMapId(param1:int) : void
      {
         hasField$0 |= 32;
         passMapId$field = param1;
      }
      
      public function get passMapId() : int
      {
         return passMapId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,mapId$field);
         }
         if(hasLevelId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,levelId$field);
         }
         if(hasRemainingTimes)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,remainingTimes$field);
         }
         if(hasFight)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,fight$field);
         }
         if(hasRemainTime)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,remainTime$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT64(param1,hp$field);
         }
         if(hasInitHp)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT64(param1,initHp$field);
         }
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,isFirst$field);
         }
         if(hasPassMapId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,passMapId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:* = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc4_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc5_:uint = 0;
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc9_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.mapId cannot be set twice.");
                  }
                  _loc10_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.levelId cannot be set twice.");
                  }
                  _loc3_++;
                  levelId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.remainingTimes cannot be set twice.");
                  }
                  _loc12_++;
                  remainingTimes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.fight cannot be set twice.");
                  }
                  _loc4_++;
                  fight = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.remainTime cannot be set twice.");
                  }
                  _loc6_++;
                  remainTime = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.hp cannot be set twice.");
                  }
                  _loc7_++;
                  hp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 6:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.initHp cannot be set twice.");
                  }
                  _loc5_++;
                  initHp = ReadUtils.read$TYPE_INT64(param1);
                  break;
               case 7:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.isFirst cannot be set twice.");
                  }
                  _loc11_++;
                  isFirst = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SecretExploreInfoRspMsg.passMapId cannot be set twice.");
                  }
                  _loc8_++;
                  passMapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
            }
         }
      }
   }
}

