package yishi.datas.templates.cate
{
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.datas.templates.GameHeroTempInfo;
   
   public class GameHeroTemplateCate extends TemplateCate
   {
      
      private var _dic:Dictionary;
      
      private var _tempXml:XML;
      
      public function GameHeroTemplateCate(param1:XMLList)
      {
         super(param1);
         _dic = new Dictionary();
      }
      
      public function getHeroResistance(param1:GameHeroTempInfo) : String
      {
         var _loc2_:String = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.null");
         if(param1.FireResi > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.FireResi");
         }
         else if(param1.WaterResi > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.WaterResi");
         }
         else if(param1.ElectResi > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.ElectResi");
         }
         else if(param1.WindResi > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.WindResi");
         }
         else if(param1.DarkResi > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.DarkResi");
         }
         else if(param1.LightResi > 0)
         {
            _loc2_ = LanguageMgr.GetTranslation("gameHeroTemp.HeroResistance.LightResi");
         }
         return _loc2_;
      }
      
      public function getTemplateByID(param1:int) : GameHeroTempInfo
      {
         var _loc2_:XML = null;
         checkFirst();
         if(_list)
         {
            if(!_dic[param1])
            {
               _loc2_ = _list.(@TemplateId == param1)[0];
               if(_loc2_)
               {
                  _dic[param1] = createNode(_loc2_,GameHeroTempInfo,_tempXml);
               }
            }
         }
         return _dic[param1];
      }
   }
}

