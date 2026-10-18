package preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import flash.utils.Dictionary;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class PreloadDefaultAvatar
   {
      
      public function PreloadDefaultAvatar()
      {
         super();
      }
      
      public function load() : void
      {
         var _loc1_:String = null;
         var _loc4_:Dictionary = new Dictionary();
         _loc4_[2] = "equip_show/hunter_default";
         _loc4_[3] = "equip_show/wizard_default";
         _loc4_[1] = "equip_show/warrior_default";
         var _loc2_:int = int("101" + thane.templateInfo.Job + "003");
         var _loc3_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_).Avata;
         _loc1_ = PathManager.resourcePath + "equip_show" + _loc3_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc1_ = PathManager.resourcePath + "swf/avatar" + _loc3_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,1,7,null);
         _loc1_ = PathManager.solveHeroAvatarPath(_loc3_,thane.templateInfo.Sexs);
         LoaderManagerII.instance.load(_loc1_,1,7,null);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

