package mvc.module.dreamarena
{
   import managers.DreamArenaManager;
   import mvc.module.children.ChildData;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ArmoryTemplateInfo;
   import yishi.datas.templates.ArtifactTemplateInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class DreamArenaSelectRoleInfo
   {
      
      public var userId:int;
      
      public var heroId:int;
      
      public var heroPetId:int;
      
      public var goddessId:int;
      
      public var mainChildId:int;
      
      public var slaveChildId:int;
      
      public var artifactId:int;
      
      public var titanSkills:String;
      
      public var titanSkillAry:Array;
      
      public var skillIndex1:int;
      
      public var skillIndex2:int;
      
      public var talismanTempId1:int;
      
      public var talismanTempId2:int;
      
      public var talismanSkillId1:int;
      
      public var talismanSkillId2:int;
      
      public var talismanSkillsAry:Array;
      
      public var dragonSkill:String;
      
      public var dragonPassiveSkill:String;
      
      public var armoryId1:int;
      
      public var armoryId2:int;
      
      public var armoryId3:int;
      
      public var armoryAry:Array;
      
      public var mainChildPetId:int;
      
      public var slaveChildPetId:int;
      
      public var runeId1:int;
      
      public var runeId2:int;
      
      public var runeArys:Array;
      
      public var heroFightPos:int;
      
      public var thane:ThaneInfo;
      
      public var mainChildData:ChildData;
      
      public var slaveChildData:ChildData;
      
      public var selfSelectJob:int;
      
      public var initInfo:Boolean = false;
      
      public function DreamArenaSelectRoleInfo()
      {
         super();
         thane = new ThaneInfo();
         mainChildData = new ChildData();
         slaveChildData = new ChildData();
         titanSkillAry = [];
         armoryAry = [];
         talismanSkillsAry = [];
      }
      
      public function setOtherData() : void
      {
         var _loc4_:Array = null;
         var _loc2_:GoodsTemplateInfo = null;
         armoryAry = [armoryId1,armoryId2,armoryId3];
         talismanSkillsAry = [talismanTempId1,talismanSkillId1,talismanTempId2,talismanSkillId2];
         titanSkillAry = titanSkills.split(",");
         runeArys = [runeId1,runeId2];
         var _loc1_:DreamArenaTempInfo = getDreamArenaById(heroId);
         if(_loc1_)
         {
            _loc4_ = _loc1_.Param2.split(",");
            if(_loc4_.length >= 4)
            {
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_[0]);
               if(_loc2_)
               {
                  thane.wingAvata = _loc2_.Avata;
               }
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_[1]);
               if(_loc2_)
               {
                  thane.hairEquipAvata = _loc2_.Avata;
                  thane.hairFashionAvata = _loc2_.Avata;
               }
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_[2]);
               if(_loc2_)
               {
                  thane.armsFashionAvata = _loc2_.Avata;
               }
               _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_[3]);
               if(_loc2_)
               {
                  thane.bodyEquipAvata = _loc2_.Avata;
                  thane.bodyFashionAvata = _loc2_.Avata;
               }
            }
            if(_loc1_.TypeTemplateId == 0)
            {
               thane.templateId = selfThane.templateId;
               selfSelectJob = 4;
               model.selectJob = 4;
               thane.dragonTalkerInfo.isDragonTalker = true;
            }
            else
            {
               model.selectJob = _loc1_.TypeTemplateId;
               selfSelectJob = _loc1_.TypeTemplateId;
               thane.templateId = playerInfo.sexs == 0 ? _loc1_.TypeTemplateId + 3 : _loc1_.TypeTemplateId;
               thane.dragonTalkerInfo.isDragonTalker = false;
            }
         }
         var _loc5_:ChildTempInfo = getChildTempInfoById(mainChildId);
         if(_loc5_)
         {
            mainChildData.job = _loc5_.JobType;
            mainChildData.growthGrade = _loc5_.Grades;
            mainChildData.isSlaveChild = false;
         }
         var _loc3_:ChildTempInfo = getChildTempInfoById(slaveChildId);
         if(_loc3_)
         {
            slaveChildData.job = _loc3_.JobType;
            slaveChildData.growthGrade = _loc3_.Grades;
            slaveChildData.isSlaveChild = true;
         }
         initInfo = true;
      }
      
      public function getDreamArenaById(param1:int) : DreamArenaTempInfo
      {
         return TempleteManager.instance.dreamArenaTempCate.getTemplateById(param1);
      }
      
      public function getHeroTempInfo() : GameHeroTempInfo
      {
         var _loc2_:DreamArenaTempInfo = getDreamArenaById(heroId);
         if(!_loc2_ || _loc2_.TypeTemplateId == 0)
         {
            return null;
         }
         var _loc1_:int = int(playerInfo.sexs == 0 ? _loc2_.TypeTemplateId + 3 : _loc2_.TypeTemplateId);
         return TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc1_);
      }
      
      public function getPetTempInfoById(param1:int) : PetTemplate
      {
         var _loc2_:DreamArenaTempInfo = getDreamArenaById(param1);
         return _loc2_ ? _loc2_.typeTempInfo as PetTemplate : null;
      }
      
      public function getChildTempInfoById(param1:int) : ChildTempInfo
      {
         var _loc2_:DreamArenaTempInfo = getDreamArenaById(param1);
         return _loc2_ ? _loc2_.typeTempInfo as ChildTempInfo : null;
      }
      
      public function getGoddessTempInfo() : GoddessTempInfo
      {
         var _loc1_:DreamArenaTempInfo = getDreamArenaById(goddessId);
         return _loc1_ ? _loc1_.typeTempInfo as GoddessTempInfo : null;
      }
      
      public function getArtifactTempInfo() : ArtifactTemplateInfo
      {
         var _loc1_:DreamArenaTempInfo = getDreamArenaById(artifactId);
         return _loc1_ ? _loc1_.typeTempInfo as ArtifactTemplateInfo : null;
      }
      
      public function getArmoryTempInfoById(param1:int) : ArmoryTemplateInfo
      {
         var _loc2_:DreamArenaTempInfo = getDreamArenaById(param1);
         return _loc2_ ? _loc2_.typeTempInfo as ArmoryTemplateInfo : null;
      }
      
      public function getRuneTempInfoById(param1:int) : RuneTemplateInfo
      {
         var _loc2_:DreamArenaTempInfo = getDreamArenaById(param1);
         return _loc2_ ? _loc2_.typeTempInfo as RuneTemplateInfo : null;
      }
      
      private function get selfThane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
   }
}

