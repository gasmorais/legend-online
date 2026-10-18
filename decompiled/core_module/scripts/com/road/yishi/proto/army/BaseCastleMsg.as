package com.road.yishi.proto.army
{
   import com.netease.protobuf.Message;
   import com.netease.protobuf.ReadUtils;
   import com.netease.protobuf.WriteUtils;
   import com.netease.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class BaseCastleMsg extends Message implements IExternalizable
   {
      
      private var id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var map_id$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var template_id$field:int;
      
      private var type$field:int;
      
      private var occupy_player_id$field:int;
      
      private var occupy_player_name$field:String;
      
      private var occupy_league_name$field:String;
      
      private var state$field:int;
      
      private var defence_lefttime$field:int;
      
      private var castle_name$field:String;
      
      private var left_energy$field:int;
      
      private var grade$field:int;
      
      private var is_defenceBuffer$field:Boolean;
      
      private var vip_castleView$field:int;
      
      private var vip_type$field:int;
      
      public function BaseCastleMsg()
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
      
      public function removeMapId() : void
      {
         hasField$0 &= 4294967293;
         map_id$field = new int();
      }
      
      public function get hasMapId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set mapId(param1:int) : void
      {
         hasField$0 |= 2;
         map_id$field = param1;
      }
      
      public function get mapId() : int
      {
         return map_id$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967291;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 4;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967287;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 8;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeTemplateId() : void
      {
         hasField$0 &= 4294967279;
         template_id$field = new int();
      }
      
      public function get hasTemplateId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set templateId(param1:int) : void
      {
         hasField$0 |= 16;
         template_id$field = param1;
      }
      
      public function get templateId() : int
      {
         return template_id$field;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967263;
         type$field = new int();
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 32;
         type$field = param1;
      }
      
      public function get type() : int
      {
         return type$field;
      }
      
      public function removeOccupyPlayerId() : void
      {
         hasField$0 &= 4294967231;
         occupy_player_id$field = new int();
      }
      
      public function get hasOccupyPlayerId() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set occupyPlayerId(param1:int) : void
      {
         hasField$0 |= 64;
         occupy_player_id$field = param1;
      }
      
      public function get occupyPlayerId() : int
      {
         return occupy_player_id$field;
      }
      
      public function removeOccupyPlayerName() : void
      {
         occupy_player_name$field = null;
      }
      
      public function get hasOccupyPlayerName() : Boolean
      {
         return occupy_player_name$field != null;
      }
      
      public function set occupyPlayerName(param1:String) : void
      {
         occupy_player_name$field = param1;
      }
      
      public function get occupyPlayerName() : String
      {
         return occupy_player_name$field;
      }
      
      public function removeOccupyLeagueName() : void
      {
         occupy_league_name$field = null;
      }
      
      public function get hasOccupyLeagueName() : Boolean
      {
         return occupy_league_name$field != null;
      }
      
      public function set occupyLeagueName(param1:String) : void
      {
         occupy_league_name$field = param1;
      }
      
      public function get occupyLeagueName() : String
      {
         return occupy_league_name$field;
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
      
      public function removeDefenceLefttime() : void
      {
         hasField$0 &= 4294967039;
         defence_lefttime$field = new int();
      }
      
      public function get hasDefenceLefttime() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set defenceLefttime(param1:int) : void
      {
         hasField$0 |= 256;
         defence_lefttime$field = param1;
      }
      
      public function get defenceLefttime() : int
      {
         return defence_lefttime$field;
      }
      
      public function removeCastleName() : void
      {
         castle_name$field = null;
      }
      
      public function get hasCastleName() : Boolean
      {
         return castle_name$field != null;
      }
      
      public function set castleName(param1:String) : void
      {
         castle_name$field = param1;
      }
      
      public function get castleName() : String
      {
         return castle_name$field;
      }
      
      public function removeLeftEnergy() : void
      {
         hasField$0 &= 4294966783;
         left_energy$field = new int();
      }
      
      public function get hasLeftEnergy() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set leftEnergy(param1:int) : void
      {
         hasField$0 |= 512;
         left_energy$field = param1;
      }
      
      public function get leftEnergy() : int
      {
         return left_energy$field;
      }
      
      public function removeGrade() : void
      {
         hasField$0 &= 4294966271;
         grade$field = new int();
      }
      
      public function get hasGrade() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set grade(param1:int) : void
      {
         hasField$0 |= 1024;
         grade$field = param1;
      }
      
      public function get grade() : int
      {
         return grade$field;
      }
      
      public function removeIsDefenceBuffer() : void
      {
         hasField$0 &= 4294965247;
         is_defenceBuffer$field = new Boolean();
      }
      
      public function get hasIsDefenceBuffer() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set isDefenceBuffer(param1:Boolean) : void
      {
         hasField$0 |= 2048;
         is_defenceBuffer$field = param1;
      }
      
      public function get isDefenceBuffer() : Boolean
      {
         return is_defenceBuffer$field;
      }
      
      public function removeVipCastleView() : void
      {
         hasField$0 &= 4294963199;
         vip_castleView$field = new int();
      }
      
      public function get hasVipCastleView() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set vipCastleView(param1:int) : void
      {
         hasField$0 |= 4096;
         vip_castleView$field = param1;
      }
      
      public function get vipCastleView() : int
      {
         return vip_castleView$field;
      }
      
      public function removeVipType() : void
      {
         hasField$0 &= 4294959103;
         vip_type$field = new int();
      }
      
      public function get hasVipType() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set vipType(param1:int) : void
      {
         hasField$0 |= 8192;
         vip_type$field = param1;
      }
      
      public function get vipType() : int
      {
         return vip_type$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,id$field);
         }
         if(hasMapId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,map_id$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,3);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasTemplateId)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,template_id$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,0,6);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasOccupyPlayerId)
         {
            WriteUtils.writeTag(param1,0,7);
            WriteUtils.write$TYPE_INT32(param1,occupy_player_id$field);
         }
         if(hasOccupyPlayerName)
         {
            WriteUtils.writeTag(param1,2,8);
            WriteUtils.write$TYPE_STRING(param1,occupy_player_name$field);
         }
         if(hasOccupyLeagueName)
         {
            WriteUtils.writeTag(param1,2,9);
            WriteUtils.write$TYPE_STRING(param1,occupy_league_name$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasDefenceLefttime)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,defence_lefttime$field);
         }
         if(hasCastleName)
         {
            WriteUtils.writeTag(param1,2,12);
            WriteUtils.write$TYPE_STRING(param1,castle_name$field);
         }
         if(hasLeftEnergy)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,left_energy$field);
         }
         if(hasGrade)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,grade$field);
         }
         if(hasIsDefenceBuffer)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_BOOL(param1,is_defenceBuffer$field);
         }
         if(hasVipCastleView)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,vip_castleView$field);
         }
         if(hasVipType)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,vip_type$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc18_:* = 0;
         var _loc6_:uint = 0;
         var _loc15_:uint = 0;
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc16_:uint = 0;
         var _loc8_:uint = 0;
         var _loc4_:uint = 0;
         var _loc20_:uint = 0;
         var _loc10_:uint = 0;
         var _loc13_:uint = 0;
         var _loc19_:uint = 0;
         var _loc11_:uint = 0;
         var _loc17_:uint = 0;
         var _loc5_:uint = 0;
         var _loc7_:uint = 0;
         var _loc12_:uint = 0;
         var _loc14_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch(((_loc18_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3) - 1)
            {
               case 0:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.id cannot be set twice.");
                  }
                  _loc6_++;
                  id = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 1:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.mapId cannot be set twice.");
                  }
                  _loc15_++;
                  mapId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.posX cannot be set twice.");
                  }
                  _loc9_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.posY cannot be set twice.");
                  }
                  _loc3_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.templateId cannot be set twice.");
                  }
                  _loc16_++;
                  templateId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.type cannot be set twice.");
                  }
                  _loc8_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.occupyPlayerId cannot be set twice.");
                  }
                  _loc4_++;
                  occupyPlayerId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.occupyPlayerName cannot be set twice.");
                  }
                  _loc20_++;
                  occupyPlayerName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.occupyLeagueName cannot be set twice.");
                  }
                  _loc10_++;
                  occupyLeagueName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 9:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.state cannot be set twice.");
                  }
                  _loc13_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc19_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.defenceLefttime cannot be set twice.");
                  }
                  _loc19_++;
                  defenceLefttime = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.castleName cannot be set twice.");
                  }
                  _loc11_++;
                  castleName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 12:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.leftEnergy cannot be set twice.");
                  }
                  _loc17_++;
                  leftEnergy = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.grade cannot be set twice.");
                  }
                  _loc5_++;
                  grade = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.isDefenceBuffer cannot be set twice.");
                  }
                  _loc7_++;
                  isDefenceBuffer = ReadUtils.read$TYPE_BOOL(param1);
                  break;
               case 15:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.vipCastleView cannot be set twice.");
                  }
                  _loc12_++;
                  vipCastleView = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: BaseCastleMsg.vipType cannot be set twice.");
                  }
                  _loc14_++;
                  vipType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc18_ & 7);
            }
         }
      }
   }
}

