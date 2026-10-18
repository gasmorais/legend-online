package yishi.view.tips
{
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.DragonTalkerViewHelper;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerTalismanInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.utils.SimpleDictionary;
   
   public class DragonTalkerSymbioteContrastTips extends BaseTip
   {
      
      private var _talismanTip:DragonTalkerTalismanTips;
      
      private var _equipTip1:DragonTalkerHeroEquipTips;
      
      private var _equipTip2:DragonTalkerHeroEquipTips;
      
      private var heroTipsArr:Array = [];
      
      public function DragonTalkerSymbioteContrastTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         _talismanTip = new DragonTalkerTalismanTips(2);
         _equipTip1 = new DragonTalkerHeroEquipTips();
         _equipTip2 = new DragonTalkerHeroEquipTips();
         heroTipsArr.push(_equipTip1);
         heroTipsArr.push(_equipTip2);
      }
      
      override public function set tipData(param1:Object) : void
      {
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         clean();
         var _loc5_:int = param1 as int;
         var _loc4_:DragonTalkerTalismanInfo = model.getEquipTalismanInfoBySontype(_loc5_);
         if(_loc4_)
         {
            addChild(_talismanTip);
            _talismanTip.tipData = _loc4_;
         }
         var _loc8_:Array = DragonTalkerViewHelper.GetEquipPosBySontype(_loc5_);
         var _loc9_:SimpleDictionary = GoodsManager.instance.getHeroGoodsListByTypeAndId(1,thane.id);
         var _loc7_:int = 4;
         var _loc2_:int = int(_loc8_.length);
         _loc6_ = 0;
         while(_loc6_ < heroTipsArr.length)
         {
            if(_loc6_ < _loc2_)
            {
               _loc3_ = int(_loc8_[_loc6_]);
               if(_loc9_[_loc3_ + "_" + _loc7_])
               {
                  heroTipsArr[_loc6_].tipData = _loc9_[_loc3_ + "_" + _loc7_];
                  addChild(heroTipsArr[_loc6_]);
               }
            }
            _loc6_++;
         }
         resetPosition();
      }
      
      private function resetPosition() : void
      {
         var _loc3_:int = 0;
         var _loc1_:DragonTalkerHeroEquipTips = null;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < heroTipsArr.length)
         {
            _loc1_ = heroTipsArr[_loc3_];
            if(_loc1_.tipData)
            {
               _loc1_.x = 0;
               _loc1_.y = _loc2_ * 325;
               _loc2_++;
            }
            _loc3_++;
         }
         if(_talismanTip.tipData)
         {
            _talismanTip.x = _loc2_ > 0 ? 305 : 0;
            _talismanTip.y = _loc2_ == 2 ? 180 : 0;
         }
      }
      
      private function clean() : void
      {
         _talismanTip.tipData = null;
         _equipTip1.tipData = null;
         _equipTip2.tipData = null;
         if(_talismanTip.parent)
         {
            removeChild(_talismanTip);
         }
         if(_equipTip1.parent)
         {
            removeChild(_equipTip1);
         }
         if(_equipTip2.parent)
         {
            removeChild(_equipTip2);
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_talismanTip);
         _talismanTip = null;
         ObjectUtils.disposeObject(_equipTip1);
         _equipTip1 = null;
         ObjectUtils.disposeObject(_equipTip2);
         _equipTip2 = null;
         super.dispose();
      }
   }
}

