package finaldefense.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.display.Loader;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class FinalDefenseSkillHelper
   {
      
      private var _data:DitchNpcInfoData;
      
      private var _loaderIndex:int = 0;
      
      private var _loader1:Loader;
      
      private var _loader2:Loader;
      
      public function FinalDefenseSkillHelper()
      {
         super();
         _loader1 = new Loader();
         _loader2 = new Loader();
      }
      
      public function set data(param1:DitchNpcInfoData) : void
      {
         _data = param1;
         loaderSkillRes(TempleteManager.instance.dichTemplateCate.getTemplateById(_data.templateId).AttackType);
      }
      
      private function loaderSkillRes(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:String = null;
         switch(param1 - 1)
         {
            case 0:
               _loc3_ = PathManager.getFinalDefenseRes("finaldefenceskill010");
               _loc2_ = PathManager.getFinalDefenseRes("finaldefenceskill011");
               break;
            case 1:
               _loc3_ = PathManager.getFinalDefenseRes("finaldefenceskill020");
               _loc2_ = PathManager.getFinalDefenseRes("finaldefenceskill021");
               break;
            case 2:
               _loc3_ = PathManager.getFinalDefenseRes("finaldefenceskill030");
               _loc2_ = PathManager.getFinalDefenseRes("finaldefenceskill031");
               break;
            case 3:
               _loc3_ = PathManager.getFinalDefenseRes("finaldefenceskill040");
               _loc2_ = PathManager.getFinalDefenseRes("finaldefenceskill041");
         }
         LoaderManagerII.instance.load(_loc3_,1,8,__onLoaderComplete);
         LoaderManagerII.instance.load(_loc2_,1,8,__onLoaderComplete);
      }
      
      protected function __onLoaderComplete(param1:LoaderInfo, param2:Object) : void
      {
         _loaderIndex = _loaderIndex + 1;
         if(!this["_loader" + _loaderIndex])
         {
            return;
         }
         var _loc3_:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         this["_loader" + _loaderIndex].loadBytes(param2 as ByteArray,_loc3_);
         if(_loaderIndex == 2)
         {
            _loaderIndex = 0;
         }
      }
      
      public function dispose() : void
      {
         _data = null;
         if(_loader1 != null)
         {
            _loader1.unloadAndStop(true);
            _loader1 = null;
         }
         if(_loader2 != null)
         {
            _loader2.unloadAndStop(true);
            _loader2 = null;
         }
      }
   }
}

