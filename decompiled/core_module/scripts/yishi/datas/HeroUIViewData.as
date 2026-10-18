package yishi.datas
{
   import flash.display.Sprite;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.SimpleDictionary;
   
   public class HeroUIViewData
   {
      
      public var curHeroInfo:ThaneInfo;
      
      public var oldHeroInfo:int;
      
      public var oldEquip:SimpleDictionary;
      
      public var curBagType:int = -1;
      
      public var curAcceptBagType:int = -1;
      
      private var _curBag:Sprite;
      
      public function HeroUIViewData()
      {
         super();
      }
      
      public function get curBag() : Sprite
      {
         return _curBag;
      }
      
      public function set curBag(param1:Sprite) : void
      {
         _curBag = param1;
      }
   }
}

