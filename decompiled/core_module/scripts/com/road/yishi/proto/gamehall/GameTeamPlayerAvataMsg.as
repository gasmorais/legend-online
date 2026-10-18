package com.road.yishi.proto.gamehall
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class GameTeamPlayerAvataMsg extends Message implements IExternalizable
   {
      
      private var userId$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nickName$field:String;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var fashionArm$field:String;
      
      private var fashionCloth$field:String;
      
      private var hide$field:Boolean;
      
      private var sex$field:int;
      
      private var templateId$field:int;
      
      private var job$field:int;
      
      private var mountId$field:int;
      
      private var sharpId$field:int;
      
      private var fightCapacity$field:int;
      
      public function GameTeamPlayerAvataMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         userId$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
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
      
      public function removeArm() : void
      {
         arm$field = null;
      }
      
      public function get hasArm() : Boolean
      {
         return arm$field != null;
      }
      
      public function set arm(param1:String) : void
      {
         arm$field = param1;
      }
      
      public function get arm() : String
      {
         return arm$field;
      }
      
      public function removeCloth() : void
      {
         cloth$field = null;
      }
      
      public function get hasCloth() : Boolean
      {
         return cloth$field != null;
      }
      
      public function set cloth(param1:String) : void
      {
         cloth$field = param1;
      }
      
      public function get cloth() : String
      {
         return cloth$field;
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
         fashionArm$field = null;
      }
      
      public function get hasFashionArm() : Boolean
      {
         return fashionArm$field != null;
      }
      
      public function set fashionArm(param1:String) : void
      {
         fashionArm$field = param1;
      }
      
      public function get fashionArm() : String
      {
         return fashionArm$field;
      }
      
      public function removeFashionCloth() : void
      {
         fashionCloth$field = null;
      }
      
      public function get hasFashionCloth() : Boolean
      {
         return fashionCloth$field != null;
      }
      
      public function set fashionCloth(param1:String) : void
      {
         fashionCloth$field = param1;
      }
      
      public function get fashionCloth() : String
      {
         return fashionCloth$field;
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
      
      public function removeSex() : void
      {
         hasField$0 &= 4294967291;
         sex$field = new int();
      }
      
      public function get hasSex() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set sex(param1:int) : void
      {
         hasField$0 |= 4;
         sex$field = param1;
      }
      
      public function get sex() : int
      {
         return sex$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967287;
         templateId$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         templateId$field = param1;
      }
      
      public function get templateId() : int
      {
         return templateId$field;
      }
      
      public function removeJob() : void
      {
         hasField$0 &= 4294967279;
         job$field = new int();
      }
      
      public function get hasJob() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set job(param1:int) : void
      {
         hasField$0 |= 16;
         job$field = param1;
      }
      
      public function get job() : int
      {
         return job$field;
      }
      
      public function removeMountId() : void
      {
         hasField$0 &= 4294967263;
         mountId$field = new int();
      }
      
      public function get hasMountId() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set mountId(param1:int) : void
      {
         hasField$0 |= 32;
         mountId$field = param1;
      }
      
      public function get mountId() : int
      {
         return mountId$field;
      }
      
      public function removeSharpId() : void
      {
         hasField$0 &= 4294967231;
         sharpId$field = new int();
      }
      
      public function get hasSharpId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set sharpId(param1:int) : void
      {
         hasField$0 |= 64;
         sharpId$field = param1;
      }
      
      public function get sharpId() : int
      {
         return sharpId$field;
      }
      
      public function removeFightCapacity() : void
      {
         hasField$0 &= 4294967167;
         fightCapacity$field = new int();
      }
      
      public function get hasFightCapacity() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set fightCapacity(param1:int) : void
      {
         hasField$0 |= 128;
         fightCapacity$field = param1;
      }
      
      public function get fightCapacity() : int
      {
         return fightCapacity$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,userId$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nickName$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,4);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,5);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,fashionArm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,fashionCloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasSex)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,sex$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,templateId$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasMountId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,mountId$field);
         }
         if(hasSharpId)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,sharpId$field);
         }
         if(hasFightCapacity)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,fightCapacity$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc16_:* = 0;
         var _loc8_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc14_:uint = 0;
         var _loc12_:uint = 0;
         var _loc3_:uint = 0;
         var _loc15_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc6_:uint = 0;
         var _loc13_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc16_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.userId cannot be set twice.");
                  }
                  _loc8_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.nickName cannot be set twice.");
                  }
                  _loc10_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.arm cannot be set twice.");
                  }
                  _loc11_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.cloth cannot be set twice.");
                  }
                  _loc14_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.wing cannot be set twice.");
                  }
                  _loc12_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.fashionArm cannot be set twice.");
                  }
                  _loc15_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.fashionCloth cannot be set twice.");
                  }
                  _loc4_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.hide cannot be set twice.");
                  }
                  _loc5_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.sex cannot be set twice.");
                  }
                  _loc7_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.templateId cannot be set twice.");
                  }
                  _loc6_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.job cannot be set twice.");
                  }
                  _loc13_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.mountId cannot be set twice.");
                  }
                  _loc17_++;
                  mountId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.sharpId cannot be set twice.");
                  }
                  _loc18_++;
                  sharpId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: GameTeamPlayerAvataMsg.fightCapacity cannot be set twice.");
                  }
                  _loc9_++;
                  fightCapacity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc16_ & 7);
            }
         }
      }
   }
}

