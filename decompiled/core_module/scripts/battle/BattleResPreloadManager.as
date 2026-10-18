package battle
{
   import battle.skillsys.loader.SkillResLoaderVO;
   import battle.skillsys.loader.SkillResourceLoader;
   import battle.view.roles.HeroLoadDataFactory;
   import com.pickgliss.loader.LoaderManagerII;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.HeroAisTemplate;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   
   public class BattleResPreloadManager
   {
      
      public function BattleResPreloadManager()
      {
         super();
      }
      
      public static function load(param1:Array, param2:Array, param3:int = -1) : void
      {
         var _loc4_:Array = getPaths(param1,param2,param3);
         loadPaths(_loc4_);
      }
      
      public static function getPaths(param1:Array, param2:Array, param3:int) : Array
      {
         var _loc7_:int = 0;
         var _loc15_:GameHeroTempInfo = null;
         var _loc16_:HeroAisTemplate = null;
         var _loc5_:int = 0;
         var _loc18_:PawnTemplate = null;
         var _loc10_:int = 0;
         var _loc4_:Array = [];
         var _loc13_:Array = [];
         var _loc17_:Array = [];
         var _loc12_:Array = [];
         if(param3 > 0)
         {
            _loc4_.push(PathManager.getBattleMapPath(param3));
         }
         _loc4_.push(PathManager.info.ResourcePath + "skillEffect/skill_public.swf");
         var _loc14_:Array = [];
         var _loc19_:Array = [];
         if(param2 && param2.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < param2.length)
            {
               _loc15_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param2[_loc7_]);
               if(_loc15_)
               {
                  _loc16_ = TempleteManager.instance.heroAISTemplateCate.getTemplateByID(_loc15_.AI);
                  _loc5_ = _loc15_.DefaultSkill;
                  if(_loc13_.indexOf(_loc5_) == -1)
                  {
                     _loc13_.push(_loc5_);
                     _loc19_.push(_loc5_);
                  }
                  if(_loc16_)
                  {
                     _loc13_ = _loc13_.concat(_loc16_.getSkills());
                  }
                  if(_loc15_.HeroType == 3)
                  {
                     _loc12_.push(PathManager.solveRolePath(_loc15_.ResPath));
                  }
                  loadBossIconById(param2[_loc7_]);
               }
               _loc7_++;
            }
         }
         _loc13_ = _loc13_.concat(SkillResourceLoader.getHeroFullSkillIds(_loc19_));
         if(param1 && param1.length > 0)
         {
            _loc7_ = 0;
            while(_loc7_ < param1.length)
            {
               _loc14_ = _loc14_.concat(SkillResourceLoader.getPawnSkillIds(param1[_loc7_]));
               _loc18_ = TempleteManager.instance.pawnTemplateCate.getTemplateByID(param1[_loc7_]);
               for each(var _loc8_:int in _loc14_)
               {
                  if(_loc8_ != 0 && _loc13_.indexOf(_loc8_) == -1)
                  {
                     _loc13_.push(_loc8_);
                  }
               }
               if(_loc18_)
               {
                  _loc16_ = TempleteManager.instance.heroAISTemplateCate.getTemplateByID(_loc18_.AI);
                  if(_loc16_)
                  {
                     _loc13_ = _loc13_.concat(_loc16_.getSkills());
                  }
                  _loc12_.push(PathManager.solveRolePath(_loc18_.Swf));
               }
               _loc7_++;
            }
         }
         for each(_loc10_ in _loc13_)
         {
            _loc17_.push(new SkillResLoaderVO(_loc10_,2));
         }
         var _loc11_:ThaneInfo = thane;
         var _loc9_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc11_.templateId);
         var _loc6_:Array = thane.skillCate.skillScript.split(",");
         _loc6_ = _loc6_.concat(SkillResourceLoader.getHeroFullSkillIds(_loc6_));
         if(_loc9_)
         {
            _loc6_.push(_loc9_.DefaultSkill);
            for each(_loc10_ in _loc6_)
            {
               _loc17_.push(new SkillResLoaderVO(_loc10_,_loc9_.Sexs));
            }
         }
         _loc12_.push(HeroLoadDataFactory.create(_loc11_,"arms2",PathManager.isShowDragon(_loc11_)).urlPath);
         _loc12_.push(HeroLoadDataFactory.create(_loc11_,"hair4",PathManager.isShowDragon(_loc11_)).urlPath);
         _loc12_.push(HeroLoadDataFactory.create(_loc11_,"body",PathManager.isShowDragon(_loc11_)).urlPath);
         _loc12_.push(HeroLoadDataFactory.create(_loc11_,"cloak2",PathManager.isShowDragon(_loc11_)).urlPath);
         _loc13_ = _loc13_.concat(_loc6_);
         _loc4_ = _loc4_.concat(_loc12_);
         return _loc4_.concat(SkillResourceLoader.getSkillResPaths(_loc17_));
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public static function loadBossIconById(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1);
         if(_loc2_)
         {
            _loc3_ = IconFactory.getHeroIconByPics(_loc2_.Icon);
            LoaderManagerII.instance.load(_loc3_,2,7,null);
         }
      }
      
      public static function loadSelfSkill(param1:Boolean = true) : Array
      {
         var _loc2_:Array = [];
         var _loc4_:ThaneInfo = thane;
         var _loc7_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc4_.templateId);
         var _loc5_:Array = thane.skillCate.skillScript.split(",");
         var _loc6_:Array = [];
         _loc5_ = _loc5_.concat(SkillResourceLoader.getHeroFullSkillIds(_loc5_));
         if(_loc7_)
         {
            _loc5_.push(_loc7_.DefaultSkill);
         }
         for each(var _loc3_:int in _loc5_)
         {
            _loc6_.push(new SkillResLoaderVO(_loc3_,_loc7_.Sexs));
         }
         _loc2_ = SkillResourceLoader.getSkillResPaths(_loc6_);
         if(param1)
         {
            loadPaths(_loc2_);
         }
         return _loc2_;
      }
      
      public static function loadPaths(param1:Array) : void
      {
         for each(var _loc2_:String in param1)
         {
            LoaderManagerII.instance.load(_loc2_,1,7,null);
         }
      }
   }
}

