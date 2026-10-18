package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   
   public class PetBossTips extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _hBox:HBox;
      
      public function PetBossTips()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.PetBossVBox");
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc1_:FilterFrameText = null;
         var _loc3_:int = 0;
         var _loc4_:GoodsInfo = null;
         var _loc2_:PetBossTipsItem = null;
         if(tipData)
         {
            _vBox.disposeAllChildren();
            _hBox = ComponentFactory.Instance.creatComponentByStylename("tips.PetBossHBox");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.PetBoss.firstTxt");
            _loc1_.text = LanguageMgr.GetTranslation("yishi.view.tips.PetBossTips.firstTxt");
            _vBox.addChild(_loc1_);
            _loc3_ = 0;
            while(_loc3_ < tipData.length)
            {
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = tipData[_loc3_].ItemId;
               _loc4_.count = tipData[_loc3_].Count;
               _loc2_ = new PetBossTipsItem();
               _loc2_.data = _loc4_;
               _hBox.addChild(_loc2_);
               _loc3_++;
            }
            _vBox.addChild(_hBox);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.PetBoss.firstTxt");
            _loc1_.text = LanguageMgr.GetTranslation("yishi.view.tips.PetBossTips.otherTxt");
            _vBox.addChild(_loc1_);
            _hBox.refreshChildPos();
            _vBox.refreshChildPos();
            _bg.width = _hBox.numChildren * 80 + 30;
            if(_bg.width < 320)
            {
               _bg.width = 320;
            }
            _bg.height = _vBox.height + 20;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

