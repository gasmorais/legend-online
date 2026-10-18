package battle.skillsys.loader
{
   import battle.BattleManager;
   import battle.skillsys.mode.ActionTemplateData;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.datas.templates.PawnTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.TalentEffectInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   
   public class SkillResourceLoader
   {
      
      private static var _notLoad:Boolean;
      
      private static var _paths:Array;
      
      private static var _linkNames:Array = [];
      
      private static var _ids:Array = [];
      
      private static var loaderList:Dictionary = new Dictionary();
      
      public function SkillResourceLoader()
      {
         super();
      }
      
      public static function add(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = int(param1.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = int(param1[_loc3_]);
            if(_ids.indexOf(_loc4_) == -1)
            {
               _ids.push(_loc4_);
               addSkill(_loc4_,2);
            }
            _loc3_++;
         }
      }
      
      public static function addSkillVOs(param1:Array) : void
      {
         var _loc3_:SkillResLoaderVO = null;
         var _loc4_:int = 0;
         var _loc2_:int = int(param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1[_loc4_];
            addSkill(_loc3_.skillId,_loc3_.sex);
            _loc4_++;
         }
      }
      
      private static function loadBufferResource(param1:BufferTemplateInfo) : void
      {
         var _loc2_:Array = null;
         if(param1)
         {
            _loc2_ = param1.getActionEffectArr();
            if(_loc2_[0])
            {
               addLoaderByLinkName(_loc2_[0]);
            }
            _loc2_ = param1.getAddEffectArr();
            if(_loc2_[0])
            {
               addLoaderByLinkName(_loc2_[0]);
            }
            _loc2_ = param1.getLastEffectArr();
            if(_loc2_[0])
            {
               addLoaderByLinkName(_loc2_[0]);
            }
         }
      }
      
      private static function loadTalentBufferResource(param1:BufferTemplateInfo) : void
      {
         var _loc2_:Array = null;
         var _loc6_:Array = null;
         var _loc5_:TalentEffectInfo = null;
         var _loc3_:Array = null;
         if(param1 && !StringHelper.isNullOrEmpty(param1.TalentEffIds) && param1.TalentEffIds.length > 0)
         {
            _loc6_ = param1.TalentEffIds.split(",");
            for each(var _loc4_:int in _loc6_)
            {
               if(_loc4_ != 0)
               {
                  _loc5_ = TempleteManager.instance.talentTemplateCate.getTemplateById(_loc4_);
                  _loc3_ = _loc5_.EffBufferIds.split(",");
                  for each(var _loc7_:int in _loc3_)
                  {
                     if(_loc7_ != 0)
                     {
                        param1 = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc7_);
                        if(param1)
                        {
                           _loc2_ = param1.getActionEffectArr();
                           if(_loc2_[0])
                           {
                              addLoaderByLinkName(_loc2_[0]);
                           }
                           _loc2_ = param1.getAddEffectArr();
                           if(_loc2_[0])
                           {
                              addLoaderByLinkName(_loc2_[0]);
                           }
                           _loc2_ = param1.getLastEffectArr();
                           if(_loc2_[0])
                           {
                              addLoaderByLinkName(_loc2_[0]);
                           }
                        }
                     }
                  }
               }
            }
         }
      }
      
      private static function addSkill(param1:int, param2:int) : void
      {
         var _loc10_:String = null;
         var _loc5_:int = 0;
         var _loc3_:Array = null;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:BufferTemplateInfo = null;
         var _loc4_:Array = getLinkNamesBySkillId(param1,param2);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc10_ = _loc4_[_loc5_];
            addLoaderByLinkName(_loc10_);
            _loc5_++;
         }
         var _loc8_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(_loc8_)
         {
            _loc3_ = _loc8_.BufferIds.split(",");
            _loc6_ = 0;
            while(_loc6_ < _loc3_.length)
            {
               _loc9_ = int(_loc3_[_loc6_]);
               _loc7_ = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_loc9_);
               loadBufferResource(_loc7_);
               loadTalentBufferResource(_loc7_);
               _loc6_++;
            }
         }
      }
      
      private static function addLoaderByLinkName(param1:String) : void
      {
         if(param1 && param1 != "" && _linkNames.indexOf(param1) == -1)
         {
            _linkNames.push(param1);
            addLoader(param1);
         }
      }
      
      private static function addLoader(param1:String) : void
      {
         var _loc3_:RegExp = /\./g;
         var _loc2_:String = param1.replace(_loc3_,"_");
         _loc2_ = PathManager.solveSkillResPath(_loc2_);
         if(_notLoad)
         {
            _paths.push(_loc2_);
         }
         else
         {
            BattleManager.getInstance().resourceModel.addMultiClassResourcePath(_loc2_);
            if(loaderList.hasOwnProperty(_loc2_))
            {
               return;
            }
            LoaderManagerII.instance.load(_loc2_,1,8,skillLoadComplete);
         }
      }
      
      public static function clearSkillLoader() : void
      {
         var _loc1_:Loader = null;
         for(var _loc2_:String in loaderList)
         {
            _loc1_ = loaderList[_loc2_] as Loader;
            if(_loc1_.contentLoaderInfo && _loc1_.contentLoaderInfo.hasEventListener("complete"))
            {
               _loc1_.contentLoaderInfo.removeEventListener("complete",__loadSkillComplete);
            }
            _loc1_.unloadAndStop(false);
            delete loaderList[_loc2_];
         }
      }
      
      private static function skillLoadComplete(param1:com.pickgliss.loader.data.LoaderInfo, param2:Object) : void
      {
         if(loaderList.hasOwnProperty(param1.url))
         {
            return;
         }
         if(!param2 || !BattleManager.getInstance().resourceModel)
         {
            return;
         }
         var _loc4_:ApplicationDomain = BattleManager.getInstance().resourceModel.getDomainByPaty(param1.url);
         var _loc5_:LoaderContext = new LoaderContext(false,_loc4_);
         if(DisplayLoader.isDebug)
         {
            _loc5_.allowCodeImport = true;
         }
         var _loc3_:Loader = new Loader();
         _loc3_.contentLoaderInfo.addEventListener("complete",__loadSkillComplete);
         _loc3_.loadBytes(param2 as ByteArray,_loc5_);
         loaderList[param1.url] = _loc3_;
         _loc4_ = null;
         _loc5_ = null;
         _loc3_ = null;
      }
      
      private static function __loadSkillComplete(param1:Event) : void
      {
         var _loc2_:flash.display.LoaderInfo = param1.currentTarget as flash.display.LoaderInfo;
         _loc2_.removeEventListener("complete",__loadSkillComplete);
         _loc2_.loader.unloadAndStop(false);
      }
      
      private static function getLinkNamesBySkillId(param1:int, param2:int) : Array
      {
         var _loc5_:SkillTempInfo = null;
         var _loc4_:int = 0;
         var _loc6_:ActionTemplateData = null;
         var _loc3_:Array = [];
         if(param1 != -1 && param1 != 0)
         {
            _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(param1);
            if(_loc5_)
            {
               _loc4_ = _loc5_.ActionId;
            }
         }
         if(_loc4_ != 0)
         {
            _loc6_ = TempleteManager.instance.actionTemplate2[_loc4_];
            if(_loc6_)
            {
               _loc3_ = _loc6_.getRes(param2);
            }
         }
         return _loc3_;
      }
      
      public static function clear() : void
      {
         _linkNames = [];
         _ids = [];
      }
      
      public static function getPawnSkillIds(param1:int) : Array
      {
         var _loc3_:PawnTemplate = TempleteManager.instance.pawnTemplateCate.getTemplateByID(param1);
         var _loc2_:Array = [];
         _loc2_.push(_loc3_.DefaultSkill);
         return _loc2_.concat(_loc3_.HighSkill.split(","));
      }
      
      public static function getHeroFullSkillIds(param1:Array) : Array
      {
         var _loc3_:SkillTempInfo = null;
         var _loc2_:Array = param1.concat([]);
         for each(var _loc4_:int in param1)
         {
            if(_loc4_ > 0)
            {
               _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc4_);
               if(_loc3_ && _loc3_.Parameter3 != 0 && _loc2_.indexOf(_loc3_.Parameter3) == -1)
               {
                  _loc2_.push(_loc3_.Parameter3);
               }
            }
         }
         return _loc2_;
      }
      
      public static function getSkillResPaths(param1:Array) : Array
      {
         _paths = [];
         _notLoad = true;
         try
         {
            addSkillVOs(param1);
         }
         catch(err:Error)
         {
         }
         _notLoad = false;
         clear();
         return _paths;
      }
   }
}

