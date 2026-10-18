package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildPveRewardTip extends BaseTip
   {
      
      private var _vBox:VBox;
      
      public function ChildPveRewardTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassVBox");
         addChild(_vBox);
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:Array = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc1_:FilterFrameText = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(tipData)
         {
            _vBox.removeAllChild();
            _loc3_ = (tipData as String).split("|");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassTitleTxt1");
            _loc1_.text = LanguageMgr.GetTranslation("childpve.dropTipsTxt");
            _vBox.addChild(_loc1_);
            while(_loc5_ < _loc3_.length)
            {
               _loc2_ = int(String(_loc3_[_loc5_]).split(",")[0]);
               _loc4_ = int(String(_loc3_[_loc5_]).split(",")[1]);
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_);
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc1_.setFrame(_loc6_.Profile);
               _loc1_.text = _loc6_.TemplateName + "*" + _loc4_;
               _vBox.addChild(_loc1_);
               _loc5_++;
            }
            _vBox.refreshChildPos();
            _bg.width = _vBox.displayWidth + 20;
            _bg.height = _vBox.displayHeight + 20;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

