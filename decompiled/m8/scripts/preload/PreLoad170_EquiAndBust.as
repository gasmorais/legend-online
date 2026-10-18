package preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class PreLoad170_EquiAndBust extends BasePreLoad
   {
      
      private var fun:Function;
      
      private var _url:String;
      
      public function PreLoad170_EquiAndBust()
      {
         super();
      }
      
      override public function load() : void
      {
         var _loc2_:int = int("104" + thane.templateInfo.Job + "002");
         var _loc4_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_).Avata;
         var _loc1_:String = PathManager.resourcePath + "equip_show" + _loc4_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,null);
         _loc1_ = PathManager.resourcePath + "equip_show" + _loc4_ + "_cloak/back/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,null);
         var _loc3_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc1_ = PathManager.resourcePath + "swf/avatar" + _loc4_ + "/" + thane.templateInfo.Sexs + ".bswf";
         _loc3_.url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,4,7,__loaderCompleteHandler,null,null,_loc3_);
         _loc1_ = PathManager.resourcePath + "swf/avatar" + _loc4_ + "_cloak/" + thane.templateInfo.Sexs + ".bswf";
         _loc3_.url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,4,7,__loaderCompleteHandler,null,null,_loc3_);
         _loc1_ = PathManager.resourcePath + "equip" + _loc4_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,null);
         _loc1_ = PathManager.resourcePath + "equip" + _loc4_ + "_cloak/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,null);
         _loc1_ = PathManager.solveHeadPath(14);
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _loc1_ = PathManager.solveHeroAvatarPath(_loc4_,thane.templateInfo.Sexs);
         LoaderManagerII.instance.load(_loc1_,1,7,onLoadComplete);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function onLoadComplete(param1:LoaderInfo) : void
      {
         var _loc3_:int = int("104" + thane.templateInfo.Job + "002");
         var _loc2_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_).Avata;
         var _loc4_:int = int(ArmyManager.instance.thane.templateInfo.Sexs);
         loadResourceByKey(_loc2_,_loc4_,loadComplete);
      }
      
      private function loadComplete(param1:String = "", param2:Object = null) : void
      {
         _isOver = true;
      }
      
      private function loadResourceByKey(param1:String, param2:int, param3:Function) : void
      {
         _url = getResourcepath(param1,param2);
         var _loc4_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc4_.url = _url;
         _loc4_.call = param3;
         LoaderManagerII.instance.load(_url,4,7,__loaderCompleteHandler,null,null,_loc4_);
      }
      
      private function __loaderCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:Function = null;
         if(param1.args)
         {
            _loc3_ = param1.args.call;
            if(_loc3_ != null)
            {
               _loc3_();
            }
            _loc3_ = null;
         }
      }
      
      private function getResourcepath(param1:String, param2:int) : String
      {
         return PathManager.avatarResourcePath(param1,param2);
      }
   }
}

