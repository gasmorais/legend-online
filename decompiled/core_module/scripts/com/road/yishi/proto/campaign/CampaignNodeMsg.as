package com.road.yishi.proto.campaign
{
   import com.netease.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class CampaignNodeMsg extends Message implements IExternalizable
   {
      
      private var node_id$field:int;
      
      private var hasField$0:uint = 0;
      
      private var camp_data_id$field:int;
      
      private var node_name$field:String;
      
      private var master_type$field:int;
      
      private var son_type$field:int;
      
      private var pre_node_ids$field:String;
      
      private var next_node_ids$field:String;
      
      private var state$field:int;
      
      private var refresh_speed$field:int;
      
      private var pos_x$field:int;
      
      private var pos_y$field:int;
      
      private var cur_x$field:int;
      
      private var cur_y$field:int;
      
      private var level$field:int;
      
      private var style_type$field:int;
      
      private var attack_types$field:int;
      
      private var name_color$field:int;
      
      private var size_type$field:int;
      
      private var toward$field:int;
      
      private var resource$field:int;
      
      private var reset_x$field:int;
      
      private var reset_y$field:int;
      
      [ArrayElementType("int")]
      public var visitUserIds:Array = [];
      
      private var fix_type$field:int;
      
      private var fix_x$field:int;
      
      private var fix_y$field:int;
      
      private var hero_tempId$field:int;
      
      private var handler_range$field:int;
      
      private var fight_capaity$field:int;
      
      private var param1$field:int;
      
      private var param2$field:int;
      
      private var param3$field:String;
      
      private var param4$field:String;
      
      private var param5$field:String;
      
      private var param6$field:String;
      
      private var currentCount$field:int;
      
      private var army_id$field:int;
      
      public function CampaignNodeMsg()
      {
         super();
      }
      
      public function removeNodeId() : void
      {
         hasField$0 &= 4294967294;
         node_id$field = new int();
      }
      
      public function get hasNodeId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set nodeId(param1:int) : void
      {
         hasField$0 |= 1;
         node_id$field = param1;
      }
      
      public function get nodeId() : int
      {
         return node_id$field;
      }
      
      public function removeCampDataId() : void
      {
         hasField$0 &= 4294967293;
         camp_data_id$field = new int();
      }
      
      public function get hasCampDataId() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set campDataId(param1:int) : void
      {
         hasField$0 |= 2;
         camp_data_id$field = param1;
      }
      
      public function get campDataId() : int
      {
         return camp_data_id$field;
      }
      
      public function removeNodeName() : void
      {
         node_name$field = null;
      }
      
      public function get hasNodeName() : Boolean
      {
         return node_name$field != null;
      }
      
      public function set nodeName(param1:String) : void
      {
         node_name$field = param1;
      }
      
      public function get nodeName() : String
      {
         return node_name$field;
      }
      
      public function removeMasterType() : void
      {
         hasField$0 &= 4294967291;
         master_type$field = new int();
      }
      
      public function get hasMasterType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set masterType(param1:int) : void
      {
         hasField$0 |= 4;
         master_type$field = param1;
      }
      
      public function get masterType() : int
      {
         return master_type$field;
      }
      
      public function removeSonType() : void
      {
         hasField$0 &= 4294967287;
         son_type$field = new int();
      }
      
      public function get hasSonType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set sonType(param1:int) : void
      {
         hasField$0 |= 8;
         son_type$field = param1;
      }
      
      public function get sonType() : int
      {
         return son_type$field;
      }
      
      public function removePreNodeIds() : void
      {
         pre_node_ids$field = null;
      }
      
      public function get hasPreNodeIds() : Boolean
      {
         return pre_node_ids$field != null;
      }
      
      public function set preNodeIds(param1:String) : void
      {
         pre_node_ids$field = param1;
      }
      
      public function get preNodeIds() : String
      {
         return pre_node_ids$field;
      }
      
      public function removeNextNodeIds() : void
      {
         next_node_ids$field = null;
      }
      
      public function get hasNextNodeIds() : Boolean
      {
         return next_node_ids$field != null;
      }
      
      public function set nextNodeIds(param1:String) : void
      {
         next_node_ids$field = param1;
      }
      
      public function get nextNodeIds() : String
      {
         return next_node_ids$field;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967279;
         state$field = new int();
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set state(param1:int) : void
      {
         hasField$0 |= 16;
         state$field = param1;
      }
      
      public function get state() : int
      {
         return state$field;
      }
      
      public function removeRefreshSpeed() : void
      {
         hasField$0 &= 4294967263;
         refresh_speed$field = new int();
      }
      
      public function get hasRefreshSpeed() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set refreshSpeed(param1:int) : void
      {
         hasField$0 |= 32;
         refresh_speed$field = param1;
      }
      
      public function get refreshSpeed() : int
      {
         return refresh_speed$field;
      }
      
      public function removePosX() : void
      {
         hasField$0 &= 4294967231;
         pos_x$field = new int();
      }
      
      public function get hasPosX() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set posX(param1:int) : void
      {
         hasField$0 |= 64;
         pos_x$field = param1;
      }
      
      public function get posX() : int
      {
         return pos_x$field;
      }
      
      public function removePosY() : void
      {
         hasField$0 &= 4294967167;
         pos_y$field = new int();
      }
      
      public function get hasPosY() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function set posY(param1:int) : void
      {
         hasField$0 |= 128;
         pos_y$field = param1;
      }
      
      public function get posY() : int
      {
         return pos_y$field;
      }
      
      public function removeCurX() : void
      {
         hasField$0 &= 4294967039;
         cur_x$field = new int();
      }
      
      public function get hasCurX() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function set curX(param1:int) : void
      {
         hasField$0 |= 256;
         cur_x$field = param1;
      }
      
      public function get curX() : int
      {
         return cur_x$field;
      }
      
      public function removeCurY() : void
      {
         hasField$0 &= 4294966783;
         cur_y$field = new int();
      }
      
      public function get hasCurY() : Boolean
      {
         return (hasField$0 & 0x0200) != 0;
      }
      
      public function set curY(param1:int) : void
      {
         hasField$0 |= 512;
         cur_y$field = param1;
      }
      
      public function get curY() : int
      {
         return cur_y$field;
      }
      
      public function removeLevel() : void
      {
         hasField$0 &= 4294966271;
         level$field = new int();
      }
      
      public function get hasLevel() : Boolean
      {
         return (hasField$0 & 0x0400) != 0;
      }
      
      public function set level(param1:int) : void
      {
         hasField$0 |= 1024;
         level$field = param1;
      }
      
      public function get level() : int
      {
         return level$field;
      }
      
      public function removeStyleType() : void
      {
         hasField$0 &= 4294965247;
         style_type$field = new int();
      }
      
      public function get hasStyleType() : Boolean
      {
         return (hasField$0 & 0x0800) != 0;
      }
      
      public function set styleType(param1:int) : void
      {
         hasField$0 |= 2048;
         style_type$field = param1;
      }
      
      public function get styleType() : int
      {
         return style_type$field;
      }
      
      public function removeAttackTypes() : void
      {
         hasField$0 &= 4294963199;
         attack_types$field = new int();
      }
      
      public function get hasAttackTypes() : Boolean
      {
         return (hasField$0 & 0x1000) != 0;
      }
      
      public function set attackTypes(param1:int) : void
      {
         hasField$0 |= 4096;
         attack_types$field = param1;
      }
      
      public function get attackTypes() : int
      {
         return attack_types$field;
      }
      
      public function removeNameColor() : void
      {
         hasField$0 &= 4294959103;
         name_color$field = new int();
      }
      
      public function get hasNameColor() : Boolean
      {
         return (hasField$0 & 0x2000) != 0;
      }
      
      public function set nameColor(param1:int) : void
      {
         hasField$0 |= 8192;
         name_color$field = param1;
      }
      
      public function get nameColor() : int
      {
         return name_color$field;
      }
      
      public function removeSizeType() : void
      {
         hasField$0 &= 4294950911;
         size_type$field = new int();
      }
      
      public function get hasSizeType() : Boolean
      {
         return (hasField$0 & 0x4000) != 0;
      }
      
      public function set sizeType(param1:int) : void
      {
         hasField$0 |= 16384;
         size_type$field = param1;
      }
      
      public function get sizeType() : int
      {
         return size_type$field;
      }
      
      public function removeToward() : void
      {
         hasField$0 &= 4294934527;
         toward$field = new int();
      }
      
      public function get hasToward() : Boolean
      {
         return (hasField$0 & 0x8000) != 0;
      }
      
      public function set toward(param1:int) : void
      {
         hasField$0 |= 32768;
         toward$field = param1;
      }
      
      public function get toward() : int
      {
         return toward$field;
      }
      
      public function removeResource() : void
      {
         hasField$0 &= 4294901759;
         resource$field = new int();
      }
      
      public function get hasResource() : Boolean
      {
         return (hasField$0 & 0x010000) != 0;
      }
      
      public function set resource(param1:int) : void
      {
         hasField$0 |= 65536;
         resource$field = param1;
      }
      
      public function get resource() : int
      {
         return resource$field;
      }
      
      public function removeResetX() : void
      {
         hasField$0 &= 4294836223;
         reset_x$field = new int();
      }
      
      public function get hasResetX() : Boolean
      {
         return (hasField$0 & 0x020000) != 0;
      }
      
      public function set resetX(param1:int) : void
      {
         hasField$0 |= 131072;
         reset_x$field = param1;
      }
      
      public function get resetX() : int
      {
         return reset_x$field;
      }
      
      public function removeResetY() : void
      {
         hasField$0 &= 4294705151;
         reset_y$field = new int();
      }
      
      public function get hasResetY() : Boolean
      {
         return (hasField$0 & 0x040000) != 0;
      }
      
      public function set resetY(param1:int) : void
      {
         hasField$0 |= 262144;
         reset_y$field = param1;
      }
      
      public function get resetY() : int
      {
         return reset_y$field;
      }
      
      public function removeFixType() : void
      {
         hasField$0 &= 4294443007;
         fix_type$field = new int();
      }
      
      public function get hasFixType() : Boolean
      {
         return (hasField$0 & 0x080000) != 0;
      }
      
      public function set fixType(param1:int) : void
      {
         hasField$0 |= 524288;
         fix_type$field = param1;
      }
      
      public function get fixType() : int
      {
         return fix_type$field;
      }
      
      public function removeFixX() : void
      {
         hasField$0 &= 4293918719;
         fix_x$field = new int();
      }
      
      public function get hasFixX() : Boolean
      {
         return (hasField$0 & 0x100000) != 0;
      }
      
      public function set fixX(param1:int) : void
      {
         hasField$0 |= 1048576;
         fix_x$field = param1;
      }
      
      public function get fixX() : int
      {
         return fix_x$field;
      }
      
      public function removeFixY() : void
      {
         hasField$0 &= 4292870143;
         fix_y$field = new int();
      }
      
      public function get hasFixY() : Boolean
      {
         return (hasField$0 & 0x200000) != 0;
      }
      
      public function set fixY(param1:int) : void
      {
         hasField$0 |= 2097152;
         fix_y$field = param1;
      }
      
      public function get fixY() : int
      {
         return fix_y$field;
      }
      
      public function removeHeroTempId() : void
      {
         hasField$0 &= 4290772991;
         hero_tempId$field = new int();
      }
      
      public function get hasHeroTempId() : Boolean
      {
         return (hasField$0 & 0x400000) != 0;
      }
      
      public function set heroTempId(param1:int) : void
      {
         hasField$0 |= 4194304;
         hero_tempId$field = param1;
      }
      
      public function get heroTempId() : int
      {
         return hero_tempId$field;
      }
      
      public function removeHandlerRange() : void
      {
         hasField$0 &= 4286578687;
         handler_range$field = new int();
      }
      
      public function get hasHandlerRange() : Boolean
      {
         return (hasField$0 & 0x800000) != 0;
      }
      
      public function set handlerRange(param1:int) : void
      {
         hasField$0 |= 8388608;
         handler_range$field = param1;
      }
      
      public function get handlerRange() : int
      {
         return handler_range$field;
      }
      
      public function removeFightCapaity() : void
      {
         hasField$0 &= 4278190079;
         fight_capaity$field = new int();
      }
      
      public function get hasFightCapaity() : Boolean
      {
         return (hasField$0 & 0x01000000) != 0;
      }
      
      public function set fightCapaity(param1:int) : void
      {
         hasField$0 |= 16777216;
         fight_capaity$field = param1;
      }
      
      public function get fightCapaity() : int
      {
         return fight_capaity$field;
      }
      
      public function removeParam1() : void
      {
         hasField$0 &= 4261412863;
         param1$field = new int();
      }
      
      public function get hasParam1() : Boolean
      {
         return (hasField$0 & 0x02000000) != 0;
      }
      
      public function set param1(param1:int) : void
      {
         hasField$0 |= 33554432;
         param1$field = param1;
      }
      
      public function get param1() : int
      {
         return param1$field;
      }
      
      public function removeParam2() : void
      {
         hasField$0 &= 4227858431;
         param2$field = new int();
      }
      
      public function get hasParam2() : Boolean
      {
         return (hasField$0 & 0x04000000) != 0;
      }
      
      public function set param2(param1:int) : void
      {
         hasField$0 |= 67108864;
         param2$field = param1;
      }
      
      public function get param2() : int
      {
         return param2$field;
      }
      
      public function removeParam3() : void
      {
         param3$field = null;
      }
      
      public function get hasParam3() : Boolean
      {
         return param3$field != null;
      }
      
      public function set param3(param1:String) : void
      {
         param3$field = param1;
      }
      
      public function get param3() : String
      {
         return param3$field;
      }
      
      public function removeParam4() : void
      {
         param4$field = null;
      }
      
      public function get hasParam4() : Boolean
      {
         return param4$field != null;
      }
      
      public function set param4(param1:String) : void
      {
         param4$field = param1;
      }
      
      public function get param4() : String
      {
         return param4$field;
      }
      
      public function removeParam5() : void
      {
         param5$field = null;
      }
      
      public function get hasParam5() : Boolean
      {
         return param5$field != null;
      }
      
      public function set param5(param1:String) : void
      {
         param5$field = param1;
      }
      
      public function get param5() : String
      {
         return param5$field;
      }
      
      public function removeParam6() : void
      {
         param6$field = null;
      }
      
      public function get hasParam6() : Boolean
      {
         return param6$field != null;
      }
      
      public function set param6(param1:String) : void
      {
         param6$field = param1;
      }
      
      public function get param6() : String
      {
         return param6$field;
      }
      
      public function removeCurrentCount() : void
      {
         hasField$0 &= 4160749567;
         currentCount$field = new int();
      }
      
      public function get hasCurrentCount() : Boolean
      {
         return (hasField$0 & 0x08000000) != 0;
      }
      
      public function set currentCount(param1:int) : void
      {
         hasField$0 |= 134217728;
         currentCount$field = param1;
      }
      
      public function get currentCount() : int
      {
         return currentCount$field;
      }
      
      public function removeArmyId() : void
      {
         hasField$0 &= 4026531839;
         army_id$field = new int();
      }
      
      public function get hasArmyId() : Boolean
      {
         return (hasField$0 & 0x10000000) != 0;
      }
      
      public function set armyId(param1:int) : void
      {
         hasField$0 |= 268435456;
         army_id$field = param1;
      }
      
      public function get armyId() : int
      {
         return army_id$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:* = 0;
         if(hasNodeId)
         {
            WriteUtils.writeTag(param1,0,1);
            WriteUtils.write$TYPE_INT32(param1,node_id$field);
         }
         if(hasCampDataId)
         {
            WriteUtils.writeTag(param1,0,2);
            WriteUtils.write$TYPE_INT32(param1,camp_data_id$field);
         }
         if(hasNodeName)
         {
            WriteUtils.writeTag(param1,2,3);
            WriteUtils.write$TYPE_STRING(param1,node_name$field);
         }
         if(hasMasterType)
         {
            WriteUtils.writeTag(param1,0,4);
            WriteUtils.write$TYPE_INT32(param1,master_type$field);
         }
         if(hasSonType)
         {
            WriteUtils.writeTag(param1,0,5);
            WriteUtils.write$TYPE_INT32(param1,son_type$field);
         }
         if(hasPreNodeIds)
         {
            WriteUtils.writeTag(param1,2,6);
            WriteUtils.write$TYPE_STRING(param1,pre_node_ids$field);
         }
         if(hasNextNodeIds)
         {
            WriteUtils.writeTag(param1,2,7);
            WriteUtils.write$TYPE_STRING(param1,next_node_ids$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,0,8);
            WriteUtils.write$TYPE_INT32(param1,state$field);
         }
         if(hasRefreshSpeed)
         {
            WriteUtils.writeTag(param1,0,9);
            WriteUtils.write$TYPE_INT32(param1,refresh_speed$field);
         }
         if(hasPosX)
         {
            WriteUtils.writeTag(param1,0,10);
            WriteUtils.write$TYPE_INT32(param1,pos_x$field);
         }
         if(hasPosY)
         {
            WriteUtils.writeTag(param1,0,11);
            WriteUtils.write$TYPE_INT32(param1,pos_y$field);
         }
         if(hasCurX)
         {
            WriteUtils.writeTag(param1,0,12);
            WriteUtils.write$TYPE_INT32(param1,cur_x$field);
         }
         if(hasCurY)
         {
            WriteUtils.writeTag(param1,0,13);
            WriteUtils.write$TYPE_INT32(param1,cur_y$field);
         }
         if(hasLevel)
         {
            WriteUtils.writeTag(param1,0,14);
            WriteUtils.write$TYPE_INT32(param1,level$field);
         }
         if(hasStyleType)
         {
            WriteUtils.writeTag(param1,0,15);
            WriteUtils.write$TYPE_INT32(param1,style_type$field);
         }
         if(hasAttackTypes)
         {
            WriteUtils.writeTag(param1,0,16);
            WriteUtils.write$TYPE_INT32(param1,attack_types$field);
         }
         if(hasNameColor)
         {
            WriteUtils.writeTag(param1,0,17);
            WriteUtils.write$TYPE_INT32(param1,name_color$field);
         }
         if(hasSizeType)
         {
            WriteUtils.writeTag(param1,0,18);
            WriteUtils.write$TYPE_INT32(param1,size_type$field);
         }
         if(hasToward)
         {
            WriteUtils.writeTag(param1,0,19);
            WriteUtils.write$TYPE_INT32(param1,toward$field);
         }
         if(hasResource)
         {
            WriteUtils.writeTag(param1,0,20);
            WriteUtils.write$TYPE_INT32(param1,resource$field);
         }
         if(hasResetX)
         {
            WriteUtils.writeTag(param1,0,21);
            WriteUtils.write$TYPE_INT32(param1,reset_x$field);
         }
         if(hasResetY)
         {
            WriteUtils.writeTag(param1,0,22);
            WriteUtils.write$TYPE_INT32(param1,reset_y$field);
         }
         _loc2_ = 0;
         while(_loc2_ < visitUserIds.length)
         {
            WriteUtils.writeTag(param1,0,23);
            WriteUtils.write$TYPE_INT32(param1,visitUserIds[_loc2_]);
            _loc2_++;
         }
         if(hasFixType)
         {
            WriteUtils.writeTag(param1,0,24);
            WriteUtils.write$TYPE_INT32(param1,fix_type$field);
         }
         if(hasFixX)
         {
            WriteUtils.writeTag(param1,0,25);
            WriteUtils.write$TYPE_INT32(param1,fix_x$field);
         }
         if(hasFixY)
         {
            WriteUtils.writeTag(param1,0,26);
            WriteUtils.write$TYPE_INT32(param1,fix_y$field);
         }
         if(hasHeroTempId)
         {
            WriteUtils.writeTag(param1,0,27);
            WriteUtils.write$TYPE_INT32(param1,hero_tempId$field);
         }
         if(hasHandlerRange)
         {
            WriteUtils.writeTag(param1,0,28);
            WriteUtils.write$TYPE_INT32(param1,handler_range$field);
         }
         if(hasFightCapaity)
         {
            WriteUtils.writeTag(param1,0,29);
            WriteUtils.write$TYPE_INT32(param1,fight_capaity$field);
         }
         if(hasParam1)
         {
            WriteUtils.writeTag(param1,0,30);
            WriteUtils.write$TYPE_INT32(param1,param1$field);
         }
         if(hasParam2)
         {
            WriteUtils.writeTag(param1,0,31);
            WriteUtils.write$TYPE_INT32(param1,param2$field);
         }
         if(hasParam3)
         {
            WriteUtils.writeTag(param1,2,32);
            WriteUtils.write$TYPE_STRING(param1,param3$field);
         }
         if(hasParam4)
         {
            WriteUtils.writeTag(param1,2,33);
            WriteUtils.write$TYPE_STRING(param1,param4$field);
         }
         if(hasParam5)
         {
            WriteUtils.writeTag(param1,2,34);
            WriteUtils.write$TYPE_STRING(param1,param5$field);
         }
         if(hasParam6)
         {
            WriteUtils.writeTag(param1,2,35);
            WriteUtils.write$TYPE_STRING(param1,param6$field);
         }
         if(hasCurrentCount)
         {
            WriteUtils.writeTag(param1,0,36);
            WriteUtils.write$TYPE_INT32(param1,currentCount$field);
         }
         if(hasArmyId)
         {
            WriteUtils.writeTag(param1,0,37);
            WriteUtils.write$TYPE_INT32(param1,army_id$field);
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc19_:* = 0;
         var _loc6_:uint = 0;
         var _loc17_:uint = 0;
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc36_:uint = 0;
         var _loc20_:uint = 0;
         var _loc16_:uint = 0;
         var _loc34_:uint = 0;
         var _loc9_:uint = 0;
         var _loc24_:uint = 0;
         var _loc31_:uint = 0;
         var _loc13_:uint = 0;
         var _loc25_:uint = 0;
         var _loc26_:uint = 0;
         var _loc38_:uint = 0;
         var _loc21_:uint = 0;
         var _loc22_:uint = 0;
         var _loc27_:uint = 0;
         var _loc8_:uint = 0;
         var _loc7_:uint = 0;
         var _loc33_:uint = 0;
         var _loc5_:uint = 0;
         var _loc18_:uint = 0;
         var _loc35_:uint = 0;
         var _loc32_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc28_:uint = 0;
         var _loc23_:uint = 0;
         var _loc29_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc39_:uint = 0;
         var _loc30_:uint = 0;
         var _loc37_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            switch((_loc19_ = ReadUtils.read$TYPE_UINT32(param1)) >>> 3)
            {
               case 1:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.nodeId cannot be set twice.");
                  }
                  _loc6_++;
                  nodeId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc17_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.campDataId cannot be set twice.");
                  }
                  _loc17_++;
                  campDataId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.nodeName cannot be set twice.");
                  }
                  _loc10_++;
                  nodeName = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 4:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.masterType cannot be set twice.");
                  }
                  _loc3_++;
                  masterType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.sonType cannot be set twice.");
                  }
                  _loc4_++;
                  sonType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc36_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.preNodeIds cannot be set twice.");
                  }
                  _loc36_++;
                  preNodeIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 7:
                  if(_loc20_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.nextNodeIds cannot be set twice.");
                  }
                  _loc20_++;
                  nextNodeIds = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 8:
                  if(_loc16_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.state cannot be set twice.");
                  }
                  _loc16_++;
                  state = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc34_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.refreshSpeed cannot be set twice.");
                  }
                  _loc34_++;
                  refreshSpeed = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.posX cannot be set twice.");
                  }
                  _loc9_++;
                  posX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 11:
                  if(_loc24_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.posY cannot be set twice.");
                  }
                  _loc24_++;
                  posY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 12:
                  if(_loc31_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.curX cannot be set twice.");
                  }
                  _loc31_++;
                  curX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.curY cannot be set twice.");
                  }
                  _loc13_++;
                  curY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 14:
                  if(_loc25_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.level cannot be set twice.");
                  }
                  _loc25_++;
                  level = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 15:
                  if(_loc26_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.styleType cannot be set twice.");
                  }
                  _loc26_++;
                  styleType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 16:
                  if(_loc38_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.attackTypes cannot be set twice.");
                  }
                  _loc38_++;
                  attackTypes = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 17:
                  if(_loc21_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.nameColor cannot be set twice.");
                  }
                  _loc21_++;
                  nameColor = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 18:
                  if(_loc22_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.sizeType cannot be set twice.");
                  }
                  _loc22_++;
                  sizeType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 19:
                  if(_loc27_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.toward cannot be set twice.");
                  }
                  _loc27_++;
                  toward = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 20:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.resource cannot be set twice.");
                  }
                  _loc8_++;
                  resource = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 21:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.resetX cannot be set twice.");
                  }
                  _loc7_++;
                  resetX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 22:
                  if(_loc33_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.resetY cannot be set twice.");
                  }
                  _loc33_++;
                  resetY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 23:
                  if((_loc19_ & 7) == 2)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,visitUserIds);
                  }
                  else
                  {
                     visitUserIds.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 24:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.fixType cannot be set twice.");
                  }
                  _loc5_++;
                  fixType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 25:
                  if(_loc18_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.fixX cannot be set twice.");
                  }
                  _loc18_++;
                  fixX = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 26:
                  if(_loc35_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.fixY cannot be set twice.");
                  }
                  _loc35_++;
                  fixY = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 27:
                  if(_loc32_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.heroTempId cannot be set twice.");
                  }
                  _loc32_++;
                  heroTempId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 28:
                  if(_loc14_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.handlerRange cannot be set twice.");
                  }
                  _loc14_++;
                  handlerRange = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 29:
                  if(_loc15_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.fightCapaity cannot be set twice.");
                  }
                  _loc15_++;
                  fightCapaity = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 30:
                  if(_loc28_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.param1 cannot be set twice.");
                  }
                  _loc28_++;
                  param1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 31:
                  if(_loc23_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.param2 cannot be set twice.");
                  }
                  _loc23_++;
                  param2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 32:
                  if(_loc29_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.param3 cannot be set twice.");
                  }
                  _loc29_++;
                  param3 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 33:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.param4 cannot be set twice.");
                  }
                  _loc11_++;
                  param4 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 34:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.param5 cannot be set twice.");
                  }
                  _loc12_++;
                  param5 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 35:
                  if(_loc39_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.param6 cannot be set twice.");
                  }
                  _loc39_++;
                  param6 = ReadUtils.read$TYPE_STRING(param1);
                  break;
               case 36:
                  if(_loc30_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.currentCount cannot be set twice.");
                  }
                  _loc30_++;
                  currentCount = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 37:
                  if(_loc37_ != 0)
                  {
                     throw new IOError("Bad data format: CampaignNodeMsg.armyId cannot be set twice.");
                  }
                  _loc37_++;
                  armyId = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc19_ & 7);
            }
         }
      }
   }
}

