package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class HeroEquUpdatedMsg extends Message implements IExternalizable
   {
      
      private var player_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var arm_str$field:String;
      
      private var cloth_str$field:String;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var fashion_arm$field:String;
      
      private var fashion_cloth$field:String;
      
      private var hide$field:Boolean;
      
      private var appellId$field:int;
      
      private var trans_grade$field:int;
      
      private var changeBranch$field:int;
      
      public function HeroEquUpdatedMsg()
      {
         super();
      }
      
      public function removePlayerId() : void
      {
         hasField$0 &= 4294967294;
         player_id$field = new int();
      }
      
      public function get hasPlayerId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set playerId(param1:int) : void
      {
         hasField$0 |= 1;
         player_id$field = param1;
      }
      
      public function get playerId() : int
      {
         return player_id$field;
      }
      
      public function removeArmStr() : void
      {
         arm_str$field = null;
      }
      
      public function get hasArmStr() : Boolean
      {
         return arm_str$field != null;
      }
      
      public function set armStr(param1:String) : void
      {
         arm_str$field = param1;
      }
      
      public function get armStr() : String
      {
         return arm_str$field;
      }
      
      public function removeClothStr() : void
      {
         cloth_str$field = null;
      }
      
      public function get hasClothStr() : Boolean
      {
         return cloth_str$field != null;
      }
      
      public function set clothStr(param1:String) : void
      {
         cloth_str$field = param1;
      }
      
      public function get clothStr() : String
      {
         return cloth_str$field;
      }
      
      public function removeWing() : void
      {
         wing$field = null;
      }
      
      public function get hasWing() : Boolean
      {
         return wing$field != null;
      }
      
      public function set wing(param1:String) : void
      {
         wing$field = param1;
      }
      
      public function get wing() : String
      {
         return wing$field;
      }
      
      public function removeHat() : void
      {
         hat$field = null;
      }
      
      public function get hasHat() : Boolean
      {
         return hat$field != null;
      }
      
      public function set hat(param1:String) : void
      {
         hat$field = param1;
      }
      
      public function get hat() : String
      {
         return hat$field;
      }
      
      public function removeFashionArm() : void
      {
         fashion_arm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashion_arm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashion_arm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashion_arm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashion_cloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashion_cloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashion_cloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashion_cloth$field;
      }
      
      public function removeHide() : void
      {
         hasField$0 &= 4294967293;
         hide$field = new Boolean();
      }
      
      public function get hasHide() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set hide(param1:Boolean) : void
      {
         hasField$0 |= 2;
         hide$field = param1;
      }
      
      public function get hide() : Boolean
      {
         return hide$field;
      }
      
      public function removeAppellId() : void
      {
         hasField$0 &= 4294967291;
         appellId$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$0 |= 4;
         appellId$field = param1;
      }
      
      public function get appellId() : int
      {
         return appellId$field;
      }
      
      public function removeTransGrade() : void
      {
         hasField$0 &= 4294967287;
         trans_grade$field = new int();
      }
      
      public function get hasTransGrade() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set transGrade(param1:int) : void
      {
         hasField$0 |= 8;
         trans_grade$field = param1;
      }
      
      public function get transGrade() : int
      {
         return trans_grade$field;
      }
      
      public function removeChangeBranch() : void
      {
         hasField$0 &= 4294967279;
         changeBranch$field = new int();
      }
      
      public function get hasChangeBranch() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set changeBranch(param1:int) : void
      {
         hasField$0 |= 16;
         changeBranch$field = param1;
      }
      
      public function get changeBranch() : int
      {
         return changeBranch$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasPlayerId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,player_id$field);
         }
         if(hasArmStr)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,arm_str$field);
         }
         if(hasClothStr)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,cloth_str$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,appellId$field);
         }
         if(hasTransGrade)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,trans_grade$field);
         }
         if(hasChangeBranch)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,changeBranch$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:* = 0;
         var _loc4_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc12_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc9_:uint = 0;
         var _loc8_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc13_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.playerId cannot be set twice.");
                  }
                  _loc4_++;
                  playerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.armStr cannot be set twice.");
                  }
                  _loc14_++;
                  armStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.clothStr cannot be set twice.");
                  }
                  _loc10_++;
                  clothStr = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.wing cannot be set twice.");
                  }
                  _loc11_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.fashionArm cannot be set twice.");
                  }
                  _loc12_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.fashionCloth cannot be set twice.");
                  }
                  _loc6_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.hide cannot be set twice.");
                  }
                  _loc7_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.appellId cannot be set twice.");
                  }
                  _loc9_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.transGrade cannot be set twice.");
                  }
                  _loc8_++;
                  transGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: HeroEquUpdatedMsg.changeBranch cannot be set twice.");
                  }
                  _loc5_++;
                  changeBranch = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
            }
         }
      }
   }
}

