package preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.road.mapengine.bitmap.load.ResourceLoaderInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class PreloadBody023Avatar
   {
      
      public function PreloadBody023Avatar()
      {
         super();
      }
      
      public function load() : void
      {
         var _loc3_:int = int("104" + thane.templateInfo.Job + "002");
         var _loc6_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_).Avata;
         var _loc1_:String = PathManager.resourcePath + "equip_show" + _loc6_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc1_ = PathManager.resourcePath + "equip_show" + _loc6_ + "_cloak/back/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         var _loc4_:ResourceLoaderInfo = new ResourceLoaderInfo();
         _loc1_ = PathManager.resourcePath + "swf/avatar" + _loc6_ + "/" + thane.templateInfo.Sexs + ".bswf";
         _loc4_.url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,1,7,null,null,null,_loc4_);
         _loc1_ = PathManager.resourcePath + "swf/avatar" + _loc6_ + "_cloak/" + thane.templateInfo.Sexs + ".bswf";
         _loc4_.url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,1,7,null,null,null,_loc4_);
         _loc1_ = PathManager.resourcePath + "equip" + _loc6_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc1_ = PathManager.resourcePath + "equip" + _loc6_ + "_cloak/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc1_ = PathManager.solveHeadPath(14);
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc1_ = PathManager.solveHeroAvatarPath(_loc6_,thane.templateInfo.Sexs);
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc3_ = int("104" + thane.templateInfo.Job + "002");
         var _loc2_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_).Avata;
         var _loc5_:int = int(ArmyManager.instance.thane.templateInfo.Sexs);
         _loc1_ = PathManager.avatarResourcePath(_loc2_,_loc5_);
         _loc4_.url = _loc1_;
         LoaderManagerII.instance.load(_loc1_,1,7,null,null,null,_loc4_);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

