package yishi.manager
{
   import com.road.yishi.proto.player.ArmoryInfoMsg;
   import com.road.yishi.proto.player.ArtifactInfoMsg;
   import com.road.yishi.proto.player.ArtifactMsg;
   import com.road.yishi.proto.player.ResonatePosMsg;
   import events.AncientArtifactEvent;
   import flash.utils.Dictionary;
   import mvc.module.ancientartifact.AncientArmoryInfo;
   import mvc.module.ancientartifact.AncientArtifactInfo;
   import mvc.module.ancientartifact.AncientArtifactModel;
   import mvc.module.ancientartifact.AncientResonateInfo;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class AncientArtifactManager
   {
      
      private static var _instance:AncientArtifactManager;
      
      public static var OPEN:int = 1;
      
      public static var ADVANCE:int = 2;
      
      public static var STRENGTHEN:int = 3;
      
      public static var EQUIP:int = 4;
      
      public static var SUMMON:int = 5;
      
      public static var RESON_EQUIP:int = 6;
      
      public static var RESON_UPGRADE:int = 7;
      
      public static var ARMORY_EQUIP:int = 8;
      
      public static var ARMORY_UPGRADE:int = 9;
      
      public static var ARMORY_ADVANCE:int = 10;
      
      public static var ARMORY_SALE:int = 11;
      
      public static var ARMORY_RESOLVE:int = 12;
      
      private var _model:AncientArtifactModel;
      
      public var openArtifact:Boolean = true;
      
      public var selectTempId:int;
      
      public var isDrag:Boolean;
      
      public function AncientArtifactManager()
      {
         super();
      }
      
      public static function get instance() : AncientArtifactManager
      {
         if(!_instance)
         {
            _instance = new AncientArtifactManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         _model = new AncientArtifactModel();
         initEvent();
      }
      
      public function get model() : AncientArtifactModel
      {
         return _model;
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 438,__artifactInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 455,__armoryGoodsInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 456,__armoryGoodsUpdataHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 457,__artifactArmoryPosInfoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 458,__artifactResonatePosInfoHandler);
      }
      
      private function __artifactResonatePosInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ResonatePosMsg = null;
         var _loc7_:AncientResonateInfo = null;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactMsg = new ArtifactMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ArtifactMsg;
         _model.resonatePosList = [];
         var _loc3_:int = int(_loc2_.resonatePos.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.resonatePos[_loc5_];
            _loc7_ = new AncientResonateInfo();
            _loc7_.posGrades = _loc4_.posGrades;
            _loc7_.posGp = _loc4_.posGp;
            _loc7_.pos = _loc4_.pos;
            _model.resonatePosList.push(_loc7_);
            _loc5_ += 1;
         }
         _model.dispatchEvent(new AncientArtifactEvent("RESONATE_INFO_UP_DATA"));
      }
      
      private function __artifactArmoryPosInfoHandler(param1:SLGSocketEvent) : void
      {
      }
      
      private function __armoryGoodsUpdataHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:ArmoryInfoMsg = null;
         var _loc10_:AncientArmoryInfo = null;
         var _loc11_:int = 0;
         var _loc9_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactMsg = new ArtifactMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as ArtifactMsg;
         var _loc4_:int = int(_loc2_.armoryInfo.length);
         var _loc3_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = _loc2_.armoryInfo[_loc6_];
            _loc11_ = _loc5_.armoryId;
            _loc9_ = _loc5_.isExist;
            if(!_loc9_)
            {
               _model.deleteArmoryInfoById(_loc11_);
               _loc7_ = _model.chooseList.indexOf(_loc11_);
               if(_loc7_ >= 0)
               {
                  _model.chooseList.splice(_loc7_,1);
                  _loc3_ = true;
               }
            }
            else
            {
               _loc10_ = _model.getArmoryInfoById(_loc11_);
               if(!_loc10_)
               {
                  _loc10_ = new AncientArmoryInfo();
                  _model.armorylist.push(_loc10_);
               }
               _loc10_.armoryId = _loc11_;
               _loc10_.templateId = _loc5_.templateId;
               _loc10_.profile = _loc5_.profile;
               _loc10_.attacks = _loc5_.attacks;
               _loc10_.defences = _loc5_.phyDefence;
               _loc10_.magicDefences = _loc5_.magicDefence;
               _loc10_.live = _loc5_.live;
               _loc10_.parry = _loc5_.parry;
               _loc10_.penetrate = _loc5_.penetrate;
               _loc10_.gp = _loc5_.gp;
               _loc10_.grades = _loc5_.grades;
               _loc10_.isEquip = _loc5_.isEquip;
               if(model.chooseId == _loc11_)
               {
                  if(model.currentArmoryIndx == 1)
                  {
                     _model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",_loc10_));
                  }
                  else if(model.currentArmoryIndx == 2)
                  {
                     _model.chooseId = 0;
                     _model.chooseList = [];
                     _model.isGradeItemInfo = false;
                     _model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA",[null,-1]));
                  }
               }
            }
            _loc6_ += 1;
         }
         _model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
         if(_loc3_ && model.currentArmoryIndx == 3)
         {
            _model.dispatchEvent(new AncientArtifactEvent("ARMORY_CHOOSE_DATA"));
         }
      }
      
      private function __armoryGoodsInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:ArmoryInfoMsg = null;
         var _loc8_:AncientArmoryInfo = null;
         var _loc9_:int = 0;
         var _loc7_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactMsg = new ArtifactMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as ArtifactMsg;
         _model.armorylist = [];
         var _loc3_:int = int(_loc2_.armoryInfo.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.armoryInfo[_loc5_];
            _loc9_ = _loc4_.armoryId;
            _loc7_ = _loc4_.isExist;
            if(!_loc7_)
            {
               _model.deleteArmoryInfoById(_loc9_);
            }
            else
            {
               _model.deleteArmoryInfoById(_loc9_);
               _loc8_ = new AncientArmoryInfo();
               _loc8_.armoryId = _loc9_;
               _loc8_.templateId = _loc4_.templateId;
               _loc8_.profile = _loc4_.profile;
               _loc8_.attacks = _loc4_.attacks;
               _loc8_.defences = _loc4_.phyDefence;
               _loc8_.magicDefences = _loc4_.magicDefence;
               _loc8_.live = _loc4_.live;
               _loc8_.parry = _loc4_.parry;
               _loc8_.penetrate = _loc4_.penetrate;
               _loc8_.gp = _loc4_.gp;
               _loc8_.grades = _loc4_.grades;
               _loc8_.isEquip = _loc4_.isEquip;
               _model.armorylist.push(_loc8_);
            }
            _loc5_ += 1;
         }
         _model.dispatchEvent(new AncientArtifactEvent("ARMORY_BAG_UP_DATA"));
      }
      
      private function __artifactInfoHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:AncientArtifactInfo = null;
         var _loc4_:ArtifactInfoMsg = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:ArtifactMsg = new ArtifactMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as ArtifactMsg;
         var _loc3_:int = int(_loc2_.infos.length);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc2_.infos[_loc5_];
            _loc6_ = _loc4_.templateId;
            _loc8_ = _model.getArtifactInfoById(_loc6_);
            if(!_loc8_)
            {
               _loc8_ = new AncientArtifactInfo();
               _model.artifactList.push(_loc8_);
            }
            _loc8_.templateId = _loc6_;
            _loc8_.level = _loc4_.level;
            _loc8_.gp = _loc4_.gp;
            _loc8_.attack = _loc4_.attack;
            _loc8_.defences = _loc4_.defences;
            _loc8_.magicAttack = _loc4_.magicAttack;
            _loc8_.magicDefences = _loc4_.magicDefences;
            _loc8_.penetrate = _loc4_.penetrate;
            _loc8_.parry = _loc4_.parry;
            _loc8_.live = _loc4_.live;
            _loc8_.skills = _loc4_.skills;
            _loc8_.isEquip = _loc4_.isEquip;
            _loc8_.addPer = _loc4_.addPer;
            _loc8_.fightPower = _loc4_.fightPower;
            _loc8_.slotedEquipPos1 = _loc4_.slotedEquipPos1;
            _loc8_.slotedEquipPos2 = _loc4_.slotedEquipPos2;
            _loc8_.slotedEquipPos3 = _loc4_.slotedEquipPos3;
            _loc8_.slotedEquipPos4 = _loc4_.slotedEquipPos4;
            _loc8_.slotedEquipPos5 = _loc4_.slotedEquipPos5;
            _loc8_.armoryEquipPos1 = _loc4_.armoryEquipPos1;
            _loc8_.armoryEquipPos2 = _loc4_.armoryEquipPos2;
            _loc8_.armoryEquipPos3 = _loc4_.armoryEquipPos3;
            _loc8_.armoryEquipPos4 = _loc4_.armoryEquipPos4;
            _loc8_.armoryEquipPos5 = _loc4_.armoryEquipPos5;
            _loc8_.armoryEquipPos6 = _loc4_.armoryEquipPos6;
            _loc8_.skillList = _loc4_.suitSkill;
            _loc5_ += 1;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("ARTIFACT_INFO_UPDATE"));
      }
      
      public function getIsEquipIdx() : int
      {
         var _loc3_:AncientArtifactInfo = null;
         var _loc1_:int = 0;
         var _loc2_:Array = getArtifactTemplates();
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = _model.getArtifactInfoById(_loc2_[_loc1_].TemplateId);
            if(_loc3_ && _loc3_.isEquip)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return 0;
      }
      
      public function getArtifactTemplates() : Array
      {
         var _loc3_:ArtifactTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc1_:Array = [];
         var _loc5_:Dictionary = TempleteManager.instance.artifactTemplateCate.getTemplates();
         for each(var _loc2_:ArtifactTemplateInfo in _loc5_)
         {
            if(_loc2_.IsOpen == 1)
            {
               _loc1_.push(_loc2_);
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc4_];
            _loc3_.IsData = _model.getArtifactInfoById(_loc3_.TemplateId) ? 1 : 2;
            _loc4_++;
         }
         _loc1_.sortOn(["IsData","TemplateId"],[16,16]);
         return _loc1_;
      }
      
      public function OperateArtifactReq(param1:int, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:int = 1, param6:int = 0, param7:Array = null) : void
      {
         var _loc9_:PackageOut = new PackageOut(9649);
         var _loc8_:ArtifactMsg = new ArtifactMsg();
         _loc8_.op = param1;
         _loc8_.templateId = param2;
         _loc8_.count = param3;
         _loc8_.isEquip = param4;
         _loc8_.pos = param5;
         _loc8_.armoryId = param6;
         if(param1 == ARMORY_ADVANCE)
         {
            _loc8_.consumeArmoryIds = param7;
         }
         else if(param1 == ARMORY_RESOLVE)
         {
            _loc8_.consumeArmoryIds = param7;
         }
         SocketSendManager.instance.sendProtoBuffer(_loc9_,_loc8_);
      }
   }
}

