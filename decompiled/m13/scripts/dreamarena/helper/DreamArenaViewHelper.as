package dreamarena.helper
{
   import manager.LanguageMgr;
   import mvc.module.dreamarena.DreamArenaSelectRoleInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class DreamArenaViewHelper
   {
      
      public function DreamArenaViewHelper()
      {
         super();
      }
      
      public static function getLeftItemData(param1:int, param2:DreamArenaSelectRoleInfo) : Object
      {
         var _loc4_:DreamArenaTempInfo = null;
         var _loc5_:SkillTempInfo = null;
         var _loc6_:SkillPropertyTempInfo = null;
         var _loc7_:int = 0;
         if(!param2.initInfo)
         {
            return null;
         }
         var _loc3_:Object = {};
         _loc3_.frame = param1 + 3;
         _loc3_.content = "";
         _loc3_.tipStyle = null;
         _loc3_.tipData = null;
         switch(param1 - 1)
         {
            case 0:
               if(!param2.getHeroTempInfo())
               {
                  _loc3_.icon = IconFactory.getHeroIconByPics(getDragonTalkerIcon());
               }
               else
               {
                  _loc7_ = int(param2.getHeroTempInfo().Job);
                  _loc3_.icon = IconFactory.getHeroIconByPics(param2.getHeroTempInfo().Icon);
                  _loc3_.frame = _loc7_;
                  _loc3_.content = LanguageMgr.GetTranslation("DreamArenaLeftItem.heroSelect.skill" + _loc7_ + param2.skillIndex1);
               }
               break;
            case 1:
               _loc3_.icon = IconFactory.getTecIconByIcon(param2.getRuneTempInfoById(param2.runeId1).Icon);
               _loc3_.tipStyle = "yishi.view.tips.goods.RuneTips";
               _loc3_.tipData = param2.getRuneTempInfoById(param2.runeId1);
               break;
            case 2:
               _loc4_ = param2.getDreamArenaById(param2.heroPetId);
               _loc3_.icon = IconFactory.getPetHeadSmallIcon(param2.getPetTempInfoById(param2.heroPetId).TemplateId);
               _loc3_.content = param2.getPetTempInfoById(param2.heroPetId).TemplateName;
               _loc3_.tipStyle = "yishi.view.tips.DreamArenaPetTips";
               _loc3_.tipData = _loc4_;
               break;
            case 3:
               _loc4_ = param2.getDreamArenaById(param2.artifactId);
               _loc5_ = TempleteManager.instance.skillTemplateDic[_loc4_.Skill1];
               _loc6_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc4_.PropertyId);
               _loc3_.icon = IconFactory.getCommonIconPath(param2.getArtifactTempInfo().Icon);
               _loc3_.content = param2.getArtifactTempInfo().TemplateName;
               _loc3_.tipStyle = "yishi.view.tips.goods.ArtifactEquipTip";
               _loc3_.tipData = {
                  "type":"dreamArena",
                  "tempInfo":param2.getArtifactTempInfo(),
                  "skillTemp":_loc5_,
                  "propTemp":_loc6_
               };
               break;
            case 4:
               _loc4_ = param2.getDreamArenaById(param2.goddessId);
               _loc6_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(_loc4_.PropertyId);
               _loc3_.icon = PathManager.getGoddessSmallIcon(param2.getGoddessTempInfo().TemplateId);
               _loc3_.content = param2.getGoddessTempInfo().TemplateName;
               _loc3_.tipStyle = "yishi.view.tips.OneLineTip";
               _loc3_.tipData = LanguageMgr.GetTranslation("playerinfo.propContiner.tipdata",_loc6_.Attack,_loc6_.Defence,_loc6_.MagicDefence,_loc6_.Live);
               break;
            case 5:
               _loc3_.icon = IconFactory.getCommonIconPath("/titan/0.png");
               break;
            case 6:
               _loc3_.icon = IconFactory.getHeroIconByPics(param2.getChildTempInfoById(param2.mainChildId).Icon);
               _loc4_ = param2.getDreamArenaById(param2.mainChildId);
               _loc3_.tipStyle = "yishi.view.tips.ChildrenFigureTip";
               _loc3_.tipData = _loc4_;
               break;
            case 7:
               _loc3_.icon = IconFactory.getHeroIconByPics(param2.getChildTempInfoById(param2.slaveChildId).Icon);
               _loc4_ = param2.getDreamArenaById(param2.slaveChildId);
               _loc3_.tipStyle = "yishi.view.tips.ChildrenFigureTip";
               _loc3_.tipData = _loc4_;
               break;
            default:
               return null;
         }
         return _loc3_;
      }
      
      public static function getDragonTalkerIcon() : String
      {
         return playerInfo.sexs == 0 ? "/player/102/head.png" : "/player/101/head.png";
      }
      
      private static function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

