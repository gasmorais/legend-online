package map.campaign.preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import yishi.datas.consant.JobType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.utils.StringHelper;
   
   public class PreloadSelfAvatar
   {
      
      private var _onComplete:Function;
      
      private var _onProgress:Function;
      
      private var _curLoadCount:int = 0;
      
      private var _needLoadCount:int = 0;
      
      public function PreloadSelfAvatar(param1:Function = null, param2:Function = null)
      {
         super();
         _onComplete = param1;
         _onProgress = param2;
      }
      
      public function load() : void
      {
         var _loc3_:String = null;
         var _loc1_:ResourceLoaderInfo = null;
         var _loc4_:int = 0;
         var _loc5_:Vector.<String> = new Vector.<String>();
         var _loc2_:int = thane.templateInfo ? thane.templateInfo.Sexs : thane.sexs;
         var _loc6_:int = thane.templateInfo ? thane.templateInfo.Job : thane.job;
         _loc3_ = StringHelper.isNullOrEmpty(thane.bodyAvata) ? JobType.getDefaultBodyEquipNameByJob(_loc6_) : thane.bodyAvata;
         _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
         _loc3_ = StringHelper.isNullOrEmpty(thane.armsAvata) ? JobType.getDefaultArmysEquipNameByJob(_loc6_) : thane.armsAvata;
         _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
         if(_loc3_.indexOf(PathManager.DRAGONIC) != -1)
         {
            _loc3_ = JobType.getDefaultCloakEquipNameByJob(4);
            _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
            _loc3_ = JobType.getDefaultHairUpByJob(4);
            _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
            _loc3_ = JobType.getDefaultHairDownByJob(4);
            _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
         }
         else
         {
            _loc3_ = StringHelper.isNullOrEmpty(thane.cloakAvata) ? JobType.getDefaultCloakEquipNameByJob(_loc6_) : thane.cloakAvata;
            _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
            _loc3_ = StringHelper.isNullOrEmpty(thane.hairAvata) ? JobType.getDefaultHairUpByJob(_loc6_) : thane.hairAvata + "up";
            _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
            _loc3_ = StringHelper.isNullOrEmpty(thane.hairAvata) ? JobType.getDefaultHairDownByJob(_loc6_) : thane.hairAvata + "down";
            _loc5_.push(PathManager.avatarResourcePath(_loc3_,_loc2_));
         }
         _needLoadCount = _loc5_.length;
         _loc4_ = 0;
         while(_loc4_ < _needLoadCount)
         {
            _loc1_ = new ResourceLoaderInfo();
            _loc1_.url = _loc5_[_loc4_];
            LoaderManagerII.instance.load(_loc5_[_loc4_],4,4,onSingleResourceLoadComplete,onResourcesLoadProgress,null,_loc1_);
            _loc4_++;
         }
      }
      
      private function onSingleResourceLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         _curLoadCount = _curLoadCount + 1;
         if(_curLoadCount >= _needLoadCount)
         {
            if(_onComplete != null)
            {
               _onComplete();
               _onComplete = null;
            }
            _onProgress = null;
         }
      }
      
      private function onResourcesLoadProgress(param1:LoaderInfo) : void
      {
         if(_onProgress != null && param1)
         {
            _onProgress(_curLoadCount / _needLoadCount * (param1.bytesLoaded / param1.bytesTotal));
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

