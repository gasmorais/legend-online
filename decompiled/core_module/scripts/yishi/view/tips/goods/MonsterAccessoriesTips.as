package yishi.view.tips.goods
{
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   
   public class MonsterAccessoriesTips extends EquipTip
   {
      
      protected var _tipsContent:MonsterAccessoriesTipsContent;
      
      public function MonsterAccessoriesTips()
      {
         super();
      }
      
      override protected function updateTransform() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc1_:GoodsTemplateInfo = null;
         if(tipData)
         {
            _blackKingBg.visible = false;
            _totalBox.removeAllChild();
            _loc2_ = tipData as GoodsInfo;
            _loc1_ = _loc2_.templateInfo;
            hidenBg(_loc1_.Profile);
            _tipsContent = new MonsterAccessoriesTipsContent();
            _tipsContent.data = _loc2_;
            _totalBox.addChild(_tipsContent);
            _bg.height = int(-_bg.y + _totalBox.y + _totalBox.height - 10);
            _redBg.height = _bg.height;
            _yellowBg.height = _bg.height;
            _purpleBg.height = _bg.height;
            _blueBg.height = _bg.height;
            _greenBg.height = _bg.height;
            _whiteBg.height = _bg.height;
            _blackKingBg.height = _bg.height;
            _bg.width = _blackKingBg.width = _redBg.width = _yellowBg.width = _purpleBg.width = _blueBg.width = _greenBg.width = _whiteBg.width = _totalBox.width + 15;
         }
      }
      
      private function hidenBg(param1:int) : void
      {
         _bg.visible = false;
         _redBg.visible = false;
         _yellowBg.visible = false;
         _purpleBg.visible = false;
         _blueBg.visible = false;
         _greenBg.visible = false;
         _whiteBg.visible = false;
         _blackKingBg.visible = false;
         switch(param1 - 1)
         {
            case 0:
               _whiteBg.visible = true;
               break;
            case 1:
               _greenBg.visible = true;
               break;
            case 2:
               _blueBg.visible = true;
               break;
            case 3:
               _purpleBg.visible = true;
               break;
            case 4:
               _yellowBg.visible = true;
               break;
            case 5:
               _redBg.visible = true;
               break;
            case 6:
               _blackKingBg.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_tipsContent);
         _tipsContent = null;
         super.dispose();
      }
   }
}

