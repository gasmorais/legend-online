package com.road.yishi.proto.module
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class SapperMsg extends Message implements IExternalizable
   {
      
      private var user_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var nick_name$field:String;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var wing$field:String;
      
      private var hat$field:String;
      
      private var fashion_arm$field:String;
      
      private var fashion_cloth$field:String;
      
      private var hide$field:Boolean;
      
      private var sex$field:int;
      
      private var template_id$field:int;
      
      private var job$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var state$field:int;
      
      private var is_dragon_talker$field:Boolean;
      
      private var battle_beastId$field:int;
      
      public function SapperMsg()
      {
         super();
      }
      
      public function removeUserId() : void
      {
         hasField$0 &= 4294967294;
         user_id$field = new int();
      }
      
      public function get hasUserId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set userId(param1:int) : void
      {
         hasField$0 |= 1;
         user_id$field = param1;
      }
      
      public function get userId() : int
      {
         return user_id$field;
      }
      
      public function removeNickName() : void
      {
         nick_name$field = null;
      }
      
      public function get hasNickName() : Boolean
      {
         return nick_name$field != null;
      }
      
      public function set nickName(param1:String) : void
      {
         nick_name$field = param1;
      }
      
      public function get nickName() : String
      {
         return nick_name$field;
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
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 8;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
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
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967263;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 32;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967231;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 64;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967167;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 128;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeIsDragonTalker() : void
      {
         hasField$0 &= 4294967039;
         is_dragon_talker$field = new Boolean();
      }
      
      public function get hasIsDragonTalker() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set isDragonTalker(param1:Boolean) : void
      {
         hasField$0 |= 256;
         is_dragon_talker$field = param1;
      }
      
      public function get isDragonTalker() : Boolean
      {
         return is_dragon_talker$field;
      }
      
      public function removeBattleBeastId() : void
      {
         hasField$0 &= 4294966783;
         battle_beastId$field = new int();
      }
      
      public function get hasBattleBeastId() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set battleBeastId(param1:int) : void
      {
         hasField$0 |= 512;
         battle_beastId$field = param1;
      }
      
      public function get battleBeastId() : int
      {
         return battle_beastId$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUserId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,user_id$field);
         }
         if(hasNickName)
         {
            WriteUtils.writeTag(param1,2,2);
            WriteUtils.write$TYPE_STRING(param1,nick_name$field);
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
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
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
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasJob)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,job$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasIsDragonTalker)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_BOOL(param1,is_dragon_talker$field);
         }
         if(hasBattleBeastId)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,battle_beastId$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc20_:* = 0;
         var _loc15_:uint = 0;
         var _loc6_:uint = 0;
         var _loc12_:uint = 0;
         var _loc18_:uint = 0;
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc16_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc19_:uint = 0;
         var _loc14_:uint = 0;
         var _loc10_:uint = 0;
         var _loc5_:uint = 0;
         var _loc17_:uint = 0;
         var _loc11_:uint = 0;
         var _loc4_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc20_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.userId cannot be set twice.");
                  }
                  _loc15_++;
                  userId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.nickName cannot be set twice.");
                  }
                  _loc6_++;
                  nickName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 2:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.arm cannot be set twice.");
                  }
                  _loc12_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 3:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.cloth cannot be set twice.");
                  }
                  _loc18_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.wing cannot be set twice.");
                  }
                  _loc13_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 5:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 6:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.fashionArm cannot be set twice.");
                  }
                  _loc16_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.fashionCloth cannot be set twice.");
                  }
                  _loc7_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.hide cannot be set twice.");
                  }
                  _loc8_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.sex cannot be set twice.");
                  }
                  _loc9_++;
                  sex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.templateId cannot be set twice.");
                  }
                  _loc19_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.job cannot be set twice.");
                  }
                  _loc14_++;
                  job = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.posX cannot be set twice.");
                  }
                  _loc10_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.posY cannot be set twice.");
                  }
                  _loc5_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.state cannot be set twice.");
                  }
                  _loc17_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.isDragonTalker cannot be set twice.");
                  }
                  _loc11_++;
                  isDragonTalker = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 16:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: SapperMsg.battleBeastId cannot be set twice.");
                  }
                  _loc4_++;
                  battleBeastId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc20_ & 7);
            }
         }
      }
   }
}

