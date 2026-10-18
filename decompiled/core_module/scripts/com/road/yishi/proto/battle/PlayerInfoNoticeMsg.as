package com.road.yishi.proto.battle
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PlayerInfoNoticeMsg extends Message implements IExternalizable
   {
      
      private var affect_geste$field:int;
      
      private var hasField$0:uint = 0;
      
      private var score$field:int;
      
      private var is_add$field:Boolean;
      
      private var player_state$field:int;
      
      private var is_tips$field:Boolean;
      
      private var server_name$field:String;
      
      private var manual_exit$field:Boolean;
      
      private var mount_template_id$field:int;
      
      private var mount_grade$field:int;
      
      private var wing$field:String;
      
      private var arm$field:String;
      
      private var cloth$field:String;
      
      private var change_shape_id$field:int;
      
      private var hat$field:String;
      
      private var fashion_arm$field:String;
      
      private var fashion_cloth$field:String;
      
      private var hide$field:Boolean;
      
      private var cross_score$field:int;
      
      private var geste_join$field:int;
      
      private var appell_id$field:int;
      
      private var pet_template_id$field:int;
      
      private var pet_name$field:String;
      
      private var pet_quality$field:int;
      
      private var geste_powcard_join$field:int;
      
      private var child_job$field:int;
      
      private var child_name$field:String;
      
      private var child_sex$field:int;
      
      private var growth_grade$field:int;
      
      public function PlayerInfoNoticeMsg()
      {
         super();
      }
      
      public function removeAffectGeste() : void
      {
         hasField$0 &= 4294967294;
         affect_geste$field = new int();
      }
      
      public function get hasAffectGeste() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set affectGeste(param1:int) : void
      {
         hasField$0 |= 1;
         affect_geste$field = param1;
      }
      
      public function get affectGeste() : int
      {
         return affect_geste$field;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new int();
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:int) : void
      {
         hasField$0 |= 2;
         score$field = param1;
      }
      
      public function get score() : int
      {
         return score$field;
      }
      
      public function removeIsAdd() : void
      {
         hasField$0 &= 4294967291;
         is_add$field = new Boolean();
      }
      
      public function get hasIsAdd() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set isAdd(param1:Boolean) : void
      {
         hasField$0 |= 4;
         is_add$field = param1;
      }
      
      public function get isAdd() : Boolean
      {
         return is_add$field;
      }
      
      public function removePlayerState() : void
      {
         hasField$0 &= 4294967287;
         player_state$field = new int();
      }
      
      public function get hasPlayerState() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set playerState(param1:int) : void
      {
         hasField$0 |= 8;
         player_state$field = param1;
      }
      
      public function get playerState() : int
      {
         return player_state$field;
      }
      
      public function removeIsTips() : void
      {
         hasField$0 &= 4294967279;
         is_tips$field = new Boolean();
      }
      
      public function get hasIsTips() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set isTips(param1:Boolean) : void
      {
         hasField$0 |= 16;
         is_tips$field = param1;
      }
      
      public function get isTips() : Boolean
      {
         return is_tips$field;
      }
      
      public function removeServerName() : void
      {
         server_name$field = null;
      }
      
      public function get hasServerName() : Boolean
      {
         return server_name$field != null;
      }
      
      public function set serverName(param1:String) : void
      {
         server_name$field = param1;
      }
      
      public function get serverName() : String
      {
         return server_name$field;
      }
      
      public function removeManualExit() : void
      {
         hasField$0 &= 4294967263;
         manual_exit$field = new Boolean();
      }
      
      public function get hasManualExit() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set manualExit(param1:Boolean) : void
      {
         hasField$0 |= 32;
         manual_exit$field = param1;
      }
      
      public function get manualExit() : Boolean
      {
         return manual_exit$field;
      }
      
      public function removeMountTemplateId() : void
      {
         hasField$0 &= 4294967231;
         mount_template_id$field = new int();
      }
      
      public function get hasMountTemplateId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set mountTemplateId(param1:int) : void
      {
         hasField$0 |= 64;
         mount_template_id$field = param1;
      }
      
      public function get mountTemplateId() : int
      {
         return mount_template_id$field;
      }
      
      public function removeMountGrade() : void
      {
         hasField$0 &= 4294967167;
         mount_grade$field = new int();
      }
      
      public function get hasMountGrade() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set mountGrade(param1:int) : void
      {
         hasField$0 |= 128;
         mount_grade$field = param1;
      }
      
      public function get mountGrade() : int
      {
         return mount_grade$field;
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
      
      public function removeChangeShapeId() : void
      {
         hasField$0 &= 4294967039;
         change_shape_id$field = new int();
      }
      
      public function get hasChangeShapeId() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set changeShapeId(param1:int) : void
      {
         hasField$0 |= 256;
         change_shape_id$field = param1;
      }
      
      public function get changeShapeId() : int
      {
         return change_shape_id$field;
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
         hasField$0 &= 4294966783;
         hide$field = new Boolean();
      }
      
      public function get hasHide() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set hide(param1:Boolean) : void
      {
         hasField$0 |= 512;
         hide$field = param1;
      }
      
      public function get hide() : Boolean
      {
         return hide$field;
      }
      
      public function removeCrossScore() : void
      {
         hasField$0 &= 4294966271;
         cross_score$field = new int();
      }
      
      public function get hasCrossScore() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set crossScore(param1:int) : void
      {
         hasField$0 |= 1024;
         cross_score$field = param1;
      }
      
      public function get crossScore() : int
      {
         return cross_score$field;
      }
      
      public function removeGesteJoin() : void
      {
         hasField$0 &= 4294965247;
         geste_join$field = new int();
      }
      
      public function get hasGesteJoin() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set gesteJoin(param1:int) : void
      {
         hasField$0 |= 2048;
         geste_join$field = param1;
      }
      
      public function get gesteJoin() : int
      {
         return geste_join$field;
      }
      
      public function removeAppellId() : void
      {
         hasField$0 &= 4294963199;
         appell_id$field = new int();
      }
      
      public function get hasAppellId() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set appellId(param1:int) : void
      {
         hasField$0 |= 4096;
         appell_id$field = param1;
      }
      
      public function get appellId() : int
      {
         return appell_id$field;
      }
      
      public function removePetTemplateId() : void
      {
         hasField$0 &= 4294959103;
         pet_template_id$field = new int();
      }
      
      public function get hasPetTemplateId() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set petTemplateId(param1:int) : void
      {
         hasField$0 |= 8192;
         pet_template_id$field = param1;
      }
      
      public function get petTemplateId() : int
      {
         return pet_template_id$field;
      }
      
      public function removePetName() : void
      {
         pet_name$field = null;
      }
      
      public function get hasPetName() : Boolean
      {
         return pet_name$field != null;
      }
      
      public function set petName(param1:String) : void
      {
         pet_name$field = param1;
      }
      
      public function get petName() : String
      {
         return pet_name$field;
      }
      
      public function removePetQuality() : void
      {
         hasField$0 &= 4294950911;
         pet_quality$field = new int();
      }
      
      public function get hasPetQuality() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set petQuality(param1:int) : void
      {
         hasField$0 |= 16384;
         pet_quality$field = param1;
      }
      
      public function get petQuality() : int
      {
         return pet_quality$field;
      }
      
      public function removeGestePowcardJoin() : void
      {
         hasField$0 &= 4294934527;
         geste_powcard_join$field = new int();
      }
      
      public function get hasGestePowcardJoin() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set gestePowcardJoin(param1:int) : void
      {
         hasField$0 |= 32768;
         geste_powcard_join$field = param1;
      }
      
      public function get gestePowcardJoin() : int
      {
         return geste_powcard_join$field;
      }
      
      public function removeChildJob() : void
      {
         hasField$0 &= 4294901759;
         child_job$field = new int();
      }
      
      public function get hasChildJob() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set childJob(param1:int) : void
      {
         hasField$0 |= 65536;
         child_job$field = param1;
      }
      
      public function get childJob() : int
      {
         return child_job$field;
      }
      
      public function removeChildName() : void
      {
         child_name$field = null;
      }
      
      public function get hasChildName() : Boolean
      {
         return child_name$field != null;
      }
      
      public function set childName(param1:String) : void
      {
         child_name$field = param1;
      }
      
      public function get childName() : String
      {
         return child_name$field;
      }
      
      public function removeChildSex() : void
      {
         hasField$0 &= 4294836223;
         child_sex$field = new int();
      }
      
      public function get hasChildSex() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set childSex(param1:int) : void
      {
         hasField$0 |= 131072;
         child_sex$field = param1;
      }
      
      public function get childSex() : int
      {
         return child_sex$field;
      }
      
      public function removeGrowthGrade() : void
      {
         hasField$0 &= 4294705151;
         growth_grade$field = new int();
      }
      
      public function get hasGrowthGrade() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set growthGrade(param1:int) : void
      {
         hasField$0 |= 262144;
         growth_grade$field = param1;
      }
      
      public function get growthGrade() : int
      {
         return growth_grade$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasAffectGeste)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,affect_geste$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,score$field);
         }
         if(hasIsAdd)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_BOOL(param1,is_add$field);
         }
         if(hasPlayerState)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,player_state$field);
         }
         if(hasIsTips)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_BOOL(param1,is_tips$field);
         }
         if(hasServerName)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,server_name$field);
         }
         if(hasManualExit)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_BOOL(param1,manual_exit$field);
         }
         if(hasMountTemplateId)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,mount_template_id$field);
         }
         if(hasMountGrade)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,mount_grade$field);
         }
         if(hasWing)
         {
            WriteUtils.writeTag(param1,2,10);
            WriteUtils.write$TYPE_STRING(param1,wing$field);
         }
         if(hasArm)
         {
            WriteUtils.writeTag(param1,2,11);
            WriteUtils.write$TYPE_STRING(param1,arm$field);
         }
         if(hasCloth)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,cloth$field);
         }
         if(hasChangeShapeId)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,change_shape_id$field);
         }
         if(hasHat)
         {
            WriteUtils.writeTag(param1,2,14);
            WriteUtils.write$TYPE_STRING(param1,hat$field);
         }
         if(hasFashionArm)
         {
            WriteUtils.writeTag(param1,2,15);
            WriteUtils.write$TYPE_STRING(param1,fashion_arm$field);
         }
         if(hasFashionCloth)
         {
            WriteUtils.writeTag(param1,2,16);
            WriteUtils.write$TYPE_STRING(param1,fashion_cloth$field);
         }
         if(hasHide)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_BOOL(param1,hide$field);
         }
         if(hasCrossScore)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,cross_score$field);
         }
         if(hasGesteJoin)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,geste_join$field);
         }
         if(hasAppellId)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,appell_id$field);
         }
         if(hasPetTemplateId)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,pet_template_id$field);
         }
         if(hasPetName)
         {
            WriteUtils.writeTag(param1,2,22);
            WriteUtils.write$TYPE_STRING(param1,pet_name$field);
         }
         if(hasPetQuality)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,pet_quality$field);
         }
         if(hasGestePowcardJoin)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,geste_powcard_join$field);
         }
         if(hasChildJob)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,child_job$field);
         }
         if(hasChildName)
         {
            WriteUtils.writeTag(param1,2,26);
            WriteUtils.write$TYPE_STRING(param1,child_name$field);
         }
         if(hasChildSex)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,child_sex$field);
         }
         if(hasGrowthGrade)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,growth_grade$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc17_:* = 0;
         var _loc18_:uint = 0;
         var _loc28_:uint = 0;
         var _loc25_:uint = 0;
         var _loc31_:uint = 0;
         var _loc12_:uint = 0;
         var _loc10_:uint = 0;
         var _loc22_:uint = 0;
         var _loc14_:uint = 0;
         var _loc19_:uint = 0;
         var _loc16_:uint = 0;
         var _loc15_:uint = 0;
         var _loc27_:uint = 0;
         var _loc29_:uint = 0;
         var _loc3_:uint = 0;
         var _loc26_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:uint = 0;
         var _loc11_:uint = 0;
         var _loc5_:uint = 0;
         var _loc13_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc24_:uint = 0;
         var _loc23_:uint = 0;
         var _loc30_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc17_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.affectGeste cannot be set twice.");
                  }
                  _loc18_++;
                  affectGeste = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.score cannot be set twice.");
                  }
                  _loc28_++;
                  score = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.isAdd cannot be set twice.");
                  }
                  _loc25_++;
                  isAdd = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 4:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.playerState cannot be set twice.");
                  }
                  _loc31_++;
                  playerState = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.isTips cannot be set twice.");
                  }
                  _loc12_++;
                  isTips = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 6:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.serverName cannot be set twice.");
                  }
                  _loc10_++;
                  serverName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.manualExit cannot be set twice.");
                  }
                  _loc22_++;
                  manualExit = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 8:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.mountTemplateId cannot be set twice.");
                  }
                  _loc14_++;
                  mountTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.mountGrade cannot be set twice.");
                  }
                  _loc19_++;
                  mountGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.wing cannot be set twice.");
                  }
                  _loc16_++;
                  wing = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 11:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.arm cannot be set twice.");
                  }
                  _loc15_++;
                  arm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.cloth cannot be set twice.");
                  }
                  _loc27_++;
                  cloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 13:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.changeShapeId cannot be set twice.");
                  }
                  _loc29_++;
                  changeShapeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.hat cannot be set twice.");
                  }
                  _loc3_++;
                  hat = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 15:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.fashionArm cannot be set twice.");
                  }
                  _loc26_++;
                  fashionArm = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 16:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.fashionCloth cannot be set twice.");
                  }
                  _loc20_++;
                  fashionCloth = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 17:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.hide cannot be set twice.");
                  }
                  _loc21_++;
                  hide = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 18:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.crossScore cannot be set twice.");
                  }
                  _loc11_++;
                  crossScore = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.gesteJoin cannot be set twice.");
                  }
                  _loc5_++;
                  gesteJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.appellId cannot be set twice.");
                  }
                  _loc13_++;
                  appellId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.petTemplateId cannot be set twice.");
                  }
                  _loc6_++;
                  petTemplateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.petName cannot be set twice.");
                  }
                  _loc7_++;
                  petName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 23:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.petQuality cannot be set twice.");
                  }
                  _loc8_++;
                  petQuality = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 24:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.gestePowcardJoin cannot be set twice.");
                  }
                  _loc4_++;
                  gestePowcardJoin = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.childJob cannot be set twice.");
                  }
                  _loc24_++;
                  childJob = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.childName cannot be set twice.");
                  }
                  _loc23_++;
                  childName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 27:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.childSex cannot be set twice.");
                  }
                  _loc30_++;
                  childSex = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PlayerInfoNoticeMsg.growthGrade cannot be set twice.");
                  }
                  _loc9_++;
                  growthGrade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc17_ & 7);
            }
         }
      }
   }
}

