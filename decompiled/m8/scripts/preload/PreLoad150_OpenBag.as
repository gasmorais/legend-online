package preload
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import flash.utils.Dictionary;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   
   public class PreLoad150_OpenBag extends BasePreLoad
   {
      
      private var _defaultDic:Dictionary;
      
      private var _count:int;
      
      public function PreLoad150_OpenBag()
      {
         super();
         _defaultDic = new Dictionary();
         _defaultDic[2] = "equip_show/hunter_default";
         _defaultDic[3] = "equip_show/wizard_default";
         _defaultDic[1] = "equip_show/warrior_default";
      }
      
      override public function load() : void
      {
         var _loc1_:String = null;
         _loc1_ = PathManager.resourcePath + _defaultDic[thane.templateInfo.Job] + "_hair/front/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.resourcePath + _defaultDic[thane.templateInfo.Job] + "_body_cloak/front/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.resourcePath + _defaultDic[thane.templateInfo.Job] + "_body/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.resourcePath + _defaultDic[thane.templateInfo.Job] + "_arms/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.resourcePath + _defaultDic[thane.templateInfo.Job] + "_hair/back/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.resourcePath + _defaultDic[thane.templateInfo.Job] + "_body_cloak/back/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         var _loc2_:int = int("101" + thane.templateInfo.Job + "002");
         var _loc3_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_).Avata;
         _loc1_ = PathManager.resourcePath + "equip_show" + _loc3_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.resourcePath + "swf/avatar" + _loc3_ + "/" + thane.templateInfo.Sexs + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,7,onLoadComplete);
         _count = _count + 1;
         _loc1_ = PathManager.solveHeroAvatarPath(_loc3_,thane.templateInfo.Sexs);
         LoaderManagerII.instance.load(_loc1_,1,7,null);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function onLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         _count = _count - 1;
         if(_count == 0)
         {
            _isOver = true;
         }
      }
   }
}

